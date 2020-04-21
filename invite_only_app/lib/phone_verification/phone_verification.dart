import 'package:flutter/material.dart';

import 'phone_verification_dialog.dart';

/// Verifies the given phone number before returning the authentication credential
/// received after verification.
///
/// If verification was cancelled or failed, the function will return null.
Future<dynamic> verifyPhoneNumber(
    BuildContext context, String phoneNumber) async {
  var authCredential = await showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) => PhoneVerificationDialog(
      phoneNumber: phoneNumber,
    ),
  );

  return authCredential;
}
