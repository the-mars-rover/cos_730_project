import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:invite_only_app/blocs/auth/auth_bloc.dart';
import 'package:invite_only_app/blocs/auth/auth_state.dart';
import 'package:invite_only_app/blocs/docs/docs_bloc.dart';
import 'package:invite_only_app/blocs/docs/docs_event.dart';
import 'package:invite_only_app/blocs/docs/docs_state.dart';
import 'package:invite_only_app/widgets/dialogs/confirmation_dialog.dart';
import 'package:invite_only_app/widgets/other/error_message.dart';
import 'package:invite_only_repo/invite_only_repo.dart';
import 'package:rsa_scan/rsa_scan.dart';

Future<void> showDocsPage(BuildContext context) async {
  Navigator.of(context).push(MaterialPageRoute(builder: (_) => DocsPage()));
}

class DocsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('My Profile')),
      body: BlocBuilder<DocsBloc, DocsState>(
        builder: (context, state) {
          if (state is LoadingDocs) {
            return Center(child: CircularProgressIndicator());
          }

          if (state is DocsLoaded) {
            return _buildProfileScaffold(context, state);
          }

          if (state is DocsError) {
            return ErrorMessage(
              state.error,
              onRetry: () => DocsBloc.of(context).add(LoadDocs()),
            );
          }

          return null;
        },
      ),
    );
  }

  Widget _buildProfileScaffold(BuildContext context, DocsLoaded docsState) {
    return ListView(
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

            return null;
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
      leading: Builder(builder: (context) {
        if (T == IdCard) return Icon(Icons.credit_card);
        if (T == IdBook) return Icon(Icons.book);
        if (T == DriversLicense) return Icon(Icons.drive_eta);
        if (T == Passport) return Icon(Icons.airplanemode_active);
        return null;
      }),
      title: Builder(builder: (context) {
        if (T == IdCard) return Text('ID Card');
        if (T == IdBook) return Text('ID Book');
        if (T == DriversLicense) return Text('Drivers License');
        if (T == Passport) return Text('Passport');
        return null;
      }),
      subtitle: Text(
        uploaded ? 'Remove the existing document' : 'Scan a new document',
      ),
      trailing: Builder(builder: (context) {
        if (uploaded) {
          return IconButton(
            icon: Icon(Icons.delete),
            onPressed: () async {
              showConfirmationDialog(
                context,
                'Deleting this document will remove it from your account.',
                () {
                  if (T == IdCard)
                    DocsBloc.of(context).add(DeleteDoc(state.idCard));
                  if (T == IdBook)
                    DocsBloc.of(context).add(DeleteDoc(state.idBook));
                  if (T == DriversLicense)
                    DocsBloc.of(context).add(DeleteDoc(state.driversLicense));
                  if (T == Passport)
                    DocsBloc.of(context).add(DeleteDoc(state.passport));
                },
              );
            },
          );
        } else {
          return IconButton(
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
          );
        }
      }),
    );
  }
}
