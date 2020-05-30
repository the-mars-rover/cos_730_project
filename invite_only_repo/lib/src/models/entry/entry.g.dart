// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'entry.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Entry _$_$_EntryFromJson(Map<String, dynamic> json) {
  return _$_Entry(
    id: json['id'] as int,
    guardPhone: json['guardPhone'] as String,
    entryDate: json['entryDate'] == null
        ? null
        : DateTime.parse(json['entryDate'] as String),
    idDocument: json['idDocument'] == null
        ? null
        : IdDocument.fromJson(json['idDocument'] as Map<String, dynamic>),
    invite: json['invite'] == null
        ? null
        : Invite.fromJson(json['invite'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$_$_EntryToJson(_$_Entry instance) => <String, dynamic>{
      'id': instance.id,
      'guardPhone': instance.guardPhone,
      'entryDate': instance.entryDate?.toIso8601String(),
      'idDocument': instance.idDocument?.toJson(),
      'invite': instance.invite?.toJson(),
    };
