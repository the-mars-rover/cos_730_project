import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';
import 'package:invite_only_docs/src/models/id_document/id_document.dart';

part 'documented_user.freezed.dart';

part 'documented_user.g.dart';

@freezed
abstract class DocumentedUser with _$DocumentedUser {
  const factory DocumentedUser({
    @required String id,
    IdBook idBook,
    IdCard idCard,
    DriversLicense driversLicense,
    Passport passport,
  }) = _DocumentedUser;

  factory DocumentedUser.fromJson(Map<String, dynamic> json) =>
      _$DocumentedUserFromJson(json);
}
