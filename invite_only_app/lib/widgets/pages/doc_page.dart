import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:invite_only_app/blocs/docs/docs_bloc.dart';
import 'package:invite_only_app/blocs/docs/docs_event.dart';
import 'package:invite_only_app/widgets/cards/drivers_card.dart';
import 'package:invite_only_app/widgets/cards/id_book_card.dart';
import 'package:invite_only_app/widgets/cards/id_card_card.dart';
import 'package:invite_only_app/widgets/cards/passport_card.dart';
import 'package:invite_only_repo/invite_only_repo.dart';

Future<void> showDocDetails(BuildContext context, IdDocument document) async {
  await Navigator.of(context).push(
    MaterialPageRoute(builder: (context) => DocPage(document: document)),
  );
}

class DocPage extends StatelessWidget {
  final IdDocument document;

  const DocPage({Key key, this.document}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Document Details')),
      body: ListView(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: _buildIdentityCard(context),
          ),
          ListTile(
            title: OutlineButton.icon(
              icon: Icon(
                Icons.delete,
                color: Colors.orange,
              ),
              label: Text(
                "DELETE DOCUMENT",
                style: TextStyle(color: Colors.orange),
              ),
              borderSide: BorderSide(color: Colors.orange),
              highlightedBorderColor: Colors.orange,
              onPressed: () {
                DocsBloc.of(context).add(DeleteDoc(document));
                Navigator.of(context).pop();
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildIdentityCard(BuildContext context) {
    if (document is IdBook) {
      return IdBookCard(document);
    }

    if (document is IdCard) {
      return IdCardCard(document);
    }

    if (document is DriversLicense) {
      return DriversCard(document);
    }

    if (document is Passport) {
      return PassportCard(document);
    }

    return null;
  }
}
