import 'package:invite_only_docs/invite_only_docs.dart' as docs;
import 'package:invite_only_spaces/invite_only_spaces.dart' as spaces;
import 'package:rsa_scan/rsa_scan.dart';

/// The app works with packages which use different structures for the modelling
/// of identification documents.
///
/// This class provides utilities to easily convert between classes used by each package.
class IdDocConverter {
  static docs.IdDocument rsaToDocs(RsaIdDocument document) {
    if (document is RsaIdBook) {
      return docs.IdDocument.idBook(
          idNumber: document.idNumber,
          birthDate: document.birthDate,
          gender: document.gender,
          citizenshipStatus: document.citizenshipStatus);
    }

    if (document is RsaIdCard) {
      return docs.IdDocument.idCard(
        idNumber: document.idNumber,
        firstNames: document.firstNames,
        surname: document.surname,
        gender: document.gender,
        birthDate: document.birthDate,
        issueDate: document.issueDate,
        smartIdNumber: document.smartIdNumber,
        nationality: document.nationality,
        countryOfBirth: document.countryOfBirth,
        citizenshipStatus: document.citizenshipStatus,
      );
    }

    if (document is RsaDriversLicense) {
      return docs.IdDocument.driversLicense(
        idNumber: document.idNumber,
        firstNames: document.firstNames,
        surname: document.surname,
        gender: document.gender,
        birthDate: document.birthDate,
        issueDates: document.issueDates,
        licenseNumber: document.licenseNumber,
        vehicleCodes: document.vehicleCodes,
        prdpCode: document.prdpCode,
        idCountryOfIssue: document.idCountryOfIssue,
        licenseCountryOfIssue: document.licenseCountryOfIssue,
        vehicleRestrictions: document.vehicleRestrictions,
        idNumberType: document.idNumberType,
        driverRestrictions: document.driverRestrictions,
        prdpExpiry: document.prdpExpiry,
        licenseIssueNumber: document.licenseIssueNumber,
        validFrom: document.validFrom,
        validTo: document.validTo,
      );
    }

    throw Exception('Unsupported type: ${document.runtimeType}');
  }

  static spaces.IdDocument rsaToSpaces(RsaIdDocument document) {
    if (document is RsaIdBook) {
      return spaces.IdDocument.idBook(
          idNumber: document.idNumber,
          birthDate: document.birthDate,
          gender: document.gender,
          citizenshipStatus: document.citizenshipStatus);
    }

    if (document is RsaIdCard) {
      return spaces.IdDocument.idCard(
        idNumber: document.idNumber,
        firstNames: document.firstNames,
        surname: document.surname,
        gender: document.gender,
        birthDate: document.birthDate,
        issueDate: document.issueDate,
        smartIdNumber: document.smartIdNumber,
        nationality: document.nationality,
        countryOfBirth: document.countryOfBirth,
        citizenshipStatus: document.citizenshipStatus,
      );
    }

    if (document is RsaDriversLicense) {
      return spaces.IdDocument.driversLicense(
        idNumber: document.idNumber,
        firstNames: document.firstNames,
        surname: document.surname,
        gender: document.gender,
        birthDate: document.birthDate,
        issueDates: document.issueDates,
        licenseNumber: document.licenseNumber,
        vehicleCodes: document.vehicleCodes,
        prdpCode: document.prdpCode,
        idCountryOfIssue: document.idCountryOfIssue,
        licenseCountryOfIssue: document.licenseCountryOfIssue,
        vehicleRestrictions: document.vehicleRestrictions,
        idNumberType: document.idNumberType,
        driverRestrictions: document.driverRestrictions,
        prdpExpiry: document.prdpExpiry,
        licenseIssueNumber: document.licenseIssueNumber,
        validFrom: document.validFrom,
        validTo: document.validTo,
      );
    }

    throw Exception('Unsupported type: ${document.runtimeType}');
  }

  static spaces.IdDocument docsToSpaces(docs.IdDocument document) {
    if (document is docs.IdBook) {
      return spaces.IdDocument.idBook(
          idNumber: document.idNumber,
          birthDate: document.birthDate,
          gender: document.gender,
          citizenshipStatus: document.citizenshipStatus);
    }

    if (document is docs.IdCard) {
      return spaces.IdDocument.idCard(
        idNumber: document.idNumber,
        firstNames: document.firstNames,
        surname: document.surname,
        gender: document.gender,
        birthDate: document.birthDate,
        issueDate: document.issueDate,
        smartIdNumber: document.smartIdNumber,
        nationality: document.nationality,
        countryOfBirth: document.countryOfBirth,
        citizenshipStatus: document.citizenshipStatus,
      );
    }

    if (document is docs.DriversLicense) {
      return spaces.IdDocument.driversLicense(
        idNumber: document.idNumber,
        firstNames: document.firstNames,
        surname: document.surname,
        gender: document.gender,
        birthDate: document.birthDate,
        issueDates: document.issueDates,
        licenseNumber: document.licenseNumber,
        vehicleCodes: document.vehicleCodes,
        prdpCode: document.prdpCode,
        idCountryOfIssue: document.idCountryOfIssue,
        licenseCountryOfIssue: document.licenseCountryOfIssue,
        vehicleRestrictions: document.vehicleRestrictions,
        idNumberType: document.idNumberType,
        driverRestrictions: document.driverRestrictions,
        prdpExpiry: document.prdpExpiry,
        licenseIssueNumber: document.licenseIssueNumber,
        validFrom: document.validFrom,
        validTo: document.validTo,
      );
    }

    if (document is docs.Passport) {
      return spaces.IdDocument.passport();
    }

    throw Exception('Unsupported type: ${document.runtimeType}');
  }
}
