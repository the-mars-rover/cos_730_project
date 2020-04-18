import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:invite_only/app/app.dart';
import 'package:invite_only/profile/profile.dart';
import 'package:invite_only_docs/invite_only_docs.dart';
import 'package:rsa_scan/rsa_scan.dart';

class UserProfilePage extends StatelessWidget {
  static const ROUTE = '/profile';

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ProfileBloc>(
      create: (context) => ProfileBloc()..add(LoadProfileDetails()),
      child: BlocBuilder<ProfileBloc, ProfileState>(builder: (context, state) {
        if (state is LoadingProfileDetails) {
          return LoadingScaffold();
        }

        if (state is ProfileDetailsLoaded) {
          return _buildProfileScaffold(state);
        }

        if (state is UploadingDocument) {
          return LoadingScaffold();
        }

        return null;
      }),
    );
  }

  Scaffold _buildProfileScaffold(ProfileDetailsLoaded state) {
    return Scaffold(
      appBar: AppBar(title: Text("My Profile")),
      body: StreamBuilder<DocumentedUser>(
        stream: state.documentedUserStream,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }

          final documentedUser = snapshot.data;
          return ListView(
            children: <Widget>[
              ListTile(
                title: Text(state.user.phoneNumber),
                subtitle: Text("Phone Number"),
              ),
              Divider(),
              ListTile(
                title: Text("South African ID Card"),
                subtitle: Text(
                  documentedUser.idCard == null ? "Not Uploaded" : "Uploaded",
                ),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    documentedUser.idCard == null
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
                          UploadIdCard(scannedIdCard),
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
                  documentedUser.idBook == null ? "Not Uploaded" : "Uploaded",
                ),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    documentedUser.idBook == null
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
                          UploadIdBook(scannedIdBook),
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
                  documentedUser.driversLicense == null
                      ? "Not Uploaded"
                      : "Uploaded",
                ),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    documentedUser.driversLicense == null
                        ? Container()
                        : Icon(
                            Icons.check_circle,
                            color: Colors.green,
                          ),
                    IconButton(
                      icon: Icon(Icons.camera_alt),
                      onPressed: () {},
                    ),
                  ],
                ),
              ),
              Divider(),
              ListTile(
                title: Text("Passport"),
                subtitle: Text(
                  documentedUser.passport == null ? "Not Uploaded" : "Uploaded",
                ),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    documentedUser.passport == null
                        ? Container()
                        : Icon(
                            Icons.check_circle,
                            color: Colors.green,
                          ),
                    IconButton(
                      icon: Icon(Icons.camera_alt),
                      onPressed: () {},
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
