import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:invite_only/blocs/authentication/authentication_bloc.dart';
import 'package:invite_only/blocs/authentication/authentication_event.dart';
import 'package:invite_only/blocs/authentication/authentication_state.dart';

class OtpDialog extends StatelessWidget {
  final String _phoneNumber;

  final TextEditingController _otpController = TextEditingController();

  OtpDialog({Key key, @required phoneNumber})
      : this._phoneNumber = phoneNumber,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthenticationBloc, AuthenticationState>(
      listener: (context, state) {
        if (state is AuthSuccess) {
          Navigator.of(context).pop();
        }
      },
      builder: (context, state) {
        if (state is AuthLoading) {
          return Center(child: CircularProgressIndicator());
        }

        if (state is SendOtpSuccess) {
          return AlertDialog(
            title: Text(
              "Verify Phone Number",
              textAlign: TextAlign.center,
            ),
            content: Padding(
              padding: EdgeInsets.only(top: 8.0, left: 16.0, right: 16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text(
                    'Enter the code sent to $_phoneNumber',
                    textAlign: TextAlign.center,
                  ),
                  TextFormField(
                    controller: _otpController,
                    autofocus: true,
                    textAlign: TextAlign.center,
                    keyboardType: TextInputType.number,
                    style: TextStyle(letterSpacing: 24.0),
                    decoration: InputDecoration(
                      hintText: '000000',
                      hintStyle: TextStyle(letterSpacing: 24.0),
                    ),
                    maxLength: 6,
                  ),
                ],
              ),
            ),
            actions: <Widget>[
              FlatButton(
                child: Text('Cancel'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              FlatButton(
                child: Text('Submit'),
                onPressed: () {
                  BlocProvider.of<AuthenticationBloc>(context)
                      .add(OtpSubmitted(_otpController.text));
                },
              ),
            ],
          );
        }

        if (state is AuthFailure) {
          return AlertDialog(
            title: Text(
              "Authentication failed",
              textAlign: TextAlign.center,
            ),
            content: Padding(
              padding: EdgeInsets.only(top: 8.0, left: 16.0, right: 16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text(
                    '$_phoneNumber could not be validated. Please try again later.',
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
            actions: <Widget>[
              FlatButton(
                child: Text('Close'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        }

        return Container();
      },
    );
  }
}
