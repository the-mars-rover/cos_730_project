import 'package:date_format/date_format.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:invite_only_app/widgets/cards/drivers_card.dart';
import 'package:invite_only_app/widgets/cards/id_book_card.dart';
import 'package:invite_only_app/widgets/cards/id_card_card.dart';
import 'package:invite_only_app/widgets/cards/passport_card.dart';
import 'package:invite_only_repo/invite_only_repo.dart';
import 'package:url_launcher/url_launcher.dart';

Future<void> showEntryDetails(BuildContext context, Entry entry) async {
  await Navigator.of(context).push(
    MaterialPageRoute(builder: (context) => EntryPage(entry: entry)),
  );
}

class EntryPage extends StatelessWidget {
  final Entry entry;

  const EntryPage({Key key, this.entry}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Entry Details')),
      body: ListView(
        padding: EdgeInsets.all(8.0),
        children: <Widget>[
          Row(
            children: <Widget>[
              _buildTimeCard(context),
              _buildGuardCard(context),
            ],
          ),
          entry.invite != null
              ? Row(
                  children: <Widget>[
                    _buildCodeCard(context),
                    _buildInviterCard(context),
                  ],
                )
              : Container(),
          _buildIdentityCard(context),
        ],
      ),
    );
  }

  Expanded _buildTimeCard(BuildContext context) {
    return Expanded(
      child: Card(
        child: ListTile(
          title: Column(
            children: <Widget>[
              Icon(
                Icons.access_time,
                size: 48.0,
                color: Theme.of(context).primaryColorLight,
              ),
              Container(height: 8.0),
              Text(
                formatDate(
                    entry.entryDate, [D, ' ', d, ' ', M, ' at ', HH, ':', nn]),
              ),
            ],
          ),
          subtitle: Text(
            'Time of entry',
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }

  Expanded _buildGuardCard(BuildContext context) {
    return Expanded(
      child: Card(
        child: ListTile(
          title: Column(
            children: <Widget>[
              Icon(
                Icons.security,
                size: 48.0,
                color: Theme.of(context).primaryColorLight,
              ),
              Container(height: 8.0),
              Text(
                entry.guardPhone,
                style: TextStyle(
                  color: Theme.of(context).accentColor,
                  decoration: TextDecoration.underline,
                ),
              ),
            ],
          ),
          subtitle: Text(
            'Guard Phone Number',
            textAlign: TextAlign.center,
          ),
          onTap: () => launch('tel://${entry.guardPhone}'),
        ),
      ),
    );
  }

  Expanded _buildCodeCard(BuildContext context) {
    return Expanded(
      child: Card(
        child: ListTile(
          title: Column(
            children: <Widget>[
              Icon(
                Icons.mail,
                size: 48.0,
                color: Theme.of(context).primaryColorLight,
              ),
              Container(height: 8.0),
              Text(entry.invite.code),
            ],
          ),
          subtitle: Text(
            'Invite code',
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }

  Expanded _buildInviterCard(BuildContext context) {
    return Expanded(
      child: Card(
        child: ListTile(
          title: Column(
            children: <Widget>[
              Icon(
                Icons.contact_mail,
                size: 48.0,
                color: Theme.of(context).primaryColorLight,
              ),
              Container(height: 8.0),
              Text(
                entry.invite.inviterPhone,
                style: TextStyle(
                  color: Theme.of(context).accentColor,
                  decoration: TextDecoration.underline,
                ),
              ),
            ],
          ),
          subtitle: Text(
            'Inviter Phone Number',
            textAlign: TextAlign.center,
          ),
          onTap: () => launch('tel://${entry.guardPhone}'),
        ),
      ),
    );
  }

  Widget _buildIdentityCard(BuildContext context) {
    final entryDoc = entry.idDocument;

    if (entryDoc is IdBook) {
      return IdBookCard(entryDoc);
    }

    if (entryDoc is IdCard) {
      return IdCardCard(entryDoc);
    }

    if (entryDoc is DriversLicense) {
      return DriversCard(entryDoc);
    }

    if (entryDoc is Passport) {
      return PassportCard(entryDoc);
    }

    return null;
  }
}
