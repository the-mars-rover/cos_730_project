import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:invite_only/home/user_home_page.dart';

Future<void> openHomePage(BuildContext context) async {
  await Navigator.of(context).pushAndRemoveUntil(
    MaterialPageRoute(builder: (context) => UserHomePage()),
    (route) => false,
  );
}
