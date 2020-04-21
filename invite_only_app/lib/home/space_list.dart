import 'package:flutter/material.dart';
import 'package:invite_only_auth/invite_only_auth.dart';
import 'package:invite_only_spaces/invite_only_spaces.dart';

import 'space_card.dart';

class SpaceList extends StatelessWidget {
  final User currentUser;

  final List<ControlledSpace> list;

  const SpaceList({
    Key key,
    @required this.currentUser,
    @required this.list,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: EdgeInsets.all(8.0),
        children: list.map((space) {
          return SpaceCard(currentUser: currentUser, space: space);
        }).toList(),
      ),
    );
  }
}
