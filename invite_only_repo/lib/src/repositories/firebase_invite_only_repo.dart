import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:invite_only_repo/src/errors/access_denied.dart';
import 'package:invite_only_repo/src/errors/auth_failure.dart';
import 'package:invite_only_repo/src/models/access/access.dart';
import 'package:invite_only_repo/src/models/id_document/id_document.dart';
import 'package:invite_only_repo/src/models/invite/invite.dart';
import 'package:invite_only_repo/src/models/invites_metadata/invites_metadata.dart';
import 'package:invite_only_repo/src/models/space/space.dart';
import 'package:invite_only_repo/src/models/user/user.dart';
import 'package:uuid/uuid.dart';

import 'invite_only_repo.dart';

class FirebaseInviteOnlyRepo implements InviteOnlyRepo {
  /// The internally visible constructor for this class, since it is a singleton.
  FirebaseInviteOnlyRepo._internal(FirebaseUser authUser,
      {FirebaseAuth fireAuth, Firestore firestore})
      : _authUser = authUser,
        _fireAuth = fireAuth != null ? fireAuth : FirebaseAuth.instance,
        _firestore = firestore != null ? firestore : Firestore.instance;

  /// The singleton instance of this class
  static FirebaseInviteOnlyRepo _instance;

  /// The method to retrieve the singleton instance of this class
  ///
  /// The optional parameters should only be necessary for testing purposes.
  static Future<FirebaseInviteOnlyRepo> getInstance(
      {FirebaseAuth firebaseAuth, Firestore firestore}) async {
    if (_instance == null) {
      FirebaseUser authUser = await FirebaseAuth.instance.currentUser();
      _instance = FirebaseInviteOnlyRepo._internal(authUser);
    }

    return _instance;
  }

  /// The static collection name for the users collection.
  static const USERS = "users";

  /// The static collection name for the users collection.
  static const SPACES = "spaces";

  /// The static collection name for the invites collection.
  static const INVITES = "invites";

  /// The static collection name for the invites collection.
  static const ACCESSES = "accesses";

  /// The provider for authentication services.
  final FirebaseAuth _fireAuth;

  /// The provider for remote data storage services.
  final Firestore _firestore;

  /// The currently authenticated user
  FirebaseUser _authUser;

