import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/material.dart';
import 'package:invite_only/app/error_dialog.dart';
import 'package:invite_only/authentication/authentication.dart';
import 'package:invite_only/home/home.dart';
import 'package:invite_only_repo/invite_only_repo.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:rsa_scan/rsa_scan.dart';

import 'contacts_search_delegate.dart';

Future<void> startApp() async {
  WidgetsFlutterBinding.ensureInitialized();

  await InviteOnlyRepo.initialize();
  final inviteOnlyRepo = InviteOnlyRepo.instance;

  if (inviteOnlyRepo.currentUser() == null) {
    authenticate();
  } else {
    startAppOnHome();
  }
}

Future<void> showErrorDialog(BuildContext context, String message) async {
  await showDialog(
    context: context,
    builder: (context) => ErrorDialog(message: message),
  );
}

Future<List<Contact>> selectContacts(BuildContext context,
    [List<Contact> selectedContacts]) async {
  // First ensure that contacts permission is granted
  var permissionStatus = await Permission.contacts.status;
  if (!permissionStatus.isGranted) {
    permissionStatus = await Permission.contacts.request();
    if (!permissionStatus.isGranted) {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Permission Denied'),
            content: Text(
                'Access to your contacts has been denied. You will need to grant the permission from the App\'s settings.'),
            actions: <Widget>[
              FlatButton(
                child: Text('Open Settings'),
                onPressed: () {
                  Navigator.of(context).pop();
                  openAppSettings();
                },
              ),
            ],
          );
        },
      );

      return null;
    }
  }

  // Select and return contacts through a search using ContactsSearchDelegate
  return await showSearch<List<Contact>>(
    context: context,
    delegate: ContactsSearchDelegate(selectedContacts: selectedContacts),
  );
}

Widget buildErrorDialog(String message) {
  return ErrorDialog(message: message);
}

/// The app works with packages which use different structures for the modelling
/// of identification documents.
///
/// This method provides utilities to easily convert between classes used by each package.
IdDocument rsaToDocs(RsaIdDocument document) {
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
