import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../invite_only_docs.dart';
import 'id_docs_repository.dart';

class FirebaseIdDocsRepository implements IdDocsRepository {
  static const String COLLECTION_NAME = 'documentedusers';

  /// The data provider for the firebase firestore database.
  final Firestore _firestore;

  /// The constructor for [FirebaseIdDocsRepository].
  ///
  /// The optional parameters are only necessary for testing purposes.
  FirebaseIdDocsRepository({Firestore firestore})
      : _firestore = firestore ?? Firestore.instance;

  @override
  Future<Stream<DocumentedUser>> documentedUser(String phoneNumber) async {
    // First, ensure that the user exists
    await _firestore.collection(COLLECTION_NAME).document(phoneNumber).setData(
        DocumentedUser(phoneNumber: phoneNumber).toJson(),
        merge: true);

    return _firestore
        .collection(COLLECTION_NAME)
        .document(phoneNumber)
        .snapshots()
        .map<DocumentedUser>((userSnapshot) {
      return DocumentedUser.fromJson(userSnapshot.data);
    });
  }

  @override
  Future<DocumentedUser> userWithDocument(IdDocument idDocument) async {
    QuerySnapshot querySnapshot;
    if (idDocument is IdBook) {
      querySnapshot = await _firestore
          .collection(COLLECTION_NAME)
          .where('idBook', isEqualTo: idDocument.toJson())
          .limit(1)
          .getDocuments();
    }
    if (idDocument is IdCard) {
      querySnapshot = await _firestore
          .collection(COLLECTION_NAME)
          .where('idCard', isEqualTo: idDocument.toJson())
          .limit(1)
          .getDocuments();
    }
    if (idDocument is DriversLicense) {
      querySnapshot = await _firestore
          .collection(COLLECTION_NAME)
          .where('driversLicense', isEqualTo: idDocument.toJson())
          .limit(1)
          .getDocuments();
    }
    if (idDocument is Passport) {
      querySnapshot = await _firestore
          .collection(COLLECTION_NAME)
          .where('passport', isEqualTo: idDocument.toJson())
          .limit(1)
          .getDocuments();
    }

    if (querySnapshot.documents.isEmpty) return null;
    return DocumentedUser.fromJson(querySnapshot.documents.first.data);
  }

  @override
  Future<void> deleteUser(String phoneNumber) async {
    await _firestore.collection(COLLECTION_NAME).document(phoneNumber).delete();
  }

  @override
  Future<void> submitDocument(String phoneNumber, IdDocument idDocument) async {
    var userSnapshot = await _firestore
        .collection(COLLECTION_NAME)
        .document(phoneNumber)
        .get();
    var savedUser = DocumentedUser.fromJson(userSnapshot.data);

    DocumentedUser updatedUser;
    if (idDocument is IdCard) {
      updatedUser = savedUser.copyWith(idCard: idDocument);
    } else if (idDocument is IdBook) {
      updatedUser = savedUser.copyWith(idBook: idDocument);
    } else if (idDocument is DriversLicense) {
      updatedUser = savedUser.copyWith(driversLicense: idDocument);
    } else if (idDocument is Passport) {
      updatedUser = savedUser.copyWith(passport: idDocument);
    }

    await _firestore
        .collection(COLLECTION_NAME)
        .document(phoneNumber)
        .updateData(updatedUser.toJson());
  }
}
