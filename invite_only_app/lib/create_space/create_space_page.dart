import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:invite_only/app/app.dart';
import 'package:invite_only/app/contacts_search_delegate.dart';
import 'package:invite_only/create_space/create_space_bloc.dart';
import 'package:invite_only/create_space/create_space_event.dart';
import 'package:invite_only/create_space/create_space_state.dart';

class CreateSpacePage extends StatelessWidget {
  static const String ROUTE = '/space/create';

  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _minAgeController = TextEditingController();
  final _capacityController = TextEditingController();
  final _managerContacts = List<Contact>();
  final _managersController = TextEditingController();
  final _guardContacts = List<Contact>();
  final _guardsController = TextEditingController();
  final _inviterContacts = List<Contact>();
  final _invitersController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider<CreateSpaceBloc>(
      create: (context) => CreateSpaceBloc()..add(InitializeCreateSpace()),
      child: BlocConsumer<CreateSpaceBloc, CreateSpaceState>(
        listener: (context, state) {
          if (state is SpaceCreated) {
            Navigator.of(context).pop(state.space);
            Scaffold.of(context).showSnackBar(SnackBar(
              content: Text('${state.space.title} successfully created'),
            ));
          }

          if (state is ErrorCreatingSpace) {
            showDialog(
              context: context,
              builder: (context) => ErrorDialog(message: state.errorMessage),
            );
          }
        },
        builder: (context, state) {
          if (state is CreateSpaceInitializing) {
            return LoadingScaffold();
          }

          if (state is CreateSpaceInitialized) {
            return _buildForm(context, state);
          }

          if (state is CreatingSpace) {
            return LoadingScaffold();
          }

          if (state is SpaceCreated) {
            // irrelevant - page will be popped
            return Container();
          }

          if (state is ErrorCreatingSpace) {
            return _buildForm(context, state);
          }

          return null;
        },
      ),
    );
  }

  Widget _buildForm(BuildContext context, state) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Create Space"),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          children: <Widget>[
            TextFormField(
              controller: _titleController,
              validator: (text) {
                if (text.isEmpty) {
                  return 'You must enter a title';
                }

                if (text.length < 3) {
                  return 'The title must be at least 3 characters long';
                }

                return null;
              },
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.title),
                labelText: "Add Title",
                suffixIcon: IconButton(
                  icon: Icon(Icons.help_outline),
                  onPressed: () {},
                ),
              ),
            ),
            TextFormField(
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.edit_location),
                labelText: "Add Location",
                suffixIcon: IconButton(
                  icon: Icon(Icons.help_outline),
                  onPressed: () {},
                ),
              ),
            ),
            TextFormField(
              controller: _minAgeController,
              inputFormatters: <TextInputFormatter>[
                WhitelistingTextInputFormatter.digitsOnly
              ],
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.child_care),
                labelText: "Add Minimum Age",
                suffixIcon: IconButton(
                  icon: Icon(Icons.help_outline),
                  onPressed: () {},
                ),
              ),
            ),
            TextFormField(
              controller: _capacityController,
              inputFormatters: <TextInputFormatter>[
                WhitelistingTextInputFormatter.digitsOnly
              ],
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.block),
                labelText: "Add Maximum Capacity",
                suffixIcon: IconButton(
                  icon: Icon(Icons.help_outline),
                  onPressed: () {},
                ),
              ),
            ),
            TextFormField(
              controller: _managersController,
              onTap: () async {
                final contacts = await ContactsSearchDelegate.selectContacts(
                  context,
                  List()..addAll(_managerContacts),
                );
                if (contacts == null) return;

                _managerContacts.clear();
                _managerContacts.addAll(contacts);
                _managersController.text = '${contacts.length} managers added';
              },
              readOnly: true,
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.people),
                labelText: "Add Managers",
                suffixIcon: IconButton(
                  icon: Icon(Icons.help_outline),
                  onPressed: () {},
                ),
              ),
            ),
            TextFormField(
              controller: _guardsController,
              onTap: () async {
                final contacts = await ContactsSearchDelegate.selectContacts(
                  context,
                  List()..addAll(_guardContacts),
                );
                if (contacts == null) return;

                _guardContacts.clear();
                _guardContacts.addAll(contacts);
                _guardsController.text = '${contacts.length} guards added';
              },
              readOnly: true,
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.security),
                labelText: "Add Guards",
                suffixIcon: IconButton(
                  icon: Icon(Icons.help_outline),
                  onPressed: () {},
                ),
              ),
            ),
            TextFormField(
              controller: _invitersController,
              onTap: () async {
                final contacts = await ContactsSearchDelegate.selectContacts(
                  context,
                  List()..addAll(_inviterContacts),
                );
                if (contacts == null) return;

                _inviterContacts.clear();
                _inviterContacts.addAll(contacts);
                _invitersController.text = '${contacts.length} inviters added';
              },
              readOnly: true,
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.mail),
                labelText: "Add Inviters",
                suffixIcon: IconButton(
                  icon: Icon(Icons.help_outline),
                  onPressed: () {},
                ),
              ),
            ),
          ],
        ),
      ),
      persistentFooterButtons: <Widget>[
        RaisedButton(
          child: Text("SAVE"),
          color: Theme.of(context).primaryColor,
          onPressed: () {
            if (!_formKey.currentState.validate()) return;

            BlocProvider.of<CreateSpaceBloc>(context).add(CreateSpace(
              title: _titleController.text,
              imageUrl:
                  'data:image/jpeg;base64,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',
              managerPhones:
                  _managerContacts.map((c) => c.phones.first.value).toList(),
              guardPhones:
                  _guardContacts.map((c) => c.phones.first.value).toList(),
              inviterPhones:
                  _inviterContacts.map((c) => c.phones.first.value).toList(),
              locationLatitude: null,
              locationLongitude: null,
              minAge: int.tryParse(_minAgeController.text),
              maxCapacity: int.tryParse(_capacityController.text),
            ));
          },
        ),
      ],
    );
  }
}
