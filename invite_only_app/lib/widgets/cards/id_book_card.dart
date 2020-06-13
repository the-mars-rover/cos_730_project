import 'package:date_format/date_format.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:invite_only_repo/invite_only_repo.dart';

class IdBookCard extends StatelessWidget {
  final IdBook idBook;

  const IdBookCard(this.idBook, {Key key}) : super(key: key);

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
                  Text('ID Book'),
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
                  idBook.idNumber,
                  'ID Number',
                ),
                _buildDetail(
                  context,
                  formatDate(idBook.birthDate, [d, ' ', MM, ' ', yyyy]),
                  'Birth Date',
                ),
              ],
            ),
            Container(height: 16.0),
            Row(
              children: <Widget>[
                _buildDetail(
                  context,
                  _gender,
                  'Gender',
                ),
                _buildDetail(
                  context,
                  idBook.citizenshipStatus,
                  'Citizenship Status',
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

  String get _gender {
    if (idBook.gender == 'M') return 'Male';
    if (idBook.gender == 'F') return 'Female';
    return 'Not specified';
  }
}
