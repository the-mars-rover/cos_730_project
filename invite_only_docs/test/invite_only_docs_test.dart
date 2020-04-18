import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:invite_only_docs/invite_only_docs.dart';
import 'package:invite_only_docs/src/repositories/id_docs_repository/firebase_id_docs_repository.dart';
import 'package:mockito/mockito.dart';

final kTestIdBook = IdDocument.idBook(
  idNumber: '5809155800088',
  gender: 'M',
  birthDate: DateTime(1958, 9, 15),
  citizenshipStatus: 'SA Citizen',
);

final kTestIdCard = IdDocument.idCard(
  idNumber: '5809155800088',
  firstNames: 'Stefanus Petrus',
  surname: 'Rautenbach',
  gender: 'M',
  birthDate: DateTime(1958, 9, 15),
  issueDate: DateTime(2015, 5, 20),
  smartIdNumber: '000000000',
  nationality: 'ZA',
  countryOfBirth: 'ZA',
  citizenshipStatus: 'SA Citizen',
);

final kTestDriversLicense = IdDocument.driversLicense(
  idNumber: '5809155800088',
  firstNames: 'Stefanus Petrus',
  surname: 'Rautenbach',
  gender: 'M',
  birthDate: DateTime(1958, 9, 15),
  issueDates: DateTime(2015, 5, 20),
  licenseNumber: '0000000000',
  vehicleCodes: ['B'],
  prdpCode: 'prdpCode',
  idCountryOfIssue: 'ZA',
  licenseCountryOfIssue: 'ZA',
  vehicleRestrictions: ['02'],
  idNumberType: '02',
  driverRestrictions: '00',
  prdpExpiry: DateTime(2025, 5, 20),
  licenseIssueNumber: '00000000',
  validFrom: DateTime(2015, 5, 20),
  validTo: DateTime(2025, 5, 20),
);

