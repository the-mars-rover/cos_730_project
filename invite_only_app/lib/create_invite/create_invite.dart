import 'package:flutter/material.dart';
import 'package:invite_only_repo/invite_only_repo.dart';

import 'create_invite_dialog.dart';

/// Creates and displays an invite for the given space.
Future<void> createInvite(BuildContext context, Space space) async {
  await showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) => CreateInviteDialog(space: space),
  );
}
