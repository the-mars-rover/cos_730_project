import 'package:flutter/material.dart';
import 'package:invite_only_app/space_details/space_page.dart';
import 'package:invite_only_repo/invite_only_repo.dart';

/// Show the user the details of the given space.
Future<void> showSpaceDetails(BuildContext context, Space space) async {
  await Navigator.of(context).push(
    MaterialPageRoute(builder: (context) => SpacePage(space: space)),
  );
}
