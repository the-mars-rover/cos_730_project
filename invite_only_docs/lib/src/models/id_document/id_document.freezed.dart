// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named

part of 'id_document.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;
IdDocument _$IdDocumentFromJson(Map<String, dynamic> json) {
  switch (json['runtimeType'] as String) {
    case 'idBook':
      return IdBook.fromJson(json);
    case 'idCard':
      return IdCard.fromJson(json);
    case 'driversLicense':
      return DriversLicense.fromJson(json);
    case 'passport':
      return Passport.fromJson(json);

    default:
      throw FallThroughError();
  }
}

class _$IdDocumentTearOff {
  const _$IdDocumentTearOff();

  IdBook idBook() {
    return const IdBook();
  }

  IdCard idCard() {
    return const IdCard();
  }

  DriversLicense driversLicense() {
    return const DriversLicense();
  }

  Passport passport() {
    return const Passport();
  }
}

// ignore: unused_element
const $IdDocument = _$IdDocumentTearOff();

mixin _$IdDocument {
  @optionalTypeArgs
  Result when<Result extends Object>({
    @required Result idBook(),
    @required Result idCard(),
    @required Result driversLicense(),
    @required Result passport(),
  });
  @optionalTypeArgs
  Result maybeWhen<Result extends Object>({
    Result idBook(),
    Result idCard(),
    Result driversLicense(),
    Result passport(),
    @required Result orElse(),
  });
  @optionalTypeArgs
  Result map<Result extends Object>({
    @required Result idBook(IdBook value),
    @required Result idCard(IdCard value),
    @required Result driversLicense(DriversLicense value),
    @required Result passport(Passport value),
  });
  @optionalTypeArgs
  Result maybeMap<Result extends Object>({
    Result idBook(IdBook value),
    Result idCard(IdCard value),
    Result driversLicense(DriversLicense value),
    Result passport(Passport value),
    @required Result orElse(),
  });
  Map<String, dynamic> toJson();
}

abstract class $IdDocumentCopyWith<$Res> {
  factory $IdDocumentCopyWith(
          IdDocument value, $Res Function(IdDocument) then) =
      _$IdDocumentCopyWithImpl<$Res>;
}

class _$IdDocumentCopyWithImpl<$Res> implements $IdDocumentCopyWith<$Res> {
  _$IdDocumentCopyWithImpl(this._value, this._then);

  final IdDocument _value;
  // ignore: unused_field
  final $Res Function(IdDocument) _then;
}

abstract class $IdBookCopyWith<$Res> {
  factory $IdBookCopyWith(IdBook value, $Res Function(IdBook) then) =
      _$IdBookCopyWithImpl<$Res>;
}

class _$IdBookCopyWithImpl<$Res> extends _$IdDocumentCopyWithImpl<$Res>
    implements $IdBookCopyWith<$Res> {
  _$IdBookCopyWithImpl(IdBook _value, $Res Function(IdBook) _then)
      : super(_value, (v) => _then(v as IdBook));

  @override
  IdBook get _value => super._value as IdBook;
}

@JsonSerializable()
class _$IdBook with DiagnosticableTreeMixin implements IdBook {
  const _$IdBook();

