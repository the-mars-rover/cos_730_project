import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:invite_only_app/blocs/auth/auth_bloc.dart';
import 'package:invite_only_app/blocs/auth/auth_event.dart';
import 'package:invite_only_app/blocs/auth/auth_state.dart';
import 'package:invite_only_app/blocs/docs/docs_bloc.dart';
import 'package:invite_only_app/blocs/docs/docs_event.dart';
import 'package:invite_only_app/blocs/docs/docs_state.dart';
import 'package:invite_only_app/widgets/other/error_message.dart';
import 'package:invite_only_app/widgets/pages/doc_page.dart';
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
      body: BlocConsumer<DocsBloc, DocsState>(
        listener: (context, state) {
          if (state is DocDeleted) {
            Fluttertoast.showToast(msg: 'Document Deleted');
          }

          if (state is AllDeleted) {
            AuthBloc.of(context).add(SignOut());
            Navigator.of(context).pop();
          }
        },
        builder: (context, state) {
          if (state is LoadingDocs) {
            return Center(child: CircularProgressIndicator());
          }

          if (state is DocsLoaded) {
            return _buildProfile(context, state);
          }

          if (state is DocsError) {
            return ErrorMessage(
              state.error,
              onRefresh: () => DocsBloc.of(context).add(LoadDocs()),
            );
          }

          if (state is AllDeleted) {
            return Center(child: CircularProgressIndicator());
          }

          return null;
        },
      ),
    );
  }

  Widget _buildProfile(BuildContext context, DocsLoaded docsState) {
    return ListView(
      children: <Widget>[
        BlocBuilder<AuthBloc, AuthState>(
          cubit: AuthBloc.of(context),
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
              DocsBloc.of(context).add(DeleteAll());
            },
          ),
        ),
      ],
    );
  }

  ListTile _buildDocTile<T extends IdDocument>(
      BuildContext context, DocsLoaded state) {
    if (T == IdCard) return _buildIdCardTile(state, context);
    if (T == IdBook) return _buildIdBookTile(state, context);
    if (T == DriversLicense) return _buildDriversTile(state, context);
    return null;
  }

  ListTile _buildIdCardTile(DocsLoaded state, BuildContext context) {
    return ListTile(
      leading: Icon(Icons.credit_card),
      title: Text('ID Card'),
      subtitle: Text(
        state.idCard != null ? 'View Document Details' : 'Scan a new document',
      ),
      trailing: state.idCard != null
          ? Icon(Icons.chevron_right)
          : Icon(Icons.camera_alt),
      onTap: () async {
        if (state.idCard != null) {
          showDocDetails(context, state.idCard);
        } else {
          final rsa = await scanIdCard(context);
          if (rsa != null)
            DocsBloc.of(context).add(SubmitDoc(DocsBloc.rsaToDocs(rsa)));
        }
      },
    );
  }

  ListTile _buildIdBookTile(DocsLoaded state, BuildContext context) {
    return ListTile(
      leading: Icon(Icons.book),
      title: Text('ID Book'),
      subtitle: Text(
        state.idBook != null ? 'View Document Details' : 'Scan a new document',
      ),
      trailing: state.idBook != null
          ? Icon(Icons.chevron_right)
          : Icon(Icons.camera_alt),
      onTap: () async {
        if (state.idBook != null) {
          showDocDetails(context, state.idBook);
        } else {
          final rsa = await scanIdBook(context);
          if (rsa != null)
            DocsBloc.of(context).add(SubmitDoc(DocsBloc.rsaToDocs(rsa)));
        }
      },
    );
  }

  ListTile _buildDriversTile(DocsLoaded state, BuildContext context) {
    return ListTile(
      leading: Icon(Icons.drive_eta),
      title: Text('Driver\'s License'),
      subtitle: Text(
        state.drivers != null ? 'View Document Details' : 'Scan a new document',
      ),
      trailing: state.drivers != null
          ? Icon(Icons.chevron_right)
          : Icon(Icons.camera_alt),
      onTap: () async {
        if (state.drivers != null) {
          showDocDetails(context, state.drivers);
        } else {
          final rsa = await scanDrivers(context);
          if (rsa != null)
            DocsBloc.of(context).add(SubmitDoc(DocsBloc.rsaToDocs(rsa)));
        }
      },
    );
  }
}
