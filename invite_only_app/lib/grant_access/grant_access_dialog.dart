import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:invite_only/grant_access/grant_access_bloc.dart';
import 'package:invite_only/grant_access/grant_access_event.dart';
import 'package:invite_only_spaces/invite_only_spaces.dart';
import 'package:rsa_scan/rsa_scan.dart';

import 'grant_access_state.dart';

class GrantAccessDialog extends StatelessWidget {
  final ControlledSpace space;

  final RsaIdDocument scannedIdDocument;

  final TextEditingController _codeController = TextEditingController();

  GrantAccessDialog({
    Key key,
    @required this.space,
    @required this.scannedIdDocument,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<GrantAccessBloc>(
      create: (context) =>
          GrantAccessBloc()..add(GrantAccess(space, scannedIdDocument)),
      child: BlocBuilder<GrantAccessBloc, GrantAccessState>(
        builder: (context, state) {
          if (state is GrantingAccess) {
            return Center(child: CircularProgressIndicator());
          }

          if (state is RequireCode) {
            return _buildCodeDialog(context, state);
          }

          if (state is AccessGranted) {
            return _buildGrantedDialog(context, state);
          }

          if (state is AccessDenied) {
            return _buildDeniedDialog(context, state);
          }

          return null;
        },
      ),
    );
  }

  Widget _buildCodeDialog(BuildContext context, RequireCode state) {
    return AlertDialog(
      title: Text(
        "Enter Invite Code",
        textAlign: TextAlign.center,
      ),
      content: Padding(
        padding: EdgeInsets.only(top: 8.0, left: 16.0, right: 16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text(
              'Enter the code shared with the visitor',
              textAlign: TextAlign.center,
            ),
            TextFormField(
              controller: _codeController,
              autofocus: true,
              textAlign: TextAlign.center,
              keyboardType: TextInputType.number,
              style: TextStyle(letterSpacing: 24.0),
              decoration: InputDecoration(
                hintText: '000000',
                hintStyle: TextStyle(letterSpacing: 24.0),
              ),
              maxLength: 6,
            ),
          ],
        ),
      ),
      actions: <Widget>[
        FlatButton(
          child: Text('Cancel'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        FlatButton(
          child: Text('Submit'),
          onPressed: () {
            BlocProvider.of<GrantAccessBloc>(context).add(
              GrantVisitorAccess(
                space,
                scannedIdDocument,
                _codeController.text,
              ),
            );
          },
        ),
      ],
    );
  }

  Widget _buildGrantedDialog(BuildContext context, AccessGranted state) {
    return AlertDialog(
      title: Center(
        child: Icon(
          Icons.verified_user,
          color: Colors.green,
          size: 48.0,
        ),
      ),
      content: Text(
        'Access Granted',
        style: Theme.of(context).primaryTextTheme.caption,
        textAlign: TextAlign.center,
      ),
      actions: <Widget>[
        FlatButton(
          child: Text('Ok'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }

  Widget _buildDeniedDialog(BuildContext context, AccessDenied state) {
    return AlertDialog(
      title: Center(
        child: Icon(
          Icons.block,
          color: Colors.red,
          size: 48.0,
        ),
      ),
      content: Text(
        'Access Denied',
        style: Theme.of(context).primaryTextTheme.caption,
        textAlign: TextAlign.center,
      ),
      actions: <Widget>[
        FlatButton(
          child: Text('Ok'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}
