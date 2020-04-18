import 'package:flutter/material.dart';
import 'package:invite_only/home/home.dart';

class SpaceList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: EdgeInsets.all(8.0),
        children: <Widget>[
          SpaceCard(),
        ],
      ),
    );
  }
}
