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
  Future<void> submitDocument(String userId, IdDocument document) async {
    var userSnapshot =
        await _firestore.collection(COLLECTION_NAME).document(userId).get();
    var savedUser = DocumentedUser.fromJson(userSnapshot.data);
    var updatedUser = _addDocToUser(savedUser, document);
    await _firestore
        .collection(COLLECTION_NAME)
        .document(userId)
        .updateData(updatedUser.toJson());
  }

  /// A helper method for [submitDocument] which returns a new documented user
  /// with the given document added to the saved user.
  DocumentedUser _addDocToUser(DocumentedUser savedUser, IdDocument document) {
    if (document is IdBook) {
      return savedUser.copyWith(idBook: document);
    } else if (document is IdCard) {
      return savedUser.copyWith(idCard: document);
    } else if (document is DriversLicense) {
      return savedUser.copyWith(driversLicense: document);
    } else if (document is Passport) {
      return savedUser.copyWith(passport: document);
    }

    return savedUser;
  }
}
