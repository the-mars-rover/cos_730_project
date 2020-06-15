import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:invite_only_app/blocs/docs/docs_bloc.dart';
import 'package:invite_only_app/blocs/entry/entry_bloc.dart';
import 'package:invite_only_app/blocs/entry/entry_event.dart';
import 'package:invite_only_app/blocs/entry/entry_state.dart';
import 'package:invite_only_app/widgets/dialogs/error_dialog.dart';
import 'package:invite_only_repo/invite_only_repo.dart';
import 'package:rsa_scan/rsa_scan.dart';

/// Returns true if entry was granted, false if not and null if cancelled.
Future<bool> grantEntry(
    BuildContext context, Space space, RsaIdDocument scannedIdDocument) async {
  return await showDialog(
    context: context,
    builder: (context) {
      return EntryDialog(space: space, scannedIdDocument: scannedIdDocument);
    },
  );
}

class EntryDialog extends StatelessWidget {
  final Space space;

  final RsaIdDocument scannedIdDocument;

  final TextEditingController _codeController = TextEditingController();

  EntryDialog({
    Key key,
    @required this.space,
    @required this.scannedIdDocument,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<EntryBloc>(
      create: (context) => EntryBloc()
        ..add(
          GrantResidentEntry(space, DocsBloc.rsaToDocs(scannedIdDocument)),
        ),
      child: BlocBuilder<EntryBloc, EntryState>(
        builder: (context, state) {
          if (state is GrantingEntry) {
            return Center(child: CircularProgressIndicator());
          }

          if (state is ResidentEntryDenied) {
            return _buildCodeDialog(context, state);
          }

          if (state is EntryGranted) {
            return _buildGrantedDialog(context, state);
          }

          if (state is EntryDenied) {
            return _buildDeniedDialog(context, state);
          }

          if (state is EntryError) {
            return ErrorDialog(message: state.error);
          }

          return null;
        },
      ),
    );
  }

  Widget _buildCodeDialog(BuildContext context, ResidentEntryDenied state) {
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
            EntryBloc.of(context).add(
              GrantVisitorEntry(space, DocsBloc.rsaToDocs(scannedIdDocument),
                  _codeController.text),
            );
          },
        ),
      ],
    );
  }

  Widget _buildGrantedDialog(BuildContext context, EntryGranted state) {
    return AlertDialog(
      title: Center(
        child: Icon(
          Icons.verified_user,
          color: Colors.green,
          size: 96.0,
        ),
      ),
      content: Text(
        'Access Granted',
        style: Theme.of(context)
            .primaryTextTheme
            .headline5
            .copyWith(color: Colors.black),
        textAlign: TextAlign.center,
      ),
      actions: <Widget>[
        OutlineButton(
          child: Text('Continue'),
          onPressed: () {
            Navigator.of(context).pop(true);
          },
        ),
      ],
    );
  }

  Widget _buildDeniedDialog(BuildContext context, EntryDenied state) {
    return AlertDialog(
      title: Center(
        child: Icon(
          Icons.block,
          color: Colors.red,
          size: 96.0,
        ),
      ),
      content: Text(
        'Access Denied',
        style: Theme.of(context)
            .primaryTextTheme
            .headline5
            .copyWith(color: Colors.black),
        textAlign: TextAlign.center,
      ),
      actions: <Widget>[
        OutlineButton(
          child: Text('Continue'),
          onPressed: () {
            Navigator.of(context).pop(false);
          },
        ),
      ],
    );
  }
}
