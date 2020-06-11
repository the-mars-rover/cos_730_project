import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:invite_only_app/blocs/auth/auth_bloc.dart';
import 'package:invite_only_app/blocs/auth/auth_event.dart';
import 'package:invite_only_app/blocs/spaces/spaces_bloc.dart';
import 'package:invite_only_app/blocs/spaces/spaces_event.dart';
import 'package:invite_only_app/blocs/spaces/spaces_state.dart';
import 'package:invite_only_app/widgets/cards/space_card.dart';
import 'package:invite_only_app/widgets/other/error_message.dart';
import 'package:invite_only_app/widgets/pages/docs_page.dart';
import 'package:invite_only_app/widgets/pages/space_page.dart';
import 'package:invite_only_repo/invite_only_repo.dart';

class SpacesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
                    onTap: () => showDocsPage(context),
                  ),
                  Divider(),
                  Builder(builder: (context) {
                    return ListTile(
                      leading: Icon(Icons.add_location),
                      title: Text("Create Space"),
                      onTap: () async {
                        final newSpace = await createSpace(context);
                        if (newSpace == null) return;
                        Navigator.of(context).pop();
                        SpacesBloc.of(context).add(SaveSpace(newSpace));
                      },
                    );
                  }),
                  Divider(),
                  ListTile(
                    leading: Icon(Icons.info),
                    title: Text("About Us"),
                  ),
                  Divider(),
                  ListTile(
                    leading: Icon(Icons.exit_to_app),
                    title: Text("Sign Out"),
                    onTap: () => AuthBloc.of(context).add(SignOut()),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      body: _buildBody(context),
    );
  }

  Widget _buildBody(BuildContext context) {
    return BlocConsumer<SpacesBloc, SpacesState>(
      listener: (context, state) {
        if (state is SpaceSaved) {
          Fluttertoast.showToast(msg: '${state.space.title} Saved');
        }

        if (state is SpaceDeleted) {
          Fluttertoast.showToast(msg: '${state.space.title} Deleted');
        }
      },
      builder: (context, state) {
        if (state is SpacesLoading) {
          return Center(child: CircularProgressIndicator());
        }

        if (state is SpacesLoaded) {
          final spaces = state.spaces;
          return _buildSpacesList(context, spaces);
        }

        if (state is SpacesError) {
          return ErrorMessage(state.error,
              onRefresh: () => SpacesBloc.of(context).add(LoadSpaces()));
        }

        if (state is SavingSpace) {
          return Center(child: CircularProgressIndicator());
        }

        if (state is SpaceSaved) {
          return Center(child: CircularProgressIndicator());
        }

        if (state is SpaceDeleted) {
          return Center(child: CircularProgressIndicator());
        }

        return null;
      },
    );
  }

  Widget _buildSpacesList(BuildContext context, List<Space> spaces) {
    if (spaces.isEmpty) {
      return Center(
        child: Padding(
          padding: EdgeInsets.all(64.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Icon(Icons.error_outline, color: Colors.amber, size: 64.0),
              Container(height: 24.0),
              Text(
                'No available spaces',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.subtitle1,
              ),
              Container(height: 16.0),
              Text(
                'You don\'t have any available spaces. Add a space yourself or ask a manager of another space to add you.',
                textAlign: TextAlign.center,
              ),
              FlatButton(
                child: Text(
                  'Refresh',
                  style: TextStyle(color: Theme.of(context).primaryColor),
                ),
                onPressed: () => SpacesBloc.of(context).add(LoadSpaces()),
              ),
            ],
          ),
        ),
      );
    }

    return RefreshIndicator(
      onRefresh: () {
        SpacesBloc.of(context).add(LoadSpaces());
        return Future.value();
      },
      child: ListView(
        physics: const AlwaysScrollableScrollPhysics(),
        padding: EdgeInsets.all(8.0),
        children: spaces.map((space) {
          return SpaceCard(space: space);
        }).toList(),
      ),
    );
  }
}
