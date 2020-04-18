// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'controlled_space.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_ControlledSpace _$_$_ControlledSpaceFromJson(Map<String, dynamic> json) {
  return _$_ControlledSpace(
    id: json['id'] as String,
    title: json['title'] as String,
    locationLatitude: (json['locationLatitude'] as num)?.toDouble(),
    locationLongitude: (json['locationLongitude'] as num)?.toDouble(),
    minAge: json['minAge'] as int,
    maxCapacity: json['maxCapacity'] as int,
    managerPhones:
        (json['managerPhones'] as List)?.map((e) => e as String)?.toList(),
    guardPhones:
        (json['guardPhones'] as List)?.map((e) => e as String)?.toList(),
    inviterPhones:
        (json['inviterPhones'] as List)?.map((e) => e as String)?.toList(),
  );
}

Map<String, dynamic> _$_$_ControlledSpaceToJson(_$_ControlledSpace instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'locationLatitude': instance.locationLatitude,
      'locationLongitude': instance.locationLongitude,
      'minAge': instance.minAge,
      'maxCapacity': instance.maxCapacity,
      'managerPhones': instance.managerPhones,
      'guardPhones': instance.guardPhones,
      'inviterPhones': instance.inviterPhones,
    };
