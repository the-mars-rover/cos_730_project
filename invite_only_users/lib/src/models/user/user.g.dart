// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_User _$_$_UserFromJson(Map<String, dynamic> json) {
  return _$_User(
    id: json['id'] as String,
    phoneNumber: json['phoneNumber'] as String,
    idBookInfo: json['idBookInfo'] == null
        ? null
        : IdBookInfo.fromJson(json['idBookInfo'] as Map<String, dynamic>),
    idCardInfo: json['idCardInfo'] == null
        ? null
        : IdCardInfo.fromJson(json['idCardInfo'] as Map<String, dynamic>),
    driversLicenseInfo: json['driversLicenseInfo'] == null
        ? null
        : DriversLicenseInfo.fromJson(
            json['driversLicenseInfo'] as Map<String, dynamic>),
    passportInfo: json['passportInfo'] == null
        ? null
        : PassportInfo.fromJson(json['passportInfo'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$_$_UserToJson(_$_User instance) => <String, dynamic>{
      'id': instance.id,
      'phoneNumber': instance.phoneNumber,
      'idBookInfo': instance.idBookInfo,
      'idCardInfo': instance.idCardInfo,
      'driversLicenseInfo': instance.driversLicenseInfo,
      'passportInfo': instance.passportInfo,
    };
