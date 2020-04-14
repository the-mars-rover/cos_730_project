import 'package:flutter/material.dart';
import 'package:invite_only/authentication/authentication.dart';
import 'package:invite_only/create_space/create_space.dart';
import 'package:invite_only/home/home.dart';
import 'package:invite_only/profile/profile.dart';

class UserHomePage extends StatelessWidget {
  static const ROUTE = '/';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
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
                      Navigator.of(context).pushNamed(UserProfilePage.ROUTE);
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
      ),
      appBar: AppBar(
        title: Text("Invite Only"),
      ),
      body: SpaceList(),
    );
  }
}
