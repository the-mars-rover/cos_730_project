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

  IdBook idBook({@required String userId}) {
    return IdBook(
      userId: userId,
    );
  }

  IdCard idCard({@required String userId}) {
    return IdCard(
      userId: userId,
    );
  }

  DriversLicense driversLicense({@required String userId}) {
    return DriversLicense(
      userId: userId,
    );
  }

  Passport passport({@required String userId}) {
    return Passport(
      userId: userId,
    );
  }
}

// ignore: unused_element
const $IdDocument = _$IdDocumentTearOff();

mixin _$IdDocument {
  String get userId;

  @optionalTypeArgs
  Result when<Result extends Object>({
    @required Result idBook(@required String userId),
    @required Result idCard(@required String userId),
    @required Result driversLicense(@required String userId),
    @required Result passport(@required String userId),
  });
  @optionalTypeArgs
  Result maybeWhen<Result extends Object>({
    Result idBook(@required String userId),
    Result idCard(@required String userId),
    Result driversLicense(@required String userId),
    Result passport(@required String userId),
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
  $IdDocumentCopyWith<IdDocument> get copyWith;
}

abstract class $IdDocumentCopyWith<$Res> {
  factory $IdDocumentCopyWith(
          IdDocument value, $Res Function(IdDocument) then) =
      _$IdDocumentCopyWithImpl<$Res>;
  $Res call({String userId});
}

class _$IdDocumentCopyWithImpl<$Res> implements $IdDocumentCopyWith<$Res> {
  _$IdDocumentCopyWithImpl(this._value, this._then);

  final IdDocument _value;
  // ignore: unused_field
  final $Res Function(IdDocument) _then;

  @override
  $Res call({
    Object userId = freezed,
  }) {
    return _then(_value.copyWith(
      userId: userId == freezed ? _value.userId : userId as String,
    ));
  }
}

abstract class $IdBookCopyWith<$Res> implements $IdDocumentCopyWith<$Res> {
  factory $IdBookCopyWith(IdBook value, $Res Function(IdBook) then) =
      _$IdBookCopyWithImpl<$Res>;
  @override
  $Res call({String userId});
}

class _$IdBookCopyWithImpl<$Res> extends _$IdDocumentCopyWithImpl<$Res>
    implements $IdBookCopyWith<$Res> {
  _$IdBookCopyWithImpl(IdBook _value, $Res Function(IdBook) _then)
      : super(_value, (v) => _then(v as IdBook));

  @override
  IdBook get _value => super._value as IdBook;

  @override
  $Res call({
    Object userId = freezed,
  }) {
    return _then(IdBook(
      userId: userId == freezed ? _value.userId : userId as String,
    ));
  }
}

@JsonSerializable()
class _$IdBook with DiagnosticableTreeMixin implements IdBook {
  const _$IdBook({@required this.userId}) : assert(userId != null);

  factory _$IdBook.fromJson(Map<String, dynamic> json) =>
      _$_$IdBookFromJson(json);

  @override
  final String userId;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'IdDocument.idBook(userId: $userId)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'IdDocument.idBook'))
      ..add(DiagnosticsProperty('userId', userId));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is IdBook &&
            (identical(other.userId, userId) ||
                const DeepCollectionEquality().equals(other.userId, userId)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^ const DeepCollectionEquality().hash(userId);

  @override
  $IdBookCopyWith<IdBook> get copyWith =>
      _$IdBookCopyWithImpl<IdBook>(this, _$identity);

  @override
  @optionalTypeArgs
  Result when<Result extends Object>({
    @required Result idBook(@required String userId),
    @required Result idCard(@required String userId),
    @required Result driversLicense(@required String userId),
    @required Result passport(@required String userId),
  }) {
    assert(idBook != null);
    assert(idCard != null);
    assert(driversLicense != null);
    assert(passport != null);
    return idBook(userId);
  }

  @override
  @optionalTypeArgs
  Result maybeWhen<Result extends Object>({
    Result idBook(@required String userId),
    Result idCard(@required String userId),
    Result driversLicense(@required String userId),
    Result passport(@required String userId),
    @required Result orElse(),
  }) {
    assert(orElse != null);
    if (idBook != null) {
      return idBook(userId);
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
  const factory IdBook({@required String userId}) = _$IdBook;

  factory IdBook.fromJson(Map<String, dynamic> json) = _$IdBook.fromJson;

  @override
  String get userId;
  @override
  $IdBookCopyWith<IdBook> get copyWith;
}

abstract class $IdCardCopyWith<$Res> implements $IdDocumentCopyWith<$Res> {
  factory $IdCardCopyWith(IdCard value, $Res Function(IdCard) then) =
      _$IdCardCopyWithImpl<$Res>;
  @override
  $Res call({String userId});
}

class _$IdCardCopyWithImpl<$Res> extends _$IdDocumentCopyWithImpl<$Res>
    implements $IdCardCopyWith<$Res> {
  _$IdCardCopyWithImpl(IdCard _value, $Res Function(IdCard) _then)
      : super(_value, (v) => _then(v as IdCard));

  @override
  IdCard get _value => super._value as IdCard;

  @override
  $Res call({
    Object userId = freezed,
  }) {
    return _then(IdCard(
      userId: userId == freezed ? _value.userId : userId as String,
    ));
  }
}

@JsonSerializable()
class _$IdCard with DiagnosticableTreeMixin implements IdCard {
  const _$IdCard({@required this.userId}) : assert(userId != null);

  factory _$IdCard.fromJson(Map<String, dynamic> json) =>
      _$_$IdCardFromJson(json);

  @override
  final String userId;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'IdDocument.idCard(userId: $userId)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'IdDocument.idCard'))
      ..add(DiagnosticsProperty('userId', userId));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is IdCard &&
            (identical(other.userId, userId) ||
                const DeepCollectionEquality().equals(other.userId, userId)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^ const DeepCollectionEquality().hash(userId);

  @override
  $IdCardCopyWith<IdCard> get copyWith =>
      _$IdCardCopyWithImpl<IdCard>(this, _$identity);

  @override
  @optionalTypeArgs
  Result when<Result extends Object>({
    @required Result idBook(@required String userId),
    @required Result idCard(@required String userId),
    @required Result driversLicense(@required String userId),
    @required Result passport(@required String userId),
  }) {
    assert(idBook != null);
    assert(idCard != null);
    assert(driversLicense != null);
    assert(passport != null);
    return idCard(userId);
  }

  @override
  @optionalTypeArgs
  Result maybeWhen<Result extends Object>({
    Result idBook(@required String userId),
    Result idCard(@required String userId),
    Result driversLicense(@required String userId),
    Result passport(@required String userId),
    @required Result orElse(),
  }) {
    assert(orElse != null);
    if (idCard != null) {
      return idCard(userId);
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
  const factory IdCard({@required String userId}) = _$IdCard;

  factory IdCard.fromJson(Map<String, dynamic> json) = _$IdCard.fromJson;

  @override
  String get userId;
  @override
  $IdCardCopyWith<IdCard> get copyWith;
}

abstract class $DriversLicenseCopyWith<$Res>
    implements $IdDocumentCopyWith<$Res> {
  factory $DriversLicenseCopyWith(
          DriversLicense value, $Res Function(DriversLicense) then) =
      _$DriversLicenseCopyWithImpl<$Res>;
  @override
  $Res call({String userId});
}

class _$DriversLicenseCopyWithImpl<$Res> extends _$IdDocumentCopyWithImpl<$Res>
    implements $DriversLicenseCopyWith<$Res> {
  _$DriversLicenseCopyWithImpl(
      DriversLicense _value, $Res Function(DriversLicense) _then)
      : super(_value, (v) => _then(v as DriversLicense));

  @override
  DriversLicense get _value => super._value as DriversLicense;

  @override
  $Res call({
    Object userId = freezed,
  }) {
    return _then(DriversLicense(
      userId: userId == freezed ? _value.userId : userId as String,
    ));
  }
}

@JsonSerializable()
class _$DriversLicense with DiagnosticableTreeMixin implements DriversLicense {
  const _$DriversLicense({@required this.userId}) : assert(userId != null);

  factory _$DriversLicense.fromJson(Map<String, dynamic> json) =>
      _$_$DriversLicenseFromJson(json);

  @override
  final String userId;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'IdDocument.driversLicense(userId: $userId)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'IdDocument.driversLicense'))
      ..add(DiagnosticsProperty('userId', userId));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is DriversLicense &&
            (identical(other.userId, userId) ||
                const DeepCollectionEquality().equals(other.userId, userId)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^ const DeepCollectionEquality().hash(userId);

  @override
  $DriversLicenseCopyWith<DriversLicense> get copyWith =>
      _$DriversLicenseCopyWithImpl<DriversLicense>(this, _$identity);

  @override
  @optionalTypeArgs
  Result when<Result extends Object>({
    @required Result idBook(@required String userId),
    @required Result idCard(@required String userId),
    @required Result driversLicense(@required String userId),
    @required Result passport(@required String userId),
  }) {
    assert(idBook != null);
    assert(idCard != null);
    assert(driversLicense != null);
    assert(passport != null);
    return driversLicense(userId);
  }

  @override
  @optionalTypeArgs
  Result maybeWhen<Result extends Object>({
    Result idBook(@required String userId),
    Result idCard(@required String userId),
    Result driversLicense(@required String userId),
    Result passport(@required String userId),
    @required Result orElse(),
  }) {
    assert(orElse != null);
    if (driversLicense != null) {
      return driversLicense(userId);
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
  const factory DriversLicense({@required String userId}) = _$DriversLicense;

  factory DriversLicense.fromJson(Map<String, dynamic> json) =
      _$DriversLicense.fromJson;

  @override
  String get userId;
  @override
  $DriversLicenseCopyWith<DriversLicense> get copyWith;
}

abstract class $PassportCopyWith<$Res> implements $IdDocumentCopyWith<$Res> {
  factory $PassportCopyWith(Passport value, $Res Function(Passport) then) =
      _$PassportCopyWithImpl<$Res>;
  @override
  $Res call({String userId});
}

class _$PassportCopyWithImpl<$Res> extends _$IdDocumentCopyWithImpl<$Res>
    implements $PassportCopyWith<$Res> {
  _$PassportCopyWithImpl(Passport _value, $Res Function(Passport) _then)
      : super(_value, (v) => _then(v as Passport));

  @override
  Passport get _value => super._value as Passport;

  @override
  $Res call({
    Object userId = freezed,
  }) {
    return _then(Passport(
      userId: userId == freezed ? _value.userId : userId as String,
    ));
  }
}

@JsonSerializable()
class _$Passport with DiagnosticableTreeMixin implements Passport {
  const _$Passport({@required this.userId}) : assert(userId != null);

  factory _$Passport.fromJson(Map<String, dynamic> json) =>
      _$_$PassportFromJson(json);

  @override
  final String userId;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'IdDocument.passport(userId: $userId)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'IdDocument.passport'))
      ..add(DiagnosticsProperty('userId', userId));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is Passport &&
            (identical(other.userId, userId) ||
                const DeepCollectionEquality().equals(other.userId, userId)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^ const DeepCollectionEquality().hash(userId);

  @override
  $PassportCopyWith<Passport> get copyWith =>
      _$PassportCopyWithImpl<Passport>(this, _$identity);

  @override
  @optionalTypeArgs
  Result when<Result extends Object>({
    @required Result idBook(@required String userId),
    @required Result idCard(@required String userId),
    @required Result driversLicense(@required String userId),
    @required Result passport(@required String userId),
  }) {
    assert(idBook != null);
    assert(idCard != null);
    assert(driversLicense != null);
    assert(passport != null);
    return passport(userId);
  }

  @override
  @optionalTypeArgs
  Result maybeWhen<Result extends Object>({
    Result idBook(@required String userId),
    Result idCard(@required String userId),
    Result driversLicense(@required String userId),
    Result passport(@required String userId),
    @required Result orElse(),
  }) {
    assert(orElse != null);
    if (passport != null) {
      return passport(userId);
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
  const factory Passport({@required String userId}) = _$Passport;

  factory Passport.fromJson(Map<String, dynamic> json) = _$Passport.fromJson;

  @override
  String get userId;
  @override
  $PassportCopyWith<Passport> get copyWith;
}
