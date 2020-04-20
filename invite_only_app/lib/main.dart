import 'package:flutter/material.dart';
import 'package:invite_only/create_space/create_space.dart';
import 'package:invite_only/space_details/space_details.dart';

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
      onGenerateRoute: (settings) {
        String route = settings.name;
        Map<String, dynamic> arguments = settings.arguments;

        if (route == AuthenticatePage.ROUTE) {
          return MaterialPageRoute(builder: (_) => AuthenticatePage());
        }

        if (route == UserHomePage.ROUTE) {
          return MaterialPageRoute(builder: (_) => UserHomePage());
        }

        if (route == UserProfilePage.ROUTE) {
          return MaterialPageRoute(builder: (_) => UserProfilePage());
        }

        if (route == CreateSpacePage.ROUTE) {
          return MaterialPageRoute(builder: (_) => CreateSpacePage());
        }

        if (route == SpacePage.ROUTE) {
          return MaterialPageRoute(
            builder: (_) => SpacePage(space: arguments['space']),
          );
        }

        return null;
      },
    );
  }
}
