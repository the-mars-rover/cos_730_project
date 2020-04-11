import 'package:flutter/material.dart';
import 'package:invite_only/screens/screens.dart';
import 'package:responsive_builder/responsive_builder.dart';

class SpaceCard extends StatelessWidget {
  const SpaceCard({
    Key key,
  }) : super(key: key);

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
    return Card(
      child: ListTile(
        leading: CircleAvatar(
          backgroundImage: NetworkImage(
            "https://www.the-wilds.co.za/templates/glovent/images/logo.jpg",
          ),
        ),
        title: Text("The Wilds Estate"),
        subtitle: Text("You are an Inviter for this space"),
        trailing: Icon(Icons.navigate_next),
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => SpacePage(),
          ));
        },
      ),
    );
  }

  Widget _tablet(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Card(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Expanded(
              child: Image.network(
                "https://www.the-wilds.co.za/templates/glovent/images/logo.jpg",
                fit: BoxFit.fill,
              ),
            ),
            ListTile(
              title: Text("The Wilds Estate"),
              subtitle: Text("You are an Inviter for this space"),
            ),
          ],
        ),
      ),
    );
  }

  Widget _desktop(BuildContext context) {
    return null;
  }
}
