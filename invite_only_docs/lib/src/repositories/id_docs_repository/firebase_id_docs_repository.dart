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
  Future<void> deleteUser(String phoneNumber) async {
    await _firestore.collection(COLLECTION_NAME).document(phoneNumber).delete();
  }

  @override
  Future<void> submitIdCard(String phoneNumber, IdCard idCard) async {
    var userSnapshot = await _firestore
        .collection(COLLECTION_NAME)
        .document(phoneNumber)
        .get();
    var savedUser = DocumentedUser.fromJson(userSnapshot.data);
    var updatedUser = savedUser.copyWith(idCard: idCard);
    await _firestore
        .collection(COLLECTION_NAME)
        .document(phoneNumber)
        .updateData(updatedUser.toJson());
  }

  @override
  Future<void> submitDriversLicense(
      String phoneNumber, DriversLicense driversLicense) async {
    var userSnapshot = await _firestore
        .collection(COLLECTION_NAME)
        .document(phoneNumber)
        .get();
    var savedUser = DocumentedUser.fromJson(userSnapshot.data);
    var updatedUser = savedUser.copyWith(driversLicense: driversLicense);
    await _firestore
        .collection(COLLECTION_NAME)
        .document(phoneNumber)
        .updateData(updatedUser.toJson());
  }

  @override
  Future<void> submitIdBook(String phoneNumber, IdBook idBook) async {
    var userSnapshot = await _firestore
        .collection(COLLECTION_NAME)
        .document(phoneNumber)
        .get();
    var savedUser = DocumentedUser.fromJson(userSnapshot.data);
    var updatedUser = savedUser.copyWith(idBook: idBook);
    await _firestore
        .collection(COLLECTION_NAME)
        .document(phoneNumber)
        .updateData(updatedUser.toJson());
  }

  @override
  Future<void> submitPassport(String phoneNumber, Passport passport) async {
    var userSnapshot = await _firestore
        .collection(COLLECTION_NAME)
        .document(phoneNumber)
        .get();
    var savedUser = DocumentedUser.fromJson(userSnapshot.data);
    var updatedUser = savedUser.copyWith(passport: passport);
    await _firestore
        .collection(COLLECTION_NAME)
        .document(phoneNumber)
        .updateData(updatedUser.toJson());
  }
}
