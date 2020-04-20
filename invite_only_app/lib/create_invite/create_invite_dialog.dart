import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:invite_only/app/app.dart';
import 'package:invite_only/create_invite/bloc.dart';
import 'package:invite_only_spaces/invite_only_spaces.dart';

class CreateInviteDialog extends StatelessWidget {
  final ControlledSpace space;

  const CreateInviteDialog({Key key, @required this.space}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CreateInviteBloc()..add(CreateInvite(space)),
      child: BlocBuilder(
        builder: (context, state) {
          if (state is CreatingInvite) {
            return Center(child: CircularProgressIndicator());
          }

          if (state is InviteCreated) {
            return _buildCreatedDialog(context, state);
          }

          if (state is InviteCreationError) {
            return ErrorDialog(message: state.errorMessage);
          }

          return null;
        },
      ),
    );
  }

  Widget _buildCreatedDialog(BuildContext context, InviteCreated state) {
    return AlertDialog(
      title: Text(
        state.invite.code,
        textAlign: TextAlign.center,
      ),
      content: Text(
        'Share this code with someone for them to be allowed entry',
        textAlign: TextAlign.center,
      ),
      actions: <Widget>[
        FlatButton(
          child: Text('Close'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        FlatButton.icon(
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
