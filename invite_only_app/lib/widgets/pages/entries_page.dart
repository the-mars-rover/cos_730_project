import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:invite_only_app/blocs/auth/auth_bloc.dart';
import 'package:invite_only_app/blocs/auth/auth_state.dart';
import 'package:invite_only_app/blocs/entries/entries_bloc.dart';
import 'package:invite_only_app/blocs/entries/entries_event.dart';
import 'package:invite_only_app/blocs/entries/entries_state.dart';
import 'package:invite_only_app/blocs/spaces/spaces_bloc.dart';
import 'package:invite_only_app/blocs/spaces/spaces_event.dart';
import 'package:invite_only_app/widgets/cards/entry_card.dart';
import 'package:invite_only_app/widgets/dialogs/entry_dialog.dart';
import 'package:invite_only_app/widgets/dialogs/error_dialog.dart';
import 'package:invite_only_app/widgets/dialogs/invite_dialog.dart';
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
    return BlocProvider<EntriesBloc>(
      create: (context) => EntriesBloc()..add(LoadEntries(space)),
      child: BlocConsumer<EntriesBloc, EntriesState>(
        listener: (context, state) async {
          if (state is EntriesError) {
            await showError(context, state.error);
            Navigator.of(context).pop();
          }
        },
        builder: (context, state) {
          if (state is EntriesLoading) {
            return Scaffold(body: Center(child: CircularProgressIndicator()));
          }

          if (state is EntriesLoaded) {
            return _buildEntries(context, state);
          }

          if (state is EntriesError) {
            return Scaffold(body: Center(child: CircularProgressIndicator()));
          }

          return null;
        },
      ),
    );
  }

  Widget _buildEntries(BuildContext context, EntriesLoaded entriesState) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        if (state is UserAuthenticated) {
          return _buildScaffold(context, entriesState, state);
        }

        return Container();
      },
    );
  }

  Widget _buildScaffold(BuildContext context, EntriesLoaded entriesState,
      UserAuthenticated authState) {
    String phone = authState.phoneNumber;
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
                image: entriesState.space.imageUrl == null
                    ? AssetImage('assets/logo.png')
                    : NetworkImage(space.imageUrl),
                fit: BoxFit.cover,
                color: Colors.black54,
                colorBlendMode: BlendMode.darken,
              ),
              title: Text(entriesState.space.title),
            ),
          ),
          Builder(
            builder: (context) {
              List<Entry> entries = entriesState.entries;
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
            },
          ),
        ],
      ),
      persistentFooterButtons: <Widget>[
        Builder(
          builder: (context) {
            if (!entriesState.space.canEdit(phone)) return Container();

            return OutlineButton.icon(
              onPressed: () async {
                final updated = await editSpace(context, entriesState.space);
                if (updated != null) {
                  SpacesBloc.of(context).add(LoadSpaces());
                  EntriesBloc.of(context).add(LoadEntries(updated));
                  Scaffold.of(context).showSnackBar(SnackBar(
                    content: Text('${updated.title} successfully updated'),
                  ));
                }
              },
              icon: Icon(Icons.edit),
              label: Text('Manage'),
            );
          },
        ),
        Visibility(
          visible: entriesState.space.canGuard(phone),
          child: OutlineButton.icon(
            onPressed: () async {
              final scannedIdDocument = await scanId(context);
              if (scannedIdDocument == null) return;

              grantEntry(context, entriesState.space, scannedIdDocument);
            },
            icon: Icon(Icons.security),
            label: Text('Guard'),
          ),
        ),
        Visibility(
          visible: entriesState.space.canInvite(phone),
          child: OutlineButton.icon(
            onPressed: () => createInvite(context, entriesState.space),
            icon: Icon(Icons.mail),
            label: Text('Invite'),
          ),
        ),
      ],
    );
  }
}
