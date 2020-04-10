import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:invite_only_users/src/repositories/user_repository/user_repository.dart';

import '../../../invite_only_users.dart';

class FirebaseUserRepository implements UserRepository {
  static const String USERS = "users";

  /// The data provider for the firebase firestore database.
  final _firestore = Firestore.instance;

  /// Adds a user to the firestore database in the USERS collection.
  @override
  Future<void> addUser(User user) async {
    await _firestore.collection(USERS).document(user.id).setData(user.toJson());
  }

  /// Returns the user with the given ID. If no user exists with the given ID,
  /// null is returned.
  @override
  Future<User> getUser(String userId) async {
    DocumentSnapshot userSnapshot =
        await _firestore.collection(USERS).document(userId).get();

    if (userSnapshot.exists) {
      return User.fromJson(userSnapshot.data);
    }

    return null;
  }
}
