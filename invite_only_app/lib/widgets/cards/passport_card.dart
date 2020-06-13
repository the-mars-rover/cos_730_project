import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:invite_only_repo/invite_only_repo.dart';

class PassportCard extends StatelessWidget {
  final Passport passport;

  const PassportCard(this.passport, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.only(
          left: 16.0,
          top: 8.0,
          right: 16.0,
          bottom: 8.0,
        ),
        child: Column(
          children: <Widget>[
            ListTile(
              title: Column(
                children: <Widget>[
                  Icon(
                    Icons.person_pin,
                    size: 48.0,
                    color: Theme.of(context).primaryColorLight,
                  ),
                  Container(height: 8.0),
                  Text('Passport'),
                ],
              ),
              subtitle: Text(
                'Identification Information',
                textAlign: TextAlign.center,
              ),
            ),
            Divider(),
            Container(height: 16.0),
            Row(
              children: <Widget>[
                _buildDetail(
                  context,
                  passport.idNumber,
                  'ID Number',
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetail(BuildContext context, String content, String caption) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(content),
          Text(
            caption,
            style: Theme.of(context).textTheme.caption,
          ),
        ],
      ),
    );
  }
}
