import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:invite_only_app/blocs/members/members_bloc.dart';
import 'package:invite_only_app/blocs/members/members_event.dart';
import 'package:invite_only_app/blocs/members/members_state.dart';
import 'package:invite_only_app/widgets/dialogs/error_dialog.dart';
import 'package:invite_only_app/widgets/dialogs/permission_dialog.dart';
import 'package:invite_only_app/widgets/search/contacts_search_delegate.dart';

Future<void> editMembers(
    BuildContext context, String title, Set<String> phoneNumbers) async {
  await Navigator.of(context).push(MaterialPageRoute(builder: (context) {
    return MembersPage(title: title, phoneNumbers: phoneNumbers);
  }));
}

class MembersPage extends StatelessWidget {
  /// The title of the type of members
  final String title;

  /// The phone numbers part of members - this is directly edited
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
          if (state is MembersError) {
            await showError(context, state.error);
            Navigator.of(context).pop();
          }

          if (state is MembersPermissionDenied) {
            await showPermissionDenied(context, 'contacts');
            Navigator.of(context).pop();
          }
        },
        builder: (context, state) {
          if (state is MembersLoading) {
            return Scaffold(body: Center(child: CircularProgressIndicator()));
          }

          if (state is MembersReady) {
            return _buildMembersList(context, state);
          }

          if (state is MembersError) {
            return Scaffold(body: Center(child: CircularProgressIndicator()));
          }

          if (state is MembersPermissionDenied) {
            return Scaffold(body: Center(child: CircularProgressIndicator()));
          }

          return null;
        },
      ),
    );
  }

  Widget _buildMembersList(BuildContext context, MembersReady state) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: state.phoneNumbers.isEmpty
          ? Center(
              child: Padding(
                padding: const EdgeInsets.all(40.0),
                child: Text(
                  'No $title added.\n\nAdd one using the \'Add\' button at the bottom of the page.',
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
              }).toList(),
            ),
      persistentFooterButtons: <Widget>[
        FlatButton(
          onPressed: () async {
            final newPhone = await selectPhone(context);
            if (newPhone != null) {
              MembersBloc.of(context).add(AddMember(newPhone));
            }
          },
          child: Text('Add'),
        ),
      ],
    );
  }
}
