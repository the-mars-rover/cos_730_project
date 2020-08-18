import 'dart:convert';
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:invite_only_repo/invite_only_repo.dart';
import 'package:invite_only_repo/src/models/invite/invite.dart';
import 'package:invite_only_repo/src/repositories/invite_only_repo_impl.dart';
import 'package:mockito/mockito.dart';

final kUrl = 'https://core.inviteonly.born.dev';

final kPhone = '+27823335555';

final kToken = 'token';

final kIdBook = IdBook(
    idNumber: '8803195800080',
    gender: 'M',
    birthDate: DateTime(1988, 3, 19),
    citizenshipStatus: 'SA Citizen');

final kIdCard = IdCard(
  idNumber: '8803195800080',
  gender: 'M',
  birthDate: DateTime(1988, 3, 19),
  citizenshipStatus: 'SA Citizen',
  countryOfBirth: 'ZA',
  firstNames: 'John',
  surname: 'Snow',
  issueDate: DateTime(2019, 09, 14),
  nationality: 'ZA',
  smartIdNumber: '0',
);

final kSpace = Space(
  title: 'test Space',
  managerPhones: Set.from([kPhone]),
  guardPhones: Set(),
  inviterPhones: Set(),
);

final kInvite = Invite(
  code: '0000',
  inviterPhone: kPhone,
  expiryDate: DateTime.now().add(Duration(days: 2)),
);

