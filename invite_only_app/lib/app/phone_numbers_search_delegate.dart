import 'dart:async';

import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

class PhoneNumbersSearchDelegate extends SearchDelegate<List<String>> {
  List<Item> phones;
  StreamController<List<Item>> phonesSC;

  PhoneNumbersSearchDelegate() {
    phones = List();
    phonesSC.add(phones);
  }

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
    return FutureBuilder<Iterable<Contact>>(
      future: ContactsService.getContacts(
        query: query.isNotEmpty ? query : null,
      ),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return LinearProgressIndicator();
        }

        var displayedContacts = snapshot.data;
        return StreamBuilder<List<Item>>(
          stream: phonesSC.stream,
          builder: (context, snapshot) {
            return Scaffold(
              body: ListView.separated(
                itemCount: displayedContacts.length,
                separatorBuilder: (context, index) => Container(),
                itemBuilder: (context, index) {
                  var contact = displayedContacts.elementAt(index);
                  if (contact.phones.isEmpty) {
                    return Container();
                  }

                  if (contact.phones.length > 1) {
                    return ExpansionTile(
                      title: Text(contact.displayName),
                      subtitle: Text(
                        contact.phones
                            .map((phone) => phone.value)
                            .toList()
                            .join(', '),
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context)
                            .primaryTextTheme
                            .subtitle
                            .copyWith(color: Colors.black45),
                      ),
                      children: contact.phones.map((phone) {
                        return CheckboxListTile(
                          title: Text(phone.label),
                          subtitle: Text(phone.value),
                          value: phones.where((p) => p == phone).isNotEmpty,
                          onChanged: (selected) {
                            if (selected) {
                              phones.add(phone);
                            } else {
                              phones.remove(phone);
                            }
                            phonesSC.add(phones);
                          },
                        );
                      }).toList(),
                    );
                  }

                  Item phone = contact.phones.first;
                  return CheckboxListTile(
                    title: Text(contact.displayName),
                    subtitle: Text(phone.value),
                    value: phones.where((p) => p == phone).isNotEmpty,
                    onChanged: (selected) {
                      if (selected) {
                        phones.add(phone);
                      } else {
                        phones.remove(phone);
                      }

                      phonesSC.add(phones);
                    },
                  );
                },
              ),
              persistentFooterButtons: <Widget>[
                FlatButton(
                  onPressed: () {
                    phonesSC.close();
                    close(context, phones.map((phone) => phone.value).toList());
                  },
                  child: Text('Save'),
                )
              ],
            );
          },
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return buildResults(context);
  }

  @override
  String get searchFieldLabel => 'Search Contacts';

  static Future<List<String>> selectPhoneNumber(BuildContext context) async {
    // First ensure that contacts permission is granted
    var permissionStatus = await Permission.contacts.status;
    if (!permissionStatus.isGranted) {
      permissionStatus = await Permission.contacts.request();
      if (!permissionStatus.isGranted) {
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text('Permission Denied'),
              content: Text(
                  'Access to your contacts has been denied. You will need to grant the permission from the App\'s settings.'),
              actions: <Widget>[
                FlatButton(
                  child: Text('Open Settings'),
                  onPressed: () {
                    Navigator.of(context).pop();
                    openAppSettings();
                  },
                ),
              ],
            );
          },
        );

        return null;
      }
    }

    // Select and return contacts through a search using ContactsSearchDelegate
    return await showSearch<List<String>>(
      context: context,
      delegate: PhoneNumbersSearchDelegate(),
    );
  }
}