import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
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
      cubit: AuthBloc.of(context),
      builder: (context, state) {
        if (state is UserAuthenticated) {
          final phone = state.phoneNumber;

          return Card(
            child: ListTile(
              leading: _buildAvatar(),
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

  Widget _buildAvatar() {
    if (space.imageUrl == null) {
      return CircleAvatar(
        backgroundImage: AssetImage('assets/place_placeholder.jpg'),
        backgroundColor: Colors.white,
      );
    }

    return CachedNetworkImage(
      imageUrl: space.imageUrl,
      fadeInDuration: Duration(seconds: 3),
      imageBuilder: (context, imageProvider) => CircleAvatar(
        backgroundImage: imageProvider,
        backgroundColor: Colors.white,
      ),
      progressIndicatorBuilder: (context, url, progress) => CircleAvatar(
        child: CircularProgressIndicator(),
        backgroundColor: Colors.white,
      ),
      errorWidget: (context, url, error) => CircleAvatar(
        child: CircularProgressIndicator(),
        backgroundColor: Colors.white,
      ),
    );
  }
}