  @override
  Future<void> verifyPhoneNumber({
    @required String phoneNumber,
    @required Duration retrievalTimeout,
    @required Function(InviteOnlyCredential) verificationCompleted,
    @required Function(AuthFailure) verificationFailed,
    @required Function(String) codeSent,
  }) async {
    await _fireAuth.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      timeout: retrievalTimeout,
      verificationCompleted: (credential) {
        verificationCompleted(InviteOnlyCredential(credential));
      },
      verificationFailed: (e) => AuthFailure(e.message),
      codeSent: codeSent,
      codeAutoRetrievalTimeout: (verificationId) {
        //do nothing
      },
    );
  }

  @override
  InviteOnlyCredential getAuthCredential(
      String phoneVerificationId, String smsCode) {
    return InviteOnlyCredential(
      PhoneAuthProvider.getCredential(
        verificationId: phoneVerificationId,
        smsCode: smsCode,
      ),
    );
  }

  @override
  Future<void> signInWithCredential(
      InviteOnlyCredential inviteOnlyCredential) async {
    try {
      final authResult =
          await _fireAuth.signInWithCredential(inviteOnlyCredential.credential);
      _authUser = authResult.user;
    } catch (e) {
      throw AuthFailure('Credential could not be used to sign in: $e');
    }
  }

  @override
  Stream<User> currentUser() {
    if (_authUser == null) return null;

    final userRef = _firestore.collection(USERS).document(_authUser.uid);

    // First, if no details exist yet for the user, a record is created for their details.
    userRef.get().then((userSnapshot) {
      final user = User(id: _authUser.uid, phoneNumber: _authUser.phoneNumber);
      if (!userSnapshot.exists) userRef.setData(user.toJson());
    });

    return userRef.snapshots().map<User>((userSnapshot) {
      if (!userSnapshot.exists) return null;
      return User.fromJson(userSnapshot.data);
    });
  }

  @override
  Future<void> deleteUser(User user) async {
    await _firestore.collection(USERS).document(user.id).delete();
  }

  @override
  Future<void> updateUser(User user) async {
    final userRef = _firestore.collection(USERS).document(user.id);
    await userRef.setData(user.toJson());
  }

  @override
  Future<void> signOut() async {
    await _fireAuth.signOut();
    _authUser = null;
  }

  @override
  Future<void> createSpace({
    String spaceId,
    @required String title,
    @required bool inviteOnly,
    @required List<String> managerPhones,
    @required List<String> guardPhones,
    @required List<String> inviterPhones,
    int minAge,
    File image,
    double locationLatitude,
    double locationLongitude,
  }) async {
    final newSpace = Space(
      id: Uuid().v4(),
      title: title,
      inviteOnly: inviteOnly,
      managerPhones: managerPhones,
      guardPhones: guardPhones,
      inviterPhones: inviterPhones,
      minAge: minAge,
      // TODO: replace imageUrl with Url where image was uploaded to.
      imageUrl:
          'https://d33v4339jhl8k0.cloudfront.net/docs/assets/5c814e0d2c7d3a0cb9325d1f/images/5c8bc20d2c7d3a154460eb97/file-1CjQ85QAme.jpg',
      locationLongitude: locationLongitude,
      locationLatitude: locationLatitude,
    );
    final spaceRef = _firestore.collection(SPACES).document(newSpace.id);
    await spaceRef.setData(newSpace.toJson());
  }

  @override
  Future<void> updateSpace(Space space) async {
    final spaceRef = _firestore.collection(SPACES).document(space.id);
    await spaceRef.updateData(space.toJson());
  }

  @override
  Future<void> deleteSpace(Space space) async {
    final spaceRef = _firestore.collection(SPACES).document(space.id);
    await spaceRef.delete();
  }

  @override
  Future<String> invite(Space space) async {
    final spaceRef = _firestore.collection(SPACES).document(space.id);
    final invitesRef = spaceRef.collection(INVITES);
    final metaRef = invitesRef.document('--metadata--');

    Invite invite;
    await Firestore.instance.runTransaction((Transaction tx) async {
      final metaSnapshot = await tx.get(metaRef);
      final invitesMetadata = metaSnapshot.exists
          ? InvitesMetadata.fromJson(metaSnapshot.data)
          : InvitesMetadata(numInvites: 0);

      invite = Invite(
        id: Uuid().v4(),
        code: invitesMetadata.numInvites.toString().padLeft(6, '0'),
        spaceId: space.id,
        expiryDate: DateTime.now().add(Duration(hours: 48)),
        inviterPhoneNumber: _authUser.phoneNumber,
        used: false,
      );
      await tx.set(invitesRef.document(invite.id), invite.toJson());

      metaSnapshot.exists
          ? await tx.update(metaRef, {'numInvites': FieldValue.increment(1)})
          : await tx.set(metaRef, {'numInvites': FieldValue.increment(1)});
    });

    return invite.code;
  }

  @override
  Future<void> grantAccess(Space space, IdDocument idDocument,
      [String inviteCode]) async {
    final spaceRef = _firestore.collection(SPACES).document(space.id);
    if (inviteCode == null) {
      await _grantResidentAccess(space, idDocument, spaceRef);
    } else {
      await _grantVisitorAccess(space, inviteCode, idDocument, spaceRef);
    }
  }

  @override
  Stream<List<Space>> spaces() {
    return _firestore.collection(SPACES).snapshots().map((querySnapshot) {
      final spaces = querySnapshot.documents.map((documentSnapshot) {
        return Space.fromJson(documentSnapshot.data);
      });

      return spaces.where((s) => s.canEnter(_authUser.phoneNumber)).toList();
    });
  }

  @override
  Stream<List<Access>> accesses(Space space) {
    final spaceRef = _firestore.collection(SPACES).document(space.id);
    final accesses = spaceRef.collection(ACCESSES);

    return accesses.snapshots().map((querySnapshot) {
      final accesses = querySnapshot.documents.map((documentSnapshot) {
        return Access.fromJson(documentSnapshot.data);
      });

      if (space.canEdit(_authUser.phoneNumber)) return accesses;

      return accesses.where((a) => a.canView(_authUser.phoneNumber)).toList();
    });
  }

  /// A helper method for [grantAccess] to grant access to a user using an invite code.
  Future<void> _grantVisitorAccess(Space space, String inviteCode,
      IdDocument idDocument, DocumentReference spaceRef) async {
    final invite = await _findInvite(space.id, inviteCode);
    if (invite == null) throw AccessDenied();

    final newAccess = Access(
      id: Uuid().v4(),
      entryGuardPhone: _authUser.phoneNumber,
      entryDate: DateTime.now(),
      idDocument: idDocument,
      granterPhoneNumber: invite.inviterPhoneNumber,
    );

    final inviteRef = spaceRef.collection(INVITES).document(invite.id);
    final accessRef = spaceRef.collection(ACCESSES).document(newAccess.id);
    await _firestore.runTransaction((txn) async {
      final updatedInvite = invite.copyWith(used: true);
      await txn.update(inviteRef, updatedInvite.toJson());
      await accessRef.setData(newAccess.toJson());
    });
  }

  /// A helper method for [grantAccess] to grant access to a user using without an invite code.
  Future<void> _grantResidentAccess(
      Space space, IdDocument idDocument, DocumentReference spaceRef) async {
    final accessor = await _findUser(space.id, idDocument);
    if (accessor == null) throw AccessDenied();

    final newAccess = Access(
      id: Uuid().v4(),
      entryGuardPhone: _authUser.phoneNumber,
      entryDate: DateTime.now(),
      idDocument: idDocument,
      granterPhoneNumber: accessor.phoneNumber,
    );
    final accessRef = spaceRef.collection(ACCESSES).document(newAccess.id);
    await accessRef.setData(newAccess.toJson());
  }

  /// A helper method for [grantAccess]. Returns the user associated with the
  /// given id document who has access to enter the given space,
  /// or null if no such user exists.
  Future<User> _findUser(String spaceId, IdDocument idDocument) async {
    QuerySnapshot querySnapshot;
    final users = _firestore.collection(USERS);
    final docData = idDocument.toJson();
    if (idDocument is IdBook) {
      final query = users.where('idBook', isEqualTo: docData).limit(1);
      querySnapshot = await query.getDocuments();
    }
    if (idDocument is IdCard) {
      final query = users.where('idCard', isEqualTo: docData).limit(1);
      querySnapshot = await query.getDocuments();
    }
    if (idDocument is DriversLicense) {
      final query = users.where('driversLicense', isEqualTo: docData).limit(1);
      querySnapshot = await query.getDocuments();
    }
    if (idDocument is Passport) {
      final query = users.where('passport', isEqualTo: docData).limit(1);
      querySnapshot = await query.getDocuments();
    }
    if (querySnapshot.documents.isEmpty) return null;
    final user = User.fromJson(querySnapshot.documents.first.data);

    final spaceRef = _firestore.collection(SPACES).document(spaceId);
    final spaceSnapshot = await spaceRef.get();
    final savedSpace = Space.fromJson(spaceSnapshot.data);

    return savedSpace.canEnter(user.phoneNumber) ? user : null;
  }

  /// A helper method for [grantVisitorAccess]. Returns the invite associated
  /// with the given space and code, or null if no invite could be found.
  Future<Invite> _findInvite(String spaceId, String code) async {
    final spaceRef = _firestore.collection(SPACES).document(spaceId);
    final querySnapshot = await spaceRef
        .collection(INVITES)
        .where('code', isEqualTo: code)
        .where('expiryDate', isGreaterThan: DateTime.now().toString())
        .limit(1)
        .getDocuments();
    if (querySnapshot.documents.isEmpty) return null;
    return Invite.fromJson(querySnapshot.documents.first.data);
  }
}
