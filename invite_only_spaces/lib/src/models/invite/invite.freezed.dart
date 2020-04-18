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
      {@required String id,
      @required String code,
      @required String spaceId,
      @required DateTime expiryDate,
      @required String inviterPhoneNumber}) {
    return _Invite(
      id: id,
      code: code,
      spaceId: spaceId,
      expiryDate: expiryDate,
      inviterPhoneNumber: inviterPhoneNumber,
    );
  }
}

// ignore: unused_element
const $Invite = _$InviteTearOff();

mixin _$Invite {
  String get id;
  String get code;
  String get spaceId;
  DateTime get expiryDate;
  String get inviterPhoneNumber;

  Map<String, dynamic> toJson();
  $InviteCopyWith<Invite> get copyWith;
}

abstract class $InviteCopyWith<$Res> {
  factory $InviteCopyWith(Invite value, $Res Function(Invite) then) =
      _$InviteCopyWithImpl<$Res>;
  $Res call(
      {String id,
      String code,
      String spaceId,
      DateTime expiryDate,
      String inviterPhoneNumber});
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
    Object expiryDate = freezed,
    Object inviterPhoneNumber = freezed,
  }) {
    return _then(_value.copyWith(
      id: id == freezed ? _value.id : id as String,
      code: code == freezed ? _value.code : code as String,
      spaceId: spaceId == freezed ? _value.spaceId : spaceId as String,
      expiryDate:
          expiryDate == freezed ? _value.expiryDate : expiryDate as DateTime,
      inviterPhoneNumber: inviterPhoneNumber == freezed
          ? _value.inviterPhoneNumber
          : inviterPhoneNumber as String,
    ));
  }
}

abstract class _$InviteCopyWith<$Res> implements $InviteCopyWith<$Res> {
  factory _$InviteCopyWith(_Invite value, $Res Function(_Invite) then) =
      __$InviteCopyWithImpl<$Res>;
  @override
  $Res call(
      {String id,
      String code,
      String spaceId,
      DateTime expiryDate,
      String inviterPhoneNumber});
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
    Object expiryDate = freezed,
    Object inviterPhoneNumber = freezed,
  }) {
    return _then(_Invite(
      id: id == freezed ? _value.id : id as String,
      code: code == freezed ? _value.code : code as String,
      spaceId: spaceId == freezed ? _value.spaceId : spaceId as String,
      expiryDate:
          expiryDate == freezed ? _value.expiryDate : expiryDate as DateTime,
      inviterPhoneNumber: inviterPhoneNumber == freezed
          ? _value.inviterPhoneNumber
          : inviterPhoneNumber as String,
    ));
  }
}

@JsonSerializable()
class _$_Invite with DiagnosticableTreeMixin implements _Invite {
  const _$_Invite(
      {@required this.id,
      @required this.code,
      @required this.spaceId,
      @required this.expiryDate,
      @required this.inviterPhoneNumber})
      : assert(id != null),
        assert(code != null),
        assert(spaceId != null),
        assert(expiryDate != null),
        assert(inviterPhoneNumber != null);

  factory _$_Invite.fromJson(Map<String, dynamic> json) =>
      _$_$_InviteFromJson(json);

  @override
  final String id;
  @override
  final String code;
  @override
  final String spaceId;
  @override
  final DateTime expiryDate;
  @override
  final String inviterPhoneNumber;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'Invite(id: $id, code: $code, spaceId: $spaceId, expiryDate: $expiryDate, inviterPhoneNumber: $inviterPhoneNumber)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'Invite'))
      ..add(DiagnosticsProperty('id', id))
      ..add(DiagnosticsProperty('code', code))
      ..add(DiagnosticsProperty('spaceId', spaceId))
      ..add(DiagnosticsProperty('expiryDate', expiryDate))
      ..add(DiagnosticsProperty('inviterPhoneNumber', inviterPhoneNumber));
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
            (identical(other.expiryDate, expiryDate) ||
                const DeepCollectionEquality()
                    .equals(other.expiryDate, expiryDate)) &&
            (identical(other.inviterPhoneNumber, inviterPhoneNumber) ||
                const DeepCollectionEquality()
                    .equals(other.inviterPhoneNumber, inviterPhoneNumber)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(id) ^
      const DeepCollectionEquality().hash(code) ^
      const DeepCollectionEquality().hash(spaceId) ^
      const DeepCollectionEquality().hash(expiryDate) ^
      const DeepCollectionEquality().hash(inviterPhoneNumber);

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
      {@required String id,
      @required String code,
      @required String spaceId,
      @required DateTime expiryDate,
      @required String inviterPhoneNumber}) = _$_Invite;

  factory _Invite.fromJson(Map<String, dynamic> json) = _$_Invite.fromJson;

  @override
  String get id;
  @override
  String get code;
  @override
  String get spaceId;
  @override
  DateTime get expiryDate;
  @override
  String get inviterPhoneNumber;
  @override
  _$InviteCopyWith<_Invite> get copyWith;
}
