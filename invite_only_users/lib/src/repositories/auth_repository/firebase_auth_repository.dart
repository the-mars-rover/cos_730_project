import 'package:firebase_auth/firebase_auth.dart';
import 'package:invite_only_users/src/repositories/user_repository/user_repository.dart';

import '../../../invite_only_users.dart';

/// An implementation of [AuthRepository] which uses [FirebaseAuth] as the
/// authentication provider.
class FirebaseAuthRepository implements AuthRepository<AuthCredential> {
  static const String USERS = "users";

  /// The data provider for firebase authentication.
  final _firebaseAuth = FirebaseAuth.instance;

  /// The UserRepository instance for accessing stored users.
  final _userRepository = UserRepository.instance;

  @override
  Future<User> currentUser() async {
    FirebaseUser firebaseUser = await _firebaseAuth.currentUser();

    if (firebaseUser == null) {
      return null;
    }

    // only one user will ever be created for each firebaseAuth user.
    return _userRepository.getUser(firebaseUser.uid);
  }

  @override
  Future<void> verifyPhoneNumber({
    String phoneNumber,
    Duration retrievalTimeout,
    Function(AuthCredential) verificationCompleted,
    Function(AuthException) verificationFailed,
    Function(String) codeSent,
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
  Future<User> signInWithCredential(AuthCredential authCredential) async {
    try {
      AuthResult authResult =
          await _firebaseAuth.signInWithCredential(authCredential);

      var user = await _userRepository.getUser(authResult.user.uid);
      if (user == null) {
        user = User(
            id: authResult.user.uid, phoneNumber: authResult.user.phoneNumber);
        await _userRepository.addUser(user);
      }

      return user;
    } catch (e) {
      throw Exception(
        'The authorization credential could not be used to sign in. Exception: $e',
      );
    }
  }

  @override
  AuthCredential getAuthCredential(String phoneVerificationId, String smsCode) {
    return PhoneAuthProvider.getCredential(
      verificationId: phoneVerificationId,
      smsCode: smsCode,
    );
  }
}