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
    DocumentSnapshot userSnapshot =
        await _firestore.collection(COLLECTION_NAME).document(userId).get();

    // if the user does not yet exist, add one.
    if (!userSnapshot.exists) {
      await _addDocumentedUser(userId);
    }

    return _firestore
        .document(userId)
        .snapshots()
        .map<DocumentedUser>((userSnapshot) {
      return DocumentedUser.fromJson(userSnapshot.data);
    });
  }

  @override
  Future<void> submitDocument(String userId, IdDocument document) async {
    final DocumentReference userRef =
        _firestore.collection(COLLECTION_NAME).document();
    await _firestore.runTransaction((Transaction tx) async {
      DocumentSnapshot userSnapshot = await tx.get(userRef);

      if (userSnapshot.exists) {
        var savedUser = DocumentedUser.fromJson(userSnapshot.data);
        // TODO: validate that document is valid before adding to user.
        var updatedUser = _addDocToUser(savedUser, document);

        await tx.update(userRef, updatedUser.toJson());
      }
    });
  }

  @override
  Future<void> deleteUser(String userId) async {
    final DocumentReference userRef =
        _firestore.collection(COLLECTION_NAME).document();
    await _firestore.runTransaction((Transaction tx) async {
      DocumentSnapshot userSnapshot = await tx.get(userRef);

      if (userSnapshot.exists) {
        await tx.delete(userRef);
      }
    });
  }

  /// A helper method for [documentedUser] to add a documented user with the
  /// given id when one does not yet exist.
  Future<void> _addDocumentedUser(String userId) async {
    var newUser = DocumentedUser(id: userId);

    await _firestore
        .collection(COLLECTION_NAME)
        .document(userId)
        .setData(newUser.toJson());
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
