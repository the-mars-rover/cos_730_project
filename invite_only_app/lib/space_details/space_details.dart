import 'package:flutter/material.dart';
import 'package:invite_only/space_details/space_page.dart';
import 'package:invite_only_spaces/invite_only_spaces.dart';

/// Show the user the details of the given space.
Future<void> showSpaceDetails(
    BuildContext context, ControlledSpace space) async {
  await Navigator.of(context).push(
    MaterialPageRoute(builder: (context) => SpacePage(space: space)),
  );
}
