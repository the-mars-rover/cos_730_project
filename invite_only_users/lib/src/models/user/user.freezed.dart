// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named

part of 'user.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;
User _$UserFromJson(Map<String, dynamic> json) {
  return _User.fromJson(json);
}

class _$UserTearOff {
  const _$UserTearOff();

  _User call(
      {@required String id,
      @required String phoneNumber,
      @nullable IdBookInfo idBookInfo,
      @nullable IdCardInfo idCardInfo,
      @nullable DriversLicenseInfo driversLicenseInfo,
      @nullable PassportInfo passportInfo}) {
    return _User(
      id: id,
      phoneNumber: phoneNumber,
      idBookInfo: idBookInfo,
      idCardInfo: idCardInfo,
      driversLicenseInfo: driversLicenseInfo,
      passportInfo: passportInfo,
    );
  }
}

// ignore: unused_element
const $User = _$UserTearOff();

mixin _$User {
  String get id;
  String get phoneNumber;
  @nullable
  IdBookInfo get idBookInfo;
  @nullable
  IdCardInfo get idCardInfo;
  @nullable
  DriversLicenseInfo get driversLicenseInfo;
  @nullable
  PassportInfo get passportInfo;

  Map<String, dynamic> toJson();
  $UserCopyWith<User> get copyWith;
}

abstract class $UserCopyWith<$Res> {
  factory $UserCopyWith(User value, $Res Function(User) then) =
      _$UserCopyWithImpl<$Res>;
  $Res call(
      {String id,
      String phoneNumber,
      @nullable IdBookInfo idBookInfo,
      @nullable IdCardInfo idCardInfo,
      @nullable DriversLicenseInfo driversLicenseInfo,
      @nullable PassportInfo passportInfo});
}

class _$UserCopyWithImpl<$Res> implements $UserCopyWith<$Res> {
  _$UserCopyWithImpl(this._value, this._then);

  final User _value;
  // ignore: unused_field
  final $Res Function(User) _then;

  @override
  $Res call({
    Object id = freezed,
    Object phoneNumber = freezed,
    Object idBookInfo = freezed,
    Object idCardInfo = freezed,
    Object driversLicenseInfo = freezed,
    Object passportInfo = freezed,
  }) {
    return _then(_value.copyWith(
      id: id == freezed ? _value.id : id as String,
      phoneNumber:
          phoneNumber == freezed ? _value.phoneNumber : phoneNumber as String,
      idBookInfo:
          idBookInfo == freezed ? _value.idBookInfo : idBookInfo as IdBookInfo,
      idCardInfo:
          idCardInfo == freezed ? _value.idCardInfo : idCardInfo as IdCardInfo,
      driversLicenseInfo: driversLicenseInfo == freezed
          ? _value.driversLicenseInfo
          : driversLicenseInfo as DriversLicenseInfo,
      passportInfo: passportInfo == freezed
          ? _value.passportInfo
          : passportInfo as PassportInfo,
    ));
  }
}

abstract class _$UserCopyWith<$Res> implements $UserCopyWith<$Res> {
  factory _$UserCopyWith(_User value, $Res Function(_User) then) =
      __$UserCopyWithImpl<$Res>;
  @override
  $Res call(
      {String id,
      String phoneNumber,
      @nullable IdBookInfo idBookInfo,
      @nullable IdCardInfo idCardInfo,
      @nullable DriversLicenseInfo driversLicenseInfo,
      @nullable PassportInfo passportInfo});
}

class __$UserCopyWithImpl<$Res> extends _$UserCopyWithImpl<$Res>
    implements _$UserCopyWith<$Res> {
  __$UserCopyWithImpl(_User _value, $Res Function(_User) _then)
      : super(_value, (v) => _then(v as _User));

  @override
  _User get _value => super._value as _User;

  @override
  $Res call({
    Object id = freezed,
    Object phoneNumber = freezed,
    Object idBookInfo = freezed,
    Object idCardInfo = freezed,
    Object driversLicenseInfo = freezed,
    Object passportInfo = freezed,
  }) {
    return _then(_User(
      id: id == freezed ? _value.id : id as String,
      phoneNumber:
          phoneNumber == freezed ? _value.phoneNumber : phoneNumber as String,
      idBookInfo:
          idBookInfo == freezed ? _value.idBookInfo : idBookInfo as IdBookInfo,
      idCardInfo:
          idCardInfo == freezed ? _value.idCardInfo : idCardInfo as IdCardInfo,
      driversLicenseInfo: driversLicenseInfo == freezed
          ? _value.driversLicenseInfo
          : driversLicenseInfo as DriversLicenseInfo,
      passportInfo: passportInfo == freezed
          ? _value.passportInfo
          : passportInfo as PassportInfo,
    ));
  }
}

