import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/material.dart';

/// Select a phone number from a list of given contacts.
Future<String> selectPhone(BuildContext context, List<Contact> contacts) async {
  // Select and return contacts through a search using ContactsSearchDelegate
  return await showSearch<String>(
    context: context,
    delegate: ContactsSearchDelegate(contacts),
  );
}

/// Search for a phone number from a list of given contacts.
class ContactsSearchDelegate extends SearchDelegate<String> {
  final List<Contact> contacts;

  ContactsSearchDelegate(this.contacts);

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
    final searched = contacts.where((c) {
      if (c.displayName == null) return false;
      return c.displayName.toLowerCase().contains(query.toLowerCase());
    });
    return ListView.separated(
      itemCount: searched.length,
      separatorBuilder: (context, index) => Container(),
      itemBuilder: (context, index) {
        var contact = searched.elementAt(index);
        if (contact.phones.isEmpty) return Container();
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

  @override
  TextInputAction get textInputAction => super.textInputAction;

  @override
  Widget buildSuggestions(BuildContext context) {
    return buildResults(context);
  }

  @override
  String get searchFieldLabel => 'Search Contacts';
}
