import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:invite_only/authentication/authentication.dart';
import 'package:invite_only/create_space/create_space.dart';
import 'package:invite_only/home/home_bloc.dart';
import 'package:invite_only/home/home_event.dart';
import 'package:invite_only/home/home_state.dart';
import 'package:invite_only/profile/profile.dart';
import 'package:invite_only_repo/invite_only_repo.dart';

import 'space_card.dart';

class UserHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<HomeBloc>(
      create: (context) => HomeBloc()..add(InitializeHome()),
      child: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) {
          if (state is HomeLoading) {
            return Scaffold(body: Center(child: CircularProgressIndicator()));
          }

          if (state is HomeReady) {
            return _buildHomeScaffold(context, state);
          }

          return null;
        },
      ),
    );
  }

  Widget _buildHomeScaffold(BuildContext context, HomeReady state) {
    return StreamBuilder<User>(
        stream: state.userStream,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Scaffold(
              body: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text('User signer out.'),
                    Container(height: 16.0),
                    RaisedButton(
                      child: Text('Sign In'),
                      onPressed: () => reauthenticate(context),
                    )
                  ],
                ),
              ),
            );
          }

          final user = snapshot.data;
          return Scaffold(
            appBar: AppBar(title: Text("Invite Only")),
            drawer: Drawer(
              child: SafeArea(
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(left: 24.0, right: 24.0),
                      child: Image.asset("assets/logo_v5.png"),
                    ),
                    Divider(),
                    ListView(
                      shrinkWrap: true,
                      children: <Widget>[
                        ListTile(
                          leading: Icon(Icons.person),
                          title: Text("My Profile"),
                          onTap: () => showProfilePage(context),
                        ),
                        Divider(),
                        ListTile(
                          leading: Icon(Icons.add_location),
                          title: Text("Create Space"),
                          onTap: () => createSpace(context),
                        ),
                        Divider(),
                        ListTile(
                          leading: Icon(Icons.info),
                          title: Text("About Us"),
                        ),
                        Divider(),
                        ListTile(
                          leading: Icon(Icons.exit_to_app),
                          title: Text("Sign Out"),
                          onTap: () {},
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            body: StreamBuilder<List<Space>>(
              stream: state.spacesStream,
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Center(child: CircularProgressIndicator());
                }

                final spaces = snapshot.data;
                return ListView(
                  padding: EdgeInsets.all(8.0),
                  children: spaces.map((space) {
                    if (space.managerPhones.contains(user.phoneNumber)) {
                      return SpaceCard(
                        space: space,
                        subtitle: 'You are a manager for this space.',
                      );
                    }

                    if (space.guardPhones.contains(user.phoneNumber)) {
                      return SpaceCard(
                        space: space,
                        subtitle: 'You are a guard for this space.',
                      );
                    }

                    if (space.inviterPhones.contains(user.phoneNumber)) {
                      return SpaceCard(
                        space: space,
                        subtitle: 'You are an inviter for this space.',
                      );
                    }

                    return null;
                  }).toList(),
                );
              },
            ),
          );
        });
  }
}
