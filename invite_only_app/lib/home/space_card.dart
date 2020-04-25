import 'package:flutter/material.dart';
import 'package:invite_only/space_details/space_details.dart';
import 'package:invite_only_repo/invite_only_repo.dart';

class SpaceCard extends StatelessWidget {
  final Space space;
  final String subtitle;

  const SpaceCard({
    Key key,
    @required this.space,
    @required this.subtitle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: CircleAvatar(backgroundImage: NetworkImage(space.imageUrl)),
        title: Text(space.title),
        subtitle: Text(subtitle),
        trailing: Icon(Icons.navigate_next),
        onTap: () => showSpaceDetails(context, space),
      ),
    );
  }
}
