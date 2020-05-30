// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named

part of 'space.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;
Space _$SpaceFromJson(Map<String, dynamic> json) {
  return _Space.fromJson(json);
}

class _$SpaceTearOff {
  const _$SpaceTearOff();

  _Space call(
      {@required int id,
      @required String title,
      @required List<String> managerPhones,
      @required List<String> guardPhones,
      @required List<String> inviterPhones,
      String imageUrl,
      double locationLatitude,
      double locationLongitude}) {
    return _Space(
      id: id,
      title: title,
      managerPhones: managerPhones,
      guardPhones: guardPhones,
      inviterPhones: inviterPhones,
      imageUrl: imageUrl,
      locationLatitude: locationLatitude,
      locationLongitude: locationLongitude,
    );
  }
}

// ignore: unused_element
const $Space = _$SpaceTearOff();

mixin _$Space {
  int get id;
  String get title;
  List<String> get managerPhones;
  List<String> get guardPhones;
  List<String> get inviterPhones;
  String get imageUrl;
  double get locationLatitude;
  double get locationLongitude;

  Map<String, dynamic> toJson();
  $SpaceCopyWith<Space> get copyWith;
}

abstract class $SpaceCopyWith<$Res> {
  factory $SpaceCopyWith(Space value, $Res Function(Space) then) =
      _$SpaceCopyWithImpl<$Res>;
  $Res call(
      {int id,
      String title,
      List<String> managerPhones,
      List<String> guardPhones,
      List<String> inviterPhones,
      String imageUrl,
      double locationLatitude,
      double locationLongitude});
}

class _$SpaceCopyWithImpl<$Res> implements $SpaceCopyWith<$Res> {
  _$SpaceCopyWithImpl(this._value, this._then);

  final Space _value;
  // ignore: unused_field
  final $Res Function(Space) _then;

  @override
  $Res call({
    Object id = freezed,
    Object title = freezed,
    Object managerPhones = freezed,
    Object guardPhones = freezed,
    Object inviterPhones = freezed,
    Object imageUrl = freezed,
    Object locationLatitude = freezed,
    Object locationLongitude = freezed,
  }) {
    return _then(_value.copyWith(
      id: id == freezed ? _value.id : id as int,
      title: title == freezed ? _value.title : title as String,
      managerPhones: managerPhones == freezed
          ? _value.managerPhones
          : managerPhones as List<String>,
      guardPhones: guardPhones == freezed
          ? _value.guardPhones
          : guardPhones as List<String>,
      inviterPhones: inviterPhones == freezed
          ? _value.inviterPhones
          : inviterPhones as List<String>,
      imageUrl: imageUrl == freezed ? _value.imageUrl : imageUrl as String,
      locationLatitude: locationLatitude == freezed
          ? _value.locationLatitude
          : locationLatitude as double,
      locationLongitude: locationLongitude == freezed
          ? _value.locationLongitude
          : locationLongitude as double,
    ));
  }
}

abstract class _$SpaceCopyWith<$Res> implements $SpaceCopyWith<$Res> {
  factory _$SpaceCopyWith(_Space value, $Res Function(_Space) then) =
      __$SpaceCopyWithImpl<$Res>;
  @override
  $Res call(
      {int id,
      String title,
      List<String> managerPhones,
      List<String> guardPhones,
      List<String> inviterPhones,
      String imageUrl,
      double locationLatitude,
      double locationLongitude});
}

class __$SpaceCopyWithImpl<$Res> extends _$SpaceCopyWithImpl<$Res>
    implements _$SpaceCopyWith<$Res> {
  __$SpaceCopyWithImpl(_Space _value, $Res Function(_Space) _then)
      : super(_value, (v) => _then(v as _Space));

  @override
  _Space get _value => super._value as _Space;

  @override
  $Res call({
    Object id = freezed,
    Object title = freezed,
    Object managerPhones = freezed,
    Object guardPhones = freezed,
    Object inviterPhones = freezed,
    Object imageUrl = freezed,
    Object locationLatitude = freezed,
    Object locationLongitude = freezed,
  }) {
    return _then(_Space(
      id: id == freezed ? _value.id : id as int,
      title: title == freezed ? _value.title : title as String,
      managerPhones: managerPhones == freezed
          ? _value.managerPhones
          : managerPhones as List<String>,
      guardPhones: guardPhones == freezed
          ? _value.guardPhones
          : guardPhones as List<String>,
      inviterPhones: inviterPhones == freezed
          ? _value.inviterPhones
          : inviterPhones as List<String>,
      imageUrl: imageUrl == freezed ? _value.imageUrl : imageUrl as String,
      locationLatitude: locationLatitude == freezed
          ? _value.locationLatitude
          : locationLatitude as double,
      locationLongitude: locationLongitude == freezed
          ? _value.locationLongitude
          : locationLongitude as double,
    ));
  }
}

