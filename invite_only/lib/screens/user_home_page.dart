import 'package:flutter/material.dart';
import 'package:invite_only/widgets/widgets.dart';
import 'package:responsive_builder/responsive_builder.dart';

class UserHomePage extends StatelessWidget {
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
      drawer: UserHomeDrawer(),
      appBar: AppBar(
        title: Text("Invite Only"),
      ),
      body: SpaceList(),
    );
  }

  Widget _tablet(BuildContext context) {
    return null;
  }

  Widget _desktop(BuildContext context) {
    return null;
  }
}
