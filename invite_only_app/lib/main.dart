import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:invite_only/screens/screens.dart';

void main() {
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
      initialRoute: AuthenticatePage.ROUTE,
      routes: {
        AuthenticatePage.ROUTE: (context) => AuthenticatePage(),
        UserHomePage.ROUTE: (context) => UserHomePage(),
      },
    );
  }
}
