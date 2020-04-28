// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'access.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Access _$_$_AccessFromJson(Map<String, dynamic> json) {
  return _$_Access(
    id: json['id'] as String,
    entryGuardPhone: json['entryGuardPhone'] as String,
    entryDate: json['entryDate'] == null
        ? null
        : DateTime.parse(json['entryDate'] as String),
    idDocument: json['idDocument'] == null
        ? null
        : IdDocument.fromJson(json['idDocument'] as Map<String, dynamic>),
    granterPhoneNumber: json['granterPhoneNumber'] as String,
  );
}

Map<String, dynamic> _$_$_AccessToJson(_$_Access instance) => <String, dynamic>{
      'id': instance.id,
      'entryGuardPhone': instance.entryGuardPhone,
      'entryDate': instance.entryDate?.toIso8601String(),
      'idDocument': instance.idDocument?.toJson(),
      'granterPhoneNumber': instance.granterPhoneNumber,
    };
