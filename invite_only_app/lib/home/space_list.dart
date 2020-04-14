import 'package:flutter/material.dart';
import 'package:invite_only/home/home.dart';
import 'package:responsive_builder/responsive_builder.dart';

class SpaceList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout(
      watch: null,
      mobile: _mobile(context),
      tablet: _tablet(context),
      desktop: _desktop(context),
    );
  }

  Widget _mobile(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: EdgeInsets.all(8.0),
        children: <Widget>[
          SpaceCard(),
        ],
      ),
    );
  }

  Widget _tablet(BuildContext context) {
    return Scaffold(
      body: GridView.count(
        padding: EdgeInsets.all(8.0),
        crossAxisCount: 3,
        children: <Widget>[
          SpaceCard(),
        ],
      ),
    );
  }

  Widget _desktop(BuildContext context) {
    return null;
  }
}
