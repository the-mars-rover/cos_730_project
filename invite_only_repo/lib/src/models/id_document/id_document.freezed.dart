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

  IdBook idBook(
      {String type = 'idBook',
      @required int id,
      @required String idNumber,
      String phoneNumber,
      @required String gender,
      @required DateTime birthDate,
      @required String citizenshipStatus}) {
    return IdBook(
      type: type,
      id: id,
      idNumber: idNumber,
      phoneNumber: phoneNumber,
      gender: gender,
      birthDate: birthDate,
      citizenshipStatus: citizenshipStatus,
    );
  }

  IdCard idCard(
      {String type = 'idCard',
      @required int id,
      @required String idNumber,
      String phoneNumber,
      @required String firstNames,
      @required String surname,
      @required String gender,
      @required DateTime birthDate,
      @required DateTime issueDate,
      @required String smartIdNumber,
      @required String nationality,
      @required String countryOfBirth,
      @required String citizenshipStatus}) {
    return IdCard(
      type: type,
      id: id,
      idNumber: idNumber,
      phoneNumber: phoneNumber,
      firstNames: firstNames,
      surname: surname,
      gender: gender,
      birthDate: birthDate,
      issueDate: issueDate,
      smartIdNumber: smartIdNumber,
      nationality: nationality,
      countryOfBirth: countryOfBirth,
      citizenshipStatus: citizenshipStatus,
    );
  }

  DriversLicense driversLicense(
      {String type = 'driversLicense',
      @required int id,
      @required String idNumber,
      String phoneNumber,
      @required String firstNames,
      @required String surname,
      @required String gender,
      @required DateTime birthDate,
      @required List<DateTime> issueDates,
      @required String licenseNumber,
      @required List<String> vehicleCodes,
      String prdpCode,
      @required String idCountryOfIssue,
      @required String licenseCountryOfIssue,
      @required List<String> vehicleRestrictions,
      @required String idNumberType,
      @required String driverRestrictions,
      DateTime prdpExpiry,
      @required String licenseIssueNumber,
      @required DateTime validFrom,
      @required DateTime validTo}) {
    return DriversLicense(
      type: type,
      id: id,
      idNumber: idNumber,
      phoneNumber: phoneNumber,
      firstNames: firstNames,
      surname: surname,
      gender: gender,
      birthDate: birthDate,
      issueDates: issueDates,
      licenseNumber: licenseNumber,
      vehicleCodes: vehicleCodes,
      prdpCode: prdpCode,
      idCountryOfIssue: idCountryOfIssue,
      licenseCountryOfIssue: licenseCountryOfIssue,
      vehicleRestrictions: vehicleRestrictions,
      idNumberType: idNumberType,
      driverRestrictions: driverRestrictions,
      prdpExpiry: prdpExpiry,
      licenseIssueNumber: licenseIssueNumber,
      validFrom: validFrom,
      validTo: validTo,
    );
  }

  Passport passport(
      {String type = 'passport',
      @required int id,
      @required String idNumber,
      String phoneNumber}) {
    return Passport(
      type: type,
      id: id,
      idNumber: idNumber,
      phoneNumber: phoneNumber,
    );
  }
}

// ignore: unused_element
const $IdDocument = _$IdDocumentTearOff();

