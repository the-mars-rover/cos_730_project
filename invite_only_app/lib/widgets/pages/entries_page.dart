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

class EntriesPage extends StatefulWidget {
  final Space space;

  const EntriesPage({Key key, @required this.space}) : super(key: key);

  @override
  _EntriesPageState createState() => _EntriesPageState();
}

class _EntriesPageState extends State<EntriesPage> {
  final _scrollController = ScrollController();
  final _scrollThreshold = 200.0;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll(BuildContext context) {
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.position.pixels;
    if (maxScroll - currentScroll <= _scrollThreshold) {
      EntriesBloc.of(context).add(LoadMoreEntries());
    }
  }

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
          final space =
              state.spaces.firstWhere((s) => s.id == this.widget.space.id);
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
      create: (context) => EntriesBloc()..add(LoadInitialEntries(widget.space)),
      child: BlocBuilder<EntriesBloc, EntriesState>(builder: (context, state) {
        return Scaffold(
          body: RefreshIndicator(
            onRefresh: () {
              EntriesBloc.of(context).add(LoadInitialEntries(widget.space));
              return Future.value();
            },
            child: CustomScrollView(
              controller: _scrollController
                ..removeListener(() => _onScroll(context))
                ..addListener(() => _onScroll(context)),
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
                          : NetworkImage(widget.space.imageUrl),
                      fit: BoxFit.cover,
                      color: Colors.black54,
                      colorBlendMode: BlendMode.darken,
                    ),
                    title: Text(loadedSpace.title),
                  ),
                ),
                Builder(
                  builder: (context) {
                    if (state is InitialEntriesLoading) {
                      return SliverFillRemaining(
                        child: Center(child: CircularProgressIndicator()),
                      );
                    }

                    if (state is EntriesLoaded) {
                      return _buildEntries(context, state);
                    }

                    if (state is EntriesError) {
                      return SliverFillRemaining(
                        child: ErrorMessage(
                          state.error,
                          onRefresh: () => EntriesBloc.of(context).add(
                            LoadInitialEntries(widget.space),
                          ),
                        ),
                      );
                    }

                    return null;
                  },
                ),
              ],
            ),
          ),
          floatingActionButton: BlocBuilder<AuthBloc, AuthState>(
            builder: (context, state) {
              if (state is UserAuthenticated) {
                return _buildActions(context, loadedSpace, state.phoneNumber);
              }

              return Container();
            },
          ),
        );
      }),
    );
  }

  Widget _buildEntries(BuildContext context, EntriesLoaded state) {
    if (state.entries.isEmpty) {
      return SliverFillRemaining(
        child: Center(child: Text('No entries')),
      );
    }

    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          if (index >= state.entries.length) {
            return Center(
              child: Container(
                height: 40.0,
                width: 32.0,
                padding: EdgeInsetsDirectional.only(bottom: 8.0),
                child: CircularProgressIndicator(),
              ),
            );
          }

          final access = state.entries.elementAt(index);
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              EntryCard(entry: access),
              Divider(),
            ],
          );
        },
        childCount: state.hasReachedMax
            ? state.entries.length
            : state.entries.length + 1,
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

    if (widget.space.canInvite(phoneNumber)) {
      actions.add(SpeedDialChild(
        child: Icon(Icons.mail),
        backgroundColor: Theme.of(context).primaryColor,
        label: 'Invite',
        onTap: () => createInvite(context, loadedSpace),
      ));
    }

    if (widget.space.canGuard(phoneNumber)) {
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

          EntriesBloc.of(context).add(LoadInitialEntries(loadedSpace));
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
