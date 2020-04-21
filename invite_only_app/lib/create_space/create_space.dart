import 'package:flutter/material.dart';

import 'create_space_page.dart';

/// Provide the user with the interface to create a new access-controlled space.
Future<void> createSpace(BuildContext context) async {
  await Navigator.of(context).push(
    MaterialPageRoute(builder: (context) => CreateSpacePage()),
  );
}
