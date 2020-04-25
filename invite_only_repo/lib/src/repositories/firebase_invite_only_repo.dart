import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:invite_only_repo/src/errors/access_denied.dart';
import 'package:invite_only_repo/src/errors/auth_failure.dart';
import 'package:invite_only_repo/src/errors/document_invalid.dart';
import 'package:invite_only_repo/src/errors/permission_denied.dart';
import 'package:invite_only_repo/src/errors/unauthenticated.dart';
import 'package:invite_only_repo/src/models/access/access.dart';
import 'package:invite_only_repo/src/models/id_document/id_document.dart';
import 'package:invite_only_repo/src/models/invite/invite.dart';
import 'package:invite_only_repo/src/models/invites_metadata/invites_metadata.dart';
import 'package:invite_only_repo/src/models/space/space.dart';
import 'package:invite_only_repo/src/models/user/user.dart';
import 'package:rxdart/rxdart.dart';
import 'package:uuid/uuid.dart';

import 'invite_only_repo.dart';

class FirebaseInviteOnlyRepo implements InviteOnlyRepo {
  /// The static collection name for the users collection.
  static const USERS = "users";

  /// The static collection name for the users collection.
  static const SPACES = "spaces";

  /// The static collection name for the invites collection.
  static const INVITES = "invites";

  /// The static collection name for the invites collection.
  static const ACCESSES = "accesses";

  /// The provider for authentication services.
  final FirebaseAuth _firebaseAuth;

  /// The provider for remote data storage services.
  final Firestore _firestore;

  /// Passing instances of FirebaseAuth and Firestore should only be necessary
  /// for testing.
  FirebaseInviteOnlyRepo({FirebaseAuth firebaseAuth, Firestore firestore})
      : _firebaseAuth =
            firebaseAuth != null ? firebaseAuth : FirebaseAuth.instance,
        _firestore = firestore != null ? firestore : Firestore.instance;

  @override
  Future<void> verifyPhoneNumber({
    @required String phoneNumber,
    @required Duration retrievalTimeout,
    @required Function(InviteOnlyCredential) verificationCompleted,
    @required Function(AuthFailure) verificationFailed,
    @required Function(String) codeSent,
  }) async {
    await _firebaseAuth.verifyPhoneNumber(
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
      await _firebaseAuth.signInWithCredential(inviteOnlyCredential.credential);
    } catch (e) {
      throw AuthFailure('Credential could not be used to sign in: $e');
    }
  }

  @override
  Future<Stream<User>> currentUser() async {
    FirebaseUser authUser = await _firebaseAuth.currentUser();
    if (authUser == null) return null;

    // First, ensure that the authenticated user exists in the users collection
    final user = User(id: authUser.uid, phoneNumber: authUser.phoneNumber);
    final userRef = _firestore.collection(USERS).document(authUser.uid);
    final userSnapshot = await userRef.get();
    if (!userSnapshot.exists) await userRef.setData(user.toJson());

    return userRef.snapshots().map<User>((userSnapshot) {
      if (!userSnapshot.exists) return null;
      return User.fromJson(userSnapshot.data);
    });
  }

  @override
  Future<void> deleteUser() async {
    final authUser = await _firebaseAuth.currentUser();
    if (authUser == null) throw Unauthenticated('User not authenticated.');

    await _firestore.collection(USERS).document(authUser.uid).delete();
  }

  @override
  Future<void> submitDocument(IdDocument idDocument) async {
    final authUser = await _firebaseAuth.currentUser();
    if (authUser == null) throw Unauthenticated('User not authenticated.');

    final userRef = _firestore.collection(USERS).document(authUser.uid);
    var updatedUser = User(id: authUser.uid, phoneNumber: authUser.phoneNumber);
    if (idDocument is IdCard) {
      updatedUser = updatedUser.copyWith(idCard: idDocument);
    } else if (idDocument is IdBook) {
      updatedUser = updatedUser.copyWith(idBook: idDocument);
    } else if (idDocument is DriversLicense) {
      updatedUser = updatedUser.copyWith(driversLicense: idDocument);
    } else if (idDocument is Passport) {
      updatedUser = updatedUser.copyWith(passport: idDocument);
    }

    try {
      await userRef.updateData(updatedUser.toJson());
    } catch (e) {
      // Document ID number does not match existing document ID numbers
      throw DocumentInvalid("Could not update the user documents: $e");
    }
  }

