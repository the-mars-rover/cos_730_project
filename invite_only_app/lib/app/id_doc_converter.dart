import 'package:invite_only_repo/invite_only_repo.dart';
import 'package:rsa_scan/rsa_scan.dart';

/// The app works with packages which use different structures for the modelling
/// of identification documents.
///
/// This class provides utilities to easily convert between classes used by each package.
class IdDocConverter {
  static IdDocument rsaToDocs(RsaIdDocument document) {
    if (document is RsaIdBook) {
      return IdDocument.idBook(
          idNumber: document.idNumber,
          birthDate: document.birthDate,
          gender: document.gender,
          citizenshipStatus: document.citizenshipStatus);
    }

    if (document is RsaIdCard) {
      return IdDocument.idCard(
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
      return IdDocument.driversLicense(
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
}