mixin _$IdDocument {
  String get type;
  int get id;
  String get idNumber;
  String get phoneNumber;

  @optionalTypeArgs
  Result when<Result extends Object>({
    @required
        Result idBook(String type, int id, String idNumber, String phoneNumber,
            String gender, DateTime birthDate, String citizenshipStatus),
    @required
        Result idCard(
            String type,
            int id,
            String idNumber,
            String phoneNumber,
            String firstNames,
            String surname,
            String gender,
            DateTime birthDate,
            DateTime issueDate,
            String smartIdNumber,
            String nationality,
            String countryOfBirth,
            String citizenshipStatus),
    @required
        Result driversLicense(
            String type,
            int id,
            String idNumber,
            String phoneNumber,
            String firstNames,
            String surname,
            String gender,
            DateTime birthDate,
            List<DateTime> issueDates,
            String licenseNumber,
            List<String> vehicleCodes,
            String prdpCode,
            String idCountryOfIssue,
            String licenseCountryOfIssue,
            List<String> vehicleRestrictions,
            String idNumberType,
            String driverRestrictions,
            DateTime prdpExpiry,
            String licenseIssueNumber,
            DateTime validFrom,
            DateTime validTo),
    @required
        Result passport(
            String type, int id, String idNumber, String phoneNumber),
  });
  @optionalTypeArgs
  Result maybeWhen<Result extends Object>({
    Result idBook(String type, int id, String idNumber, String phoneNumber,
        String gender, DateTime birthDate, String citizenshipStatus),
    Result idCard(
        String type,
        int id,
        String idNumber,
        String phoneNumber,
        String firstNames,
        String surname,
        String gender,
        DateTime birthDate,
        DateTime issueDate,
        String smartIdNumber,
        String nationality,
        String countryOfBirth,
        String citizenshipStatus),
    Result driversLicense(
        String type,
        int id,
        String idNumber,
        String phoneNumber,
        String firstNames,
        String surname,
        String gender,
        DateTime birthDate,
        List<DateTime> issueDates,
        String licenseNumber,
        List<String> vehicleCodes,
        String prdpCode,
        String idCountryOfIssue,
        String licenseCountryOfIssue,
        List<String> vehicleRestrictions,
        String idNumberType,
        String driverRestrictions,
        DateTime prdpExpiry,
        String licenseIssueNumber,
        DateTime validFrom,
        DateTime validTo),
    Result passport(String type, int id, String idNumber, String phoneNumber),
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
  $Res call({String type, int id, String idNumber, String phoneNumber});
}

class _$IdDocumentCopyWithImpl<$Res> implements $IdDocumentCopyWith<$Res> {
  _$IdDocumentCopyWithImpl(this._value, this._then);

  final IdDocument _value;
  // ignore: unused_field
  final $Res Function(IdDocument) _then;

  @override
  $Res call({
    Object type = freezed,
    Object id = freezed,
    Object idNumber = freezed,
    Object phoneNumber = freezed,
  }) {
    return _then(_value.copyWith(
      type: type == freezed ? _value.type : type as String,
      id: id == freezed ? _value.id : id as int,
      idNumber: idNumber == freezed ? _value.idNumber : idNumber as String,
      phoneNumber:
          phoneNumber == freezed ? _value.phoneNumber : phoneNumber as String,
    ));
  }
}

abstract class $IdBookCopyWith<$Res> implements $IdDocumentCopyWith<$Res> {
  factory $IdBookCopyWith(IdBook value, $Res Function(IdBook) then) =
      _$IdBookCopyWithImpl<$Res>;
  @override
  $Res call(
      {String type,
      int id,
      String idNumber,
      String phoneNumber,
      String gender,
      DateTime birthDate,
      String citizenshipStatus});
}

class _$IdBookCopyWithImpl<$Res> extends _$IdDocumentCopyWithImpl<$Res>
    implements $IdBookCopyWith<$Res> {
  _$IdBookCopyWithImpl(IdBook _value, $Res Function(IdBook) _then)
      : super(_value, (v) => _then(v as IdBook));

  @override
  IdBook get _value => super._value as IdBook;

  @override
  $Res call({
    Object type = freezed,
    Object id = freezed,
    Object idNumber = freezed,
    Object phoneNumber = freezed,
    Object gender = freezed,
    Object birthDate = freezed,
    Object citizenshipStatus = freezed,
  }) {
    return _then(IdBook(
      type: type == freezed ? _value.type : type as String,
      id: id == freezed ? _value.id : id as int,
      idNumber: idNumber == freezed ? _value.idNumber : idNumber as String,
      phoneNumber:
          phoneNumber == freezed ? _value.phoneNumber : phoneNumber as String,
      gender: gender == freezed ? _value.gender : gender as String,
      birthDate:
          birthDate == freezed ? _value.birthDate : birthDate as DateTime,
      citizenshipStatus: citizenshipStatus == freezed
          ? _value.citizenshipStatus
          : citizenshipStatus as String,
    ));
  }
}

@JsonSerializable()
class _$IdBook with DiagnosticableTreeMixin implements IdBook {
  const _$IdBook(
      {this.type = 'idBook',
      @required this.id,
      @required this.idNumber,
      this.phoneNumber,
      @required this.gender,
      @required this.birthDate,
      @required this.citizenshipStatus})
      : assert(type != null),
        assert(id != null),
        assert(idNumber != null),
        assert(gender != null),
        assert(birthDate != null),
        assert(citizenshipStatus != null);

  factory _$IdBook.fromJson(Map<String, dynamic> json) =>
      _$_$IdBookFromJson(json);

  @JsonKey(defaultValue: 'idBook')
  @override
  final String type;
  @override
  final int id;
  @override
  final String idNumber;
  @override
  final String phoneNumber;
  @override
  final String gender;
  @override
  final DateTime birthDate;
  @override
  final String citizenshipStatus;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'IdDocument.idBook(type: $type, id: $id, idNumber: $idNumber, phoneNumber: $phoneNumber, gender: $gender, birthDate: $birthDate, citizenshipStatus: $citizenshipStatus)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'IdDocument.idBook'))
      ..add(DiagnosticsProperty('type', type))
      ..add(DiagnosticsProperty('id', id))
      ..add(DiagnosticsProperty('idNumber', idNumber))
      ..add(DiagnosticsProperty('phoneNumber', phoneNumber))
      ..add(DiagnosticsProperty('gender', gender))
      ..add(DiagnosticsProperty('birthDate', birthDate))
      ..add(DiagnosticsProperty('citizenshipStatus', citizenshipStatus));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is IdBook &&
            (identical(other.type, type) ||
                const DeepCollectionEquality().equals(other.type, type)) &&
            (identical(other.id, id) ||
                const DeepCollectionEquality().equals(other.id, id)) &&
            (identical(other.idNumber, idNumber) ||
                const DeepCollectionEquality()
                    .equals(other.idNumber, idNumber)) &&
            (identical(other.phoneNumber, phoneNumber) ||
                const DeepCollectionEquality()
                    .equals(other.phoneNumber, phoneNumber)) &&
            (identical(other.gender, gender) ||
                const DeepCollectionEquality().equals(other.gender, gender)) &&
            (identical(other.birthDate, birthDate) ||
                const DeepCollectionEquality()
                    .equals(other.birthDate, birthDate)) &&
            (identical(other.citizenshipStatus, citizenshipStatus) ||
                const DeepCollectionEquality()
                    .equals(other.citizenshipStatus, citizenshipStatus)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(type) ^
      const DeepCollectionEquality().hash(id) ^
      const DeepCollectionEquality().hash(idNumber) ^
      const DeepCollectionEquality().hash(phoneNumber) ^
      const DeepCollectionEquality().hash(gender) ^
      const DeepCollectionEquality().hash(birthDate) ^
      const DeepCollectionEquality().hash(citizenshipStatus);

  @override
  $IdBookCopyWith<IdBook> get copyWith =>
      _$IdBookCopyWithImpl<IdBook>(this, _$identity);

  @override
  @optionalTypeArgs
  Result when<Result extends Object>({
    @required
        Result idBook(String type, int id, String idNumber, String phoneNumber,
            String gender, DateTime birthDate, String citizenshipStatus),
    @required
        Result idCard(
            String type,
            int id,
            String idNumber,
            String phoneNumber,
            String firstNames,
            String surname,
            String gender,
            DateTime birthDate,
            DateTime issueDate,
            String smartIdNumber,
            String nationality,
            String countryOfBirth,
            String citizenshipStatus),
    @required
        Result driversLicense(
            String type,
            int id,
            String idNumber,
            String phoneNumber,
            String firstNames,
            String surname,
            String gender,
            DateTime birthDate,
            List<DateTime> issueDates,
            String licenseNumber,
            List<String> vehicleCodes,
            String prdpCode,
            String idCountryOfIssue,
            String licenseCountryOfIssue,
            List<String> vehicleRestrictions,
            String idNumberType,
            String driverRestrictions,
            DateTime prdpExpiry,
            String licenseIssueNumber,
            DateTime validFrom,
            DateTime validTo),
    @required
        Result passport(
            String type, int id, String idNumber, String phoneNumber),
  }) {
    assert(idBook != null);
    assert(idCard != null);
    assert(driversLicense != null);
    assert(passport != null);
    return idBook(
        type, id, idNumber, phoneNumber, gender, birthDate, citizenshipStatus);
  }

  @override
  @optionalTypeArgs
  Result maybeWhen<Result extends Object>({
    Result idBook(String type, int id, String idNumber, String phoneNumber,
        String gender, DateTime birthDate, String citizenshipStatus),
    Result idCard(
        String type,
        int id,
        String idNumber,
        String phoneNumber,
        String firstNames,
        String surname,
        String gender,
        DateTime birthDate,
        DateTime issueDate,
        String smartIdNumber,
        String nationality,
        String countryOfBirth,
        String citizenshipStatus),
    Result driversLicense(
        String type,
        int id,
        String idNumber,
        String phoneNumber,
        String firstNames,
        String surname,
        String gender,
        DateTime birthDate,
        List<DateTime> issueDates,
        String licenseNumber,
        List<String> vehicleCodes,
        String prdpCode,
        String idCountryOfIssue,
        String licenseCountryOfIssue,
        List<String> vehicleRestrictions,
        String idNumberType,
        String driverRestrictions,
        DateTime prdpExpiry,
        String licenseIssueNumber,
        DateTime validFrom,
        DateTime validTo),
    Result passport(String type, int id, String idNumber, String phoneNumber),
    @required Result orElse(),
  }) {
    assert(orElse != null);
    if (idBook != null) {
      return idBook(type, id, idNumber, phoneNumber, gender, birthDate,
          citizenshipStatus);
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
  const factory IdBook(
      {String type,
      @required int id,
      @required String idNumber,
      String phoneNumber,
      @required String gender,
      @required DateTime birthDate,
      @required String citizenshipStatus}) = _$IdBook;

  factory IdBook.fromJson(Map<String, dynamic> json) = _$IdBook.fromJson;

  @override
  String get type;
  @override
  int get id;
  @override
  String get idNumber;
  @override
  String get phoneNumber;
  String get gender;
  DateTime get birthDate;
  String get citizenshipStatus;
  @override
  $IdBookCopyWith<IdBook> get copyWith;
}

abstract class $IdCardCopyWith<$Res> implements $IdDocumentCopyWith<$Res> {
  factory $IdCardCopyWith(IdCard value, $Res Function(IdCard) then) =
      _$IdCardCopyWithImpl<$Res>;
  @override
  $Res call(
      {String type,
      int id,
      String idNumber,
      String phoneNumber,
      String firstNames,
      String surname,
      String gender,
      DateTime birthDate,
      DateTime issueDate,
      String smartIdNumber,
      String nationality,
      String countryOfBirth,
      String citizenshipStatus});
}

class _$IdCardCopyWithImpl<$Res> extends _$IdDocumentCopyWithImpl<$Res>
    implements $IdCardCopyWith<$Res> {
  _$IdCardCopyWithImpl(IdCard _value, $Res Function(IdCard) _then)
      : super(_value, (v) => _then(v as IdCard));

  @override
  IdCard get _value => super._value as IdCard;

  @override
  $Res call({
    Object type = freezed,
    Object id = freezed,
    Object idNumber = freezed,
    Object phoneNumber = freezed,
    Object firstNames = freezed,
    Object surname = freezed,
    Object gender = freezed,
    Object birthDate = freezed,
    Object issueDate = freezed,
    Object smartIdNumber = freezed,
    Object nationality = freezed,
    Object countryOfBirth = freezed,
    Object citizenshipStatus = freezed,
  }) {
    return _then(IdCard(
      type: type == freezed ? _value.type : type as String,
      id: id == freezed ? _value.id : id as int,
      idNumber: idNumber == freezed ? _value.idNumber : idNumber as String,
      phoneNumber:
          phoneNumber == freezed ? _value.phoneNumber : phoneNumber as String,
      firstNames:
          firstNames == freezed ? _value.firstNames : firstNames as String,
      surname: surname == freezed ? _value.surname : surname as String,
      gender: gender == freezed ? _value.gender : gender as String,
      birthDate:
          birthDate == freezed ? _value.birthDate : birthDate as DateTime,
      issueDate:
          issueDate == freezed ? _value.issueDate : issueDate as DateTime,
      smartIdNumber: smartIdNumber == freezed
          ? _value.smartIdNumber
          : smartIdNumber as String,
      nationality:
          nationality == freezed ? _value.nationality : nationality as String,
      countryOfBirth: countryOfBirth == freezed
          ? _value.countryOfBirth
          : countryOfBirth as String,
      citizenshipStatus: citizenshipStatus == freezed
          ? _value.citizenshipStatus
          : citizenshipStatus as String,
    ));
  }
}

@JsonSerializable()
class _$IdCard with DiagnosticableTreeMixin implements IdCard {
  const _$IdCard(
      {this.type = 'idCard',
      @required this.id,
      @required this.idNumber,
      this.phoneNumber,
      @required this.firstNames,
      @required this.surname,
      @required this.gender,
      @required this.birthDate,
      @required this.issueDate,
      @required this.smartIdNumber,
      @required this.nationality,
      @required this.countryOfBirth,
      @required this.citizenshipStatus})
      : assert(type != null),
        assert(id != null),
        assert(idNumber != null),
        assert(firstNames != null),
        assert(surname != null),
        assert(gender != null),
        assert(birthDate != null),
        assert(issueDate != null),
        assert(smartIdNumber != null),
        assert(nationality != null),
        assert(countryOfBirth != null),
        assert(citizenshipStatus != null);

  factory _$IdCard.fromJson(Map<String, dynamic> json) =>
      _$_$IdCardFromJson(json);

  @JsonKey(defaultValue: 'idCard')
  @override
  final String type;
  @override
  final int id;
  @override
  final String idNumber;
  @override
  final String phoneNumber;
  @override
  final String firstNames;
  @override
  final String surname;
  @override
  final String gender;
  @override
  final DateTime birthDate;
  @override
  final DateTime issueDate;
  @override
  final String smartIdNumber;
  @override
  final String nationality;
  @override
  final String countryOfBirth;
  @override
  final String citizenshipStatus;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'IdDocument.idCard(type: $type, id: $id, idNumber: $idNumber, phoneNumber: $phoneNumber, firstNames: $firstNames, surname: $surname, gender: $gender, birthDate: $birthDate, issueDate: $issueDate, smartIdNumber: $smartIdNumber, nationality: $nationality, countryOfBirth: $countryOfBirth, citizenshipStatus: $citizenshipStatus)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'IdDocument.idCard'))
      ..add(DiagnosticsProperty('type', type))
      ..add(DiagnosticsProperty('id', id))
      ..add(DiagnosticsProperty('idNumber', idNumber))
      ..add(DiagnosticsProperty('phoneNumber', phoneNumber))
      ..add(DiagnosticsProperty('firstNames', firstNames))
      ..add(DiagnosticsProperty('surname', surname))
      ..add(DiagnosticsProperty('gender', gender))
      ..add(DiagnosticsProperty('birthDate', birthDate))
      ..add(DiagnosticsProperty('issueDate', issueDate))
      ..add(DiagnosticsProperty('smartIdNumber', smartIdNumber))
      ..add(DiagnosticsProperty('nationality', nationality))
      ..add(DiagnosticsProperty('countryOfBirth', countryOfBirth))
      ..add(DiagnosticsProperty('citizenshipStatus', citizenshipStatus));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is IdCard &&
            (identical(other.type, type) ||
                const DeepCollectionEquality().equals(other.type, type)) &&
            (identical(other.id, id) ||
                const DeepCollectionEquality().equals(other.id, id)) &&
            (identical(other.idNumber, idNumber) ||
                const DeepCollectionEquality()
                    .equals(other.idNumber, idNumber)) &&
            (identical(other.phoneNumber, phoneNumber) ||
                const DeepCollectionEquality()
                    .equals(other.phoneNumber, phoneNumber)) &&
            (identical(other.firstNames, firstNames) ||
                const DeepCollectionEquality()
                    .equals(other.firstNames, firstNames)) &&
            (identical(other.surname, surname) ||
                const DeepCollectionEquality()
                    .equals(other.surname, surname)) &&
            (identical(other.gender, gender) ||
                const DeepCollectionEquality().equals(other.gender, gender)) &&
            (identical(other.birthDate, birthDate) ||
                const DeepCollectionEquality()
                    .equals(other.birthDate, birthDate)) &&
            (identical(other.issueDate, issueDate) ||
                const DeepCollectionEquality()
                    .equals(other.issueDate, issueDate)) &&
            (identical(other.smartIdNumber, smartIdNumber) ||
                const DeepCollectionEquality()
                    .equals(other.smartIdNumber, smartIdNumber)) &&
            (identical(other.nationality, nationality) ||
                const DeepCollectionEquality()
                    .equals(other.nationality, nationality)) &&
            (identical(other.countryOfBirth, countryOfBirth) ||
                const DeepCollectionEquality()
                    .equals(other.countryOfBirth, countryOfBirth)) &&
            (identical(other.citizenshipStatus, citizenshipStatus) ||
                const DeepCollectionEquality()
                    .equals(other.citizenshipStatus, citizenshipStatus)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(type) ^
      const DeepCollectionEquality().hash(id) ^
      const DeepCollectionEquality().hash(idNumber) ^
      const DeepCollectionEquality().hash(phoneNumber) ^
      const DeepCollectionEquality().hash(firstNames) ^
      const DeepCollectionEquality().hash(surname) ^
      const DeepCollectionEquality().hash(gender) ^
      const DeepCollectionEquality().hash(birthDate) ^
      const DeepCollectionEquality().hash(issueDate) ^
      const DeepCollectionEquality().hash(smartIdNumber) ^
      const DeepCollectionEquality().hash(nationality) ^
      const DeepCollectionEquality().hash(countryOfBirth) ^
      const DeepCollectionEquality().hash(citizenshipStatus);

  @override
  $IdCardCopyWith<IdCard> get copyWith =>
      _$IdCardCopyWithImpl<IdCard>(this, _$identity);

  @override
  @optionalTypeArgs
  Result when<Result extends Object>({
    @required
        Result idBook(String type, int id, String idNumber, String phoneNumber,
            String gender, DateTime birthDate, String citizenshipStatus),
    @required
        Result idCard(
            String type,
            int id,
            String idNumber,
            String phoneNumber,
            String firstNames,
            String surname,
            String gender,
            DateTime birthDate,
            DateTime issueDate,
            String smartIdNumber,
            String nationality,
            String countryOfBirth,
            String citizenshipStatus),
    @required
        Result driversLicense(
            String type,
            int id,
            String idNumber,
            String phoneNumber,
            String firstNames,
            String surname,
            String gender,
            DateTime birthDate,
            List<DateTime> issueDates,
            String licenseNumber,
            List<String> vehicleCodes,
            String prdpCode,
            String idCountryOfIssue,
            String licenseCountryOfIssue,
            List<String> vehicleRestrictions,
            String idNumberType,
            String driverRestrictions,
            DateTime prdpExpiry,
            String licenseIssueNumber,
            DateTime validFrom,
            DateTime validTo),
    @required
        Result passport(
            String type, int id, String idNumber, String phoneNumber),
  }) {
    assert(idBook != null);
    assert(idCard != null);
    assert(driversLicense != null);
    assert(passport != null);
    return idCard(
        type,
        id,
        idNumber,
        phoneNumber,
        firstNames,
        surname,
        gender,
        birthDate,
        issueDate,
        smartIdNumber,
        nationality,
        countryOfBirth,
        citizenshipStatus);
  }

  @override
  @optionalTypeArgs
  Result maybeWhen<Result extends Object>({
    Result idBook(String type, int id, String idNumber, String phoneNumber,
        String gender, DateTime birthDate, String citizenshipStatus),
    Result idCard(
        String type,
        int id,
        String idNumber,
        String phoneNumber,
        String firstNames,
        String surname,
        String gender,
        DateTime birthDate,
        DateTime issueDate,
        String smartIdNumber,
        String nationality,
        String countryOfBirth,
        String citizenshipStatus),
    Result driversLicense(
        String type,
        int id,
        String idNumber,
        String phoneNumber,
        String firstNames,
        String surname,
        String gender,
        DateTime birthDate,
        List<DateTime> issueDates,
        String licenseNumber,
        List<String> vehicleCodes,
        String prdpCode,
        String idCountryOfIssue,
        String licenseCountryOfIssue,
        List<String> vehicleRestrictions,
        String idNumberType,
        String driverRestrictions,
        DateTime prdpExpiry,
        String licenseIssueNumber,
        DateTime validFrom,
        DateTime validTo),
    Result passport(String type, int id, String idNumber, String phoneNumber),
    @required Result orElse(),
  }) {
    assert(orElse != null);
    if (idCard != null) {
      return idCard(
          type,
          id,
          idNumber,
          phoneNumber,
          firstNames,
          surname,
          gender,
          birthDate,
          issueDate,
          smartIdNumber,
          nationality,
          countryOfBirth,
          citizenshipStatus);
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
  const factory IdCard(
      {String type,
      @required int id,
      @required String idNumber,
      String phoneNumber,
      @required String firstNames,
      @required String surname,
      @required String gender,
      @required DateTime birthDate,
      @required DateTime issueDate,
      @required String smartIdNumber,
      @required String nationality,
      @required String countryOfBirth,
      @required String citizenshipStatus}) = _$IdCard;

  factory IdCard.fromJson(Map<String, dynamic> json) = _$IdCard.fromJson;

  @override
  String get type;
  @override
  int get id;
  @override
  String get idNumber;
  @override
  String get phoneNumber;
  String get firstNames;
  String get surname;
  String get gender;
  DateTime get birthDate;
  DateTime get issueDate;
  String get smartIdNumber;
  String get nationality;
  String get countryOfBirth;
  String get citizenshipStatus;
  @override
  $IdCardCopyWith<IdCard> get copyWith;
}

abstract class $DriversLicenseCopyWith<$Res>
    implements $IdDocumentCopyWith<$Res> {
  factory $DriversLicenseCopyWith(
          DriversLicense value, $Res Function(DriversLicense) then) =
      _$DriversLicenseCopyWithImpl<$Res>;
  @override
  $Res call(
      {String type,
      int id,
      String idNumber,
      String phoneNumber,
      String firstNames,
      String surname,
      String gender,
      DateTime birthDate,
      List<DateTime> issueDates,
      String licenseNumber,
      List<String> vehicleCodes,
      String prdpCode,
      String idCountryOfIssue,
      String licenseCountryOfIssue,
      List<String> vehicleRestrictions,
      String idNumberType,
      String driverRestrictions,
      DateTime prdpExpiry,
      String licenseIssueNumber,
      DateTime validFrom,
      DateTime validTo});
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
    Object type = freezed,
    Object id = freezed,
    Object idNumber = freezed,
    Object phoneNumber = freezed,
    Object firstNames = freezed,
    Object surname = freezed,
    Object gender = freezed,
    Object birthDate = freezed,
    Object issueDates = freezed,
    Object licenseNumber = freezed,
    Object vehicleCodes = freezed,
    Object prdpCode = freezed,
    Object idCountryOfIssue = freezed,
    Object licenseCountryOfIssue = freezed,
    Object vehicleRestrictions = freezed,
    Object idNumberType = freezed,
    Object driverRestrictions = freezed,
    Object prdpExpiry = freezed,
    Object licenseIssueNumber = freezed,
    Object validFrom = freezed,
    Object validTo = freezed,
  }) {
    return _then(DriversLicense(
      type: type == freezed ? _value.type : type as String,
      id: id == freezed ? _value.id : id as int,
      idNumber: idNumber == freezed ? _value.idNumber : idNumber as String,
      phoneNumber:
          phoneNumber == freezed ? _value.phoneNumber : phoneNumber as String,
      firstNames:
          firstNames == freezed ? _value.firstNames : firstNames as String,
      surname: surname == freezed ? _value.surname : surname as String,
      gender: gender == freezed ? _value.gender : gender as String,
      birthDate:
          birthDate == freezed ? _value.birthDate : birthDate as DateTime,
      issueDates: issueDates == freezed
          ? _value.issueDates
          : issueDates as List<DateTime>,
      licenseNumber: licenseNumber == freezed
          ? _value.licenseNumber
          : licenseNumber as String,
      vehicleCodes: vehicleCodes == freezed
          ? _value.vehicleCodes
          : vehicleCodes as List<String>,
      prdpCode: prdpCode == freezed ? _value.prdpCode : prdpCode as String,
      idCountryOfIssue: idCountryOfIssue == freezed
          ? _value.idCountryOfIssue
          : idCountryOfIssue as String,
      licenseCountryOfIssue: licenseCountryOfIssue == freezed
          ? _value.licenseCountryOfIssue
          : licenseCountryOfIssue as String,
      vehicleRestrictions: vehicleRestrictions == freezed
          ? _value.vehicleRestrictions
          : vehicleRestrictions as List<String>,
      idNumberType: idNumberType == freezed
          ? _value.idNumberType
          : idNumberType as String,
      driverRestrictions: driverRestrictions == freezed
          ? _value.driverRestrictions
          : driverRestrictions as String,
      prdpExpiry:
          prdpExpiry == freezed ? _value.prdpExpiry : prdpExpiry as DateTime,
      licenseIssueNumber: licenseIssueNumber == freezed
          ? _value.licenseIssueNumber
          : licenseIssueNumber as String,
      validFrom:
          validFrom == freezed ? _value.validFrom : validFrom as DateTime,
      validTo: validTo == freezed ? _value.validTo : validTo as DateTime,
    ));
  }
}

@JsonSerializable()
class _$DriversLicense with DiagnosticableTreeMixin implements DriversLicense {
  const _$DriversLicense(
      {this.type = 'driversLicense',
      @required this.id,
      @required this.idNumber,
      this.phoneNumber,
      @required this.firstNames,
      @required this.surname,
      @required this.gender,
      @required this.birthDate,
      @required this.issueDates,
      @required this.licenseNumber,
      @required this.vehicleCodes,
      this.prdpCode,
      @required this.idCountryOfIssue,
      @required this.licenseCountryOfIssue,
      @required this.vehicleRestrictions,
      @required this.idNumberType,
      @required this.driverRestrictions,
      this.prdpExpiry,
      @required this.licenseIssueNumber,
      @required this.validFrom,
      @required this.validTo})
      : assert(type != null),
        assert(id != null),
        assert(idNumber != null),
        assert(firstNames != null),
        assert(surname != null),
        assert(gender != null),
        assert(birthDate != null),
        assert(issueDates != null),
        assert(licenseNumber != null),
        assert(vehicleCodes != null),
        assert(idCountryOfIssue != null),
        assert(licenseCountryOfIssue != null),
        assert(vehicleRestrictions != null),
        assert(idNumberType != null),
        assert(driverRestrictions != null),
        assert(licenseIssueNumber != null),
        assert(validFrom != null),
        assert(validTo != null);

  factory _$DriversLicense.fromJson(Map<String, dynamic> json) =>
      _$_$DriversLicenseFromJson(json);

  @JsonKey(defaultValue: 'driversLicense')
  @override
  final String type;
  @override
  final int id;
  @override
  final String idNumber;
  @override
  final String phoneNumber;
  @override
  final String firstNames;
  @override
  final String surname;
  @override
  final String gender;
  @override
  final DateTime birthDate;
  @override
  final List<DateTime> issueDates;
  @override
  final String licenseNumber;
  @override
  final List<String> vehicleCodes;
  @override
  final String prdpCode;
  @override
  final String idCountryOfIssue;
  @override
  final String licenseCountryOfIssue;
  @override
  final List<String> vehicleRestrictions;
  @override
  final String idNumberType;
  @override
  final String driverRestrictions;
  @override
  final DateTime prdpExpiry;
  @override
  final String licenseIssueNumber;
  @override
  final DateTime validFrom;
  @override
  final DateTime validTo;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'IdDocument.driversLicense(type: $type, id: $id, idNumber: $idNumber, phoneNumber: $phoneNumber, firstNames: $firstNames, surname: $surname, gender: $gender, birthDate: $birthDate, issueDates: $issueDates, licenseNumber: $licenseNumber, vehicleCodes: $vehicleCodes, prdpCode: $prdpCode, idCountryOfIssue: $idCountryOfIssue, licenseCountryOfIssue: $licenseCountryOfIssue, vehicleRestrictions: $vehicleRestrictions, idNumberType: $idNumberType, driverRestrictions: $driverRestrictions, prdpExpiry: $prdpExpiry, licenseIssueNumber: $licenseIssueNumber, validFrom: $validFrom, validTo: $validTo)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'IdDocument.driversLicense'))
      ..add(DiagnosticsProperty('type', type))
      ..add(DiagnosticsProperty('id', id))
      ..add(DiagnosticsProperty('idNumber', idNumber))
      ..add(DiagnosticsProperty('phoneNumber', phoneNumber))
      ..add(DiagnosticsProperty('firstNames', firstNames))
      ..add(DiagnosticsProperty('surname', surname))
      ..add(DiagnosticsProperty('gender', gender))
      ..add(DiagnosticsProperty('birthDate', birthDate))
      ..add(DiagnosticsProperty('issueDates', issueDates))
      ..add(DiagnosticsProperty('licenseNumber', licenseNumber))
      ..add(DiagnosticsProperty('vehicleCodes', vehicleCodes))
      ..add(DiagnosticsProperty('prdpCode', prdpCode))
      ..add(DiagnosticsProperty('idCountryOfIssue', idCountryOfIssue))
      ..add(DiagnosticsProperty('licenseCountryOfIssue', licenseCountryOfIssue))
      ..add(DiagnosticsProperty('vehicleRestrictions', vehicleRestrictions))
      ..add(DiagnosticsProperty('idNumberType', idNumberType))
      ..add(DiagnosticsProperty('driverRestrictions', driverRestrictions))
      ..add(DiagnosticsProperty('prdpExpiry', prdpExpiry))
      ..add(DiagnosticsProperty('licenseIssueNumber', licenseIssueNumber))
      ..add(DiagnosticsProperty('validFrom', validFrom))
      ..add(DiagnosticsProperty('validTo', validTo));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is DriversLicense &&
            (identical(other.type, type) ||
                const DeepCollectionEquality().equals(other.type, type)) &&
            (identical(other.id, id) ||
                const DeepCollectionEquality().equals(other.id, id)) &&
            (identical(other.idNumber, idNumber) ||
                const DeepCollectionEquality()
                    .equals(other.idNumber, idNumber)) &&
            (identical(other.phoneNumber, phoneNumber) ||
                const DeepCollectionEquality()
                    .equals(other.phoneNumber, phoneNumber)) &&
            (identical(other.firstNames, firstNames) ||
                const DeepCollectionEquality()
                    .equals(other.firstNames, firstNames)) &&
            (identical(other.surname, surname) ||
                const DeepCollectionEquality()
                    .equals(other.surname, surname)) &&
            (identical(other.gender, gender) ||
                const DeepCollectionEquality().equals(other.gender, gender)) &&
            (identical(other.birthDate, birthDate) ||
                const DeepCollectionEquality()
                    .equals(other.birthDate, birthDate)) &&
            (identical(other.issueDates, issueDates) ||
                const DeepCollectionEquality()
                    .equals(other.issueDates, issueDates)) &&
            (identical(other.licenseNumber, licenseNumber) ||
                const DeepCollectionEquality()
                    .equals(other.licenseNumber, licenseNumber)) &&
            (identical(other.vehicleCodes, vehicleCodes) ||
                const DeepCollectionEquality()
                    .equals(other.vehicleCodes, vehicleCodes)) &&
            (identical(other.prdpCode, prdpCode) ||
                const DeepCollectionEquality()
                    .equals(other.prdpCode, prdpCode)) &&
            (identical(other.idCountryOfIssue, idCountryOfIssue) ||
                const DeepCollectionEquality()
                    .equals(other.idCountryOfIssue, idCountryOfIssue)) &&
            (identical(other.licenseCountryOfIssue, licenseCountryOfIssue) ||
                const DeepCollectionEquality().equals(
                    other.licenseCountryOfIssue, licenseCountryOfIssue)) &&
            (identical(other.vehicleRestrictions, vehicleRestrictions) ||
                const DeepCollectionEquality()
                    .equals(other.vehicleRestrictions, vehicleRestrictions)) &&
            (identical(other.idNumberType, idNumberType) ||
                const DeepCollectionEquality()
                    .equals(other.idNumberType, idNumberType)) &&
            (identical(other.driverRestrictions, driverRestrictions) ||
                const DeepCollectionEquality()
                    .equals(other.driverRestrictions, driverRestrictions)) &&
            (identical(other.prdpExpiry, prdpExpiry) ||
                const DeepCollectionEquality()
                    .equals(other.prdpExpiry, prdpExpiry)) &&
            (identical(other.licenseIssueNumber, licenseIssueNumber) ||
                const DeepCollectionEquality()
                    .equals(other.licenseIssueNumber, licenseIssueNumber)) &&
            (identical(other.validFrom, validFrom) ||
                const DeepCollectionEquality()
                    .equals(other.validFrom, validFrom)) &&
            (identical(other.validTo, validTo) ||
                const DeepCollectionEquality().equals(other.validTo, validTo)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(type) ^
      const DeepCollectionEquality().hash(id) ^
      const DeepCollectionEquality().hash(idNumber) ^
      const DeepCollectionEquality().hash(phoneNumber) ^
      const DeepCollectionEquality().hash(firstNames) ^
      const DeepCollectionEquality().hash(surname) ^
      const DeepCollectionEquality().hash(gender) ^
      const DeepCollectionEquality().hash(birthDate) ^
      const DeepCollectionEquality().hash(issueDates) ^
      const DeepCollectionEquality().hash(licenseNumber) ^
      const DeepCollectionEquality().hash(vehicleCodes) ^
      const DeepCollectionEquality().hash(prdpCode) ^
      const DeepCollectionEquality().hash(idCountryOfIssue) ^
      const DeepCollectionEquality().hash(licenseCountryOfIssue) ^
      const DeepCollectionEquality().hash(vehicleRestrictions) ^
      const DeepCollectionEquality().hash(idNumberType) ^
      const DeepCollectionEquality().hash(driverRestrictions) ^
      const DeepCollectionEquality().hash(prdpExpiry) ^
      const DeepCollectionEquality().hash(licenseIssueNumber) ^
      const DeepCollectionEquality().hash(validFrom) ^
      const DeepCollectionEquality().hash(validTo);

  @override
  $DriversLicenseCopyWith<DriversLicense> get copyWith =>
      _$DriversLicenseCopyWithImpl<DriversLicense>(this, _$identity);

  @override
  @optionalTypeArgs
  Result when<Result extends Object>({
    @required
        Result idBook(String type, int id, String idNumber, String phoneNumber,
            String gender, DateTime birthDate, String citizenshipStatus),
    @required
        Result idCard(
            String type,
            int id,
            String idNumber,
            String phoneNumber,
            String firstNames,
            String surname,
            String gender,
            DateTime birthDate,
            DateTime issueDate,
            String smartIdNumber,
            String nationality,
            String countryOfBirth,
            String citizenshipStatus),
    @required
        Result driversLicense(
            String type,
            int id,
            String idNumber,
            String phoneNumber,
            String firstNames,
            String surname,
            String gender,
            DateTime birthDate,
            List<DateTime> issueDates,
            String licenseNumber,
            List<String> vehicleCodes,
            String prdpCode,
            String idCountryOfIssue,
            String licenseCountryOfIssue,
            List<String> vehicleRestrictions,
            String idNumberType,
            String driverRestrictions,
            DateTime prdpExpiry,
            String licenseIssueNumber,
            DateTime validFrom,
            DateTime validTo),
    @required
        Result passport(
            String type, int id, String idNumber, String phoneNumber),
  }) {
    assert(idBook != null);
    assert(idCard != null);
    assert(driversLicense != null);
    assert(passport != null);
    return driversLicense(
        type,
        id,
        idNumber,
        phoneNumber,
        firstNames,
        surname,
        gender,
        birthDate,
        issueDates,
        licenseNumber,
        vehicleCodes,
        prdpCode,
        idCountryOfIssue,
        licenseCountryOfIssue,
        vehicleRestrictions,
        idNumberType,
        driverRestrictions,
        prdpExpiry,
        licenseIssueNumber,
        validFrom,
        validTo);
  }

  @override
  @optionalTypeArgs
  Result maybeWhen<Result extends Object>({
    Result idBook(String type, int id, String idNumber, String phoneNumber,
        String gender, DateTime birthDate, String citizenshipStatus),
    Result idCard(
        String type,
        int id,
        String idNumber,
        String phoneNumber,
        String firstNames,
        String surname,
        String gender,
        DateTime birthDate,
        DateTime issueDate,
        String smartIdNumber,
        String nationality,
        String countryOfBirth,
        String citizenshipStatus),
    Result driversLicense(
        String type,
        int id,
        String idNumber,
        String phoneNumber,
        String firstNames,
        String surname,
        String gender,
        DateTime birthDate,
        List<DateTime> issueDates,
        String licenseNumber,
        List<String> vehicleCodes,
        String prdpCode,
        String idCountryOfIssue,
        String licenseCountryOfIssue,
        List<String> vehicleRestrictions,
        String idNumberType,
        String driverRestrictions,
        DateTime prdpExpiry,
        String licenseIssueNumber,
        DateTime validFrom,
        DateTime validTo),
    Result passport(String type, int id, String idNumber, String phoneNumber),
    @required Result orElse(),
  }) {
    assert(orElse != null);
    if (driversLicense != null) {
      return driversLicense(
          type,
          id,
          idNumber,
          phoneNumber,
          firstNames,
          surname,
          gender,
          birthDate,
          issueDates,
          licenseNumber,
          vehicleCodes,
          prdpCode,
          idCountryOfIssue,
          licenseCountryOfIssue,
          vehicleRestrictions,
          idNumberType,
          driverRestrictions,
          prdpExpiry,
          licenseIssueNumber,
          validFrom,
          validTo);
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
  const factory DriversLicense(
      {String type,
      @required int id,
      @required String idNumber,
      String phoneNumber,
      @required String firstNames,
      @required String surname,
      @required String gender,
      @required DateTime birthDate,
      @required List<DateTime> issueDates,
      @required String licenseNumber,
      @required List<String> vehicleCodes,
      String prdpCode,
      @required String idCountryOfIssue,
      @required String licenseCountryOfIssue,
      @required List<String> vehicleRestrictions,
      @required String idNumberType,
      @required String driverRestrictions,
      DateTime prdpExpiry,
      @required String licenseIssueNumber,
      @required DateTime validFrom,
      @required DateTime validTo}) = _$DriversLicense;

  factory DriversLicense.fromJson(Map<String, dynamic> json) =
      _$DriversLicense.fromJson;

  @override
  String get type;
  @override
  int get id;
  @override
  String get idNumber;
  @override
  String get phoneNumber;
  String get firstNames;
  String get surname;
  String get gender;
  DateTime get birthDate;
  List<DateTime> get issueDates;
  String get licenseNumber;
  List<String> get vehicleCodes;
  String get prdpCode;
  String get idCountryOfIssue;
  String get licenseCountryOfIssue;
  List<String> get vehicleRestrictions;
  String get idNumberType;
  String get driverRestrictions;
  DateTime get prdpExpiry;
  String get licenseIssueNumber;
  DateTime get validFrom;
  DateTime get validTo;
  @override
  $DriversLicenseCopyWith<DriversLicense> get copyWith;
}

abstract class $PassportCopyWith<$Res> implements $IdDocumentCopyWith<$Res> {
  factory $PassportCopyWith(Passport value, $Res Function(Passport) then) =
      _$PassportCopyWithImpl<$Res>;
  @override
  $Res call({String type, int id, String idNumber, String phoneNumber});
}

class _$PassportCopyWithImpl<$Res> extends _$IdDocumentCopyWithImpl<$Res>
    implements $PassportCopyWith<$Res> {
  _$PassportCopyWithImpl(Passport _value, $Res Function(Passport) _then)
      : super(_value, (v) => _then(v as Passport));

  @override
  Passport get _value => super._value as Passport;

  @override
  $Res call({
    Object type = freezed,
    Object id = freezed,
    Object idNumber = freezed,
    Object phoneNumber = freezed,
  }) {
    return _then(Passport(
      type: type == freezed ? _value.type : type as String,
      id: id == freezed ? _value.id : id as int,
      idNumber: idNumber == freezed ? _value.idNumber : idNumber as String,
      phoneNumber:
          phoneNumber == freezed ? _value.phoneNumber : phoneNumber as String,
    ));
  }
}

@JsonSerializable()
class _$Passport with DiagnosticableTreeMixin implements Passport {
  const _$Passport(
      {this.type = 'passport',
      @required this.id,
      @required this.idNumber,
      this.phoneNumber})
      : assert(type != null),
        assert(id != null),
        assert(idNumber != null);

  factory _$Passport.fromJson(Map<String, dynamic> json) =>
      _$_$PassportFromJson(json);

  @JsonKey(defaultValue: 'passport')
  @override
  final String type;
  @override
  final int id;
  @override
  final String idNumber;
  @override
  final String phoneNumber;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'IdDocument.passport(type: $type, id: $id, idNumber: $idNumber, phoneNumber: $phoneNumber)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'IdDocument.passport'))
      ..add(DiagnosticsProperty('type', type))
      ..add(DiagnosticsProperty('id', id))
      ..add(DiagnosticsProperty('idNumber', idNumber))
      ..add(DiagnosticsProperty('phoneNumber', phoneNumber));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is Passport &&
            (identical(other.type, type) ||
                const DeepCollectionEquality().equals(other.type, type)) &&
            (identical(other.id, id) ||
                const DeepCollectionEquality().equals(other.id, id)) &&
            (identical(other.idNumber, idNumber) ||
                const DeepCollectionEquality()
                    .equals(other.idNumber, idNumber)) &&
            (identical(other.phoneNumber, phoneNumber) ||
                const DeepCollectionEquality()
                    .equals(other.phoneNumber, phoneNumber)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(type) ^
      const DeepCollectionEquality().hash(id) ^
      const DeepCollectionEquality().hash(idNumber) ^
      const DeepCollectionEquality().hash(phoneNumber);

  @override
  $PassportCopyWith<Passport> get copyWith =>
      _$PassportCopyWithImpl<Passport>(this, _$identity);

  @override
  @optionalTypeArgs
  Result when<Result extends Object>({
    @required
        Result idBook(String type, int id, String idNumber, String phoneNumber,
            String gender, DateTime birthDate, String citizenshipStatus),
    @required
        Result idCard(
            String type,
            int id,
            String idNumber,
            String phoneNumber,
            String firstNames,
            String surname,
            String gender,
            DateTime birthDate,
            DateTime issueDate,
            String smartIdNumber,
            String nationality,
            String countryOfBirth,
            String citizenshipStatus),
    @required
        Result driversLicense(
            String type,
            int id,
            String idNumber,
            String phoneNumber,
            String firstNames,
            String surname,
            String gender,
            DateTime birthDate,
            List<DateTime> issueDates,
            String licenseNumber,
            List<String> vehicleCodes,
            String prdpCode,
            String idCountryOfIssue,
            String licenseCountryOfIssue,
            List<String> vehicleRestrictions,
            String idNumberType,
            String driverRestrictions,
            DateTime prdpExpiry,
            String licenseIssueNumber,
            DateTime validFrom,
            DateTime validTo),
    @required
        Result passport(
            String type, int id, String idNumber, String phoneNumber),
  }) {
    assert(idBook != null);
    assert(idCard != null);
    assert(driversLicense != null);
    assert(passport != null);
    return passport(type, id, idNumber, phoneNumber);
  }

  @override
  @optionalTypeArgs
  Result maybeWhen<Result extends Object>({
    Result idBook(String type, int id, String idNumber, String phoneNumber,
        String gender, DateTime birthDate, String citizenshipStatus),
    Result idCard(
        String type,
        int id,
        String idNumber,
        String phoneNumber,
        String firstNames,
        String surname,
        String gender,
        DateTime birthDate,
        DateTime issueDate,
        String smartIdNumber,
        String nationality,
        String countryOfBirth,
        String citizenshipStatus),
    Result driversLicense(
        String type,
        int id,
        String idNumber,
        String phoneNumber,
        String firstNames,
        String surname,
        String gender,
        DateTime birthDate,
        List<DateTime> issueDates,
        String licenseNumber,
        List<String> vehicleCodes,
        String prdpCode,
        String idCountryOfIssue,
        String licenseCountryOfIssue,
        List<String> vehicleRestrictions,
        String idNumberType,
        String driverRestrictions,
        DateTime prdpExpiry,
        String licenseIssueNumber,
        DateTime validFrom,
        DateTime validTo),
    Result passport(String type, int id, String idNumber, String phoneNumber),
    @required Result orElse(),
  }) {
    assert(orElse != null);
    if (passport != null) {
      return passport(type, id, idNumber, phoneNumber);
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
  const factory Passport(
      {String type,
      @required int id,
      @required String idNumber,
      String phoneNumber}) = _$Passport;

  factory Passport.fromJson(Map<String, dynamic> json) = _$Passport.fromJson;

  @override
  String get type;
  @override
  int get id;
  @override
  String get idNumber;
  @override
  String get phoneNumber;
  @override
  $PassportCopyWith<Passport> get copyWith;
}
