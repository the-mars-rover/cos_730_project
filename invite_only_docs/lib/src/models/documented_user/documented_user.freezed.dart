// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named

part of 'documented_user.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;
DocumentedUser _$DocumentedUserFromJson(Map<String, dynamic> json) {
  return _DocumentedUser.fromJson(json);
}

class _$DocumentedUserTearOff {
  const _$DocumentedUserTearOff();

  _DocumentedUser call(
      {@required String id,
      IdBook idBook,
      IdCard idCard,
      DriversLicense driversLicense,
      Passport passport}) {
    return _DocumentedUser(
      id: id,
      idBook: idBook,
      idCard: idCard,
      driversLicense: driversLicense,
      passport: passport,
    );
  }
}

// ignore: unused_element
const $DocumentedUser = _$DocumentedUserTearOff();

mixin _$DocumentedUser {
  String get id;
  IdBook get idBook;
  IdCard get idCard;
  DriversLicense get driversLicense;
  Passport get passport;

  Map<String, dynamic> toJson();
  $DocumentedUserCopyWith<DocumentedUser> get copyWith;
}

abstract class $DocumentedUserCopyWith<$Res> {
  factory $DocumentedUserCopyWith(
          DocumentedUser value, $Res Function(DocumentedUser) then) =
      _$DocumentedUserCopyWithImpl<$Res>;
  $Res call(
      {String id,
      IdBook idBook,
      IdCard idCard,
      DriversLicense driversLicense,
      Passport passport});
}

class _$DocumentedUserCopyWithImpl<$Res>
    implements $DocumentedUserCopyWith<$Res> {
  _$DocumentedUserCopyWithImpl(this._value, this._then);

  final DocumentedUser _value;
  // ignore: unused_field
  final $Res Function(DocumentedUser) _then;

  @override
  $Res call({
    Object id = freezed,
    Object idBook = freezed,
    Object idCard = freezed,
    Object driversLicense = freezed,
    Object passport = freezed,
  }) {
    return _then(_value.copyWith(
      id: id == freezed ? _value.id : id as String,
      idBook: idBook == freezed ? _value.idBook : idBook as IdBook,
      idCard: idCard == freezed ? _value.idCard : idCard as IdCard,
      driversLicense: driversLicense == freezed
          ? _value.driversLicense
          : driversLicense as DriversLicense,
      passport: passport == freezed ? _value.passport : passport as Passport,
    ));
  }
}

abstract class _$DocumentedUserCopyWith<$Res>
    implements $DocumentedUserCopyWith<$Res> {
  factory _$DocumentedUserCopyWith(
          _DocumentedUser value, $Res Function(_DocumentedUser) then) =
      __$DocumentedUserCopyWithImpl<$Res>;
  @override
  $Res call(
      {String id,
      IdBook idBook,
      IdCard idCard,
      DriversLicense driversLicense,
      Passport passport});
}

class __$DocumentedUserCopyWithImpl<$Res>
    extends _$DocumentedUserCopyWithImpl<$Res>
    implements _$DocumentedUserCopyWith<$Res> {
  __$DocumentedUserCopyWithImpl(
      _DocumentedUser _value, $Res Function(_DocumentedUser) _then)
      : super(_value, (v) => _then(v as _DocumentedUser));

  @override
  _DocumentedUser get _value => super._value as _DocumentedUser;

  @override
  $Res call({
    Object id = freezed,
    Object idBook = freezed,
    Object idCard = freezed,
    Object driversLicense = freezed,
    Object passport = freezed,
  }) {
    return _then(_DocumentedUser(
      id: id == freezed ? _value.id : id as String,
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
class _$_DocumentedUser
    with DiagnosticableTreeMixin
    implements _DocumentedUser {
  const _$_DocumentedUser(
      {@required this.id,
      this.idBook,
      this.idCard,
      this.driversLicense,
      this.passport})
      : assert(id != null);

  factory _$_DocumentedUser.fromJson(Map<String, dynamic> json) =>
      _$_$_DocumentedUserFromJson(json);

  @override
  final String id;
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
    return 'DocumentedUser(id: $id, idBook: $idBook, idCard: $idCard, driversLicense: $driversLicense, passport: $passport)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'DocumentedUser'))
      ..add(DiagnosticsProperty('id', id))
      ..add(DiagnosticsProperty('idBook', idBook))
      ..add(DiagnosticsProperty('idCard', idCard))
      ..add(DiagnosticsProperty('driversLicense', driversLicense))
      ..add(DiagnosticsProperty('passport', passport));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _DocumentedUser &&
            (identical(other.id, id) ||
                const DeepCollectionEquality().equals(other.id, id)) &&
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
      const DeepCollectionEquality().hash(idBook) ^
      const DeepCollectionEquality().hash(idCard) ^
      const DeepCollectionEquality().hash(driversLicense) ^
      const DeepCollectionEquality().hash(passport);

  @override
  _$DocumentedUserCopyWith<_DocumentedUser> get copyWith =>
      __$DocumentedUserCopyWithImpl<_DocumentedUser>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$_$_DocumentedUserToJson(this);
  }
}

abstract class _DocumentedUser implements DocumentedUser {
  const factory _DocumentedUser(
      {@required String id,
      IdBook idBook,
      IdCard idCard,
      DriversLicense driversLicense,
      Passport passport}) = _$_DocumentedUser;

  factory _DocumentedUser.fromJson(Map<String, dynamic> json) =
      _$_DocumentedUser.fromJson;

  @override
  String get id;
  @override
  IdBook get idBook;
  @override
  IdCard get idCard;
  @override
  DriversLicense get driversLicense;
  @override
  Passport get passport;
  @override
  _$DocumentedUserCopyWith<_DocumentedUser> get copyWith;
}
