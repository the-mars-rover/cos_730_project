// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named

part of 'invite.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;
Invite _$InviteFromJson(Map<String, dynamic> json) {
  return _Invite.fromJson(json);
}

class _$InviteTearOff {
  const _$InviteTearOff();

  _Invite call(
      {@required int id,
      @required String code,
      @required String spaceId,
      @required String inviterPhone,
      @required DateTime expiryDate}) {
    return _Invite(
      id: id,
      code: code,
      spaceId: spaceId,
      inviterPhone: inviterPhone,
      expiryDate: expiryDate,
    );
  }
}

// ignore: unused_element
const $Invite = _$InviteTearOff();

mixin _$Invite {
  int get id;
  String get code;
  String get spaceId;
  String get inviterPhone;
  DateTime get expiryDate;

  Map<String, dynamic> toJson();
  $InviteCopyWith<Invite> get copyWith;
}

abstract class $InviteCopyWith<$Res> {
  factory $InviteCopyWith(Invite value, $Res Function(Invite) then) =
      _$InviteCopyWithImpl<$Res>;
  $Res call(
      {int id,
      String code,
      String spaceId,
      String inviterPhone,
      DateTime expiryDate});
}

class _$InviteCopyWithImpl<$Res> implements $InviteCopyWith<$Res> {
  _$InviteCopyWithImpl(this._value, this._then);

  final Invite _value;
  // ignore: unused_field
  final $Res Function(Invite) _then;

  @override
  $Res call({
    Object id = freezed,
    Object code = freezed,
    Object spaceId = freezed,
    Object inviterPhone = freezed,
    Object expiryDate = freezed,
  }) {
    return _then(_value.copyWith(
      id: id == freezed ? _value.id : id as int,
      code: code == freezed ? _value.code : code as String,
      spaceId: spaceId == freezed ? _value.spaceId : spaceId as String,
      inviterPhone: inviterPhone == freezed
          ? _value.inviterPhone
          : inviterPhone as String,
      expiryDate:
          expiryDate == freezed ? _value.expiryDate : expiryDate as DateTime,
    ));
  }
}

abstract class _$InviteCopyWith<$Res> implements $InviteCopyWith<$Res> {
  factory _$InviteCopyWith(_Invite value, $Res Function(_Invite) then) =
      __$InviteCopyWithImpl<$Res>;
  @override
  $Res call(
      {int id,
      String code,
      String spaceId,
      String inviterPhone,
      DateTime expiryDate});
}

class __$InviteCopyWithImpl<$Res> extends _$InviteCopyWithImpl<$Res>
    implements _$InviteCopyWith<$Res> {
  __$InviteCopyWithImpl(_Invite _value, $Res Function(_Invite) _then)
      : super(_value, (v) => _then(v as _Invite));

  @override
  _Invite get _value => super._value as _Invite;

  @override
  $Res call({
    Object id = freezed,
    Object code = freezed,
    Object spaceId = freezed,
    Object inviterPhone = freezed,
    Object expiryDate = freezed,
  }) {
    return _then(_Invite(
      id: id == freezed ? _value.id : id as int,
      code: code == freezed ? _value.code : code as String,
      spaceId: spaceId == freezed ? _value.spaceId : spaceId as String,
      inviterPhone: inviterPhone == freezed
          ? _value.inviterPhone
          : inviterPhone as String,
      expiryDate:
          expiryDate == freezed ? _value.expiryDate : expiryDate as DateTime,
    ));
  }
}

@JsonSerializable()
class _$_Invite with DiagnosticableTreeMixin implements _Invite {
  const _$_Invite(
      {@required this.id,
      @required this.code,
      @required this.spaceId,
      @required this.inviterPhone,
      @required this.expiryDate})
      : assert(id != null),
        assert(code != null),
        assert(spaceId != null),
        assert(inviterPhone != null),
        assert(expiryDate != null);

  factory _$_Invite.fromJson(Map<String, dynamic> json) =>
      _$_$_InviteFromJson(json);

  @override
  final int id;
  @override
  final String code;
  @override
  final String spaceId;
  @override
  final String inviterPhone;
  @override
  final DateTime expiryDate;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'Invite(id: $id, code: $code, spaceId: $spaceId, inviterPhone: $inviterPhone, expiryDate: $expiryDate)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'Invite'))
      ..add(DiagnosticsProperty('id', id))
      ..add(DiagnosticsProperty('code', code))
      ..add(DiagnosticsProperty('spaceId', spaceId))
      ..add(DiagnosticsProperty('inviterPhone', inviterPhone))
      ..add(DiagnosticsProperty('expiryDate', expiryDate));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _Invite &&
            (identical(other.id, id) ||
                const DeepCollectionEquality().equals(other.id, id)) &&
            (identical(other.code, code) ||
                const DeepCollectionEquality().equals(other.code, code)) &&
            (identical(other.spaceId, spaceId) ||
                const DeepCollectionEquality()
                    .equals(other.spaceId, spaceId)) &&
            (identical(other.inviterPhone, inviterPhone) ||
                const DeepCollectionEquality()
                    .equals(other.inviterPhone, inviterPhone)) &&
            (identical(other.expiryDate, expiryDate) ||
                const DeepCollectionEquality()
                    .equals(other.expiryDate, expiryDate)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(id) ^
      const DeepCollectionEquality().hash(code) ^
      const DeepCollectionEquality().hash(spaceId) ^
      const DeepCollectionEquality().hash(inviterPhone) ^
      const DeepCollectionEquality().hash(expiryDate);

  @override
  _$InviteCopyWith<_Invite> get copyWith =>
      __$InviteCopyWithImpl<_Invite>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$_$_InviteToJson(this);
  }
}

abstract class _Invite implements Invite {
  const factory _Invite(
      {@required int id,
      @required String code,
      @required String spaceId,
      @required String inviterPhone,
      @required DateTime expiryDate}) = _$_Invite;

  factory _Invite.fromJson(Map<String, dynamic> json) = _$_Invite.fromJson;

  @override
  int get id;
  @override
  String get code;
  @override
  String get spaceId;
  @override
  String get inviterPhone;
  @override
  DateTime get expiryDate;
  @override
  _$InviteCopyWith<_Invite> get copyWith;
}
