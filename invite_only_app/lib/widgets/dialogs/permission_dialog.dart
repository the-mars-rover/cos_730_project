import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

Future<void> showPermissionDenied(
    BuildContext context, String permission) async {
  await showDialog(
    context: context,
    builder: (_) => PermissionDialog(permission),
  );
}

class PermissionDialog extends StatelessWidget {
  final String permission;

  const PermissionDialog(this.permission, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Permission Denied'),
      content: Text(
          'Access to $permission has been denied. You will need to grant the permission from the App\'s settings.'),
      actions: <Widget>[
        FlatButton(
          child: Text('Open Settings'),
          onPressed: () {
            Navigator.of(context).pop();
            openAppSettings();
          },
        ),
      ],
    );
  }
}
