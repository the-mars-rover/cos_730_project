import 'package:flutter/material.dart';
import 'package:invite_only/space_details/space_details.dart';
import 'package:invite_only_auth/invite_only_auth.dart';
import 'package:invite_only_spaces/invite_only_spaces.dart';

class SpaceCard extends StatelessWidget {
  final User currentUser;

  final ControlledSpace space;

  const SpaceCard({
    Key key,
    @required this.currentUser,
    @required this.space,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: CircleAvatar(backgroundImage: NetworkImage(space.imageUrl)),
        title: Text(space.title),
        subtitle: Text(_buildSubtitle()),
        trailing: Icon(Icons.navigate_next),
        onTap: () => showSpaceDetails(context, space),
      ),
    );
  }

  String _buildSubtitle() {
    if (space.managerPhones
        .where((p) => p == currentUser.phoneNumber)
        .isNotEmpty) {
      return 'You are a manager for this space.';
    }

    if (space.guardPhones
        .where((p) => p == currentUser.phoneNumber)
        .isNotEmpty) {
      return 'You are a guard for this space.';
    }

    if (space.inviterPhones
        .where((p) => p == currentUser.phoneNumber)
        .isNotEmpty) {
      return 'You are an inviter for this space.';
    }

    return '';
  }
}
