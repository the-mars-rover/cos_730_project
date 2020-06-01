import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:invite_only_app/blocs/auth/auth_bloc.dart';
import 'package:invite_only_app/blocs/auth/auth_state.dart';
import 'package:invite_only_app/blocs/docs/docs_bloc.dart';
import 'package:invite_only_app/blocs/docs/docs_event.dart';
import 'package:invite_only_app/blocs/docs/docs_state.dart';
import 'package:invite_only_app/widgets/dialogs/error_dialog.dart';
import 'package:invite_only_repo/invite_only_repo.dart';
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

  Scaffold _buildProfileScaffold(BuildContext context, DocsLoaded docsState) {
    return Scaffold(
      appBar: AppBar(title: Text("My Profile")),
      body: ListView(
        children: <Widget>[
          BlocBuilder<AuthBloc, AuthState>(
            bloc: AuthBloc.of(context),
            builder: (context, state) {
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
          _buildDocTile<IdCard>(context, docsState),
          Divider(),
          _buildDocTile<IdBook>(context, docsState),
          Divider(),
          _buildDocTile<DriversLicense>(context, docsState),
          Divider(),
          // TODO: Uncomment when support for passports is added
//          _buildDocTile<Passport>(context, docsState),
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

  ListTile _buildDocTile<T extends IdDocument>(
      BuildContext context, DocsLoaded state) {
    bool uploaded = false;
    if (T == IdCard) uploaded = state.idCard != null;
    if (T == IdBook) uploaded = state.idBook != null;
    if (T == DriversLicense) uploaded = state.driversLicense != null;
    if (T == Passport) uploaded = state.passport != null;

    return ListTile(
      title: Builder(builder: (context) {
        if (T == IdCard) return Text('ID Card');
        if (T == IdBook) return Text('ID Book');
        if (T == DriversLicense) return Text('Drivers License');
        if (T == Passport) return Text('Passport');
        return null;
      }),
      subtitle: Text(
        !uploaded == null ? "Not Uploaded" : "Uploaded",
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: !uploaded
            ? [
                IconButton(
                  icon: Icon(Icons.camera_alt),
                  onPressed: () async {
                    var rsa;
                    if (T == IdCard) rsa = await scanIdCard(context);
                    if (T == IdBook) rsa = await scanIdBook(context);
                    if (T == DriversLicense) rsa = await scanDrivers(context);
                    if (T == Passport) rsa = await scanId(context);

                    if (rsa == null) return;
                    DocsBloc.of(context).add(
                      SubmitDoc(DocsBloc.rsaToDocs(rsa)),
                    );
                  },
                ),
              ]
            : [
                Icon(Icons.check_circle, color: Colors.green),
                IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () async {
                    if (T == IdCard)
                      DocsBloc.of(context).add(DeleteDoc(state.idCard));
                    if (T == IdBook)
                      DocsBloc.of(context).add(DeleteDoc(state.idBook));
                    if (T == DriversLicense)
                      DocsBloc.of(context).add(DeleteDoc(state.driversLicense));
                    if (T == Passport)
                      DocsBloc.of(context).add(DeleteDoc(state.passport));
                  },
                ),
              ],
      ),
    );
  }
}
