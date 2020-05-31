import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:invite_only_app/blocs/auth/auth_bloc.dart';
import 'package:invite_only_app/blocs/auth/auth_state.dart';
import 'package:invite_only_app/blocs/docs/docs_bloc.dart';
import 'package:invite_only_app/blocs/docs/docs_event.dart';
import 'package:invite_only_app/blocs/docs/docs_state.dart';
import 'package:invite_only_app/widgets/dialogs/error_dialog.dart';
import 'package:rsa_scan/rsa_scan.dart';

Future<void> showDocsPage(BuildContext context) async {
  Navigator.of(context).push(MaterialPageRoute(builder: (_) => DocsPage()));
}

class DocsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<DocsBloc, DocsState>(
      listener: (context, state) async {
        if (state is DocsError) {
          showError(context, state.error);
        }

        if (state is DocSubmitted) {
          Scaffold.of(context).showSnackBar(SnackBar(
            content: Text('Document successfully uploaded'),
          ));
          DocsBloc.of(context).add(LoadDocs());
        }
      },
      builder: (context, state) {
        if (state is LoadingDocs) {
          return Scaffold(body: Center(child: CircularProgressIndicator()));
        }

        if (state is DocsLoaded) {
          return _buildProfileScaffold(context, state);
        }

        if (state is DocsError) {
          return Scaffold(body: Center(child: CircularProgressIndicator()));
        }

        if (state is DocSubmitted) {
          return Scaffold(body: Center(child: CircularProgressIndicator()));
        }

        return null;
      },
    );
  }

  Scaffold _buildProfileScaffold(BuildContext context, DocsLoaded state) {
    return Scaffold(
      appBar: AppBar(title: Text("My Profile")),
      body: ListView(
        children: <Widget>[
          BlocBuilder<AuthBloc, AuthState>(
            bloc: AuthBloc.of(context),
            builder: (_, state) {
              if (state is UserAuthenticated) {
                return ListTile(
                  title: Text(state.phoneNumber),
                  subtitle: Text("Phone Number"),
                );
              }

              return Container();
            },
          ),
          Divider(),
          ListTile(
            title: Text("South African ID Card"),
            subtitle: Text(
              state.idCard == null ? "Not Uploaded" : "Uploaded",
            ),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                state.idCard == null
                    ? Container()
                    : Icon(Icons.check_circle, color: Colors.green),
                IconButton(
                  icon: Icon(Icons.camera_alt),
                  onPressed: () async {
                    final scannedIdCard = await scanIdCard(context);
                    if (scannedIdCard == null) return;

                    DocsBloc.of(context).add(
                      SubmitDoc(DocsBloc.rsaToDocs(scannedIdCard)),
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
              state.idBook == null ? "Not Uploaded" : "Uploaded",
            ),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                state.idBook == null
                    ? Container()
                    : Icon(Icons.check_circle, color: Colors.green),
                IconButton(
                  icon: Icon(Icons.camera_alt),
                  onPressed: () async {
                    final scannedIdBook = await scanIdBook(context);
                    if (scannedIdBook == null) return;

                    DocsBloc.of(context).add(
                      SubmitDoc(DocsBloc.rsaToDocs(scannedIdBook)),
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
              state.driversLicense == null ? "Not Uploaded" : "Uploaded",
            ),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                state.driversLicense == null
                    ? Container()
                    : Icon(Icons.check_circle, color: Colors.green),
                IconButton(
                  icon: Icon(Icons.camera_alt),
                  onPressed: () async {
                    final scannedDrivers = await scanDrivers(context);

                    if (scannedDrivers == null) return;

                    DocsBloc.of(context).add(
                      SubmitDoc(DocsBloc.rsaToDocs(scannedDrivers)),
                    );
                  },
                ),
              ],
            ),
          ),
          Divider(),
          // TODO: Uncomment when support for passports is added
//          ListTile(
//            title: Text("Passport"),
//            subtitle: Text(
//              state.passport == null ? "Not Uploaded" : "Uploaded",
//            ),
//            trailing: Row(
//              mainAxisSize: MainAxisSize.min,
//              children: <Widget>[
//                state.passport == null
//                    ? Container()
//                    : Icon(Icons.check_circle, color: Colors.green),
//                IconButton(
//                  icon: Icon(Icons.camera_alt),
//                  onPressed: () {
//
//                  },
//                ),
//              ],
//            ),
//          ),
//          Divider(),
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
              onPressed: () {
                // TODO: Delete all user info
              },
            ),
          ),
        ],
      ),
    );
  }
}
