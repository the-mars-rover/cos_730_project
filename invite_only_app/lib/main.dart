import 'package:flutter/material.dart';
import 'package:invite_only/create_space/create_space.dart';

import 'authentication/authentication.dart';
import 'home/home.dart';
import 'profile/profile.dart';

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
      initialRoute: AuthenticatePage.ROUTE,
      routes: {
        AuthenticatePage.ROUTE: (context) => AuthenticatePage(),
        UserHomePage.ROUTE: (context) => UserHomePage(),
        UserProfilePage.ROUTE: (context) => UserProfilePage(),
        CreateSpacePage.ROUTE: (context) => CreateSpacePage(),
      },
    );
  }
}
