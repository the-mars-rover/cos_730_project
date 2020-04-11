import 'package:flutter/material.dart';
import 'package:invite_only/screens/screens.dart';

class UserHomeDrawer extends StatelessWidget {
  const UserHomeDrawer({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SafeArea(
        child: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(left: 24.0, right: 24.0),
              child: Image.asset("assets/logo_v5.png"),
            ),
            Divider(),
            ListView(
              shrinkWrap: true,
              children: <Widget>[
                ListTile(
                  leading: Icon(Icons.person),
                  title: Text("My Profile"),
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => UserProfilePage(),
                      ),
                    );
                  },
                ),
                Divider(),
                ListTile(
                  leading: Icon(Icons.add_location),
                  title: Text("Create Space"),
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => CreateSpacePage(),
                    ));
                  },
                ),
                Divider(),
                ListTile(
                  leading: Icon(Icons.info),
                  title: Text("About Us"),
                ),
                Divider(),
                ListTile(
                  leading: Icon(Icons.exit_to_app),
                  title: Text("Sign Out"),
                  onTap: () {
                    Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(
                        builder: (context) => AuthenticatePage(),
                      ),
                      (route) => false,
                    );
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
