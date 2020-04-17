import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

part 'id_document.freezed.dart';

part 'id_document.g.dart';

@freezed
abstract class IdDocument with _$IdDocument {
  const factory IdDocument.idBook({
    /// The ID Number of the person to whom this document belongs.
    @required String idNumber,

    /// The text representing gender of the person to whom this document belongs.
    ///
    /// 'M' and 'F' represent Male and Female.
    @required String gender,

    /// The birth date of the person to whom this document belongs.
    @required DateTime birthDate,

    /// The citizenship status of the owner of this document.
    ///
    /// Will be either 'SA Citizen' or 'Permanent Resident'.
    @required String citizenshipStatus,
  }) = IdBook;

  const factory IdDocument.idCard({
    /// The ID Number of the person to whom this document belongs.
    @required String idNumber,

    /// The first names of the person to whom this document belongs.
    ///
    /// May only contain initials if first names are not available.
    @required String firstNames,

    /// The last name of the person to whom this document belongs.
    @required String surname,

    /// The text representing gender of the person to whom this document belongs.
    ///
    /// 'M' and 'F' represent Male and Female.
    @required String gender,

    /// The birth date of the person to whom this document belongs.
    @required DateTime birthDate,

    /// The date on which this license was issued.
    @required DateTime issueDate,

    /// The number of this smart ID.
    @required String smartIdNumber,

    /// The country code representing the nationality of the person to whom this
    /// document belongs.
    @required String nationality,

    /// The country code representing the country of birth of the person to whom
    /// this document belongs.
    @required String countryOfBirth,

    /// The citizenship status of the person to whom this document belongs.
    @required String citizenshipStatus,
  }) = IdCard;

  const factory IdDocument.driversLicense({
    /// The ID Number of the person to whom this document belongs.
    @required String idNumber,

    /// The first names of the person to whom this document belongs.
    ///
    /// May only contain initials if first names are not available.
    @required String firstNames,

    /// The last name of the person to whom this document belongs.
    @required String surname,

    /// The text representing gender of the person to whom this document belongs.
    ///
    /// 'M' and 'F' represent Male and Female.
    @required String gender,

    /// The birth date of the person to whom this document belongs.
    @required DateTime birthDate,

    /// The issue date for each license code. Normally contains a date for each
    /// vehicleCode in [vehicleCodes].
    @required DateTime issueDates,

    /// The license number of this license.
    @required String licenseNumber,

    /// The list of vehicle codes appearing on the license.
    @required List<String> vehicleCodes,

    /// The PrDP Code appearing on the license.
    @required String prdpCode,

    /// The country code representing the country in which the ID was issued.
    @required String idCountryOfIssue,

    /// The country code representing the country in which this license was issued.
    @required String licenseCountryOfIssue,

    /// The vehicle restrictions placed on this license
    @required List<String> vehicleRestrictions,

    /// The type of the ID number. '02' represents a South African ID number.
    @required String idNumberType,

    /// A string representing driver restriction codes placed on this license.
    ///
    /// '00' = none
    /// '10' = glasses
    /// '20' = artificial limb
    /// '12' = glasses and artificial limb
    @required String driverRestrictions,

    /// The expiry date of the PrDP Permit.
    @required DateTime prdpExpiry,

    /// The issue number of this license.
    @required String licenseIssueNumber,

    /// The date from which this license is valid.
    @required DateTime validFrom,

    /// The date to which this license is valid.
    @required DateTime validTo,
  }) = DriversLicense;

  //TODO: Add properties for a passport
  const factory IdDocument.passport() = Passport;

  factory IdDocument.fromJson(Map<String, dynamic> json) =>
      _$IdDocumentFromJson(json);
}
