import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

import '../../../invite_only_auth.dart';

/// An implementation of [AuthRepository] which uses [FirebaseAuth] as the
/// authentication provider.
class FirebaseAuthRepository implements AuthRepository<AuthCredential> {
  static const String USERS = "users";

  /// The data provider for firebase authentication.
  final FirebaseAuth _firebaseAuth;

  /// The constructor for [FirebaseAuthRepository].
  ///
  /// The optional parameters are only necessary for testing purposes.
  FirebaseAuthRepository({FirebaseAuth firebaseAuth})
      : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance;

  @override
  Future<User> currentUser() async {
    FirebaseUser firebaseUser = await _firebaseAuth.currentUser();

    if (firebaseUser == null) {
      return null;
    }

    // only one user will ever be created for each firebaseAuth user.
    return User.fromFirebaseUser(firebaseUser);
  }

  @override
  Future<void> verifyPhoneNumber({
    @required String phoneNumber,
    @required Duration retrievalTimeout,
    @required Function(AuthCredential) verificationCompleted,
    @required Function(AuthException) verificationFailed,
    @required Function(String) codeSent,
  }) async {
    await _firebaseAuth.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      timeout: retrievalTimeout,
      verificationCompleted: verificationCompleted,
      verificationFailed: verificationFailed,
      codeSent: codeSent,
      codeAutoRetrievalTimeout: (verificationId) {
        //do nothing
      },
    );
  }

  @override
  AuthCredential getAuthCredential(String phoneVerificationId, String smsCode) {
    return PhoneAuthProvider.getCredential(
      verificationId: phoneVerificationId,
      smsCode: smsCode,
    );
  }

  @override
  Future<User> signInWithCredential(AuthCredential authCredential) async {
    try {
      AuthResult authResult =
          await _firebaseAuth.signInWithCredential(authCredential);

      return User.fromFirebaseUser(authResult.user);
    } catch (e) {
      throw Exception(
        'The authorization credential could not be used to sign in. Exception: $e',
      );
    }
  }
}
