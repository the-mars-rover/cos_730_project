import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:invite_only/create_invite/create_invite.dart';
import 'package:invite_only/grant_access/grant_access.dart';
import 'package:invite_only/space_details/space_details_bloc.dart';
import 'package:invite_only/space_details/space_details_event.dart';
import 'package:invite_only/space_details/space_details_state.dart';
import 'package:invite_only_repo/invite_only_repo.dart';
import 'package:rsa_scan/rsa_scan.dart';

import 'access_info_card.dart';

class SpacePage extends StatelessWidget {
  final Space space;

  const SpacePage({Key key, @required this.space}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<SpaceDetailsBloc>(
      create: (context) => SpaceDetailsBloc()..add(LoadSpaceDetails(space)),
      child: BlocBuilder<SpaceDetailsBloc, SpaceDetailsState>(
        builder: (context, state) {
          if (state is SpaceDetailsLoading) {
            return Scaffold(body: Center(child: CircularProgressIndicator()));
          }

          if (state is SpaceDetailsLoaded) {
            return _buildDetailsScaffold(context, state);
          }

          return null;
        },
      ),
    );
  }

  Widget _buildDetailsScaffold(BuildContext context, SpaceDetailsLoaded state) {
    return StreamBuilder<User>(
      stream: state.userStream,
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Scaffold(
            body: Center(
              child: Column(
                children: <Widget>[
                  Text('User signer out.'),
                  Container(height: 16.0),
                  RaisedButton(
                    child: Text('Sign In'),
                    onPressed: () {},
                  )
                ],
              ),
            ),
          );
        }

        final user = snapshot.data;
        return Scaffold(
          body: CustomScrollView(
            slivers: <Widget>[
              SliverAppBar(
                expandedHeight: 150.0,
                floating: true,
                pinned: true,
                snap: true,
                flexibleSpace: FlexibleSpaceBar(
                  background: Image(
                    image: NetworkImage(space.imageUrl),
                    fit: BoxFit.cover,
                    color: Colors.black54,
                    colorBlendMode: BlendMode.darken,
                  ),
                  title: Text('The Wilds Estate'),
                ),
              ),
              StreamBuilder<List<Access>>(
                stream: state.accessesStream,
                builder: (context, snapshot) {
                  if (!snapshot.hasData)
                    return SliverFillRemaining(
                        child: LinearProgressIndicator());

                  List<Access> accesses = snapshot.data;
                  if (accesses.isEmpty) {
                    return SliverFillRemaining(
                      child: Center(child: Text('No Accesses')),
                    );
                  }

                  return SliverList(
                    delegate: SliverChildListDelegate(
                      accesses.map((access) {
                        return Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            AccessInfoCard(access: access),
                            Divider(),
                          ],
                        );
                      }).toList(),
                    ),
                  );
                },
              ),
            ],
          ),
          persistentFooterButtons: <Widget>[
            Visibility(
              visible: space.canEdit(user.phoneNumber),
              child: OutlineButton.icon(
                onPressed: () {},
                icon: Icon(Icons.settings),
                label: Text('Manage'),
              ),
            ),
            Visibility(
              visible: space.canGuard(user.phoneNumber),
              child: OutlineButton.icon(
                onPressed: () async {
                  final scannedIdDocument = await scanId(context);
                  if (scannedIdDocument == null) return;

                  grantAccess(context, space, scannedIdDocument);
                },
                icon: Icon(Icons.security),
                label: Text('Guard'),
              ),
            ),
            Visibility(
              visible: space.canInvite(user.phoneNumber),
              child: OutlineButton.icon(
                onPressed: () => createInvite(context, space),
                icon: Icon(Icons.mail),
                label: Text('Invite'),
              ),
            ),
          ],
        );
      },
    );
  }
}
