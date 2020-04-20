import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:invite_only_spaces/invite_only_spaces.dart';

class AccessInfoCard extends StatelessWidget {
  final Access access;

  const AccessInfoCard({Key key, @required this.access}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      isThreeLine: true,
      leading: Icon(Icons.arrow_forward, color: Colors.green),
      title: _buildTitle(),
      subtitle: Column(
        children: <Widget>[
          Text('Entry: ${_formattedEntryDate()}'),
          Text('Exit: ${_formattedExitDate()}'),
        ],
      ),
    );
  }

  Widget _buildTitle() {
    final document = access.idDocument;

    if (document is IdBook) {
      return Text(document.idNumber);
    }

    if (document is IdCard) {
      return Text('${document.firstNames} ${document.surname}');
    }

    if (document is DriversLicense) {
      return Text('${document.firstNames} ${document.surname}');
    }

    if (document is Passport) {
      //TODO: Replace this.
      return Text('Passport not yet supported');
    }

    return null;
  }

  String _formattedEntryDate() {
    return formatDate(access.entryDate, [D, mm, M, '@', HH, ':', nn]);
  }

  String _formattedExitDate() {
    return access.exitDate == null
        ? 'Person has not left'
        : formatDate(access.exitDate, [D, mm, M, '@', HH, ':', nn]);
  }
}
