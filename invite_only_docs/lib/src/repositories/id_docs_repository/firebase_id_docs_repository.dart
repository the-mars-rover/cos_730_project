import 'package:invite_only_docs/invite_only_docs.dart';

class FirebaseIdDocsRepository implements IdDocsRepository {
  @override
  Future<Stream<DocumentedUser>> documentedUser(String id) {
    // TODO: implement documentedUser
    return null;
  }

  @override
  Future<void> submitDocument(String userId, IdDocument document) {
    // TODO: implement submitDocument
    return null;
  }

  @override
  Future<void> deleteUser(String userId) {
    // TODO: implement deleteUser
    return null;
  }
}