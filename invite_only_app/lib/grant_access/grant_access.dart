import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:invite_only/grant_access/grant_access_dialog.dart';
import 'package:invite_only_repo/invite_only_repo.dart';
import 'package:rsa_scan/rsa_scan.dart';

Future<void> grantAccess(
    BuildContext context, Space space, RsaIdDocument scannedIdDocument) async {
  await showDialog(
    context: context,
    builder: (context) {
      return GrantAccessDialog(
        space: space,
        scannedIdDocument: scannedIdDocument,
      );
    },
  );
}