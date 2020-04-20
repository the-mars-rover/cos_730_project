import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:invite_only/app/app.dart';
import 'package:invite_only/create_invite/create_invite_dialog.dart';
import 'package:invite_only/space_details/space_details_bloc.dart';
import 'package:invite_only/space_details/space_details_event.dart';
import 'package:invite_only/space_details/space_details_state.dart';
import 'package:invite_only_spaces/invite_only_spaces.dart';

import 'access_info_card.dart';

class SpacePage extends StatelessWidget {
  final ControlledSpace space;

  const SpacePage({Key key, @required this.space}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<SpaceDetailsBloc>(
      create: (context) => SpaceDetailsBloc()..add(LoadSpaceDetails(space)),
      child: BlocBuilder<SpaceDetailsBloc, SpaceDetailsState>(
        builder: (context, state) {
          if (state is SpaceDetailsLoading) {
            return LoadingScaffold();
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
                if (!snapshot.hasData) return LinearProgressIndicator();

                List<Access> accesses = snapshot.data;
                if (accesses.isEmpty) {
                  return Center(child: Text('No Accesses'));
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
              }),
        ],
      ),
      persistentFooterButtons: <Widget>[
        Visibility(
          visible: space.managerPhones.contains(state.currentUser.phoneNumber),
          child: OutlineButton.icon(
            onPressed: () {},
            icon: Icon(Icons.settings),
            label: Text('Manage'),
          ),
        ),
        Visibility(
          visible:
              space.managerPhones.contains(state.currentUser.phoneNumber) ||
                  space.guardPhones.contains(state.currentUser.phoneNumber),
          child: OutlineButton.icon(
            onPressed: () {},
            icon: Icon(Icons.security),
            label: Text('Guard'),
          ),
        ),
        Visibility(
          visible:
              space.managerPhones.contains(state.currentUser.phoneNumber) ||
                  space.inviterPhones.contains(state.currentUser.phoneNumber),
          child: OutlineButton.icon(
            onPressed: () async {
              String phoneNumber =
                  await PhoneNumberSearchDelegate.selectPhoneNumber(context);
              if (phoneNumber == null) return;

              showDialog(
                context: context,
                barrierDismissible: false,
                builder: (context) => CreateInviteDialog(space: space),
              );
            },
            icon: Icon(Icons.mail),
            label: Text('Invite'),
          ),
        ),
      ],
    );
  }
}
