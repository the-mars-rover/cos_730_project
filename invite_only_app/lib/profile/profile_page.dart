import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:invite_only_app/app/app.dart';
import 'package:invite_only_repo/invite_only_repo.dart';
import 'package:rsa_scan/rsa_scan.dart';

import 'profile_bloc.dart';
import 'profile_event.dart';
import 'profile_state.dart';

class UserProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<ProfileBloc>(
      create: (context) => ProfileBloc()..add(LoadProfileDetails()),
      child: BlocConsumer<ProfileBloc, ProfileState>(
        listener: (context, state) async {
          if (state is DocumentUploadError) {
            showErrorDialog(context, 'The scanned document is not valid');
          }
        },
        builder: (context, state) {
          if (state is LoadingProfileDetails) {
            return Scaffold(body: Center(child: CircularProgressIndicator()));
          }

          if (state is ProfileDetailsLoaded) {
            return _buildProfileScaffold(state);
          }

          if (state is UploadingDocument) {
            return Scaffold(body: Center(child: CircularProgressIndicator()));
          }

          if (state is DocumentUploadError) {
            return _buildProfileScaffold(state);
          }

          return null;
        },
      ),
    );
  }

  Scaffold _buildProfileScaffold(state) {
    return Scaffold(
      appBar: AppBar(title: Text("My Profile")),
      body: StreamBuilder<User>(
        stream: state.userStream,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }

          final user = snapshot.data;
          return ListView(
            children: <Widget>[
              ListTile(
                title: Text(user.phoneNumber),
                subtitle: Text("Phone Number"),
              ),
              Divider(),
              ListTile(
                title: Text("South African ID Card"),
                subtitle: Text(
                  user.idCard == null ? "Not Uploaded" : "Uploaded",
                ),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    user.idCard == null
                        ? Container()
                        : Icon(
                            Icons.check_circle,
                            color: Colors.green,
                          ),
                    IconButton(
                      icon: Icon(Icons.camera_alt),
                      onPressed: () async {
                        final scannedIdCard = await scanIdCard(context);

                        if (scannedIdCard == null) return;

                        BlocProvider.of<ProfileBloc>(context).add(
                          UpdateUser(
                            user.copyWith(idCard: rsaToDocs(scannedIdCard)),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
              Divider(),
              ListTile(
                title: Text("South African ID Book"),
                subtitle: Text(
                  user.idBook == null ? "Not Uploaded" : "Uploaded",
                ),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    user.idBook == null
                        ? Container()
                        : Icon(
                            Icons.check_circle,
                            color: Colors.green,
                          ),
                    IconButton(
                      icon: Icon(Icons.camera_alt),
                      onPressed: () async {
                        final scannedIdBook = await scanIdBook(context);

                        if (scannedIdBook == null) return;

                        BlocProvider.of<ProfileBloc>(context).add(
                          UpdateUser(
                            user.copyWith(idBook: rsaToDocs(scannedIdBook)),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
              Divider(),
              ListTile(
                title: Text("South African Driver's License"),
                subtitle: Text(
                  user.driversLicense == null ? "Not Uploaded" : "Uploaded",
                ),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    user.driversLicense == null
                        ? Container()
                        : Icon(
                            Icons.check_circle,
                            color: Colors.green,
                          ),
                    IconButton(
                      icon: Icon(Icons.camera_alt),
                      onPressed: () async {
                        final scannedDrivers = await scanDrivers(context);

                        if (scannedDrivers == null) return;

                        BlocProvider.of<ProfileBloc>(context).add(
                          UpdateUser(
                            user.copyWith(
                                driversLicense: rsaToDocs(scannedDrivers)),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
              Divider(),
              ListTile(
                title: Text("Passport"),
                subtitle: Text(
                  user.passport == null ? "Not Uploaded" : "Uploaded",
                ),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    user.passport == null
                        ? Container()
                        : Icon(
                            Icons.check_circle,
                            color: Colors.green,
                          ),
                    IconButton(
                      icon: Icon(Icons.camera_alt),
                      onPressed: () {
                        //Todo: add support for passports
                      },
                    ),
                  ],
                ),
              ),
              Divider(),
              ListTile(
                title: OutlineButton.icon(
                  icon: Icon(
                    Icons.delete,
                    color: Colors.red,
                  ),
                  label: Text(
                    "DELETE MY PROFILE",
                    style: TextStyle(color: Colors.red),
                  ),
                  borderSide: BorderSide(color: Colors.red),
                  highlightedBorderColor: Colors.red,
                  onPressed: () {},
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