@JsonSerializable()
class _$_User with DiagnosticableTreeMixin implements _User {
  const _$_User(
      {@required this.id,
      @required this.phoneNumber,
      @nullable this.idBookInfo,
      @nullable this.idCardInfo,
      @nullable this.driversLicenseInfo,
      @nullable this.passportInfo})
      : assert(id != null),
        assert(phoneNumber != null);

  factory _$_User.fromJson(Map<String, dynamic> json) =>
      _$_$_UserFromJson(json);

  @override
  final String id;
  @override
  final String phoneNumber;
  @override
  @nullable
  final IdBookInfo idBookInfo;
  @override
  @nullable
  final IdCardInfo idCardInfo;
  @override
  @nullable
  final DriversLicenseInfo driversLicenseInfo;
  @override
  @nullable
  final PassportInfo passportInfo;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'User(id: $id, phoneNumber: $phoneNumber, idBookInfo: $idBookInfo, idCardInfo: $idCardInfo, driversLicenseInfo: $driversLicenseInfo, passportInfo: $passportInfo)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'User'))
      ..add(DiagnosticsProperty('id', id))
      ..add(DiagnosticsProperty('phoneNumber', phoneNumber))
      ..add(DiagnosticsProperty('idBookInfo', idBookInfo))
      ..add(DiagnosticsProperty('idCardInfo', idCardInfo))
      ..add(DiagnosticsProperty('driversLicenseInfo', driversLicenseInfo))
      ..add(DiagnosticsProperty('passportInfo', passportInfo));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _User &&
            (identical(other.id, id) ||
                const DeepCollectionEquality().equals(other.id, id)) &&
            (identical(other.phoneNumber, phoneNumber) ||
                const DeepCollectionEquality()
                    .equals(other.phoneNumber, phoneNumber)) &&
            (identical(other.idBookInfo, idBookInfo) ||
                const DeepCollectionEquality()
                    .equals(other.idBookInfo, idBookInfo)) &&
            (identical(other.idCardInfo, idCardInfo) ||
                const DeepCollectionEquality()
                    .equals(other.idCardInfo, idCardInfo)) &&
            (identical(other.driversLicenseInfo, driversLicenseInfo) ||
                const DeepCollectionEquality()
                    .equals(other.driversLicenseInfo, driversLicenseInfo)) &&
            (identical(other.passportInfo, passportInfo) ||
                const DeepCollectionEquality()
                    .equals(other.passportInfo, passportInfo)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(id) ^
      const DeepCollectionEquality().hash(phoneNumber) ^
      const DeepCollectionEquality().hash(idBookInfo) ^
      const DeepCollectionEquality().hash(idCardInfo) ^
      const DeepCollectionEquality().hash(driversLicenseInfo) ^
      const DeepCollectionEquality().hash(passportInfo);

  @override
  _$UserCopyWith<_User> get copyWith =>
      __$UserCopyWithImpl<_User>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$_$_UserToJson(this);
  }
}

abstract class _User implements User {
  const factory _User(
      {@required String id,
      @required String phoneNumber,
      @nullable IdBookInfo idBookInfo,
      @nullable IdCardInfo idCardInfo,
      @nullable DriversLicenseInfo driversLicenseInfo,
      @nullable PassportInfo passportInfo}) = _$_User;

  factory _User.fromJson(Map<String, dynamic> json) = _$_User.fromJson;

  @override
  String get id;
  @override
  String get phoneNumber;
  @override
  @nullable
  IdBookInfo get idBookInfo;
  @override
  @nullable
  IdCardInfo get idCardInfo;
  @override
  @nullable
  DriversLicenseInfo get driversLicenseInfo;
  @override
  @nullable
  PassportInfo get passportInfo;
  @override
  _$UserCopyWith<_User> get copyWith;
}
