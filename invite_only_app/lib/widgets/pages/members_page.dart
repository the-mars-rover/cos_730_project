import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:invite_only_app/blocs/auth/auth_bloc.dart';
import 'package:invite_only_app/blocs/auth/auth_state.dart';
import 'package:invite_only_app/blocs/members/members_bloc.dart';
import 'package:invite_only_app/blocs/members/members_event.dart';
import 'package:invite_only_app/blocs/members/members_state.dart';
import 'package:invite_only_app/widgets/dialogs/permission_dialog.dart';
import 'package:invite_only_app/widgets/other/error_message.dart';
import 'package:invite_only_app/widgets/other/permission_message.dart';
import 'package:invite_only_app/widgets/search/contacts_search_delegate.dart';

Future<Set<String>> editMembers(
    BuildContext context, String title, Set<String> phoneNumbers) async {
  final edited =
      await Navigator.of(context).push(MaterialPageRoute(builder: (context) {
    return MembersPage(title: title, phoneNumbers: Set.of(phoneNumbers));
  }));

  if (edited == null) return phoneNumbers;

  return edited;
}

class MembersPage extends StatelessWidget {
  /// The title of the type of members
  final String title;

  /// The phone numbers part of members
  final Set<String> phoneNumbers;

  const MembersPage(
      {Key key, @required this.title, @required this.phoneNumbers})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<MembersBloc>(
      create: (context) => MembersBloc()..add(LoadMembers(phoneNumbers)),
      child: BlocConsumer<MembersBloc, MembersState>(
        listener: (context, state) async {
          if (state is MembersPermissionDenied) {
            await showPermissionDenied(context, 'contacts');
            Navigator.of(context).pop();
          }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              title: Text(title),
              actions: <Widget>[
                IconButton(
                  icon: Icon(Icons.add),
                  onPressed: () async {
                    final newPhone = await selectPhone(context);
                    if (newPhone != null) {
                      MembersBloc.of(context).add(AddMember(newPhone));
                    }
                  },
                ),
              ],
            ),
            persistentFooterButtons: <Widget>[
              FlatButton(
                onPressed: () async {
                  Navigator.of(context).pop(phoneNumbers);
                },
                child: Text('Save'),
              ),
            ],
            body: Builder(builder: (context) {
              if (state is MembersLoading) {
                return Scaffold(
                    body: Center(child: CircularProgressIndicator()));
              }

              if (state is MembersReady) {
                return _buildMembersList(context, state);
              }

              if (state is MembersError) {
                return ErrorMessage(
                  state.error,
                  onRefresh: () => Navigator.of(context).pop(),
                );
              }

              if (state is MembersPermissionDenied) {
                return PermissionMessage(
                  'contacts',
                  onRefresh: () => MembersBloc.of(context).add(
                    LoadMembers(phoneNumbers),
                  ),
                );
              }

              return null;
            }),
          );
        },
      ),
    );
  }

  Widget _buildMembersList(BuildContext context, MembersReady state) {
    return state.phoneNumbers.isEmpty
        ? Center(
            child: Padding(
              padding: const EdgeInsets.all(40.0),
              child: Text(
                'No $title added.\n\nAdd one using the \'+\' button at the top of the page.',
                textAlign: TextAlign.center,
              ),
            ),
          )
        : ListView(
            children: state.phoneNumbers.map((p) {
              final contact = state.contacts.firstWhere(
                  (c) => c.phones.where((i) => i.value == p).isNotEmpty,
                  orElse: () => null);
              if (contact != null) {
                return ListTile(
                  title: Text(contact.displayName),
                  subtitle: Text(p),
                  trailing: IconButton(
                    icon: Icon(Icons.remove_circle_outline),
                    onPressed: () {
                      MembersBloc.of(context).add(RemoveMember(p));
                    },
                  ),
                );
              }

              return BlocBuilder<AuthBloc, AuthState>(
                  builder: (context, state) {
                if (state is UserAuthenticated && state.phoneNumber == p) {
                  return ListTile(title: Text(p), subtitle: Text('You'));
                }

                return ListTile(
                  title: Text(p),
                  subtitle: Text('Not in your contact list'),
                  trailing: IconButton(
                    icon: Icon(Icons.remove_circle_outline),
                    onPressed: () {
                      MembersBloc.of(context).add(RemoveMember(p));
                    },
                  ),
                );
              });
            }).toList(),
          );
  }
}
