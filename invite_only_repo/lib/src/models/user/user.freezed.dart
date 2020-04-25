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
      IdBook idBook,
      IdCard idCard,
      DriversLicense driversLicense,
      Passport passport}) {
    return _User(
      id: id,
      phoneNumber: phoneNumber,
      idBook: idBook,
      idCard: idCard,
      driversLicense: driversLicense,
      passport: passport,
    );
  }
}

// ignore: unused_element
const $User = _$UserTearOff();

mixin _$User {
  String get id;
  String get phoneNumber;
  IdBook get idBook;
  IdCard get idCard;
  DriversLicense get driversLicense;
  Passport get passport;

  Map<String, dynamic> toJson();
  $UserCopyWith<User> get copyWith;
}

abstract class $UserCopyWith<$Res> {
  factory $UserCopyWith(User value, $Res Function(User) then) =
      _$UserCopyWithImpl<$Res>;
  $Res call(
      {String id,
      String phoneNumber,
      IdBook idBook,
      IdCard idCard,
      DriversLicense driversLicense,
      Passport passport});
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
    Object idBook = freezed,
    Object idCard = freezed,
    Object driversLicense = freezed,
    Object passport = freezed,
  }) {
    return _then(_value.copyWith(
      id: id == freezed ? _value.id : id as String,
      phoneNumber:
          phoneNumber == freezed ? _value.phoneNumber : phoneNumber as String,
      idBook: idBook == freezed ? _value.idBook : idBook as IdBook,
      idCard: idCard == freezed ? _value.idCard : idCard as IdCard,
      driversLicense: driversLicense == freezed
          ? _value.driversLicense
          : driversLicense as DriversLicense,
      passport: passport == freezed ? _value.passport : passport as Passport,
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
      IdBook idBook,
      IdCard idCard,
      DriversLicense driversLicense,
      Passport passport});
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
    Object idBook = freezed,
    Object idCard = freezed,
    Object driversLicense = freezed,
    Object passport = freezed,
  }) {
    return _then(_User(
      id: id == freezed ? _value.id : id as String,
      phoneNumber:
          phoneNumber == freezed ? _value.phoneNumber : phoneNumber as String,
      idBook: idBook == freezed ? _value.idBook : idBook as IdBook,
      idCard: idCard == freezed ? _value.idCard : idCard as IdCard,
      driversLicense: driversLicense == freezed
          ? _value.driversLicense
          : driversLicense as DriversLicense,
      passport: passport == freezed ? _value.passport : passport as Passport,
    ));
  }
}

@JsonSerializable()
class _$_User with DiagnosticableTreeMixin implements _User {
  const _$_User(
      {@required this.id,
      @required this.phoneNumber,
      this.idBook,
      this.idCard,
      this.driversLicense,
      this.passport})
      : assert(id != null),
        assert(phoneNumber != null);

  factory _$_User.fromJson(Map<String, dynamic> json) =>
      _$_$_UserFromJson(json);

  @override
  final String id;
  @override
  final String phoneNumber;
  @override
  final IdBook idBook;
  @override
  final IdCard idCard;
  @override
  final DriversLicense driversLicense;
  @override
  final Passport passport;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'User(id: $id, phoneNumber: $phoneNumber, idBook: $idBook, idCard: $idCard, driversLicense: $driversLicense, passport: $passport)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'User'))
      ..add(DiagnosticsProperty('id', id))
      ..add(DiagnosticsProperty('phoneNumber', phoneNumber))
      ..add(DiagnosticsProperty('idBook', idBook))
      ..add(DiagnosticsProperty('idCard', idCard))
      ..add(DiagnosticsProperty('driversLicense', driversLicense))
      ..add(DiagnosticsProperty('passport', passport));
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
            (identical(other.idBook, idBook) ||
                const DeepCollectionEquality().equals(other.idBook, idBook)) &&
            (identical(other.idCard, idCard) ||
                const DeepCollectionEquality().equals(other.idCard, idCard)) &&
            (identical(other.driversLicense, driversLicense) ||
                const DeepCollectionEquality()
                    .equals(other.driversLicense, driversLicense)) &&
            (identical(other.passport, passport) ||
                const DeepCollectionEquality()
                    .equals(other.passport, passport)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(id) ^
      const DeepCollectionEquality().hash(phoneNumber) ^
      const DeepCollectionEquality().hash(idBook) ^
      const DeepCollectionEquality().hash(idCard) ^
      const DeepCollectionEquality().hash(driversLicense) ^
      const DeepCollectionEquality().hash(passport);

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
      IdBook idBook,
      IdCard idCard,
      DriversLicense driversLicense,
      Passport passport}) = _$_User;

  factory _User.fromJson(Map<String, dynamic> json) = _$_User.fromJson;

  @override
  String get id;
  @override
  String get phoneNumber;
  @override
  IdBook get idBook;
  @override
  IdCard get idCard;
  @override
  DriversLicense get driversLicense;
  @override
  Passport get passport;
  @override
  _$UserCopyWith<_User> get copyWith;
}
