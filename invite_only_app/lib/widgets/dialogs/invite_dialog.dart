import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:invite_only_app/blocs/invite/invite_bloc.dart';
import 'package:invite_only_app/blocs/invite/invite_event.dart';
import 'package:invite_only_app/blocs/invite/invite_state.dart';
import 'package:invite_only_app/widgets/dialogs/error_dialog.dart';
import 'package:invite_only_repo/invite_only_repo.dart';
import 'package:share/share.dart';

/// Creates and displays an invite for the given space.
Future<void> createInvite(BuildContext context, Space space) async {
  await showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) => InviteDialog(space: space),
  );
}

class InviteDialog extends StatelessWidget {
  final Space space;

  const InviteDialog({Key key, @required this.space}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<InviteBloc>(
      create: (context) => InviteBloc()..add(CreateInvite(space)),
      child: BlocBuilder<InviteBloc, InviteState>(
        builder: (context, state) {
          if (state is CreatingInvite) {
            return Center(child: CircularProgressIndicator());
          }

          if (state is InviteCreated) {
            return _buildCreatedDialog(context, state);
          }

          if (state is InviteCreationError) {
            return ErrorDialog(message: state.error);
          }

          return null;
        },
      ),
    );
  }

  Widget _buildCreatedDialog(BuildContext context, InviteCreated state) {
    return AlertDialog(
      title: Text(state.invite.code, textAlign: TextAlign.center),
      content: Text(
        'Share this code with someone for them to be allowed entry. '
        'This code may only be used once and will expire on ${_formattedDate(state.invite.expiryDate)}.',
        textAlign: TextAlign.center,
      ),
      actions: <Widget>[
        OutlineButton(
          child: Text('Close'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        OutlineButton.icon(
          icon: Icon(Icons.share),
          label: Text('Share'),
          onPressed: () {
            try {
              Share.share(
                'Present code ${state.invite.code} to gain access to ${space.title}. '
                'This code may only be used once and will expire on ${_formattedDate(state.invite.expiryDate)}.'
                '\nShared with love by Invite Only.',
                subject: 'Entry Code for ${space.title}',
              );
            } catch (e) {
              Navigator.of(context).pop();
            }
          },
        ),
      ],
    );
  }

  String _formattedDate(DateTime dateTime) {
    return formatDate(dateTime, [d, ' ', MM, ' at ', HH, ':', nn]);
  }
}
