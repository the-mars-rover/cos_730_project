import 'package:invite_only_docs/invite_only_docs.dart';
import 'package:invite_only_docs/src/errors/document_rejected.dart';
import 'package:invite_only_docs/src/models/documented_user/documented_user.dart';
import 'package:invite_only_docs/src/repositories/id_docs_repository/firebase_id_docs_repository.dart';

/// Retrieve and manage identity documents associated with specific users.
///
/// Implementations of this class will use a chosen Data Storage Provider to
/// implement the necessary functionality for abstract methods. So, to support a
/// different data storage provider, all that is needed is to write a new implementation
/// of this interface.
abstract class IdDocsRepository {
  /// The singleton instance of [IdDocsRepository]. Currently, [FirebaseIdDocsRepository]
  /// is being used since Firestore is the preferred Data Storage Provider.
  static final _instance = FirebaseIdDocsRepository();

  /// The getter for the singleton instance of this class.
  static IdDocsRepository get instance => _instance;

  /// Returns a stream of the documented user with the given id.
  ///
  /// If this is the first time a user with the given id is being accessed,
  /// the user will first be added before returning the stream - hence, why this
  /// method returns a future.
  Future<Stream<DocumentedUser>> documentedUser(String id);

  /// Submit an ID Card for the user with the given id.
  ///
  /// Throws [DocumentedRejected] if the given documented is rejected,
  /// in which case [DocumentedRejected.reason] will contain the reason why the
  /// document was rejected.
  Future<void> submitIdCard(String userId, IdCard idCard);

  /// Submit an ID Book for the user with the given id.
  ///
  /// Throws [DocumentedRejected] if the given documented is rejected,
  /// in which case [DocumentedRejected.reason] will contain the reason why the
  /// document was rejected.
  Future<void> submitIdBook(String userId, IdBook idBook);

  /// Submit a Drivers License for the user with the given id.
  ///
  /// Throws [DocumentedRejected] if the given documented is rejected,
  /// in which case [DocumentedRejected.reason] will contain the reason why the
  /// document was rejected.
  Future<void> submitDriversLicense(
      String userId, DriversLicense driversLicense);

  /// Submit a Passport for the user with the given id.
  ///
  /// Throws [DocumentedRejected] if the given documented is rejected,
  /// in which case [DocumentedRejected.reason] will contain the reason why the
  /// document was rejected.
  Future<void> submitPassport(String userId, Passport passport);

  /// Deletes the documented user with the given id.
  ///
  /// If no user with the id could be found, this method does nothing.
  Future<void> deleteUser(String userId);
}
