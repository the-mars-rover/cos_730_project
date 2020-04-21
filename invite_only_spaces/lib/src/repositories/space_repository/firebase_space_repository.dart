import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uuid/uuid.dart';

import '../../../invite_only_spaces.dart';

class FirebaseSpaceRepository implements SpaceRepository {
  static const String SPACE_COLLECTION = 'spaces';
  static const String INVITE_COLLECTION = 'invites';
  static const String ACCESS_COLLECTION = 'accesses';

  /// The data provider for the firebase firestore database.
  final Firestore _firestore;

  /// The constructor for [FirebaseSpaceRepository].
  ///
  /// The optional parameters are only necessary for testing purposes.
  FirebaseSpaceRepository({Firestore firestore})
      : _firestore = firestore ?? Firestore.instance;

  @override
  Future<void> createSpace(ControlledSpace space) async {
    await _firestore
        .collection(SPACE_COLLECTION)
        .document(space.id)
        .setData(space.toJson());
  }

  @override
  Stream<List<ControlledSpace>> managerSpaces(String phoneNumber) {
    return _firestore
        .collection(SPACE_COLLECTION)
        .where('managerPhones', arrayContains: phoneNumber)
        .snapshots()
        .map<List<ControlledSpace>>((querySnapshot) {
      return querySnapshot.documents.map((documentSnapshot) {
        return ControlledSpace.fromJson(documentSnapshot.data);
      }).toList();
    });
  }

  @override
  Stream<List<ControlledSpace>> guardSpaces(String phoneNumber) {
    return _firestore
        .collection(SPACE_COLLECTION)
        .where('guardPhones', arrayContains: phoneNumber)
        .snapshots()
        .map<List<ControlledSpace>>((querySnapshot) {
      return querySnapshot.documents.map((documentSnapshot) {
        return ControlledSpace.fromJson(documentSnapshot.data);
      }).toList();
    });
  }

  @override
  Stream<List<ControlledSpace>> inviterSpaces(String phoneNumber) {
    return _firestore
        .collection(SPACE_COLLECTION)
        .where('inviterPhones', arrayContains: phoneNumber)
        .snapshots()
        .map<List<ControlledSpace>>((querySnapshot) {
      return querySnapshot.documents.map((documentSnapshot) {
        return ControlledSpace.fromJson(documentSnapshot.data);
      }).toList();
    });
  }

  @override
  Stream<List<Access>> accesses(String spaceId) {
    return _firestore
        .collection(SPACE_COLLECTION)
        .reference()
        .document(spaceId)
        .collection(ACCESS_COLLECTION)
        .snapshots()
        .map<List<Access>>((querySnapshot) {
      return querySnapshot.documents.map((documentSnapshot) {
        return Access.fromJson(documentSnapshot.data);
      }).toList();
    });
  }

  @override
  Future<void> updateSpace(ControlledSpace space) async {
    await _firestore
        .collection(SPACE_COLLECTION)
        .document(space.id)
        .updateData(space.toJson());
  }

  @override
  Future<void> deleteSpace(String spaceId) async {
    await _firestore
        .collection(SPACE_COLLECTION)
        .reference()
        .document(spaceId)
        .delete();
  }

  /// Please see the following page about Keeping a Count of Documents in a Collection:
  /// https://fireship.io/snippets/firestore-increment-tips/
  @override
  Future<Invite> createInvite(String spaceId, String phoneNumber) async {
    final invitesRef = _firestore
        .collection(SPACE_COLLECTION)
        .document(spaceId)
        .collection(INVITE_COLLECTION);
    final metadataRef = invitesRef.document('--metadata--');

    Invite invite;
    await Firestore.instance.runTransaction((Transaction tx) async {
      final metadataSnapshot = await tx.get(metadataRef);
      final invitesMetadata = metadataSnapshot.exists
          ? InvitesMetadata.fromJson(metadataSnapshot.data)
          : InvitesMetadata(numInvites: 0);

      invite = Invite(
        id: Uuid().v4(),
        code: invitesMetadata.numInvites.toString().padLeft(6, '0'),
        spaceId: spaceId,
        expiryDate: DateTime.now().add(Duration(hours: 48)),
        inviterPhoneNumber: phoneNumber,
      );
      final inviteRef = invitesRef.document(invite.id);
      await tx.set(inviteRef, invite.toJson());

      if (metadataSnapshot.exists) {
        await tx.update(metadataRef, {'numInvites': FieldValue.increment(1)});
      } else {
        await tx.set(metadataRef, {'numInvites': FieldValue.increment(1)});
      }
    });

    return invite;
  }

  @override
  Future<void> grantEntry(String spaceId, String phoneNumber,
      IdDocument idDocument, String guardPhone) async {
    final spaceRef = _firestore.collection(SPACE_COLLECTION).document(spaceId);
    final spaceSnapshot = await spaceRef.get();
    final space = ControlledSpace.fromJson(spaceSnapshot.data);
    if (!(space.managerPhones.contains(phoneNumber) ||
        space.guardPhones.contains(phoneNumber) ||
        space.inviterPhones.contains(phoneNumber))) {
      throw Exception('Access not allowed');
    }

    Access newAccess = Access(
      id: Uuid().v4(),
      spaceId: spaceId,
      entryGuardPhone: guardPhone,
      entryDate: DateTime.now(),
      idDocument: idDocument,
      granterPhoneNumber: phoneNumber,
    );
    await spaceRef
        .collection(ACCESS_COLLECTION)
        .document(newAccess.id)
        .setData(newAccess.toJson());
  }

  @override
  Future<void> grantVisitorEntry(String spaceId, IdDocument idDocument,
      String entryCode, String guardPhone) async {
    final spaceRef = _firestore.collection(SPACE_COLLECTION).document(spaceId);
    final inviteQuerySnapshot = await spaceRef
        .collection(INVITE_COLLECTION)
        .where('code', isEqualTo: entryCode)
        .where('expiryDate', isGreaterThan: DateTime.now().millisecondsSinceEpoch)
        .limit(1)
        .getDocuments();
    if (inviteQuerySnapshot.documents.isEmpty) {
      throw Exception('$entryCode is an invalid invite code');
    }
    final invite = Invite.fromJson(inviteQuerySnapshot.documents.first.data);

    final Access newAccess = Access(
      id: Uuid().v4(),
      spaceId: spaceId,
      entryGuardPhone: guardPhone,
      entryDate: DateTime.now(),
      idDocument: idDocument,
      granterPhoneNumber: invite.inviterPhoneNumber,
    );
    await spaceRef
        .collection(ACCESS_COLLECTION)
        .document(newAccess.id)
        .setData(newAccess.toJson());
  }
}
