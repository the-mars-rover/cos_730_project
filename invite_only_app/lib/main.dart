import 'package:flutter/material.dart';

import 'authentication/authentication.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(InviteOnlyApp());
}

class InviteOnlyApp extends StatelessWidget {
  const InviteOnlyApp({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Invite Only',
      theme: ThemeData(primarySwatch: Colors.green),
      home: AuthenticatePage(),
    );
  }
}