  @override
  Future<void> createSpace({
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

    try {
      final spaceRef = _firestore.collection(SPACES).document(newSpace.id);
      await spaceRef.setData(newSpace.toJson());
    } catch (e) {
      // Firebase security rules error (ie. there is no authenticated user)
      throw PermissionDenied('Could not create space: $e');
    }
  }

  @override
  Future<void> updateSpace(Space space) async {
    try {
      final spaceRef = _firestore.collection(SPACES).document(space.id);
      await spaceRef.updateData(space.toJson());
    } catch (e) {
      // Firebase security rules error (ie. the current user is not a manager for the space)
      throw PermissionDenied('Could not update space: $e');
    }
  }

  @override
  Future<void> deleteSpace(Space space) async {
    try {
      final spaceRef = _firestore.collection(SPACES).document(space.id);
      await spaceRef.delete();
    } catch (e) {
      // Firebase security rules error (ie. the current user is not a manager for the space)
      throw PermissionDenied('Could not delete space: $e');
    }
  }

  @override
  Future<String> invite(Space space) async {
    final authUser = await _firebaseAuth.currentUser();
    if (authUser == null) throw Unauthenticated('User not authenticated.');

    final spaceRef = _firestore.collection(SPACES).document(space.id);
    final invitesRef = spaceRef.collection(INVITES);
    final metaRef = invitesRef.document('--metadata--');

    Invite invite;
    try {
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
          inviterPhoneNumber: authUser.phoneNumber,
        );
        await tx.set(invitesRef.document(invite.id), invite.toJson());

        metaSnapshot.exists
            ? await tx.update(metaRef, {'numInvites': FieldValue.increment(1)})
            : await tx.set(metaRef, {'numInvites': FieldValue.increment(1)});
      });
    } catch (e) {
      // Firebase security rules error (ie. the current user is not a manager or inviter for the space)
      throw PermissionDenied('Could not update space: $e');
    }

    return invite.code;
  }

  @override
  Future<void> grantAccess(Space space, IdDocument idDocument) async {
    final authUser = await _firebaseAuth.currentUser();
    if (authUser == null) throw Unauthenticated('User not authenticated.');

    final spaceRef = _firestore.collection(SPACES).document(space.id);
    final accessor = await _findUser(space, idDocument);
    if (accessor == null) throw AccessDenied('Document not found: $idDocument');
    Access newAccess = Access(
      id: Uuid().v4(),
      spaceId: space.id,
      entryGuardPhone: authUser.phoneNumber,
      entryDate: DateTime.now(),
      idDocument: idDocument,
      granterPhoneNumber: accessor.phoneNumber,
    );

    try {
      final accessRef = spaceRef.collection(ACCESSES).document(newAccess.id);
      await accessRef.setData(newAccess.toJson());
    } catch (e) {
      // Firebase security rules error (ie. the current user is not a manager or guard for the space
      throw PermissionDenied('Could not grant access: $e');
    }
  }

  @override
  Future<void> grantVisitorAccess(
    Space space,
    IdDocument idDocument,
    String code,
  ) async {
    final authUser = await _firebaseAuth.currentUser();
    if (authUser == null) throw Unauthenticated('User not authenticated.');

    final spaceRef = _firestore.collection(SPACES).document(space.id);
    final invite = await _findInvite(space, code);
    if (invite == null) throw AccessDenied('Code not found: $code');
    Access newAccess = Access(
      id: Uuid().v4(),
      spaceId: space.id,
      entryGuardPhone: authUser.phoneNumber,
      entryDate: DateTime.now(),
      idDocument: idDocument,
      granterPhoneNumber: invite.inviterPhoneNumber,
    );

    try {
      final accessRef = spaceRef.collection(ACCESSES).document(newAccess.id);
      await accessRef.setData(newAccess.toJson());
    } catch (e) {
      // Firebase security rules error (ie. the current user is not a manager or guard for the space)
      throw PermissionDenied('Could not grant access: $e');
    }
  }

  @override
  Future<Stream<List<Space>>> spaces() async {
    final authUser = await _firebaseAuth.currentUser();
    if (authUser == null) throw Unauthenticated('User not authenticated.');

    final managerStream = _managerSpaces(authUser.phoneNumber);
    final guardStream = _guardSpaces(authUser.phoneNumber);
    final inviterStream = _inviterSpaces(authUser.phoneNumber);

    return CombineLatestStream.combine3(
      managerStream,
      guardStream,
      inviterStream,
      (List a, List b, List c) {
        a.addAll(b);
        a.addAll(c);
        return a.toSet().toList();
      },
    );
  }

  @override
  Future<Stream<Space>> space(Space space) async {
    final spaceRef = _firestore.collection(SPACES).document(space.id);
    try {
      return spaceRef.snapshots().map<Space>((spaceSnapshot) {
        if (!spaceSnapshot.exists) return null;

        final space = Space.fromJson(spaceSnapshot.data);
        return space;
      });
    } catch (e) {
      throw PermissionDenied('Could not read space: $e');
    }
  }

  @override
  Future<Stream<List<Access>>> accesses(Space space) async {
    final spaceRef = _firestore.collection(SPACES).document(space.id);
    final accesses = spaceRef.collection(ACCESSES);
    try {
      return accesses.snapshots().map<List<Access>>((querySnapshot) {
        return querySnapshot.documents.map((documentSnapshot) {
          return Access.fromJson(documentSnapshot.data);
        }).toList();
      });
    } catch (e) {
      throw PermissionDenied('Could not read space: $e');
    }
  }

  /// A helper method for [grantAccess]. Returns the user associated with the
  /// given id document and who has access to enter the given space,
  /// or null if no such user exists.
  Future<User> _findUser(Space space, IdDocument idDocument) async {
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

    final spaceRef = _firestore.collection(SPACES).document(space.id);
    final spaceSnapshot = await spaceRef.get();
    final savedSpace = Space.fromJson(spaceSnapshot.data);

    return _canEnter(savedSpace, user.phoneNumber) ? user : null;
  }

  /// A helper method for [grantVisitorAccess]. Returns the invite associated
  /// with the given space and code, or null if no invite could be found.
  Future<Invite> _findInvite(Space space, String code) async {
    final spaceRef = _firestore.collection(SPACES).document(space.id);
    final querySnapshot = await spaceRef
        .collection(INVITES)
        .where('code', isEqualTo: code)
        .where('expiryDate', isGreaterThan: DateTime.now().toString())
        .limit(1)
        .getDocuments();
    if (querySnapshot.documents.isEmpty) return null;
    return Invite.fromJson(querySnapshot.documents.first.data);
  }

  /// A helper method for [spaces] which only returns a stream of the spaces this
  /// user is a manager for.
  Stream<List<Space>> _managerSpaces(String phone) {
    final spaces = _firestore.collection(SPACES);
    final ref = spaces.where('managerPhones', arrayContains: phone);
    return ref.snapshots().map<List<Space>>((querySnapshot) {
      return querySnapshot.documents.map((documentSnapshot) {
        return Space.fromJson(documentSnapshot.data);
      }).toList();
    });
  }

  /// A helper method for [spaces] which only returns a stream of the spaces this
  /// user is a manager for.
  Stream<List<Space>> _guardSpaces(String phone) {
    final spaces = _firestore.collection(SPACES);
    final ref = spaces.where('guardPhones', arrayContains: phone);
    return ref.snapshots().map<List<Space>>((querySnapshot) {
      return querySnapshot.documents.map((documentSnapshot) {
        return Space.fromJson(documentSnapshot.data);
      }).toList();
    });
  }

  /// A helper method for [spaces] which only returns a stream of the spaces this
  /// user is a manager for.
  Stream<List<Space>> _inviterSpaces(String phone) {
    final spaces = _firestore.collection(SPACES);
    final ref = spaces.where('inviterPhones', arrayContains: phone);
    return ref.snapshots().map<List<Space>>((querySnapshot) {
      return querySnapshot.documents.map((documentSnapshot) {
        return Space.fromJson(documentSnapshot.data);
      }).toList();
    });
  }

  /// A helper method which returns true if a person with the phone number can enter the space.
  bool _canEnter(Space space, String phoneNumber) {
    return space.managerPhones.contains(phoneNumber) ||
        space.guardPhones.contains(phoneNumber) ||
        space.inviterPhones.contains(phoneNumber);
  }
}
