import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:invite_only_app/blocs/auth/auth_bloc.dart';
import 'package:invite_only_app/blocs/auth/auth_state.dart';
import 'package:invite_only_app/widgets/pages/entries_page.dart';
import 'package:invite_only_repo/invite_only_repo.dart';

class SpaceCard extends StatelessWidget {
  final Space space;

  const SpaceCard({Key key, @required this.space}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      bloc: AuthBloc.of(context),
      builder: (context, state) {
        if (state is UserAuthenticated) {
          final phone = state.phoneNumber;

          return Card(
            child: ListTile(
              leading: space.imageUrl == null
                  ? CircleAvatar(backgroundImage: AssetImage('assets/logo.png'))
                  : CircleAvatar(backgroundImage: NetworkImage(space.imageUrl)),
              title: Text(space.title),
              subtitle: Text('Tap to open'),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Icon(Icons.mode_edit,
                      color: space.canEdit(phone)
                          ? Theme.of(context).primaryColor
                          : Theme.of(context).disabledColor),
                  Container(width: 16),
                  Icon(Icons.security,
                      color: space.canGuard(phone)
                          ? Theme.of(context).primaryColor
                          : Theme.of(context).disabledColor),
                  Container(width: 16),
                  Icon(Icons.mail,
                      color: space.canInvite(phone)
                          ? Theme.of(context).primaryColor
                          : Theme.of(context).disabledColor),
                ],
              ),
              onTap: () => showEntries(context, space),
            ),
          );
        }

        return Container();
      },
    );
  }
}
