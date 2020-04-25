// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'space.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Space _$_$_SpaceFromJson(Map<String, dynamic> json) {
  return _$_Space(
    id: json['id'] as String,
    title: json['title'] as String,
    inviteOnly: json['inviteOnly'] as bool,
    managerPhones:
        (json['managerPhones'] as List)?.map((e) => e as String)?.toList(),
    guardPhones:
        (json['guardPhones'] as List)?.map((e) => e as String)?.toList(),
    inviterPhones:
        (json['inviterPhones'] as List)?.map((e) => e as String)?.toList(),
    minAge: json['minAge'] as int ?? 0,
    imageUrl: json['imageUrl'] as String,
    locationLatitude: (json['locationLatitude'] as num)?.toDouble(),
    locationLongitude: (json['locationLongitude'] as num)?.toDouble(),
  );
}

Map<String, dynamic> _$_$_SpaceToJson(_$_Space instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'inviteOnly': instance.inviteOnly,
      'managerPhones': instance.managerPhones,
      'guardPhones': instance.guardPhones,
      'inviterPhones': instance.inviterPhones,
      'minAge': instance.minAge,
      'imageUrl': instance.imageUrl,
      'locationLatitude': instance.locationLatitude,
      'locationLongitude': instance.locationLongitude,
    };
