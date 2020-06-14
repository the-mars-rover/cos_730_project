import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';
import 'package:invite_only_app/widgets/dialogs/confirmation_dialog.dart';
import 'package:invite_only_app/widgets/pages/members_page.dart';
import 'package:invite_only_repo/invite_only_repo.dart';
import 'package:uuid/uuid.dart';

/// Create a new space and return the space that was created, or null if no space was created.
Future<Space> createSpace(BuildContext context) async {
  return Navigator.of(context).push(MaterialPageRoute(builder: (context) {
    return SpacePage();
  }));
}

/// Update the space and return the updated space.
///
/// If no updates were made to the space, return the original space.
/// If the space has been deleted, return null.
Future<Space> editSpace(BuildContext context, Space space) async {
  return await Navigator.of(context).push(MaterialPageRoute(builder: (context) {
    return SpacePage(space: space.copyWith());
  }));
}

/// This page is used to edit a single [Space]. If [space] is null this page will create
/// a new space.
///
/// The page will pop with the updated space if the space was changed; or,
/// with null if the changes to the given space (or null) was not saved.
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
    _initMembers();
  }

  Future<void> _initMembers() async {
    _formKey = GlobalKey<FormState>();
    _titleController = TextEditingController(text: widget.space?.title);
    _managerPhones = widget.space?.managerPhones ?? Set();
    _inviterPhones = widget.space?.inviterPhones ?? Set();
    _guardPhones = widget.space?.guardPhones ?? Set();
    _imageUrl = widget.space?.imageUrl;
    _uploading = false;
    try {
      final placemarks = await Geolocator().placemarkFromCoordinates(
        widget.space.locationLatitude,
        widget.space.locationLongitude,
      );
      setState(() => _location = placemarks.first);
    } catch (e) {
      setState(() => _location = null);
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        Navigator.of(context).pop(widget.space);
        return Future.value(false);
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.space == null ? 'Create Space' : 'Edit Space'),
          excludeHeaderSemantics: false,
        ),
        persistentFooterButtons: [
          RaisedButton(
            child: Text('SAVE'),
            color: Theme.of(context).primaryColor,
            onPressed: () {
              if (!_formKey.currentState.validate()) return;

              var newSpace;
              if (widget.space != null) {
                newSpace = widget.space.copyWith(
                  title: _titleController.text,
                  managerPhones: _managerPhones,
                  inviterPhones: _inviterPhones,
                  guardPhones: _guardPhones,
                  imageUrl: _imageUrl,
                  locationLatitude: _location?.position?.latitude,
                  locationLongitude: _location?.position?.longitude,
                );
              } else {
                newSpace = Space(
                  title: _titleController.text,
                  managerPhones: _managerPhones,
                  inviterPhones: _inviterPhones,
                  guardPhones: _guardPhones,
                  imageUrl: _imageUrl,
                  locationLatitude: _location?.position?.latitude,
                  locationLongitude: _location?.position?.longitude,
                );
              }

              Navigator.of(context).pop(newSpace);
            },
          )
        ],
        body: _buildForm(context),
      ),
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
// TODO: uncomment to support location
//          Divider(),
//          ListTile(
//            leading: Icon(Icons.location_on),
//            trailing: Icon(Icons.chevron_right),
//            title: _location != null
//                ? Text(
//                    '${_location.subThoroughfare} ${_location.thoroughfare}',
//                  )
//                : Text(
//                    'Add Location',
//                    style: TextStyle(color: Theme.of(context).hintColor),
//                  ),
//            subtitle: _location != null
//                ? Text(
//                    '${_location.subThoroughfare} ${_location.thoroughfare}, ${_location.subLocality}, ${_location.locality}, ${_location.administrativeArea}',
//                  )
//                : null,
//            onTap: () async {
//              var apiKey;
//              if (Platform.isAndroid) apiKey = kAndroidMapsApiKey;
//              if (Platform.isIOS) apiKey = kIosMapsApiKey;
//              final result = await showLocationPicker(context, apiKey);
//              FocusScope.of(context).requestFocus(new FocusNode());
//              if (result == null) return;
//
//              final placemarks = await Geolocator().placemarkFromCoordinates(
//                result.latLng.latitude,
//                result.latLng.longitude,
//              );
//              setState(() => _location = placemarks.first);
//            },
//          ),
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
              FocusScope.of(context).requestFocus(new FocusNode());
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
              FocusScope.of(context).requestFocus(new FocusNode());
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
              FocusScope.of(context).requestFocus(new FocusNode());
            },
          ),
          Divider(),
          Visibility(
            visible: widget.space != null,
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
                  showConfirmationDialog(
                    context,
                    'All information associated with the space will be irrecoverably deleted.',
                    () => Navigator.of(context).pop(null),
                  );
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
        decoration: BoxDecoration(color: Colors.grey),
        child: Center(child: CircularProgressIndicator()),
      );
    }

    if (_imageUrl == null) {
      return Container(
        padding: EdgeInsets.all(8.0),
        height: 150.0,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/place_placeholder.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Stack(children: <Widget>[_buildUploadButton(context)]),
      );
    }

    return CachedNetworkImage(
      imageUrl: _imageUrl,
      fadeInDuration: Duration(seconds: 3),
      imageBuilder: (context, imageProvider) => Container(
        padding: EdgeInsets.all(8.0),
        height: 150.0,
        decoration: BoxDecoration(
          image: DecorationImage(image: imageProvider, fit: BoxFit.cover),
        ),
        child: Stack(children: <Widget>[_buildUploadButton(context)]),
      ),
      progressIndicatorBuilder: (context, url, progress) => Container(
        height: 150.0,
        decoration: BoxDecoration(color: Colors.grey),
        child: Center(child: CircularProgressIndicator()),
      ),
      errorWidget: (context, url, error) => Container(
        height: 150.0,
        decoration: BoxDecoration(color: Colors.grey),
        child: Center(child: CircularProgressIndicator()),
      ),
    );
  }

  Widget _buildUploadButton(BuildContext context) {
    return Builder(
      builder: (context) => Positioned(
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
    try {
      final storage = FirebaseStorage.instance;
      final ref = storage.ref().child('images/${Uuid().v4()}');
      final snapshot = await ref.putFile(image).onComplete;
      if (snapshot.error == null) {
        final url = await snapshot.ref.getDownloadURL();
        setState(() => _imageUrl = url);
      } else {
        throw Exception('Firebase storage error: ${snapshot.error}');
      }
    } catch (e) {
      print(e);
      Fluttertoast.showToast(
          msg: 'Image could not be saved', textColor: Colors.amber);
    }
    setState(() => _uploading = false);
  }
}
