// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named

part of 'controlled_space.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;
ControlledSpace _$ControlledSpaceFromJson(Map<String, dynamic> json) {
  return _ControlledSpace.fromJson(json);
}

class _$ControlledSpaceTearOff {
  const _$ControlledSpaceTearOff();

  _ControlledSpace call(
      {@required String id,
      @required String title,
      @required List<String> managerPhones,
      @required List<String> guardPhones,
      @required List<String> inviterPhones,
      double locationLatitude,
      double locationLongitude,
      int minAge,
      int maxCapacity}) {
    return _ControlledSpace(
      id: id,
      title: title,
      managerPhones: managerPhones,
      guardPhones: guardPhones,
      inviterPhones: inviterPhones,
      locationLatitude: locationLatitude,
      locationLongitude: locationLongitude,
      minAge: minAge,
      maxCapacity: maxCapacity,
    );
  }
}

// ignore: unused_element
const $ControlledSpace = _$ControlledSpaceTearOff();

mixin _$ControlledSpace {
  String get id;
  String get title;
  List<String> get managerPhones;
  List<String> get guardPhones;
  List<String> get inviterPhones;
  double get locationLatitude;
  double get locationLongitude;
  int get minAge;
  int get maxCapacity;

  Map<String, dynamic> toJson();
  $ControlledSpaceCopyWith<ControlledSpace> get copyWith;
}

abstract class $ControlledSpaceCopyWith<$Res> {
  factory $ControlledSpaceCopyWith(
          ControlledSpace value, $Res Function(ControlledSpace) then) =
      _$ControlledSpaceCopyWithImpl<$Res>;
  $Res call(
      {String id,
      String title,
      List<String> managerPhones,
      List<String> guardPhones,
      List<String> inviterPhones,
      double locationLatitude,
      double locationLongitude,
      int minAge,
      int maxCapacity});
}

class _$ControlledSpaceCopyWithImpl<$Res>
    implements $ControlledSpaceCopyWith<$Res> {
  _$ControlledSpaceCopyWithImpl(this._value, this._then);

  final ControlledSpace _value;
  // ignore: unused_field
  final $Res Function(ControlledSpace) _then;

  @override
  $Res call({
    Object id = freezed,
    Object title = freezed,
    Object managerPhones = freezed,
    Object guardPhones = freezed,
    Object inviterPhones = freezed,
    Object locationLatitude = freezed,
    Object locationLongitude = freezed,
    Object minAge = freezed,
    Object maxCapacity = freezed,
  }) {
    return _then(_value.copyWith(
      id: id == freezed ? _value.id : id as String,
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
      locationLatitude: locationLatitude == freezed
          ? _value.locationLatitude
          : locationLatitude as double,
      locationLongitude: locationLongitude == freezed
          ? _value.locationLongitude
          : locationLongitude as double,
      minAge: minAge == freezed ? _value.minAge : minAge as int,
      maxCapacity:
          maxCapacity == freezed ? _value.maxCapacity : maxCapacity as int,
    ));
  }
}

abstract class _$ControlledSpaceCopyWith<$Res>
    implements $ControlledSpaceCopyWith<$Res> {
  factory _$ControlledSpaceCopyWith(
          _ControlledSpace value, $Res Function(_ControlledSpace) then) =
      __$ControlledSpaceCopyWithImpl<$Res>;
  @override
  $Res call(
      {String id,
      String title,
      List<String> managerPhones,
      List<String> guardPhones,
      List<String> inviterPhones,
      double locationLatitude,
      double locationLongitude,
      int minAge,
      int maxCapacity});
}

class __$ControlledSpaceCopyWithImpl<$Res>
    extends _$ControlledSpaceCopyWithImpl<$Res>
    implements _$ControlledSpaceCopyWith<$Res> {
  __$ControlledSpaceCopyWithImpl(
      _ControlledSpace _value, $Res Function(_ControlledSpace) _then)
      : super(_value, (v) => _then(v as _ControlledSpace));

  @override
  _ControlledSpace get _value => super._value as _ControlledSpace;

  @override
  $Res call({
    Object id = freezed,
    Object title = freezed,
    Object managerPhones = freezed,
    Object guardPhones = freezed,
    Object inviterPhones = freezed,
    Object locationLatitude = freezed,
    Object locationLongitude = freezed,
    Object minAge = freezed,
    Object maxCapacity = freezed,
  }) {
    return _then(_ControlledSpace(
      id: id == freezed ? _value.id : id as String,
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
      locationLatitude: locationLatitude == freezed
          ? _value.locationLatitude
          : locationLatitude as double,
      locationLongitude: locationLongitude == freezed
          ? _value.locationLongitude
          : locationLongitude as double,
      minAge: minAge == freezed ? _value.minAge : minAge as int,
      maxCapacity:
          maxCapacity == freezed ? _value.maxCapacity : maxCapacity as int,
    ));
  }
}

