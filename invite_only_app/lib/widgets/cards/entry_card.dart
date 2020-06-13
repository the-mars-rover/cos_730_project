import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:invite_only_app/blocs/auth/auth_bloc.dart';
import 'package:invite_only_app/blocs/auth/auth_state.dart';
import 'package:invite_only_app/widgets/pages/entry_page.dart';
import 'package:invite_only_repo/invite_only_repo.dart';

class EntryCard extends StatelessWidget {
  final Entry entry;

  const EntryCard({Key key, @required this.entry}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      dense: true,
      title: _buildTitle(),
      subtitle: _buildSubtitle(),
      trailing: Icon(Icons.chevron_right),
      onTap: () => showEntryDetails(context, entry),
    );
  }

  Widget _buildTitle() {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        if (state is UserAuthenticated) {
          final entryDoc = entry.idDocument;

          if (entryDoc is IdBook) {
            return Text('ID Number: ${entryDoc.idNumber}');
          }

          if (entryDoc is IdCard) {
            return Text('${entryDoc.firstNames} ${entryDoc.surname}');
          }

          if (entryDoc is DriversLicense) {
            return Text('${entryDoc.firstNames} ${entryDoc.surname}');
          }

          if (entryDoc is Passport) {
            return Text('ID Number: ${entryDoc.idNumber}');
          }
        }

        return null;
      },
    );
  }

  Widget _buildSubtitle() {
    return Text('Entered on ${formatDate(
      entry.entryDate,
      [D, ' ', d, ' ', M, ' at ', HH, ':', nn],
    )}');
  }
}
