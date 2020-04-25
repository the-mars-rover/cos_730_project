// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_User _$_$_UserFromJson(Map<String, dynamic> json) {
  return _$_User(
    id: json['id'] as String,
    phoneNumber: json['phoneNumber'] as String,
    idBook: json['idBook'] == null
        ? null
        : IdBook.fromJson(json['idBook'] as Map<String, dynamic>),
    idCard: json['idCard'] == null
        ? null
        : IdCard.fromJson(json['idCard'] as Map<String, dynamic>),
    driversLicense: json['driversLicense'] == null
        ? null
        : DriversLicense.fromJson(
            json['driversLicense'] as Map<String, dynamic>),
    passport: json['passport'] == null
        ? null
        : Passport.fromJson(json['passport'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$_$_UserToJson(_$_User instance) => <String, dynamic>{
      'id': instance.id,
      'phoneNumber': instance.phoneNumber,
      'idBook': instance.idBook?.toJson(),
      'idCard': instance.idCard?.toJson(),
      'driversLicense': instance.driversLicense?.toJson(),
      'passport': instance.passport?.toJson(),
    };
