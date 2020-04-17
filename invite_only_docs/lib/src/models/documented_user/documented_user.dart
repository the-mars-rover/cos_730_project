import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:invite_only_docs/src/models/id_document/id_document.dart';

part 'documented_user.freezed.dart';
part 'documented_user.g.dart';

@freezed
abstract class DocumentedUser with _$DocumentedUser {
  const factory DocumentedUser({
    /// The identifier for the user - can be anything as long as it is unique.
    @required String id,

    /// The Id book stored for this user, null if no ID book is stored.
    IdBook idBook,

    /// The Id card stored for this user, null if no ID card is stored.
    IdCard idCard,

    /// The Driver's license stored for this user, null if no Driver's license is stored.
    DriversLicense driversLicense,

    /// The Passport stored for this user, null if no Passport is stored.
    Passport passport,
  }) = _DocumentedUser;

  factory DocumentedUser.fromJson(Map<String, dynamic> json) =>
      _$DocumentedUserFromJson(json);
}
