import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

class PermissionMessage extends StatelessWidget {
  final String permission;
  final Function onRefresh;

  const PermissionMessage(this.permission, {Key key, @required this.onRefresh})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(64.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Icon(Icons.error_outline, color: Colors.amber, size: 64.0),
              Container(height: 24.0),
              Text(
                'Permission Denied',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.subtitle1,
              ),
              Container(height: 16.0),
              Text(
                'Access to $permission has been denied. You will need to grant the permission from the App\'s settings.',
                textAlign: TextAlign.center,
              ),
              FlatButton(
                child: Text(
                  'Open Settings',
                  style: TextStyle(color: Theme.of(context).primaryColor),
                ),
                onPressed: () => openAppSettings(),
              ),
              FlatButton(
                child: Text(
                  'Refresh',
                  style: TextStyle(color: Theme.of(context).primaryColor),
                ),
                onPressed: onRefresh,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
