import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_map_location_picker/google_map_location_picker.dart';
import 'package:image_picker/image_picker.dart';
import 'package:invite_only_app/main.dart';
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

class SpacePage extends StatefulWidget {
  final Space space;

  SpacePage({Key key, this.space}) : super(key: key);

  @override
  _SpacePageState createState() => _SpacePageState();
}

class _SpacePageState extends State<SpacePage> {
  GlobalKey<FormState> _formKey;
  TextEditingController _titleController;
  Set<String> _managerPhones;
  Set<String> _inviterPhones;
  Set<String> _guardPhones;
  String _imageUrl;
  Placemark _location;
  bool _uploading;

  @override
  void initState() {
    super.initState();
    _formKey = GlobalKey<FormState>();
    _titleController = TextEditingController(text: widget.space.title);
    _managerPhones = widget.space.managerPhones;
    _inviterPhones = widget.space.inviterPhones;
    _guardPhones = widget.space.guardPhones;
    _imageUrl = widget.space?.imageUrl;
    _uploading = false;
    if (widget.space.locationLatitude != null &&
        widget.space.locationLongitude != null) {
      Geolocator()
          .placemarkFromCoordinates(
              widget.space.locationLatitude, widget.space.locationLongitude)
          .then((p) {
        if (p == null) return;
        setState(() => _location = p.first);
      });
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.space.id == null ? 'Create Space' : 'Edit Space'),
        excludeHeaderSemantics: false,
      ),
      persistentFooterButtons: [
        RaisedButton(
          child: Text('SAVE'),
          color: Theme.of(context).primaryColor,
          onPressed: () {
            if (!_formKey.currentState.validate()) return;

            Navigator.of(context).pop(widget.space.copyWith(
              title: _titleController.text,
              managerPhones: _managerPhones,
              inviterPhones: _inviterPhones,
              guardPhones: _guardPhones,
              imageUrl: _imageUrl,
              locationLatitude: _location?.position?.latitude,
              locationLongitude: _location?.position?.longitude,
            ));
          },
        )
      ],
      body: _buildForm(context),
    );
  }

  Form _buildForm(BuildContext context) {
    return Form(
      key: _formKey,
      child: ListView(
        children: <Widget>[
          _buildImage(context),
          ListTile(
            leading: Icon(Icons.title),
            title: TextFormField(
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
                hintText: 'Add Title',
                border: InputBorder.none,
              ),
            ),
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.location_on),
            title: _location != null
                ? Text(
                    '${_location.subThoroughfare} ${_location.thoroughfare}, ${_location.subLocality}, ${_location.locality}, ${_location.administrativeArea}',
                  )
                : Text(
                    'Add Location',
                    style: TextStyle(color: Theme.of(context).hintColor),
                  ),
            subtitle: _location != null
                ? Text(
                    '${_location.subThoroughfare} ${_location.thoroughfare}, ${_location.subLocality}, ${_location.locality}, ${_location.administrativeArea}',
                  )
                : null,
            onTap: () async {
              var apiKey;
              if (Platform.isAndroid) apiKey = kAndroidMapsApiKey;
              if (Platform.isIOS) apiKey = kIosMapsApiKey;

              final result = await showLocationPicker(context, apiKey);
              if (result == null) return;

              final placemarks = await Geolocator().placemarkFromCoordinates(
                result.latLng.latitude,
                result.latLng.longitude,
              );
              setState(() => _location = placemarks.first);
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.edit),
            title: Text('Managers'),
            subtitle: Text('May edit or delete the space'),
            trailing: Icon(Icons.navigate_next),
            onTap: () async {
              final edited =
                  await editMembers(context, 'Managers', _managerPhones);
              setState(() => _managerPhones = edited);
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.mail),
            title: Text('Inviters'),
            subtitle: Text('May create invites for the space'),
            trailing: Icon(Icons.navigate_next),
            onTap: () async {
              final edited =
                  await editMembers(context, 'Inviters', _inviterPhones);
              setState(() => _inviterPhones = edited);
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.security),
            title: Text('Guards'),
            subtitle: Text('May grant entry to the space'),
            trailing: Icon(Icons.navigate_next),
            onTap: () async {
              final edited = await editMembers(context, 'Guards', _guardPhones);
              setState(() => _guardPhones = edited);
            },
          ),
          Divider(),
          Visibility(
            visible: widget.space.id != null,
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
    );
  }

  Widget _buildImage(BuildContext context) {
    if (_uploading) {
      return Container(
        height: 150.0,
        decoration: BoxDecoration(color: Colors.grey.withOpacity(0.5)),
        child: Center(child: CircularProgressIndicator()),
      );
    }

    return Container(
      padding: EdgeInsets.all(8.0),
      height: 150.0,
      decoration: BoxDecoration(
        image: _imageUrl != null
            ? DecorationImage(
                image: NetworkImage(_imageUrl),
                fit: BoxFit.cover,
              )
            : null,
        color: Colors.grey.withOpacity(0.5),
      ),
      child: Stack(
        children: <Widget>[
          _buildUploadButton(context),
          Visibility(
            visible: _imageUrl == null,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(Icons.image, size: 32.0),
                  Text('No image added'),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Positioned _buildUploadButton(BuildContext context) {
    return Positioned(
      bottom: 8.0,
      right: 8.0,
      child: ClipOval(
        child: Material(
          color: Theme.of(context).canvasColor, // button color
          child: InkWell(
            splashColor: Theme.of(context).primaryColor, // inkwell color
            child: SizedBox(
              width: 64.0,
              height: 64.0,
              child: Icon(Icons.add_a_photo),
            ),
            onTap: () {
              _setImage(context);
            },
          ),
        ),
      ),
    );
  }

  Future<void> _setImage(BuildContext context) async {
    final picker = ImagePicker();
    final pickedFile =
        await picker.getImage(source: ImageSource.gallery, imageQuality: 25);
    if (pickedFile == null) return;
    final image = File(pickedFile.path);

    setState(() => _uploading = true);
    final storage = FirebaseStorage.instance;
    final ref = storage.ref().child('images/');
    final snapshot = await ref.putFile(image).onComplete;
    if (snapshot.error == null) {
      final url = await snapshot.ref.getDownloadURL();
      setState(() => _imageUrl = url);
    } else {
      Scaffold.of(context).showSnackBar(
        SnackBar(content: Text('Image could not be saved')),
      );
    }
    setState(() => _uploading = false);
  }
}
