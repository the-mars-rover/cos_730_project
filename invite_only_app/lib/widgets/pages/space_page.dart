import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:invite_only_app/blocs/space/space_bloc.dart';
import 'package:invite_only_app/blocs/space/space_event.dart';
import 'package:invite_only_app/blocs/space/space_state.dart';
import 'package:invite_only_app/widgets/dialogs/error_dialog.dart';
import 'package:invite_only_app/widgets/pages/members_page.dart';
import 'package:invite_only_repo/invite_only_repo.dart';

/// Create a new space and return the space that was created, or null if no space was created.
Future<Space> createSpace(BuildContext context) async {
  return await Navigator.of(context).push(MaterialPageRoute(builder: (context) {
    return SpacePage(
      space: Space(
          title: '',
          guardPhones: Set(),
          inviterPhones: Set(),
          managerPhones: Set()),
    );
  }));
}

/// Update the space and return the updated space, or null if no space was created.
Future<Space> editSpace(BuildContext context, Space space) async {
  return await Navigator.of(context).push(MaterialPageRoute(builder: (context) {
    return SpacePage(space: space);
  }));
}

// TODO: Add support for image and location selection
class SpacePage extends StatelessWidget {
  final Space space;
  final _formKey;
  final _titleController;

  SpacePage({Key key, this.space})
      : _formKey = GlobalKey<FormState>(),
        _titleController = TextEditingController(text: space.title),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<SpaceBloc>(
      create: (context) => SpaceBloc(),
      child: BlocConsumer<SpaceBloc, SpaceState>(
        listener: (context, state) async {
          if (state is SpaceSaved) {
            Navigator.of(context).pop(state.space);
          }

          if (state is ErrorSavingSpace) {
            await showError(context, state.error);
          }
        },
        builder: (context, state) {
          if (state is SpaceInitial) {
            return _buildForm(context, state);
          }

          if (state is SavingSpace) {
            return Scaffold(body: Center(child: CircularProgressIndicator()));
          }

          if (state is SpaceSaved) {
            return Scaffold(body: Center(child: CircularProgressIndicator()));
          }

          if (state is ErrorSavingSpace) {
            return Scaffold(body: Center(child: CircularProgressIndicator()));
          }

          return null;
        },
      ),
    );
  }

  Widget _buildForm(BuildContext context, SpaceInitial state) {
    return Scaffold(
      appBar: AppBar(
        title: Text(space.id == null ? 'Create Space' : 'Edit Space'),
        excludeHeaderSemantics: false,
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
                labelText: 'Add Title',
              ),
            ),
            TextFormField(
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.edit_location),
                labelText: 'Add Location',
              ),
            ),
            ListTile(
              title: Text('Managers, Inviters and Guards'),
              subtitle: Text('May all enter the space'),
            ),
            ListTile(
              leading: Icon(Icons.edit),
              title: Text('Managers'),
              subtitle: Text('May edit or delete the space'),
              trailing: Icon(Icons.navigate_next),
              onTap: () async {
                await editMembers(context, 'Managers', space.managerPhones);
              },
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.mail),
              title: Text('Inviters'),
              subtitle: Text('May create invites for the space'),
              trailing: Icon(Icons.navigate_next),
              onTap: () async {
                await editMembers(context, 'Inviters', space.inviterPhones);
              },
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.security),
              title: Text('Guards'),
              subtitle: Text('May grant entry to the space'),
              trailing: Icon(Icons.navigate_next),
              onTap: () async {
                await editMembers(context, 'Guards', space.guardPhones);
              },
            ),
            Divider(),
            Visibility(
              visible: space.id != null,
              child: ListTile(
                title: OutlineButton.icon(
                  icon: Icon(Icons.delete, color: Colors.red),
                  label: Text(
                    "DELETE SPACE",
                    style: TextStyle(color: Colors.red),
                  ),
                  borderSide: BorderSide(color: Colors.red),
                  highlightedBorderColor: Colors.red,
                  onPressed: () {
                    // TODO: Delete space
                  },
                ),
              ),
            ),
          ],
        ),
      ),
      persistentFooterButtons: <Widget>[
        RaisedButton(
          child: Text('SAVE'),
          color: Theme.of(context).primaryColor,
          onPressed: () {
            if (!_formKey.currentState.validate()) return;

            final newSpace = space.copyWith(title: _titleController.text);
            SpaceBloc.of(context).add(SaveSpace(newSpace));
          },
        ),
      ],
    );
  }
}