main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  final firebaseAuth = MockFirebaseAuth();

  final firebaseUser = MockFirebaseUser();

  final authCredential = MockAuthCredential();

  final client = MockClient();

  final inviteOnlyRepo = InviteOnlyRepoImpl.getInstance(
    kUrl,
    firebaseAuth: firebaseAuth,
    client: client,
  );

  group('currentUser', () {
    test(
        'given no currently authenticated user - when called - then return null',
        () async {
      // given
      when(firebaseAuth.currentUser).thenReturn(null);

      // when
      String currentPhone = inviteOnlyRepo.currentUser();

      // then
      expect(currentPhone, isNull);
    });

    test(
        'given there is an authenticated user - when called - then return user phone',
        () async {
      // given
      when(firebaseAuth.currentUser).thenReturn(firebaseUser);

      // when
      String currentPhone = inviteOnlyRepo.currentUser();

      // then
      expect(currentPhone, equals(kPhone));
    });
  });

  group('verifyPhoneNumber', () {
    test(
        'given valid fields - when called - then FirebaseAuth.verifyPhoneNumber',
        () async {
      // given when
      await inviteOnlyRepo.verifyPhoneNumber(
          phoneNumber: kPhone,
          retrievalTimeout: Duration(seconds: 30),
          verificationCompleted: (cred) {},
          verificationFailed: (e) {},
          codeSent: (code, [forceResendingToken]) {});

      // then
      verify(firebaseAuth.verifyPhoneNumber(
          phoneNumber: anyNamed('phoneNumber'),
          timeout: anyNamed('timeout'),
          verificationCompleted: anyNamed('verificationCompleted'),
          verificationFailed: anyNamed('verificationFailed'),
          codeSent: anyNamed('codeSent'),
          codeAutoRetrievalTimeout: anyNamed('codeAutoRetrievalTimeout')));
    });
  });

  group('getAuthCredential', () {
    test(
        'given valid fields - when called - then PhoneAuthProvider.getCredential',
        () async {
      // given
      final verId = 'verificationId';
      final code = 'smsCode';

      // given when
      final cred = inviteOnlyRepo.getAuthCredential(verId, code);

      // then
      final firebaseCred =
          PhoneAuthProvider.credential(verificationId: verId, smsCode: code);
      expect(cred.credential.toString(), firebaseCred.toString());
    });
  });

  group('signInWithCredential', () {
    test(
        'given sign in credential - when sign in failed - then throw AuthFailure',
        () async {
      // given
      final cred = InviteOnlyCredential(authCredential);

      // when
      when(firebaseAuth.signInWithCredential(cred.credential)).thenAnswer(
        (_) => Future.error(Exception('ERROR_INVALID_CREDENTIAL')),
      );
      try {
        await inviteOnlyRepo.signInWithCredential(cred);
      } catch (e) {
        // then
        expect(e, isInstanceOf<AuthFailure>());
      }
    });

    test(
        'given sign in credential - when sign in succeeded - then no exception',
        () async {
      // given
      final cred = InviteOnlyCredential(authCredential);

      // when then
      when(firebaseAuth.signInWithCredential(cred.credential)).thenAnswer(
        (_) => Future.value(),
      );
      await inviteOnlyRepo.signInWithCredential(cred);
    });
  });

  group('signOut', () {
    test(
        'given any preconditions - when called - then FirebaseAuth.signOut is called',
        () async {
      // given when
      await inviteOnlyRepo.signOut();

      //then
      verify(firebaseAuth.signOut());
    });
  });

  group('addIdDocument', () {
    test(
        'given an ID Document - when no authenticated user - then throw Unauthenticated',
        () async {
      // given
      final idDoc = kIdBook;

      // when
      when(firebaseAuth.currentUser).thenReturn(null);
      try {
        await inviteOnlyRepo.addIdDocument(idDoc);
      } catch (e) {
        // then
        expect(e, isInstanceOf<Unauthenticated>());
      }
    });

    test(
        'given an ID Document - when document already exists (HttpStatus.conflict) - then throw Conflict',
        () async {
      // given
      final idDoc = kIdBook;

      // when
      when(firebaseAuth.currentUser).thenReturn(firebaseUser);
      when(client.post(
        '$kUrl/docs',
        headers: {
          'Authorization': 'Bearer $kToken',
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: json.encode(idDoc.toJson()),
      )).thenAnswer((_) async => http.Response('', HttpStatus.conflict));
      try {
        await inviteOnlyRepo.addIdDocument(idDoc);
      } catch (e) {
        // then
        expect(e, isInstanceOf<Conflict>());
      }
    });

    test(
        'given an ID Document - when unknown or unhandled error - then throw UnknownError',
        () async {
      // given
      final idDoc = kIdBook;

      // when
      when(firebaseAuth.currentUser).thenReturn(firebaseUser);
      when(client.post(
        '$kUrl/docs',
        headers: {
          'Authorization': 'Bearer $kToken',
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: json.encode(idDoc.toJson()),
      )).thenAnswer((_) async => http.Response('', HttpStatus.badRequest));
      try {
        await inviteOnlyRepo.addIdDocument(idDoc);
      } catch (e) {
        // then
        expect(e, isInstanceOf<UnknownError>());
      }
    });

    test(
        'given an ID Document - when created (HttpStatus.created) - then return created document',
        () async {
      // given
      final idDoc = kIdBook;

      // when
      when(firebaseAuth.currentUser).thenReturn(firebaseUser);
      final resp = idDoc.copyWith(id: 0, phoneNumber: kPhone);
      when(client.post('$kUrl/docs',
              headers: {
                'Authorization': 'Bearer $kToken',
                'Content-Type': 'application/json; charset=UTF-8',
              },
              body: json.encode(idDoc.toJson())))
          .thenAnswer((_) async =>
              http.Response(json.encode(resp.toJson()), HttpStatus.created));
      final saved = await inviteOnlyRepo.addIdDocument(idDoc);

      // then
      expect(saved, equals(resp));
    });
  });

  group('fetchIdDocuments', () {
    test(
        'given no authenticated user - when fetch ID documents - then throw Unauthenticated',
        () async {
      // given when
      when(firebaseAuth.currentUser).thenReturn(null);
      try {
        await inviteOnlyRepo.fetchIdDocuments();
      } catch (e) {
        // then
        expect(e, isInstanceOf<Unauthenticated>());
      }
    });

    test(
        'given authenticated user - when fetch ID documents and unknown or unhandled error - then throw UnknownError',
        () async {
      // given
      when(firebaseAuth.currentUser).thenReturn(firebaseUser);

      // when
      when(client.get(
        '$kUrl/docs',
        headers: {'Authorization': 'Bearer $kToken'},
      )).thenAnswer((_) async => http.Response('', HttpStatus.badRequest));
      try {
        await inviteOnlyRepo.fetchIdDocuments();
      } catch (e) {
        // then
        expect(e, isInstanceOf<UnknownError>());
      }
    });

    test(
        'given authenticated user - when fetch ID documents - then return documents',
        () async {
      // given
      when(firebaseAuth.currentUser).thenReturn(firebaseUser);

      // when
      final resp = [
        kIdBook.copyWith(id: 0, phoneNumber: kPhone),
        kIdCard.copyWith(id: 1, phoneNumber: kPhone),
      ];
      when(client.get(
        '$kUrl/docs',
        headers: {'Authorization': 'Bearer $kToken'},
      )).thenAnswer(
          (_) async => http.Response(json.encode(resp), HttpStatus.ok));
      final saved = await inviteOnlyRepo.fetchIdDocuments();

      // then
      expect(saved, equals(resp));
    });
  });

  group('deleteIdDocument', () {
    test(
        'given no authenticated user - when delete document - then throw Unauthenticated',
        () async {
      // given
      when(firebaseAuth.currentUser).thenReturn(null);

      try {
        // when
        await inviteOnlyRepo.deleteIdDocument(kIdBook);
      } catch (e) {
        // then
        expect(e, isInstanceOf<Unauthenticated>());
      }
    });

    test(
        'given authenticated user - when delete document and document not found - then throw NotFound',
        () async {
      // given
      when(firebaseAuth.currentUser).thenReturn(firebaseUser);

      // when
      final idBook = kIdBook.copyWith(id: 0, phoneNumber: kPhone);
      when(client.delete(
        '$kUrl/docs/${idBook.id}',
        headers: {'Authorization': 'Bearer $kToken'},
      )).thenAnswer((_) async => http.Response('', HttpStatus.notFound));
      try {
        await inviteOnlyRepo.deleteIdDocument(idBook);
      } catch (e) {
        // then
        expect(e, isInstanceOf<NotFound>());
      }
    });

    test(
        'given authenticated user - when delete document and user unauthorized - then throw Unauthorized',
        () async {
      // given
      when(firebaseAuth.currentUser).thenReturn(firebaseUser);

      // when
      final idBook = kIdBook.copyWith(id: 0, phoneNumber: kPhone);
      when(client.delete(
        '$kUrl/docs/${idBook.id}',
        headers: {'Authorization': 'Bearer $kToken'},
      )).thenAnswer((_) async => http.Response('', HttpStatus.forbidden));
      try {
        await inviteOnlyRepo.deleteIdDocument(idBook);
      } catch (e) {
        // then
        expect(e, isInstanceOf<Unauthorized>());
      }
    });

    test(
        'given authenticated user - when delete document and unknown or unhandled error - then throw UnknownError',
        () async {
      // given
      when(firebaseAuth.currentUser).thenReturn(firebaseUser);

      // when
      final idBook = kIdBook.copyWith(id: 0, phoneNumber: kPhone);
      when(client.delete(
        '$kUrl/docs/${idBook.id}',
        headers: {'Authorization': 'Bearer $kToken'},
      )).thenAnswer((_) async => http.Response('', HttpStatus.badRequest));
      try {
        await inviteOnlyRepo.deleteIdDocument(idBook);
      } catch (e) {
        // then
        expect(e, isInstanceOf<UnknownError>());
      }
    });

    test(
        'given authenticated user - when delete document - then no error is thrown',
        () async {
      // given
      when(firebaseAuth.currentUser).thenReturn(firebaseUser);

      // when then
      final idBook = kIdBook.copyWith(id: 0, phoneNumber: kPhone);
      when(client.delete(
        '$kUrl/docs/${idBook.id}',
        headers: {'Authorization': 'Bearer $kToken'},
      )).thenAnswer((_) async => http.Response('', HttpStatus.ok));
      await inviteOnlyRepo.deleteIdDocument(idBook);
    });
  });

  group('addSpace', () {
    test(
        'given no authenticated user - when add space - then throw Unauthenticated',
        () async {
      // given
      when(firebaseAuth.currentUser).thenReturn(null);

      // when
      try {
        await inviteOnlyRepo.addSpace(kSpace);
      } catch (e) {
        // then
        expect(e, isInstanceOf<Unauthenticated>());
      }
    });

    test(
        'given authenticated user - when add space and unknown or unhandled error - then throw UnknownError',
        () async {
      // given
      when(firebaseAuth.currentUser).thenReturn(firebaseUser);

      // when
      when(client.post(
        '$kUrl/spaces',
        headers: {
          'Authorization': 'Bearer $kToken',
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: json.encode(kSpace.toJson()),
      )).thenAnswer((_) async => http.Response('', HttpStatus.badRequest));
      try {
        await inviteOnlyRepo.addSpace(kSpace);
      } catch (e) {
        // then
        expect(e, isInstanceOf<UnknownError>());
      }
    });

    test(
        'given authenticated user - when add space - then return created space',
        () async {
      // given
      when(firebaseAuth.currentUser).thenReturn(firebaseUser);

      // when
      final created = kSpace.copyWith(id: 0);
      when(client.post('$kUrl/spaces',
              headers: {
                'Authorization': 'Bearer $kToken',
                'Content-Type': 'application/json; charset=UTF-8',
              },
              body: json.encode(kSpace.toJson())))
          .thenAnswer((_) async =>
              http.Response(json.encode(created.toJson()), HttpStatus.created));
      final saved = await inviteOnlyRepo.addSpace(kSpace);

      // then
      expect(saved, equals(created));
    });
  });

  group('fetchSpaces', () {
    test(
        'given no authenticated user - when fetch spaces - then throw Unauthenticated',
        () async {
      // given
      when(firebaseAuth.currentUser).thenReturn(null);

      // when
      try {
        await inviteOnlyRepo.fetchSpaces();
      } catch (e) {
        // then
        expect(e, isInstanceOf<Unauthenticated>());
      }
    });

    test(
        'given authenticated user - when fetch spaces and unknown or unhandled error - then throw UnknownError',
        () async {
      // given
      when(firebaseAuth.currentUser).thenReturn(firebaseUser);

      // when
      when(client.get(
        '$kUrl/spaces',
        headers: {'Authorization': 'Bearer $kToken'},
      )).thenAnswer((_) async => http.Response('', HttpStatus.badRequest));
      try {
        await inviteOnlyRepo.fetchSpaces();
      } catch (e) {
        // then
        expect(e, isInstanceOf<UnknownError>());
      }
    });

    test(
        'given authenticated user - when fetch spaces - then return list of spaces',
        () async {
      // given
      when(firebaseAuth.currentUser).thenReturn(firebaseUser);

      // when
      final resp = [
        kSpace.copyWith(id: 0, title: 'Test Space 1'),
        kSpace.copyWith(id: 1, title: 'Test Space 2'),
      ];
      when(client.get(
        '$kUrl/spaces',
        headers: {'Authorization': 'Bearer $kToken'},
      )).thenAnswer(
          (_) async => http.Response(json.encode(resp), HttpStatus.ok));
      final saved = await inviteOnlyRepo.fetchSpaces();

      // then
      expect(saved, equals(resp));
    });
  });

  group('updateSpace', () {
    test(
        'given no authenticated user - when update space - then throw Unauthenticated',
        () async {
      // given
      when(firebaseAuth.currentUser).thenReturn(null);

      // when
      try {
        await inviteOnlyRepo.updateSpace(kSpace);
      } catch (e) {
        // then
        expect(e, isInstanceOf<Unauthenticated>());
      }
    });

    test(
        'given authenticated user - when update space and space not found - then throw NotFound',
        () async {
      // given
      when(firebaseAuth.currentUser).thenReturn(firebaseUser);

      // when
      final updating = kSpace.copyWith(id: 0);
      when(client.put(
        '$kUrl/spaces/${updating.id}',
        headers: {
          'Authorization': 'Bearer $kToken',
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: json.encode(updating.toJson()),
      )).thenAnswer((_) async => http.Response('', HttpStatus.notFound));
      try {
        await inviteOnlyRepo.updateSpace(updating);
      } catch (e) {
        // then
        expect(e, isInstanceOf<NotFound>());
      }
    });

    test(
        'given authenticated user - when update space and user unauthorized - then throw Unauthorized',
        () async {
      // given
      when(firebaseAuth.currentUser).thenReturn(firebaseUser);

      // when
      final updating = kSpace.copyWith(id: 0);
      when(client.put(
        '$kUrl/spaces/${updating.id}',
        headers: {
          'Authorization': 'Bearer $kToken',
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: json.encode(updating.toJson()),
      )).thenAnswer((_) async => http.Response('', HttpStatus.forbidden));
      try {
        await inviteOnlyRepo.updateSpace(updating);
      } catch (e) {
        // then
        expect(e, isInstanceOf<Unauthorized>());
      }
    });

    test(
        'given authenticated user - when update space and unknown or unhandled error - then throw UnknownError',
        () async {
      // given
      when(firebaseAuth.currentUser).thenReturn(firebaseUser);

      // when
      final updating = kSpace.copyWith(id: 0);
      when(client.put(
        '$kUrl/spaces/${updating.id}',
        headers: {
          'Authorization': 'Bearer $kToken',
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: json.encode(updating.toJson()),
      )).thenAnswer((_) async => http.Response('', HttpStatus.badRequest));
      try {
        await inviteOnlyRepo.updateSpace(updating);
      } catch (e) {
        // then
        expect(e, isInstanceOf<UnknownError>());
      }
    });

    test(
        'given authenticated user - when update space - then return updated space',
        () async {
      // given
      when(firebaseAuth.currentUser).thenReturn(firebaseUser);

      // when
      final updating = kSpace.copyWith(id: 0);
      when(client.put('$kUrl/spaces/${updating.id}',
              headers: {
                'Authorization': 'Bearer $kToken',
                'Content-Type': 'application/json; charset=UTF-8',
              },
              body: json.encode(updating.toJson())))
          .thenAnswer((_) async =>
              http.Response(json.encode(updating.toJson()), HttpStatus.ok));
      final saved = await inviteOnlyRepo.updateSpace(updating);

      // then
      expect(saved, equals(updating));
    });
  });

  group('deleteSpace', () {
    test(
        'given no authenticated user - when delete space - then throw Unauthenticated',
        () async {
      // given
      when(firebaseAuth.currentUser).thenReturn(null);

      try {
        // when
        await inviteOnlyRepo.deleteSpace(kSpace);
      } catch (e) {
        // then
        expect(e, isInstanceOf<Unauthenticated>());
      }
    });

    test(
        'given authenticated user - when delete space and space not found - then throw NotFound',
        () async {
      // given
      when(firebaseAuth.currentUser).thenReturn(firebaseUser);

      // when
      final deleting = kSpace.copyWith(id: 0);
      when(client.delete(
        '$kUrl/spaces/${deleting.id}',
        headers: {'Authorization': 'Bearer $kToken'},
      )).thenAnswer((_) async => http.Response('', HttpStatus.notFound));
      try {
        await inviteOnlyRepo.deleteSpace(deleting);
      } catch (e) {
        // then
        expect(e, isInstanceOf<NotFound>());
      }
    });

    test(
        'given authenticated user - when delete space and user unauthorized - then throw Unauthorized',
        () async {
      // given
      when(firebaseAuth.currentUser).thenReturn(firebaseUser);

      // when
      final deleting = kSpace.copyWith(id: 0);
      when(client.delete(
        '$kUrl/spaces/${deleting.id}',
        headers: {'Authorization': 'Bearer $kToken'},
      )).thenAnswer((_) async => http.Response('', HttpStatus.forbidden));
      try {
        await inviteOnlyRepo.deleteSpace(deleting);
      } catch (e) {
        // then
        expect(e, isInstanceOf<Unauthorized>());
      }
    });

    test(
        'given authenticated user - when delete space and unknown or unhandled error - then throw UnknownError',
        () async {
      // given
      when(firebaseAuth.currentUser).thenReturn(firebaseUser);

      // when
      final deleting = kSpace.copyWith(id: 0);
      when(client.delete(
        '$kUrl/spaces/${deleting.id}',
        headers: {'Authorization': 'Bearer $kToken'},
      )).thenAnswer((_) async => http.Response('', HttpStatus.badRequest));
      try {
        await inviteOnlyRepo.deleteSpace(deleting);
      } catch (e) {
        // then
        expect(e, isInstanceOf<UnknownError>());
      }
    });

    test(
        'given authenticated user - when delete space - then no errors are thrown',
        () async {
      // given
      when(firebaseAuth.currentUser).thenReturn(firebaseUser);

      // when then
      final deleting = kSpace.copyWith(id: 0);
      when(client.delete(
        '$kUrl/spaces/${deleting.id}',
        headers: {'Authorization': 'Bearer $kToken'},
      )).thenAnswer((_) async => http.Response('', HttpStatus.ok));
      await inviteOnlyRepo.deleteSpace(deleting);
    });
  });

  group('createInvite', () {
    test(
        'given no authenticated user - when create invite - then throw Unauthenticated',
        () async {
      // given
      when(firebaseAuth.currentUser).thenReturn(null);

      // when
      try {
        await inviteOnlyRepo.createInvite(kSpace);
      } catch (e) {
        // then
        expect(e, isInstanceOf<Unauthenticated>());
      }
    });

    test(
        'given authenticated user - when create invite and space not found - then throw NotFound',
        () async {
      // given
      when(firebaseAuth.currentUser).thenReturn(firebaseUser);

      // when
      final space = kSpace.copyWith(id: 0);
      when(client.post(
        '$kUrl/spaces/${space.id}/invites',
        headers: {'Authorization': 'Bearer $kToken'},
      )).thenAnswer((_) async => http.Response('', HttpStatus.notFound));
      try {
        await inviteOnlyRepo.createInvite(space);
      } catch (e) {
        // then
        expect(e, isInstanceOf<NotFound>());
      }
    });

    test(
        'given authenticated user - when create invite and user unauthorized - then throw Unauthorized',
        () async {
      // given
      when(firebaseAuth.currentUser).thenReturn(firebaseUser);

      // when
      final space = kSpace.copyWith(id: 0);
      when(client.post(
        '$kUrl/spaces/${space.id}/invites',
        headers: {'Authorization': 'Bearer $kToken'},
      )).thenAnswer((_) async => http.Response('', HttpStatus.forbidden));
      try {
        await inviteOnlyRepo.createInvite(space);
      } catch (e) {
        // then
        expect(e, isInstanceOf<Unauthorized>());
      }
    });

    test(
        'given authenticated user - when create invite and unknown or unhandled error - then throw UnknownError',
        () async {
      // given
      when(firebaseAuth.currentUser).thenReturn(firebaseUser);

      // when
      final space = kSpace.copyWith(id: 0);
      when(client.post(
        '$kUrl/spaces/${space.id}/invites',
        headers: {'Authorization': 'Bearer $kToken'},
      )).thenAnswer((_) async => http.Response('', HttpStatus.badRequest));
      try {
        await inviteOnlyRepo.createInvite(space);
      } catch (e) {
        // then
        expect(e, isInstanceOf<UnknownError>());
      }
    });

    test(
        'given authenticated user - when create invite - then return created invite',
        () async {
      // given
      when(firebaseAuth.currentUser).thenReturn(firebaseUser);

      // when
      final space = kSpace.copyWith(id: 0);
      final created = kInvite;
      when(client.post(
        '$kUrl/spaces/${space.id}/invites',
        headers: {'Authorization': 'Bearer $kToken'},
      )).thenAnswer((_) async =>
          http.Response(jsonEncode(created.toJson()), HttpStatus.created));
      final returned = await inviteOnlyRepo.createInvite(space);
      expect(returned, equals(created));
    });
  });

  group('addEntry', () {
    test(
        'given no authenticated user - when add entry - then throw Unauthenticated',
        () async {
      // given
      when(firebaseAuth.currentUser).thenReturn(null);

      // when
      try {
        await inviteOnlyRepo.addEntry(kSpace, kIdBook);
      } catch (e) {
        // then
        expect(e, isInstanceOf<Unauthenticated>());
      }
    });

    test(
        'given authenticated user - when add entry and space not found - then throw NotFound',
        () async {
      // given
      when(firebaseAuth.currentUser).thenReturn(firebaseUser);

      // when
      final space = kSpace.copyWith(id: 0);
      when(client.post(
        '$kUrl/spaces/${space.id}/entries',
        headers: {
          'Authorization': 'Bearer $kToken',
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: json.encode(kIdBook.toJson()),
      )).thenAnswer((_) async => http.Response('', HttpStatus.notFound));
      try {
        await inviteOnlyRepo.addEntry(space, kIdBook);
      } catch (e) {
        // then
        expect(e, isInstanceOf<NotFound>());
      }
    });

    test(
        'given authenticated user - when add entry and user unauthorized - then throw Unauthorized',
        () async {
      // given
      when(firebaseAuth.currentUser).thenReturn(firebaseUser);

      // when
      final space = kSpace.copyWith(id: 0);
      when(client.post(
        '$kUrl/spaces/${space.id}/entries',
        headers: {
          'Authorization': 'Bearer $kToken',
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: json.encode(kIdBook.toJson()),
      )).thenAnswer((_) async => http.Response('', HttpStatus.forbidden));
      try {
        await inviteOnlyRepo.addEntry(space, kIdBook);
      } catch (e) {
        // then
        expect(e, isInstanceOf<Unauthorized>());
      }
    });

    test(
        'given authenticated user - when add entry invite invite code - then throw InvalidInvite',
        () async {
      // given
      when(firebaseAuth.currentUser).thenReturn(firebaseUser);

      // when
      final space = kSpace.copyWith(id: 0);
      when(client.post(
        '$kUrl/spaces/${space.id}/entries?inviteCode=${kInvite.code}',
        headers: {
          'Authorization': 'Bearer $kToken',
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: json.encode(kIdBook.toJson()),
      )).thenAnswer((_) async => http.Response('', HttpStatus.notAcceptable));
      try {
        await inviteOnlyRepo.addEntry(space, kIdBook, kInvite.code);
      } catch (e) {
        // then
        expect(e, isInstanceOf<InvalidInvite>());
      }
    });

    test(
        'given authenticated user - when add entry and unknown or unhandled error - then throw UnknownError',
        () async {
      // given
      when(firebaseAuth.currentUser).thenReturn(firebaseUser);

      // when
      final space = kSpace.copyWith(id: 0);
      when(client.post(
        '$kUrl/spaces/${space.id}/entries',
        headers: {
          'Authorization': 'Bearer $kToken',
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: json.encode(kIdBook.toJson()),
      )).thenAnswer((_) async => http.Response('', HttpStatus.badRequest));
      try {
        await inviteOnlyRepo.addEntry(space, kIdBook);
      } catch (e) {
        // then
        expect(e, isInstanceOf<UnknownError>());
      }
    });

    test(
        'given authenticated user - when add entry - then return entry that was added',
        () async {
      // given
      when(firebaseAuth.currentUser).thenReturn(firebaseUser);

      // when
      final space = kSpace.copyWith(id: 0);
      final created = Entry(
          guardPhone: kPhone, entryDate: DateTime.now(), idDocument: kIdBook);
      when(client.post(
        '$kUrl/spaces/${space.id}/entries',
        headers: {
          'Authorization': 'Bearer $kToken',
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: json.encode(kIdBook.toJson()),
      )).thenAnswer((_) async =>
          http.Response(jsonEncode(created.toJson()), HttpStatus.created));
      final returned = await inviteOnlyRepo.addEntry(space, kIdBook);

      // then
      expect(returned, equals(created));
    });
  });

  group('fetchEntries', () {
    test(
        'given no authenticated user - when fetch entries - then throw Unauthenticated',
        () async {
      // given
      when(firebaseAuth.currentUser).thenReturn(null);

      // when
      try {
        await inviteOnlyRepo.fetchEntries(kSpace, 10, 0);
      } catch (e) {
        // then
        expect(e, isInstanceOf<Unauthenticated>());
      }
    });

    test(
        'given authenticated user - when fetch entries and apce not found - then throw NotFound',
        () async {
      // given
      when(firebaseAuth.currentUser).thenReturn(firebaseUser);

      // when
      final space = kSpace.copyWith(id: 0);
      when(client.get(
        '$kUrl/spaces/${space.id}/entries?page=0&size=10&sort=entryDate,DESC',
        headers: {'Authorization': 'Bearer $kToken'},
      )).thenAnswer((_) async => http.Response('', HttpStatus.notFound));
      try {
        await inviteOnlyRepo.fetchEntries(space, 10, 0);
      } catch (e) {
        // then
        expect(e, isInstanceOf<NotFound>());
      }
    });

    test(
        'given authenticated user - when fetch entries and unknown or unhandled error - then throw UnknownError',
        () async {
      // given
      when(firebaseAuth.currentUser).thenReturn(firebaseUser);

      // when
      final space = kSpace.copyWith(id: 0);
      when(client.get(
        '$kUrl/spaces/${space.id}/entries?page=0&size=10&sort=entryDate,DESC',
        headers: {'Authorization': 'Bearer $kToken'},
      )).thenAnswer((_) async => http.Response('', HttpStatus.badRequest));
      try {
        await inviteOnlyRepo.fetchEntries(space, 10, 0);
      } catch (e) {
        // then
        expect(e, isInstanceOf<UnknownError>());
      }
    });

    test(
        'given authenticated user - when fetch entries - then return list of entries',
        () async {
      // given
      when(firebaseAuth.currentUser).thenReturn(firebaseUser);

      // when
      final space = kSpace.copyWith(id: 0);
      final entries = [
        Entry(
            guardPhone: kPhone, entryDate: DateTime.now(), idDocument: kIdBook),
        Entry(
            guardPhone: kPhone, entryDate: DateTime.now(), idDocument: kIdBook),
      ];
      when(client.get(
        '$kUrl/spaces/${space.id}/entries?page=0&size=10&sort=entryDate,DESC',
        headers: {'Authorization': 'Bearer $kToken'},
      )).thenAnswer((_) async =>
          http.Response(json.encode({'content': entries}), HttpStatus.ok));
      final saved = await inviteOnlyRepo.fetchEntries(space, 10, 0);

      // then
      expect(saved, equals(entries));
    });
  });
}

class MockFirebaseAuth extends Mock implements FirebaseAuth {}

class MockFirebaseUser extends Mock implements User {
  @override
  String get phoneNumber => kPhone;

  @override
  Future<IdTokenResult> getIdTokenResult([bool forceRefresh = false]) {
    return Future.value(MockIdTokenResult());
  }
}

class MockAuthCredential extends Mock implements AuthCredential {}

class MockIdTokenResult extends Mock implements IdTokenResult {
  @override
  DateTime get expirationTime => DateTime.now().add(Duration(hours: 1));

  @override
  String get token => kToken;
}

class MockClient extends Mock implements http.Client {}
