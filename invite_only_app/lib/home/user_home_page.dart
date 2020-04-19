import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:invite_only/app/loading_scaffold.dart';
import 'package:invite_only/create_space/create_space.dart';
import 'package:invite_only/home/home.dart';
import 'package:invite_only/home/home_bloc.dart';
import 'package:invite_only/home/home_event.dart';
import 'package:invite_only/home/home_state.dart';
import 'package:invite_only/profile/profile.dart';
import 'package:invite_only_spaces/invite_only_spaces.dart';

class UserHomePage extends StatelessWidget {
  static const ROUTE = '/';

  @override
  Widget build(BuildContext context) {
    return BlocProvider<HomeBloc>(
      create: (context) => HomeBloc()..add(InitializeHome()),
      child: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) {
          if (state is HomeLoading) {
            return LoadingScaffold();
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
    return Scaffold(
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
                    onTap: () {
                      Navigator.of(context).pushNamed(UserProfilePage.ROUTE);
                    },
                  ),
                  Divider(),
                  ListTile(
                    leading: Icon(Icons.add_location),
                    title: Text("Create Space"),
                    onTap: () {
                      Navigator.of(context).pushNamed(CreateSpacePage.ROUTE);
                    },
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
      appBar: AppBar(
        title: Text("Invite Only"),
      ),
      body: StreamBuilder(
        stream: state.managedSpacesStream,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }

          final managedSpaces = snapshot.data;
          return StreamBuilder(
            stream: state.guardingSpacesStream,
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return Center(child: CircularProgressIndicator());
              }

              final guardingSpaces = snapshot.data;
              return StreamBuilder(
                stream: state.invitingSpacesStream,
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return Center(child: CircularProgressIndicator());
                  }

                  final invitingSpaces = snapshot.data;
                  final allSpaces = List<ControlledSpace>()
                    ..addAll(managedSpaces)
                    ..addAll(guardingSpaces)
                    ..addAll(invitingSpaces)
                    ..sort((a, b) => a.title.compareTo(b.title));

                  return SpaceList(
                    currentUser: state.currentUser,
                    list: allSpaces,
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
