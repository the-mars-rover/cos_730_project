import 'package:flutter/material.dart';

import 'authenticate_page.dart';

/// Starts the app by first authenticating the user.
void authenticate() {
  runApp(MaterialApp(
    title: "Invite Only",
    theme: ThemeData(primarySwatch: Colors.green),
    home: AuthenticatePage(),
  ));
}

/// Removes all routes from the app and will reauthenticate the user.
Future<void> reauthenticate(BuildContext context) async {
  await Navigator.of(context).pushAndRemoveUntil(
    MaterialPageRoute(builder: (context) => AuthenticatePage()),
    (route) => false,
  );
}
