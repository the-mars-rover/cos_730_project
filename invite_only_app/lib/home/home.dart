import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:invite_only_app/home/user_home_page.dart';

Future<void> startAppOnHome() async {
  runApp(MaterialApp(
    title: "Invite Only",
    theme: ThemeData(primarySwatch: Colors.green),
    home: UserHomePage(),
  ));
}

Future<void> openHomePage(BuildContext context) async {
  await Navigator.of(context).pushAndRemoveUntil(
    MaterialPageRoute(builder: (context) => UserHomePage()),
    (route) => false,
  );
}
