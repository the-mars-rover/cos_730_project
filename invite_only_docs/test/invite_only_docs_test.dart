import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:invite_only_docs/invite_only_docs.dart';
import 'package:invite_only_docs/src/repositories/id_docs_repository/firebase_id_docs_repository.dart';
import 'package:mockito/mockito.dart';

void main() {
  group('FirebaseIdDocsRepository', () {
    // Mock and inject dependencies in the instance of FirebaseAuthRepository
    FirestoreMock firestoreMock = FirestoreMock();
    TransactionMock transactionMock = TransactionMock();
    CollectionReferenceMock collectionReferenceMock = CollectionReferenceMock();
    DocumentReferenceMock documentReferenceMock = DocumentReferenceMock();
    DocumentSnapshotMock documentSnapshotMock = DocumentSnapshotMock();
    FirebaseIdDocsRepository idDocsRepository = FirebaseIdDocsRepository(
      firestore: firestoreMock,
    );

    group('documentedUser', () {
      test('user is added then streamed', () async {
        // Mock the necessary method calls
        when(firestoreMock.collection(FirebaseIdDocsRepository.COLLECTION_NAME))
            .thenReturn(collectionReferenceMock);
        when(collectionReferenceMock.document('userId'))
            .thenReturn(documentReferenceMock);
        when(documentReferenceMock.setData(argThat(anything)))
            .thenAnswer((_) => Future.value());
        when(documentReferenceMock.snapshots()).thenAnswer(
            (_) => Stream<DocumentSnapshot>.value(documentSnapshotMock));
        when(documentSnapshotMock.data).thenReturn({'id': 'userId'});

        var documentedUser = await idDocsRepository.documentedUser('userId');
        expectLater(documentedUser, emits(DocumentedUser(id: 'userId')));
      });
    });

    group('deleteUser', () {
      test('delete the user from firestore', () async {
        // Mock the necessary method calls
        when(firestoreMock.collection(FirebaseIdDocsRepository.COLLECTION_NAME))
            .thenReturn(collectionReferenceMock);
        when(collectionReferenceMock.document('userId'))
            .thenReturn(documentReferenceMock);
        when(documentReferenceMock.delete()).thenAnswer((_) => Future.value());

        await idDocsRepository.deleteUser('userId');

        verify(documentReferenceMock.delete()).called(1);
      });
    });

    group('submitDocument', () {
      test('submitting ID Book adds an ID Book to user', () async {
        // Mock the necessary method calls
        when(firestoreMock.collection(FirebaseIdDocsRepository.COLLECTION_NAME))
            .thenReturn(collectionReferenceMock);
        when(collectionReferenceMock.document('userId'))
            .thenReturn(documentReferenceMock);
        when(documentReferenceMock.get())
            .thenAnswer((_) => Future.value(documentSnapshotMock));
        when(documentSnapshotMock.data)
            .thenReturn(DocumentedUser(id: 'userId').toJson());
        when(documentReferenceMock.updateData(
                DocumentedUser(id: 'userId', idBook: IdBook()).toJson()))
            .thenAnswer((_) => Future.value());

        await idDocsRepository.submitDocument('userId', IdBook());

        verify(
          documentReferenceMock.updateData(
            DocumentedUser(id: 'userId', idBook: IdBook()).toJson(),
          ),
        ).called(1);
      });

      test('submitting ID Card adds a ID Card to user', () async {
        // Mock the necessary method calls
        when(firestoreMock.collection(FirebaseIdDocsRepository.COLLECTION_NAME))
            .thenReturn(collectionReferenceMock);
        when(collectionReferenceMock.document('userId'))
            .thenReturn(documentReferenceMock);
        when(documentReferenceMock.get())
            .thenAnswer((_) => Future.value(documentSnapshotMock));
        when(documentSnapshotMock.data)
            .thenReturn(DocumentedUser(id: 'userId').toJson());
        when(documentReferenceMock.updateData(
                DocumentedUser(id: 'userId', idCard: IdCard()).toJson()))
            .thenAnswer((_) => Future.value());

        await idDocsRepository.submitDocument('userId', IdCard());

        verify(
          documentReferenceMock.updateData(
            DocumentedUser(id: 'userId', idCard: IdCard()).toJson(),
          ),
        ).called(1);
      });

      test('submitting Drivers adds an Drivers to user', () async {
        // Mock the necessary method calls
        when(firestoreMock.collection(FirebaseIdDocsRepository.COLLECTION_NAME))
            .thenReturn(collectionReferenceMock);
        when(collectionReferenceMock.document('userId'))
            .thenReturn(documentReferenceMock);
        when(documentReferenceMock.get())
            .thenAnswer((_) => Future.value(documentSnapshotMock));
        when(documentSnapshotMock.data)
            .thenReturn(DocumentedUser(id: 'userId').toJson());
        when(documentReferenceMock.updateData(
                DocumentedUser(id: 'userId', driversLicense: DriversLicense())
                    .toJson()))
            .thenAnswer((_) => Future.value());

        await idDocsRepository.submitDocument('userId', DriversLicense());

        verify(
          documentReferenceMock.updateData(
            DocumentedUser(id: 'userId', driversLicense: DriversLicense())
                .toJson(),
          ),
        ).called(1);
      });

      test('submitting Passport adds an Passport to user', () async {
        // Mock the necessary method calls
        when(firestoreMock.collection(FirebaseIdDocsRepository.COLLECTION_NAME))
            .thenReturn(collectionReferenceMock);
        when(collectionReferenceMock.document('userId'))
            .thenReturn(documentReferenceMock);
        when(documentReferenceMock.get())
            .thenAnswer((_) => Future.value(documentSnapshotMock));
        when(documentSnapshotMock.data)
            .thenReturn(DocumentedUser(id: 'userId').toJson());
        when(documentReferenceMock.updateData(
                DocumentedUser(id: 'userId', passport: Passport()).toJson()))
            .thenAnswer((_) => Future.value());

        await idDocsRepository.submitDocument('userId', Passport());

        verify(
          documentReferenceMock.updateData(
            DocumentedUser(id: 'userId', passport: Passport()).toJson(),
          ),
        ).called(1);
      });
    });
  });
}

class FirestoreMock extends Mock implements Firestore {}

class TransactionMock extends Mock implements Transaction {}

class CollectionReferenceMock extends Mock implements CollectionReference {}

class DocumentReferenceMock extends Mock implements DocumentReference {}

class DocumentSnapshotMock extends Mock implements DocumentSnapshot {}