import 'package:flutter/material.dart';
import 'package:invite_only/widgets/widgets.dart';

class UserHomePage extends StatelessWidget {
  static const ROUTE = '/';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: UserHomeDrawer(),
      appBar: AppBar(
        title: Text("Invite Only"),
      ),
      body: SpaceList(),
    );
  }
}
