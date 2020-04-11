//import 'package:firebase_auth/firebase_auth.dart';
//import 'package:flutter_test/flutter_test.dart';
//import 'package:invite_only_users/invite_only_auth.dart';
//import 'package:invite_only_users/src/repositories/auth_repository/firebase_auth_repository.dart';
//import 'package:mockito/mockito.dart';
//
//class FirebaseAuthMock extends Mock implements FirebaseAuth {}
//
//class UserInfoMock extends Mock implements UserInfo {
//  @override
//  String get providerId => PhoneAuthProvider.providerId;
//
//  @override
//  String get uid => 'userId';
//
//  @override
//  String get phoneNumber => '+27824445555';
//}
//
//class UserRepositoryMock extends Mock implements UserRepository {}
//
//const User kTestUser = User(id: 'userId', phoneNumber: '+27824445555');
//
//void main() {
//  group('FirebaseAuthRepository', () {
//    // Mock and inject dependencies in the instance of FirebaseAuthRepository
//    FirebaseAuthMock firebaseAuthMock = FirebaseAuthMock();
//    UserRepositoryMock userRepositoryMock = UserRepositoryMock();
//    FirebaseAuthRepository firebaseAuthRepository = FirebaseAuthRepository(
//      firebaseAuth: firebaseAuthMock,
//      userRepository: userRepositoryMock,
//    );
//
//    group('currentUser', () {
//      test('returns the current user when there is an authenticated user',
//          () async {
//        // Mock the necessary method calls
//        when(firebaseAuthMock.currentUser())
//            .thenReturn(Future<FirebaseUser>.value(kTestUser));
//
//        var user = await firebaseAuthRepository.currentUser();
//        expect(_authRepository, isA<FirebaseAuthRepository>());
//      });
//    });
//  });
//}
