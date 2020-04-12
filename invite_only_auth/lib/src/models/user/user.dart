import 'package:firebase_auth/firebase_auth.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';
import 'package:invite_only_auth/invite_only_auth.dart';
import 'package:invite_only_auth/src/repositories/auth_repository/firebase_auth_repository.dart';

part 'user.freezed.dart';

part 'user.g.dart';

@freezed
abstract class User with _$User {
  const factory User({
    @required String id,
    @required String phoneNumber,
  }) = _User;

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  /// Specifically used by the [FirebaseAuthRepository] implementation of [AuthRepository]
  factory User.fromFirebaseUser(FirebaseUser firebaseUser) => User(
        id: firebaseUser.uid,
        phoneNumber: firebaseUser.phoneNumber,
      );
}
