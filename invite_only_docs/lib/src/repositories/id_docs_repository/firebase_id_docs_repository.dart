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
  Future<Stream<DocumentedUser>> documentedUser(String userId) async {
    // First, ensure that the user exists
    await _firestore
        .collection(COLLECTION_NAME)
        .document(userId)
        .setData(DocumentedUser(id: userId).toJson(), merge: true);

    return _firestore
        .collection(COLLECTION_NAME)
        .document(userId)
        .snapshots()
        .map<DocumentedUser>((userSnapshot) {
      return DocumentedUser.fromJson(userSnapshot.data);
    });
  }

  @override
  Future<void> deleteUser(String userId) async {
    await _firestore.collection(COLLECTION_NAME).document(userId).delete();
  }

  @override
  Future<void> submitIdCard(String userId, IdCard idCard) async {
    var userSnapshot =
        await _firestore.collection(COLLECTION_NAME).document(userId).get();
    var savedUser = DocumentedUser.fromJson(userSnapshot.data);
    var updatedUser = savedUser.copyWith(idCard: idCard);
    await _firestore
        .collection(COLLECTION_NAME)
        .document(userId)
        .updateData(updatedUser.toJson());
  }

  @override
  Future<void> submitDriversLicense(
      String userId, DriversLicense driversLicense) async {
    var userSnapshot =
        await _firestore.collection(COLLECTION_NAME).document(userId).get();
    var savedUser = DocumentedUser.fromJson(userSnapshot.data);
    var updatedUser = savedUser.copyWith(driversLicense: driversLicense);
    await _firestore
        .collection(COLLECTION_NAME)
        .document(userId)
        .updateData(updatedUser.toJson());
  }

  @override
  Future<void> submitIdBook(String userId, IdBook idBook) async {
    var userSnapshot =
        await _firestore.collection(COLLECTION_NAME).document(userId).get();
    var savedUser = DocumentedUser.fromJson(userSnapshot.data);
    var updatedUser = savedUser.copyWith(idBook: idBook);
    await _firestore
        .collection(COLLECTION_NAME)
        .document(userId)
        .updateData(updatedUser.toJson());
  }

  @override
  Future<void> submitPassport(String userId, Passport passport) async {
    var userSnapshot =
        await _firestore.collection(COLLECTION_NAME).document(userId).get();
    var savedUser = DocumentedUser.fromJson(userSnapshot.data);
    var updatedUser = savedUser.copyWith(passport: passport);
    await _firestore
        .collection(COLLECTION_NAME)
        .document(userId)
        .updateData(updatedUser.toJson());
  }
}
