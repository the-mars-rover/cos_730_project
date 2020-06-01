import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:invite_only_app/blocs/spaces/spaces_bloc.dart';
import 'package:invite_only_app/blocs/spaces/spaces_event.dart';
import 'package:invite_only_app/blocs/spaces/spaces_state.dart';
import 'package:invite_only_app/widgets/cards/space_card.dart';
import 'package:invite_only_app/widgets/dialogs/error_dialog.dart';
import 'package:invite_only_app/widgets/pages/docs_page.dart';
import 'package:invite_only_app/widgets/pages/space_page.dart';

class SpacesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SpacesBloc, SpacesState>(
      listener: (context, state) {
        if (state is SpacesError) {
          showError(context, state.error).then((value) {
            SpacesBloc.of(context).add(LoadSpaces());
          });
        }
      },
      builder: (context, state) {
        if (state is SpacesLoading) {
          return Scaffold(body: Center(child: CircularProgressIndicator()));
        }

        if (state is SpacesLoaded) {
          return _buildSpacesScaffold(context, state);
        }

        if (state is SpacesError) {
          return Scaffold(body: Center(child: CircularProgressIndicator()));
        }

        return null;
      },
    );
  }

  Widget _buildSpacesScaffold(BuildContext context, SpacesLoaded state) {
    final spaces = state.spaces;
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
                        SpacesBloc.of(context).add(LoadSpaces());
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
                    onTap: () {},
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      body: spaces.isEmpty
          ? Center(
              child: Padding(
                padding: const EdgeInsets.all(40.0),
                child: Text(
                  'You do not have access to any spaces.\n\n'
                  'You can create your own space or ask a manager of an existing space to add you.',
                  textAlign: TextAlign.center,
                ),
              ),
            )
          : ListView(
              padding: EdgeInsets.all(8.0),
              children: spaces.map((space) {
                return SpaceCard(space: space);
              }).toList(),
            ),
    );
  }
}
