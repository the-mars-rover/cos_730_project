// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'space.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Space _$_$_SpaceFromJson(Map<String, dynamic> json) {
  return _$_Space(
    id: json['id'] as int,
    title: json['title'] as String,
    managerPhones:
        (json['managerPhones'] as List)?.map((e) => e as String)?.toSet(),
    guardPhones:
        (json['guardPhones'] as List)?.map((e) => e as String)?.toSet(),
    inviterPhones:
        (json['inviterPhones'] as List)?.map((e) => e as String)?.toSet(),
    imageUrl: json['imageUrl'] as String,
    locationLatitude: (json['locationLatitude'] as num)?.toDouble(),
    locationLongitude: (json['locationLongitude'] as num)?.toDouble(),
  );
}

Map<String, dynamic> _$_$_SpaceToJson(_$_Space instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'managerPhones': instance.managerPhones?.toList(),
      'guardPhones': instance.guardPhones?.toList(),
      'inviterPhones': instance.inviterPhones?.toList(),
      'imageUrl': instance.imageUrl,
      'locationLatitude': instance.locationLatitude,
      'locationLongitude': instance.locationLongitude,
    };
