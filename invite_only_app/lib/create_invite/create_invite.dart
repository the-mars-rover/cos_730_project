import 'package:flutter/material.dart';
import 'package:invite_only_spaces/invite_only_spaces.dart';

import 'create_invite_dialog.dart';

/// Creates and displays an invite for the given space.
Future<void> createInvite(BuildContext context, ControlledSpace space) async {
  await showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) => CreateInviteDialog(space: space),
  );
}