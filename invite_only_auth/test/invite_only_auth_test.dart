import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:invite_only_auth/invite_only_auth.dart';
import 'package:invite_only_auth/src/repositories/auth_repository/firebase_auth_repository.dart';
import 'package:mockito/mockito.dart';

class FirebaseAuthMock extends Mock implements FirebaseAuth {}

class FirebaseUserMock extends Mock implements FirebaseUser {
  @override
  String get providerId => PhoneAuthProvider.providerId;

  @override
  String get uid => 'userId';

  @override
  String get phoneNumber => '+27824445555';
}

class AuthResultMock extends Mock implements AuthResult {
  @override
  FirebaseUser get user => FirebaseUserMock();
}

const kVerificationId = 'verificationId';

const kSmsCode = '000000';

final kCredential = PhoneAuthProvider.getCredential(
  verificationId: kVerificationId,
  smsCode: kSmsCode,
);

final kUser = User.fromFirebaseUser(FirebaseUserMock());

void main() {
  group('FirebaseAuthRepository', () {
    // Mock and inject dependencies in the instance of FirebaseAuthRepository
    FirebaseAuthMock firebaseAuthMock = FirebaseAuthMock();
    FirebaseAuthRepository firebaseAuthRepository = FirebaseAuthRepository(
      firebaseAuth: firebaseAuthMock,
    );

    group('currentUser', () {
      test('returns the current user when there is an authenticated user',
          () async {
        // Mock the necessary method calls
        when(firebaseAuthMock.currentUser()).thenAnswer(
          (_) => Future<FirebaseUser>.value(FirebaseUserMock()),
        );

        var user = await firebaseAuthRepository.currentUser();
        expect(user, equals(kUser));
      });

      test('returns null when there is not an authenticated user', () async {
        // Mock the necessary method calls
        when(firebaseAuthMock.currentUser()).thenAnswer(
          (_) => Future<FirebaseUser>.value(null),
        );

        var user = await firebaseAuthRepository.currentUser();
        expect(user, isNull);
      });
    });

    group('getAuthCredential', () {
      test('returns an AuthCredential provided by PhoneAuthProvider', () {
        AuthCredential authCredential = firebaseAuthRepository
            .getAuthCredential('verificationId', '000000');
        expect(authCredential.providerId, equals(PhoneAuthProvider.providerId));
      });
    });

    group('signInWithCredential', () {
      test('returns a the User when sign in is successful', () async {
        // Mock the necessary method calls
        when(firebaseAuthMock.signInWithCredential(kCredential)).thenAnswer(
          (_) => Future<AuthResult>.value(AuthResultMock()),
        );

        var user =
            await firebaseAuthRepository.signInWithCredential(kCredential);
        expect(user, equals(kUser));
      });

      test('returns a the User when sign in is unsuccessful', () async {
        // Mock the necessary method calls
        when(firebaseAuthMock.signInWithCredential(kCredential)).thenAnswer(
          (_) => Future.error(
            AuthException(
              'ERROR_INVALID_CREDENTIAL',
              'the credential data is malformed or has expired.',
            ),
          ),
        );

        try {
          await firebaseAuthRepository.signInWithCredential(kCredential);
        } catch (e) {
          expect(
            e.message,
            startsWith(
              'The authorization credential could not be used to sign in.',
            ),
          );
        }
      });
    });
  });
}
