import 'package:flutter/material.dart';

class UserProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("My Profile")),
      body: ListView(
        children: <Widget>[
          ListTile(
            title: Text("0815029249"),
            subtitle: Text("Phone Number"),
          ),
          Divider(),
          ListTile(
            title: Text("South African ID Book"),
            subtitle: Text("Uploaded"),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Icon(
                  Icons.check_circle,
                  color: Colors.green,
                ),
                IconButton(
                  icon: Icon(Icons.file_upload),
                  onPressed: () {},
                ),
              ],
            ),
          ),
          Divider(),
          ListTile(
            title: Text("South African Driver's License"),
            subtitle: Text("Expired"),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Icon(
                  Icons.warning,
                  color: Colors.orange,
                ),
                IconButton(
                  icon: Icon(Icons.file_upload),
                  onPressed: () {},
                ),
              ],
            ),
          ),
          Divider(),
          ListTile(
            title: Text("Passport"),
            subtitle: Text("Not Uploaded"),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                IconButton(
                  icon: Icon(Icons.file_upload),
                  onPressed: () {},
                ),
              ],
            ),
          ),
          Divider(),
          ListTile(
            title: OutlineButton.icon(
              icon: Icon(
                Icons.delete,
                color: Colors.red,
              ),
              label: Text(
                "DELETE MY PROFILE",
                style: TextStyle(color: Colors.red),
              ),
              borderSide: BorderSide(color: Colors.red),
              highlightedBorderColor: Colors.red,
              onPressed: () {},
            ),
          ),
        ],
      ),
    );
  }
}
