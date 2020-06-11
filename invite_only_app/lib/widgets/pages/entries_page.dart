import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:invite_only_app/blocs/auth/auth_bloc.dart';
import 'package:invite_only_app/blocs/auth/auth_state.dart';
import 'package:invite_only_app/blocs/entries/entries_bloc.dart';
import 'package:invite_only_app/blocs/entries/entries_event.dart';
import 'package:invite_only_app/blocs/entries/entries_state.dart';
import 'package:invite_only_app/blocs/spaces/spaces_bloc.dart';
import 'package:invite_only_app/blocs/spaces/spaces_event.dart';
import 'package:invite_only_app/blocs/spaces/spaces_state.dart';
import 'package:invite_only_app/widgets/cards/entry_card.dart';
import 'package:invite_only_app/widgets/dialogs/entry_dialog.dart';
import 'package:invite_only_app/widgets/dialogs/invite_dialog.dart';
import 'package:invite_only_app/widgets/other/error_message.dart';
import 'package:invite_only_app/widgets/pages/space_page.dart';
import 'package:invite_only_repo/invite_only_repo.dart';
import 'package:rsa_scan/rsa_scan.dart';

Future<void> showEntries(BuildContext context, Space space) async {
  Navigator.of(context).push(MaterialPageRoute(
    builder: (context) => EntriesPage(space: space),
  ));
}

class EntriesPage extends StatelessWidget {
  final Space space;

  const EntriesPage({Key key, @required this.space}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SpacesBloc, SpacesState>(
      listener: (context, state) {
        if (state is SpaceSaved) {
          Fluttertoast.showToast(msg: '${state.space.title} Saved');
        }

        if (state is SpaceDeleted) {
          Fluttertoast.showToast(msg: '${state.space.title} Deleted');
          Navigator.of(context).pop();
        }
      },
      builder: (context, state) {
        if (state is SpacesLoading) {
          return Scaffold(body: Center(child: CircularProgressIndicator()));
        }

        if (state is SpacesLoaded) {
          final space = state.spaces.firstWhere((s) => s.id == this.space.id);
          return _buildSpaceScaffold(context, space);
        }

        if (state is SpacesError) {
          return ErrorMessage(state.error,
              onRefresh: () => SpacesBloc.of(context).add(LoadSpaces()));
        }

        if (state is SavingSpace) {
          return Scaffold(body: Center(child: CircularProgressIndicator()));
        }

        if (state is SpaceSaved) {
          return Scaffold(body: Center(child: CircularProgressIndicator()));
        }

        if (state is DeletingSpace) {
          return Scaffold(body: Center(child: CircularProgressIndicator()));
        }

        if (state is SpaceDeleted) {
          return Scaffold(body: Center(child: CircularProgressIndicator()));
        }

        return null;
      },
    );
  }

  Widget _buildSpaceScaffold(BuildContext context, Space loadedSpace) {
    return BlocProvider<EntriesBloc>(
      create: (context) => EntriesBloc()..add(LoadEntries(space)),
      child: Scaffold(
        body: CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(
              expandedHeight: 150.0,
              floating: true,
              pinned: true,
              snap: true,
              flexibleSpace: FlexibleSpaceBar(
                background: Image(
                  image: loadedSpace.imageUrl == null
                      ? AssetImage('assets/logo.png')
                      : NetworkImage(space.imageUrl),
                  fit: BoxFit.cover,
                  color: Colors.black54,
                  colorBlendMode: BlendMode.darken,
                ),
                title: Text(loadedSpace.title),
              ),
            ),
            BlocConsumer<EntriesBloc, EntriesState>(
              listener: (context, state) async {},
              builder: (context, state) {
                if (state is EntriesLoading) {
                  return SliverFillRemaining(
                    child: Center(child: CircularProgressIndicator()),
                  );
                }

                if (state is EntriesLoaded) {
                  return _buildEntries(context, state.entries);
                }

                if (state is EntriesError) {
                  return SliverFillRemaining(
                    child: Center(child: CircularProgressIndicator()),
                  );
                }

                return null;
              },
            ),
          ],
        ),
        floatingActionButton: BlocBuilder<AuthBloc, AuthState>(
          builder: (context, state) {
            if (state is UserAuthenticated) {
              return _buildActions(context, loadedSpace, state.phoneNumber);
            }

            return Container();
          },
        ),
      ),
    );
  }

  Widget _buildEntries(BuildContext context, List<Entry> entries) {
    if (entries.isEmpty) {
      return SliverFillRemaining(
        child: Center(child: Text('No entries')),
      );
    }

    return SliverList(
      delegate: SliverChildListDelegate(
        entries.map((access) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              EntryCard(entry: access),
              Divider(),
            ],
          );
        }).toList(),
      ),
    );
  }

  Widget _buildActions(
      BuildContext context, Space loadedSpace, String phoneNumber) {
    List<SpeedDialChild> actions = [];
    if (loadedSpace.canEdit(phoneNumber)) {
      actions.add(SpeedDialChild(
        child: Icon(Icons.edit),
        backgroundColor: Theme.of(context).primaryColor,
        label: 'Manage',
        onTap: () async {
          final updated = await editSpace(context, loadedSpace);

          // if space was deleted, add delete event.
          if (updated == null)
            SpacesBloc.of(context).add(DeleteSpace(loadedSpace));

          // if space was changed, save space.
          if (updated != loadedSpace)
            SpacesBloc.of(context).add(SaveSpace(updated));
        },
      ));
    }

    if (space.canInvite(phoneNumber)) {
      actions.add(SpeedDialChild(
        child: Icon(Icons.mail),
        backgroundColor: Theme.of(context).primaryColor,
        label: 'Invite',
        onTap: () => createInvite(context, loadedSpace),
      ));
    }

    if (space.canGuard(phoneNumber)) {
      actions.add(SpeedDialChild(
        child: Icon(Icons.security),
        backgroundColor: Theme.of(context).primaryColor,
        label: 'Guard',
        onTap: () async {
          final scannedIdDocument = await scanId(context);
          if (scannedIdDocument == null) return;

          final granted =
              await grantEntry(context, loadedSpace, scannedIdDocument);
          if (!granted) return;

          EntriesBloc.of(context).add(LoadEntries(loadedSpace));
        },
      ));
    }

    return SpeedDial(
      animatedIcon: AnimatedIcons.menu_close,
      overlayColor: Colors.black,
      overlayOpacity: 0.5,
      children: actions,
    );
  }
}
