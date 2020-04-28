import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:invite_only_repo/invite_only_repo.dart';

import 'create_invite_bloc.dart';
import 'create_invite_event.dart';
import 'create_invite_state.dart';

class CreateInviteDialog extends StatelessWidget {
  final Space space;

  const CreateInviteDialog({Key key, @required this.space}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<CreateInviteBloc>(
      create: (context) => CreateInviteBloc()..add(CreateInvite(space)),
      child: BlocBuilder<CreateInviteBloc, CreateInviteState>(
        builder: (context, state) {
          if (state is CreatingInvite) {
            return Center(child: CircularProgressIndicator());
          }

          if (state is InviteCreated) {
            return _buildCreatedDialog(context, state);
          }

          return null;
        },
      ),
    );
  }

  Widget _buildCreatedDialog(BuildContext context, InviteCreated state) {
    return AlertDialog(
      title: Text(state.inviteCode, textAlign: TextAlign.center),
      content: Text(
        'Share this code with someone for them to be allowed entry',
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
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}
