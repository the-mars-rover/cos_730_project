import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:invite_only/app/app.dart';

import 'phone_verification_bloc.dart';
import 'phone_verification_event.dart';
import 'phone_verification_state.dart';

class PhoneVerificationDialog extends StatelessWidget {
  final String _phoneNumber;

  final TextEditingController _otpController = TextEditingController();

  PhoneVerificationDialog({Key key, @required phoneNumber})
      : this._phoneNumber = phoneNumber,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<PhoneVerificationBloc>(
      create: (context) =>
          PhoneVerificationBloc()..add(SendSmsCode(_phoneNumber)),
      child: BlocConsumer<PhoneVerificationBloc, PhoneVerificationState>(
        listener: (context, state) {
          if (state is PhoneNumberVerified) {
            Navigator.of(context).pop(state.authCredential);
          }
        },
        builder: (context, state) {
          if (state is SendingSmsCode) {
            return Center(child: CircularProgressIndicator());
          }

          if (state is SmsCodeSent) {
            return _buildSmsCodeDialog(context);
          }

          if (state is ValidatingSmsCode) {
            return Center(child: CircularProgressIndicator());
          }

          if (state is PhoneNumberVerified) {
            // irrelevant - dialog will be popped.
            return Center(child: CircularProgressIndicator());
          }

          if (state is PhoneVerificationError) {
            return ErrorDialog(message: state.errorMessage);
          }

          return null;
        },
      ),
    );
  }

  AlertDialog _buildSmsCodeDialog(BuildContext context) {
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
            BlocProvider.of<PhoneVerificationBloc>(context)
                .add(SubmitSmsCode(_otpController.text));
          },
        ),
      ],
    );
  }
}
