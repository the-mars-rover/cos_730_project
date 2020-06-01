import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:invite_only_app/blocs/auth/auth_bloc.dart';
import 'package:invite_only_app/blocs/auth/auth_state.dart';
import 'package:invite_only_app/blocs/contacts/contacts_bloc.dart';
import 'package:invite_only_app/blocs/contacts/contacts_event.dart';
import 'package:invite_only_app/blocs/contacts/contacts_state.dart';
import 'package:invite_only_app/widgets/dialogs/error_dialog.dart';
import 'package:invite_only_app/widgets/dialogs/permission_dialog.dart';

Future<String> selectPhone(BuildContext context) async {
  // Select and return contacts through a search using ContactsSearchDelegate
  return await showSearch<String>(
    context: context,
    delegate: ContactsSearchDelegate(),
  );
}

class ContactsSearchDelegate extends SearchDelegate<String> {
  @override
  List<Widget> buildActions(BuildContext context) {
    return <Widget>[
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return Scaffold(
      body: BlocProvider<ContactsBloc>(
        create: (_) => ContactsBloc()..add(LoadContacts(query)),
        child: BlocConsumer<ContactsBloc, ContactsState>(
          listener: (_, state) async {
            if (state is ContactsError) {
              await showError(context, state.error);
              close(context, null);
            }

            if (state is ContactsPermissionDenied) {
              await showPermissionDenied(context, 'contacts');
              close(context, null);
            }
          },
          builder: (_, state) {
            if (state is ContactsLoading) {
              return Center(child: CircularProgressIndicator());
            }

            if (state is ContactsLoaded) {
              return _buildContactsList(state);
            }

            if (state is ContactsPermissionDenied) {
              return Center(child: CircularProgressIndicator());
            }

            if (state is ContactsError) {
              return Center(child: CircularProgressIndicator());
            }

            return null;
          },
        ),
      ),
      persistentFooterButtons: <Widget>[
        BlocBuilder<AuthBloc, AuthState>(builder: (context, state) {
          if (state is UserAuthenticated) {
            return FlatButton(
              onPressed: () => close(context, state.phoneNumber),
              child: Text('Add yourself'),
            );
          }

          return Container();
        })
      ],
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return buildResults(context);
  }

  @override
  String get searchFieldLabel => 'Search Contacts';

  Widget _buildContactsList(ContactsLoaded state) {
    return ListView.separated(
      itemCount: state.contacts.length,
      separatorBuilder: (context, index) => Container(),
      itemBuilder: (context, index) {
        var contact = state.contacts.elementAt(index);
        if (contact.phones.isEmpty) {
          return Container();
        }

        if (contact.phones.length == 1) {
          return ListTile(
            title: Text(contact.displayName),
            subtitle: Text(contact.phones.first.value),
            onTap: () => close(context, contact.phones.first.value),
          );
        }

        return ExpansionTile(
          title: Text(contact.displayName),
          subtitle: Text('Tap to see options'),
          children: contact.phones.map((p) {
            return ListTile(
              title: Text(p.label),
              subtitle: Text(p.value),
              onTap: () => close(context, p.value),
            );
          }).toList(),
        );
      },
    );
  }
}
