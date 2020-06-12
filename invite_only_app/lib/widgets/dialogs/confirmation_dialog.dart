import 'package:flutter/material.dart';

Future<void> showConfirmationDialog(
    BuildContext context, String message, Function onConfirm) async {
  await showDialog(
    context: context,
    builder: (_) => ConfirmationDialog(message: message, onConfirm: onConfirm),
  );
}

class ConfirmationDialog extends StatelessWidget {
  final Function onConfirm;
  final String message;

  const ConfirmationDialog({Key key, this.message, this.onConfirm})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Are you sure?'),
      content: Text(message),
      actions: <Widget>[
        OutlineButton(
          child: Text('Cancel'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        OutlineButton(
          child: Text('Confirm'),
          onPressed: () {
            Navigator.of(context).pop();
            onConfirm();
          },
        ),
      ],
    );
  }
}
