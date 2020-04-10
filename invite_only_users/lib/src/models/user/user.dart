import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';
import 'package:invite_only_users/invite_only_users.dart';

part 'user.freezed.dart';

part 'user.g.dart';

@freezed
abstract class User with _$User {
  const factory User({
    @required String id,
    @required String phoneNumber,
    @nullable IdBookInfo idBookInfo,
    @nullable IdCardInfo idCardInfo,
    @nullable DriversLicenseInfo driversLicenseInfo,
    @nullable PassportInfo passportInfo,
  }) = _User;

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
}