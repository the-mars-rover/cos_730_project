import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';
import 'package:invite_only_repo/src/models/id_document/id_document.dart';

part 'user.freezed.dart';

part 'user.g.dart';

@freezed
abstract class User with _$User {
  const factory User({
    @required String id,
    @required String phoneNumber,

    /// The Id book stored for this user, null if no ID book is stored.
    IdBook idBook,

    /// The Id card stored for this user, null if no ID card is stored.
    IdCard idCard,

    /// The Driver's license stored for this user, null if no Driver's license is stored.
    DriversLicense driversLicense,

    /// The Passport stored for this user, null if no Passport is stored.
    Passport passport,
  }) = _User;

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
}