@JsonSerializable()
class _$_Space extends _Space with DiagnosticableTreeMixin {
  const _$_Space(
      {@required this.id,
      @required this.title,
      @required this.managerPhones,
      @required this.guardPhones,
      @required this.inviterPhones,
      this.imageUrl,
      this.locationLatitude,
      this.locationLongitude})
      : assert(id != null),
        assert(title != null),
        assert(managerPhones != null),
        assert(guardPhones != null),
        assert(inviterPhones != null),
        super._();

  factory _$_Space.fromJson(Map<String, dynamic> json) =>
      _$_$_SpaceFromJson(json);

  @override
  final int id;
  @override
  final String title;
  @override
  final List<String> managerPhones;
  @override
  final List<String> guardPhones;
  @override
  final List<String> inviterPhones;
  @override
  final String imageUrl;
  @override
  final double locationLatitude;
  @override
  final double locationLongitude;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'Space(id: $id, title: $title, managerPhones: $managerPhones, guardPhones: $guardPhones, inviterPhones: $inviterPhones, imageUrl: $imageUrl, locationLatitude: $locationLatitude, locationLongitude: $locationLongitude)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'Space'))
      ..add(DiagnosticsProperty('id', id))
      ..add(DiagnosticsProperty('title', title))
      ..add(DiagnosticsProperty('managerPhones', managerPhones))
      ..add(DiagnosticsProperty('guardPhones', guardPhones))
      ..add(DiagnosticsProperty('inviterPhones', inviterPhones))
      ..add(DiagnosticsProperty('imageUrl', imageUrl))
      ..add(DiagnosticsProperty('locationLatitude', locationLatitude))
      ..add(DiagnosticsProperty('locationLongitude', locationLongitude));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _Space &&
            (identical(other.id, id) ||
                const DeepCollectionEquality().equals(other.id, id)) &&
            (identical(other.title, title) ||
                const DeepCollectionEquality().equals(other.title, title)) &&
            (identical(other.managerPhones, managerPhones) ||
                const DeepCollectionEquality()
                    .equals(other.managerPhones, managerPhones)) &&
            (identical(other.guardPhones, guardPhones) ||
                const DeepCollectionEquality()
                    .equals(other.guardPhones, guardPhones)) &&
            (identical(other.inviterPhones, inviterPhones) ||
                const DeepCollectionEquality()
                    .equals(other.inviterPhones, inviterPhones)) &&
            (identical(other.imageUrl, imageUrl) ||
                const DeepCollectionEquality()
                    .equals(other.imageUrl, imageUrl)) &&
            (identical(other.locationLatitude, locationLatitude) ||
                const DeepCollectionEquality()
                    .equals(other.locationLatitude, locationLatitude)) &&
            (identical(other.locationLongitude, locationLongitude) ||
                const DeepCollectionEquality()
                    .equals(other.locationLongitude, locationLongitude)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(id) ^
      const DeepCollectionEquality().hash(title) ^
      const DeepCollectionEquality().hash(managerPhones) ^
      const DeepCollectionEquality().hash(guardPhones) ^
      const DeepCollectionEquality().hash(inviterPhones) ^
      const DeepCollectionEquality().hash(imageUrl) ^
      const DeepCollectionEquality().hash(locationLatitude) ^
      const DeepCollectionEquality().hash(locationLongitude);

  @override
  _$SpaceCopyWith<_Space> get copyWith =>
      __$SpaceCopyWithImpl<_Space>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$_$_SpaceToJson(this);
  }
}

abstract class _Space extends Space {
  const _Space._() : super._();
  const factory _Space(
      {@required int id,
      @required String title,
      @required List<String> managerPhones,
      @required List<String> guardPhones,
      @required List<String> inviterPhones,
      String imageUrl,
      double locationLatitude,
      double locationLongitude}) = _$_Space;

  factory _Space.fromJson(Map<String, dynamic> json) = _$_Space.fromJson;

  @override
  int get id;
  @override
  String get title;
  @override
  List<String> get managerPhones;
  @override
  List<String> get guardPhones;
  @override
  List<String> get inviterPhones;
  @override
  String get imageUrl;
  @override
  double get locationLatitude;
  @override
  double get locationLongitude;
  @override
  _$SpaceCopyWith<_Space> get copyWith;
}
