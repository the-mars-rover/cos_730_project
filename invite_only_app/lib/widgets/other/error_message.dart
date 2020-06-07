import 'package:flutter/material.dart';

class ErrorMessage extends StatelessWidget {
  final String message;
  final Function onRetry;

  const ErrorMessage(this.message, {Key key, @required this.onRetry})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(64.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Icon(Icons.error_outline, color: Colors.amber, size: 64.0),
              Container(height: 24.0),
              Text(
                'Oops, an error occurred!',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.subtitle1,
              ),
              Container(height: 16.0),
              Text(message, textAlign: TextAlign.center),
              FlatButton(
                child: Text(
                  'Try Again',
                  style: TextStyle(color: Theme.of(context).primaryColor),
                ),
                onPressed: onRetry,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
