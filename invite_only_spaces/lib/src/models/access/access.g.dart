// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'access.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Access _$_$_AccessFromJson(Map<String, dynamic> json) {
  return _$_Access(
    id: json['id'] as String,
    spaceId: json['spaceId'] as String,
    entryDate: json['entryDate'] == null
        ? null
        : DateTime.parse(json['entryDate'] as String),
    exitDate: json['exitDate'] == null
        ? null
        : DateTime.parse(json['exitDate'] as String),
    idDocument: json['idDocument'] == null
        ? null
        : IdDocument.fromJson(json['idDocument'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$_$_AccessToJson(_$_Access instance) => <String, dynamic>{
      'id': instance.id,
      'spaceId': instance.spaceId,
      'entryDate': instance.entryDate?.toIso8601String(),
      'exitDate': instance.exitDate?.toIso8601String(),
      'idDocument': instance.idDocument?.toJson(),
    };
