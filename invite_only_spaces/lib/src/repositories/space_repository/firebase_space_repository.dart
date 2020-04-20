import 'package:cloud_firestore/cloud_firestore.dart';

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

  @override
  Future<String> invite(String spaceId, String phoneNumber) {
    // TODO: implement invite
    return null;
  }

  @override
  Future<void> grantEntry(String spaceId, String phoneNumber) {
    // TODO: implement grantEntry
    return null;
  }

  @override
  Future<void> grantExit(String spaceId, String phoneNumber) {
    // TODO: implement grantExit
    return null;
  }
}