void main() {
  group('FirebaseIdDocsRepository', () {
    // Mock and inject dependencies in the instance of FirebaseAuthRepository
    FirestoreMock firestoreMock = FirestoreMock();
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
        when(collectionReferenceMock.document('phoneNumber'))
            .thenReturn(documentReferenceMock);
        when(documentReferenceMock.setData(argThat(anything)))
            .thenAnswer((_) => Future.value());
        when(documentReferenceMock.snapshots()).thenAnswer(
            (_) => Stream<DocumentSnapshot>.value(documentSnapshotMock));
        when(documentSnapshotMock.data)
            .thenReturn({'phoneNumber': 'phoneNumber'});

        var documentedUser =
            await idDocsRepository.documentedUser('phoneNumber');
        expectLater(
            documentedUser, emits(DocumentedUser(phoneNumber: 'phoneNumber')));
      });
    });

    group('deleteUser', () {
      test('delete the user from firestore', () async {
        // Mock the necessary method calls
        when(firestoreMock.collection(FirebaseIdDocsRepository.COLLECTION_NAME))
            .thenReturn(collectionReferenceMock);
        when(collectionReferenceMock.document('phoneNumber'))
            .thenReturn(documentReferenceMock);
        when(documentReferenceMock.delete()).thenAnswer((_) => Future.value());

        await idDocsRepository.deleteUser('phoneNumber');

        verify(documentReferenceMock.delete()).called(1);
      });
    });

    group('submitDocument', () {
      test('submitting ID Book adds an ID Book to user', () async {
        // Mock the necessary method calls
        when(firestoreMock.collection(FirebaseIdDocsRepository.COLLECTION_NAME))
            .thenReturn(collectionReferenceMock);
        when(collectionReferenceMock.document('phoneNumber'))
            .thenReturn(documentReferenceMock);
        when(documentReferenceMock.get())
            .thenAnswer((_) => Future.value(documentSnapshotMock));
        when(documentSnapshotMock.data)
            .thenReturn(DocumentedUser(phoneNumber: 'phoneNumber').toJson());
        when(documentReferenceMock.updateData(
                DocumentedUser(phoneNumber: 'phoneNumber', idBook: kTestIdBook)
                    .toJson()))
            .thenAnswer((_) => Future.value());

        await idDocsRepository.submitIdBook('phoneNumber', kTestIdBook);

        verify(
          documentReferenceMock.updateData(
            DocumentedUser(phoneNumber: 'phoneNumber', idBook: kTestIdBook)
                .toJson(),
          ),
        ).called(1);
      });

      test('submitting ID Card adds a ID Card to user', () async {
        // Mock the necessary method calls
        when(firestoreMock.collection(FirebaseIdDocsRepository.COLLECTION_NAME))
            .thenReturn(collectionReferenceMock);
        when(collectionReferenceMock.document('phoneNumber'))
            .thenReturn(documentReferenceMock);
        when(documentReferenceMock.get())
            .thenAnswer((_) => Future.value(documentSnapshotMock));
        when(documentSnapshotMock.data)
            .thenReturn(DocumentedUser(phoneNumber: 'phoneNumber').toJson());
        when(documentReferenceMock.updateData(
                DocumentedUser(phoneNumber: 'phoneNumber', idCard: kTestIdCard)
                    .toJson()))
            .thenAnswer((_) => Future.value());

        await idDocsRepository.submitIdCard('phoneNumber', kTestIdCard);

        verify(
          documentReferenceMock.updateData(
            DocumentedUser(phoneNumber: 'phoneNumber', idCard: kTestIdCard)
                .toJson(),
          ),
        ).called(1);
      });

      test('submitting Drivers adds an Drivers to user', () async {
        // Mock the necessary method calls
        when(firestoreMock.collection(FirebaseIdDocsRepository.COLLECTION_NAME))
            .thenReturn(collectionReferenceMock);
        when(collectionReferenceMock.document('phoneNumber'))
            .thenReturn(documentReferenceMock);
        when(documentReferenceMock.get())
            .thenAnswer((_) => Future.value(documentSnapshotMock));
        when(documentSnapshotMock.data)
            .thenReturn(DocumentedUser(phoneNumber: 'phoneNumber').toJson());
        when(documentReferenceMock.updateData(DocumentedUser(
                    phoneNumber: 'phoneNumber',
                    driversLicense: kTestDriversLicense)
                .toJson()))
            .thenAnswer((_) => Future.value());

        await idDocsRepository.submitDriversLicense(
            'phoneNumber', kTestDriversLicense);

        verify(
          documentReferenceMock.updateData(
            DocumentedUser(
                    phoneNumber: 'phoneNumber',
                    driversLicense: kTestDriversLicense)
                .toJson(),
          ),
        ).called(1);
      });

      test('submitting Passport adds an Passport to user', () async {
        // Mock the necessary method calls
        when(firestoreMock.collection(FirebaseIdDocsRepository.COLLECTION_NAME))
            .thenReturn(collectionReferenceMock);
        when(collectionReferenceMock.document('phoneNumber'))
            .thenReturn(documentReferenceMock);
        when(documentReferenceMock.get())
            .thenAnswer((_) => Future.value(documentSnapshotMock));
        when(documentSnapshotMock.data)
            .thenReturn(DocumentedUser(phoneNumber: 'phoneNumber').toJson());
        when(documentReferenceMock.updateData(
                DocumentedUser(phoneNumber: 'phoneNumber', passport: Passport())
                    .toJson()))
            .thenAnswer((_) => Future.value());

        await idDocsRepository.submitPassport('phoneNumber', Passport());

        verify(
          documentReferenceMock.updateData(
            DocumentedUser(phoneNumber: 'phoneNumber', passport: Passport())
                .toJson(),
          ),
        ).called(1);
      });
    });
  });
}

class FirestoreMock extends Mock implements Firestore {}

class CollectionReferenceMock extends Mock implements CollectionReference {}

class DocumentReferenceMock extends Mock implements DocumentReference {}

class DocumentSnapshotMock extends Mock implements DocumentSnapshot {}
