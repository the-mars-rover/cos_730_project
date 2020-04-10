import 'package:invite_only_users/src/repositories/auth_repository/firebase_auth_repository.dart';

import '../../../invite_only_users.dart';

/// Provides means to authenticate users for the Invite Only platform or to
/// retrieve the currently authenticated user.
///
/// Implementations of this class will use a chosen Authentication Provider to
/// implement the necessary functionality for abstract methods. So, to support a
/// different authentication provider all that is needed is to write a new implementation
/// of this interface.
///
/// [T] is the type of the authorization credential used for implementations of
/// this class.
abstract class AuthRepository<T> {
  /// The singleton instance of [AuthRepository]. Currently, [FirebaseAuthRepository]
  /// is being used since FirebaseAuth is the preferred Authentication Provider.
  static final AuthRepository instance = FirebaseAuthRepository();

  /// Return the user that is currently signed in, or null if no user is signed in.
  Future<User> currentUser();

  /// Starts the phone number verification process for a given phone number.
  ///
  /// [phoneNumber] The phone number for the account the user is signing up
  ///   for or signing into. Make sure to pass in a phone number with country
  ///   code prefixed with plus sign ('+').
  ///
  /// [timeout] The maximum amount of time you are willing to wait for SMS
  ///   auto-retrieval to be completed by the library. Maximum allowed value
  ///   is 2 minutes. Use 0 to disable SMS-auto-retrieval. Setting this to 0
  ///   will also cause [codeAutoRetrievalTimeout] to be called immediately.
  ///   If you specified a positive value less than 30 seconds, library will
  ///   default to 30 seconds.
  ///
  /// [verificationCompleted] will trigger when an SMS is auto-retrieved or the
  ///   phone number has been instantly verified. The callback receives an authorization
  ///   credential of type [T] that can be passed to [signInWithCredential].
  ///
  /// [verificationFailed] is Triggered when an error occurred during phone number verification.
  ///
  /// [codeSent] will trigger when an SMS has been sent to the users phone, and
  ///   will include a [verificationId] to use with [getAuthCredential] when validating
  ///   an SMS code.
  Future<void> verifyPhoneNumber(
    String phoneNumber,
    Duration retrievalTimeout,
    Function(T) verificationCompleted,
    Function(Exception) verificationFailed,
    Function(String) codeSent,
  );

  /// Returns an authorization credential of type [T]
  ///
  /// [phoneVerificationId] is the verification ID obtained from the codeSent
  /// callback of [verifyPhoneNumber].
  ///
  /// [smsCode] is the SMS code submitted by the user.
  T getAuthCredential(String phoneVerificationId, String smsCode);

  /// Sign in the user using the authorization credential of type [T] provided by
  /// the verificationCompleted callback of [verifyPhoneNumber] or [getAuthCredential].
  Future<User> signInWithCredential(T authCredential);
}
