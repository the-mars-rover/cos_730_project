// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'id_document.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$IdBook _$_$IdBookFromJson(Map<String, dynamic> json) {
  return _$IdBook(
    type: json['type'] as String ?? 'idBook',
    id: json['id'] as int,
    idNumber: json['idNumber'] as String,
    phoneNumber: json['phoneNumber'] as String,
    gender: json['gender'] as String,
    birthDate: json['birthDate'] == null
        ? null
        : DateTime.parse(json['birthDate'] as String),
    citizenshipStatus: json['citizenshipStatus'] as String,
  );
}

Map<String, dynamic> _$_$IdBookToJson(_$IdBook instance) => <String, dynamic>{
      'type': instance.type,
      'id': instance.id,
      'idNumber': instance.idNumber,
      'phoneNumber': instance.phoneNumber,
      'gender': instance.gender,
      'birthDate': instance.birthDate?.toIso8601String(),
      'citizenshipStatus': instance.citizenshipStatus,
    };

_$IdCard _$_$IdCardFromJson(Map<String, dynamic> json) {
  return _$IdCard(
    type: json['type'] as String ?? 'idCard',
    id: json['id'] as int,
    idNumber: json['idNumber'] as String,
    phoneNumber: json['phoneNumber'] as String,
    firstNames: json['firstNames'] as String,
    surname: json['surname'] as String,
    gender: json['gender'] as String,
    birthDate: json['birthDate'] == null
        ? null
        : DateTime.parse(json['birthDate'] as String),
    issueDate: json['issueDate'] == null
        ? null
        : DateTime.parse(json['issueDate'] as String),
    smartIdNumber: json['smartIdNumber'] as String,
    nationality: json['nationality'] as String,
    countryOfBirth: json['countryOfBirth'] as String,
    citizenshipStatus: json['citizenshipStatus'] as String,
  );
}

Map<String, dynamic> _$_$IdCardToJson(_$IdCard instance) => <String, dynamic>{
      'type': instance.type,
      'id': instance.id,
      'idNumber': instance.idNumber,
      'phoneNumber': instance.phoneNumber,
      'firstNames': instance.firstNames,
      'surname': instance.surname,
      'gender': instance.gender,
      'birthDate': instance.birthDate?.toIso8601String(),
      'issueDate': instance.issueDate?.toIso8601String(),
      'smartIdNumber': instance.smartIdNumber,
      'nationality': instance.nationality,
      'countryOfBirth': instance.countryOfBirth,
      'citizenshipStatus': instance.citizenshipStatus,
    };

_$DriversLicense _$_$DriversLicenseFromJson(Map<String, dynamic> json) {
  return _$DriversLicense(
    type: json['type'] as String ?? 'driversLicense',
    id: json['id'] as int,
    idNumber: json['idNumber'] as String,
    phoneNumber: json['phoneNumber'] as String,
    firstNames: json['firstNames'] as String,
    surname: json['surname'] as String,
    gender: json['gender'] as String,
    birthDate: json['birthDate'] == null
        ? null
        : DateTime.parse(json['birthDate'] as String),
    licenseNumber: json['licenseNumber'] as String,
    vehicleCodes:
        (json['vehicleCodes'] as List)?.map((e) => e as String)?.toList(),
    prdpCode: json['prdpCode'] as String,
    idCountryOfIssue: json['idCountryOfIssue'] as String,
    licenseCountryOfIssue: json['licenseCountryOfIssue'] as String,
    vehicleRestrictions: (json['vehicleRestrictions'] as List)
        ?.map((e) => e as String)
        ?.toList(),
    idNumberType: json['idNumberType'] as String,
    driverRestrictions: json['driverRestrictions'] as String,
    prdpExpiry: json['prdpExpiry'] == null
        ? null
        : DateTime.parse(json['prdpExpiry'] as String),
    licenseIssueNumber: json['licenseIssueNumber'] as String,
    validFrom: json['validFrom'] == null
        ? null
        : DateTime.parse(json['validFrom'] as String),
    validTo: json['validTo'] == null
        ? null
        : DateTime.parse(json['validTo'] as String),
  );
}

Map<String, dynamic> _$_$DriversLicenseToJson(_$DriversLicense instance) =>
    <String, dynamic>{
      'type': instance.type,
      'id': instance.id,
      'idNumber': instance.idNumber,
      'phoneNumber': instance.phoneNumber,
      'firstNames': instance.firstNames,
      'surname': instance.surname,
      'gender': instance.gender,
      'birthDate': instance.birthDate?.toIso8601String(),
      'licenseNumber': instance.licenseNumber,
      'vehicleCodes': instance.vehicleCodes,
      'prdpCode': instance.prdpCode,
      'idCountryOfIssue': instance.idCountryOfIssue,
      'licenseCountryOfIssue': instance.licenseCountryOfIssue,
      'vehicleRestrictions': instance.vehicleRestrictions,
      'idNumberType': instance.idNumberType,
      'driverRestrictions': instance.driverRestrictions,
      'prdpExpiry': instance.prdpExpiry?.toIso8601String(),
      'licenseIssueNumber': instance.licenseIssueNumber,
      'validFrom': instance.validFrom?.toIso8601String(),
      'validTo': instance.validTo?.toIso8601String(),
    };

_$Passport _$_$PassportFromJson(Map<String, dynamic> json) {
  return _$Passport(
    type: json['type'] as String ?? 'passport',
    id: json['id'] as int,
    idNumber: json['idNumber'] as String,
    phoneNumber: json['phoneNumber'] as String,
  );
}

Map<String, dynamic> _$_$PassportToJson(_$Passport instance) =>
    <String, dynamic>{
      'type': instance.type,
      'id': instance.id,
      'idNumber': instance.idNumber,
      'phoneNumber': instance.phoneNumber,
    };
