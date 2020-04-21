import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:invite_only/profile/profile_page.dart';

/// Show the user their profile details.
Future<void> showProfilePage(BuildContext context) async {
  await Navigator.of(context).push(
    MaterialPageRoute(builder: (context) => UserProfilePage()),
  );
}
