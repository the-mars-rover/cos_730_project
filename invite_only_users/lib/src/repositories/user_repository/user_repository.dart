import 'package:invite_only_users/src/repositories/user_repository/firebase_user_repository.dart';

import '../../../invite_only_users.dart';

abstract class UserRepository {
  static final UserRepository instance = FirebaseUserRepository();

  /// Adds a user to the firestore database in the USERS collection.
  Future<void> addUser(User user);

  /// Returns the user with the given ID. If no user exists with the given ID,
  /// null is returned.
  Future<User> getUser(String userId);
}