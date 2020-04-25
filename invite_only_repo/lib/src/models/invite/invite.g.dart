// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'invite.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Invite _$_$_InviteFromJson(Map<String, dynamic> json) {
  return _$_Invite(
    id: json['id'] as String,
    code: json['code'] as String,
    spaceId: json['spaceId'] as String,
    expiryDate: json['expiryDate'] == null
        ? null
        : DateTime.parse(json['expiryDate'] as String),
    inviterPhoneNumber: json['inviterPhoneNumber'] as String,
  );
}

Map<String, dynamic> _$_$_InviteToJson(_$_Invite instance) => <String, dynamic>{
      'id': instance.id,
      'code': instance.code,
      'spaceId': instance.spaceId,
      'expiryDate': instance.expiryDate?.toIso8601String(),
      'inviterPhoneNumber': instance.inviterPhoneNumber,
    };