@JsonSerializable()
class _$_ControlledSpace
    with DiagnosticableTreeMixin
    implements _ControlledSpace {
  const _$_ControlledSpace(
      {@required this.id,
      @required this.title,
      @required this.managerPhones,
      @required this.guardPhones,
      @required this.inviterPhones,
      this.locationLatitude,
      this.locationLongitude,
      this.minAge,
      this.maxCapacity})
      : assert(id != null),
        assert(title != null),
        assert(managerPhones != null),
        assert(guardPhones != null),
        assert(inviterPhones != null);

  factory _$_ControlledSpace.fromJson(Map<String, dynamic> json) =>
      _$_$_ControlledSpaceFromJson(json);

  @override
  final String id;
  @override
  final String title;
  @override
  final List<String> managerPhones;
  @override
  final List<String> guardPhones;
  @override
  final List<String> inviterPhones;
  @override
  final double locationLatitude;
  @override
  final double locationLongitude;
  @override
  final int minAge;
  @override
  final int maxCapacity;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'ControlledSpace(id: $id, title: $title, managerPhones: $managerPhones, guardPhones: $guardPhones, inviterPhones: $inviterPhones, locationLatitude: $locationLatitude, locationLongitude: $locationLongitude, minAge: $minAge, maxCapacity: $maxCapacity)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'ControlledSpace'))
      ..add(DiagnosticsProperty('id', id))
      ..add(DiagnosticsProperty('title', title))
      ..add(DiagnosticsProperty('managerPhones', managerPhones))
      ..add(DiagnosticsProperty('guardPhones', guardPhones))
      ..add(DiagnosticsProperty('inviterPhones', inviterPhones))
      ..add(DiagnosticsProperty('locationLatitude', locationLatitude))
      ..add(DiagnosticsProperty('locationLongitude', locationLongitude))
      ..add(DiagnosticsProperty('minAge', minAge))
      ..add(DiagnosticsProperty('maxCapacity', maxCapacity));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _ControlledSpace &&
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
            (identical(other.locationLatitude, locationLatitude) ||
                const DeepCollectionEquality()
                    .equals(other.locationLatitude, locationLatitude)) &&
            (identical(other.locationLongitude, locationLongitude) ||
                const DeepCollectionEquality()
                    .equals(other.locationLongitude, locationLongitude)) &&
            (identical(other.minAge, minAge) ||
                const DeepCollectionEquality().equals(other.minAge, minAge)) &&
            (identical(other.maxCapacity, maxCapacity) ||
                const DeepCollectionEquality()
                    .equals(other.maxCapacity, maxCapacity)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(id) ^
      const DeepCollectionEquality().hash(title) ^
      const DeepCollectionEquality().hash(managerPhones) ^
      const DeepCollectionEquality().hash(guardPhones) ^
      const DeepCollectionEquality().hash(inviterPhones) ^
      const DeepCollectionEquality().hash(locationLatitude) ^
      const DeepCollectionEquality().hash(locationLongitude) ^
      const DeepCollectionEquality().hash(minAge) ^
      const DeepCollectionEquality().hash(maxCapacity);

  @override
  _$ControlledSpaceCopyWith<_ControlledSpace> get copyWith =>
      __$ControlledSpaceCopyWithImpl<_ControlledSpace>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$_$_ControlledSpaceToJson(this);
  }
}

abstract class _ControlledSpace implements ControlledSpace {
  const factory _ControlledSpace(
      {@required String id,
      @required String title,
      @required List<String> managerPhones,
      @required List<String> guardPhones,
      @required List<String> inviterPhones,
      double locationLatitude,
      double locationLongitude,
      int minAge,
      int maxCapacity}) = _$_ControlledSpace;

  factory _ControlledSpace.fromJson(Map<String, dynamic> json) =
      _$_ControlledSpace.fromJson;

  @override
  String get id;
  @override
  String get title;
  @override
  List<String> get managerPhones;
  @override
  List<String> get guardPhones;
  @override
  List<String> get inviterPhones;
  @override
  double get locationLatitude;
  @override
  double get locationLongitude;
  @override
  int get minAge;
  @override
  int get maxCapacity;
  @override
  _$ControlledSpaceCopyWith<_ControlledSpace> get copyWith;
}