  factory _$IdBook.fromJson(Map<String, dynamic> json) =>
      _$_$IdBookFromJson(json);

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'IdDocument.idBook()';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties..add(DiagnosticsProperty('type', 'IdDocument.idBook'));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) || (other is IdBook);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  Result when<Result extends Object>({
    @required Result idBook(),
    @required Result idCard(),
    @required Result driversLicense(),
    @required Result passport(),
  }) {
    assert(idBook != null);
    assert(idCard != null);
    assert(driversLicense != null);
    assert(passport != null);
    return idBook();
  }

  @override
  @optionalTypeArgs
  Result maybeWhen<Result extends Object>({
    Result idBook(),
    Result idCard(),
    Result driversLicense(),
    Result passport(),
    @required Result orElse(),
  }) {
    assert(orElse != null);
    if (idBook != null) {
      return idBook();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  Result map<Result extends Object>({
    @required Result idBook(IdBook value),
    @required Result idCard(IdCard value),
    @required Result driversLicense(DriversLicense value),
    @required Result passport(Passport value),
  }) {
    assert(idBook != null);
    assert(idCard != null);
    assert(driversLicense != null);
    assert(passport != null);
    return idBook(this);
  }

  @override
  @optionalTypeArgs
  Result maybeMap<Result extends Object>({
    Result idBook(IdBook value),
    Result idCard(IdCard value),
    Result driversLicense(DriversLicense value),
    Result passport(Passport value),
    @required Result orElse(),
  }) {
    assert(orElse != null);
    if (idBook != null) {
      return idBook(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$_$IdBookToJson(this)..['runtimeType'] = 'idBook';
  }
}

abstract class IdBook implements IdDocument {
  const factory IdBook() = _$IdBook;

  factory IdBook.fromJson(Map<String, dynamic> json) = _$IdBook.fromJson;
}

abstract class $IdCardCopyWith<$Res> {
  factory $IdCardCopyWith(IdCard value, $Res Function(IdCard) then) =
      _$IdCardCopyWithImpl<$Res>;
}

class _$IdCardCopyWithImpl<$Res> extends _$IdDocumentCopyWithImpl<$Res>
    implements $IdCardCopyWith<$Res> {
  _$IdCardCopyWithImpl(IdCard _value, $Res Function(IdCard) _then)
      : super(_value, (v) => _then(v as IdCard));

  @override
  IdCard get _value => super._value as IdCard;
}

@JsonSerializable()
class _$IdCard with DiagnosticableTreeMixin implements IdCard {
  const _$IdCard();

  factory _$IdCard.fromJson(Map<String, dynamic> json) =>
      _$_$IdCardFromJson(json);

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'IdDocument.idCard()';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties..add(DiagnosticsProperty('type', 'IdDocument.idCard'));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) || (other is IdCard);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  Result when<Result extends Object>({
    @required Result idBook(),
    @required Result idCard(),
    @required Result driversLicense(),
    @required Result passport(),
  }) {
    assert(idBook != null);
    assert(idCard != null);
    assert(driversLicense != null);
    assert(passport != null);
    return idCard();
  }

  @override
  @optionalTypeArgs
  Result maybeWhen<Result extends Object>({
    Result idBook(),
    Result idCard(),
    Result driversLicense(),
    Result passport(),
    @required Result orElse(),
  }) {
    assert(orElse != null);
    if (idCard != null) {
      return idCard();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  Result map<Result extends Object>({
    @required Result idBook(IdBook value),
    @required Result idCard(IdCard value),
    @required Result driversLicense(DriversLicense value),
    @required Result passport(Passport value),
  }) {
    assert(idBook != null);
    assert(idCard != null);
    assert(driversLicense != null);
    assert(passport != null);
    return idCard(this);
  }

  @override
  @optionalTypeArgs
  Result maybeMap<Result extends Object>({
    Result idBook(IdBook value),
    Result idCard(IdCard value),
    Result driversLicense(DriversLicense value),
    Result passport(Passport value),
    @required Result orElse(),
  }) {
    assert(orElse != null);
    if (idCard != null) {
      return idCard(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$_$IdCardToJson(this)..['runtimeType'] = 'idCard';
  }
}

abstract class IdCard implements IdDocument {
  const factory IdCard() = _$IdCard;

  factory IdCard.fromJson(Map<String, dynamic> json) = _$IdCard.fromJson;
}

abstract class $DriversLicenseCopyWith<$Res> {
  factory $DriversLicenseCopyWith(
          DriversLicense value, $Res Function(DriversLicense) then) =
      _$DriversLicenseCopyWithImpl<$Res>;
}

class _$DriversLicenseCopyWithImpl<$Res> extends _$IdDocumentCopyWithImpl<$Res>
    implements $DriversLicenseCopyWith<$Res> {
  _$DriversLicenseCopyWithImpl(
      DriversLicense _value, $Res Function(DriversLicense) _then)
      : super(_value, (v) => _then(v as DriversLicense));

  @override
  DriversLicense get _value => super._value as DriversLicense;
}

@JsonSerializable()
class _$DriversLicense with DiagnosticableTreeMixin implements DriversLicense {
  const _$DriversLicense();

  factory _$DriversLicense.fromJson(Map<String, dynamic> json) =>
      _$_$DriversLicenseFromJson(json);

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'IdDocument.driversLicense()';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties..add(DiagnosticsProperty('type', 'IdDocument.driversLicense'));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) || (other is DriversLicense);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  Result when<Result extends Object>({
    @required Result idBook(),
    @required Result idCard(),
    @required Result driversLicense(),
    @required Result passport(),
  }) {
    assert(idBook != null);
    assert(idCard != null);
    assert(driversLicense != null);
    assert(passport != null);
    return driversLicense();
  }

  @override
  @optionalTypeArgs
  Result maybeWhen<Result extends Object>({
    Result idBook(),
    Result idCard(),
    Result driversLicense(),
    Result passport(),
    @required Result orElse(),
  }) {
    assert(orElse != null);
    if (driversLicense != null) {
      return driversLicense();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  Result map<Result extends Object>({
    @required Result idBook(IdBook value),
    @required Result idCard(IdCard value),
    @required Result driversLicense(DriversLicense value),
    @required Result passport(Passport value),
  }) {
    assert(idBook != null);
    assert(idCard != null);
    assert(driversLicense != null);
    assert(passport != null);
    return driversLicense(this);
  }

  @override
  @optionalTypeArgs
  Result maybeMap<Result extends Object>({
    Result idBook(IdBook value),
    Result idCard(IdCard value),
    Result driversLicense(DriversLicense value),
    Result passport(Passport value),
    @required Result orElse(),
  }) {
    assert(orElse != null);
    if (driversLicense != null) {
      return driversLicense(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$_$DriversLicenseToJson(this)..['runtimeType'] = 'driversLicense';
  }
}

abstract class DriversLicense implements IdDocument {
  const factory DriversLicense() = _$DriversLicense;

  factory DriversLicense.fromJson(Map<String, dynamic> json) =
      _$DriversLicense.fromJson;
}

abstract class $PassportCopyWith<$Res> {
  factory $PassportCopyWith(Passport value, $Res Function(Passport) then) =
      _$PassportCopyWithImpl<$Res>;
}

class _$PassportCopyWithImpl<$Res> extends _$IdDocumentCopyWithImpl<$Res>
    implements $PassportCopyWith<$Res> {
  _$PassportCopyWithImpl(Passport _value, $Res Function(Passport) _then)
      : super(_value, (v) => _then(v as Passport));

  @override
  Passport get _value => super._value as Passport;
}

@JsonSerializable()
class _$Passport with DiagnosticableTreeMixin implements Passport {
  const _$Passport();

  factory _$Passport.fromJson(Map<String, dynamic> json) =>
      _$_$PassportFromJson(json);

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'IdDocument.passport()';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties..add(DiagnosticsProperty('type', 'IdDocument.passport'));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) || (other is Passport);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  Result when<Result extends Object>({
    @required Result idBook(),
    @required Result idCard(),
    @required Result driversLicense(),
    @required Result passport(),
  }) {
    assert(idBook != null);
    assert(idCard != null);
    assert(driversLicense != null);
    assert(passport != null);
    return passport();
  }

  @override
  @optionalTypeArgs
  Result maybeWhen<Result extends Object>({
    Result idBook(),
    Result idCard(),
    Result driversLicense(),
    Result passport(),
    @required Result orElse(),
  }) {
    assert(orElse != null);
    if (passport != null) {
      return passport();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  Result map<Result extends Object>({
    @required Result idBook(IdBook value),
    @required Result idCard(IdCard value),
    @required Result driversLicense(DriversLicense value),
    @required Result passport(Passport value),
  }) {
    assert(idBook != null);
    assert(idCard != null);
    assert(driversLicense != null);
    assert(passport != null);
    return passport(this);
  }

  @override
  @optionalTypeArgs
  Result maybeMap<Result extends Object>({
    Result idBook(IdBook value),
    Result idCard(IdCard value),
    Result driversLicense(DriversLicense value),
    Result passport(Passport value),
    @required Result orElse(),
  }) {
    assert(orElse != null);
    if (passport != null) {
      return passport(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$_$PassportToJson(this)..['runtimeType'] = 'passport';
  }
}

abstract class Passport implements IdDocument {
  const factory Passport() = _$Passport;

  factory Passport.fromJson(Map<String, dynamic> json) = _$Passport.fromJson;
}
