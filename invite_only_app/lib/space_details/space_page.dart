import 'package:flutter/material.dart';
import 'package:invite_only/app/app.dart';
import 'package:invite_only/space_details/space_details.dart';

class SpacePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            expandedHeight: 150.0,
            floating: true,
            pinned: true,
            snap: true,
            flexibleSpace: FlexibleSpaceBar(
              background: Image(
                image: NetworkImage(
                  'https://www.the-wilds.co.za/templates/glovent/images/logo.jpg',
                ),
                fit: BoxFit.cover,
                color: Colors.black54,
                colorBlendMode: BlendMode.darken,
              ),
              title: Text('The Wilds Estate'),
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate(<Widget>[
              AccessInfoCard(),
              Divider(),
              AccessInfoCard(),
              Divider(),
              AccessInfoCard(),
              Divider(),
              AccessInfoCard(),
              Divider(),
              AccessInfoCard(),
              Divider(),
              AccessInfoCard(),
              Divider(),
              AccessInfoCard(),
            ]),
          ),
        ],
      ),
      persistentFooterButtons: <Widget>[
        OutlineButton.icon(
          onPressed: () {},
          icon: Icon(Icons.settings),
          label: Text('Manage'),
        ),
        OutlineButton.icon(
          onPressed: () {},
          icon: Icon(Icons.security),
          label: Text('Guard'),
        ),
        OutlineButton.icon(
          onPressed: () async {
            String phoneNumber =
                await PhoneNumberSearchDelegate.selectPhoneNumber(context);

            if (phoneNumber != null) {
              showDialog(
                  context: context,
                  barrierDismissible: false,
                  builder: (context) {
                    return AlertDialog(
                      title: Icon(
                        Icons.mail,
                        color: Theme.of(context).primaryColor,
                        size: 64.0,
                      ),
                      content: Text(
                        'Are you sure you want to send an invite to $phoneNumber?',
                        textAlign: TextAlign.center,
                      ),
                      actions: <Widget>[
                        FlatButton.icon(
                          icon: Icon(Icons.cancel),
                          label: Text('Cancel'),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                        FlatButton.icon(
                          icon: Icon(Icons.send),
                          label: Text('Send'),
                          onPressed: () {},
                        ),
                      ],
                    );
                  });
            }
          },
          icon: Icon(Icons.mail),
          label: Text('Invite'),
        ),
      ],
    );
  }
}
