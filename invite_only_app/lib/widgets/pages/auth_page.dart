import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:international_phone_input/international_phone_input.dart';
import 'package:invite_only_app/blocs/auth/auth_bloc.dart';
import 'package:invite_only_app/blocs/auth/auth_event.dart';
import 'package:invite_only_app/blocs/auth/auth_state.dart';
import 'package:invite_only_app/widgets/other/error_message.dart';

class AuthPage extends StatelessWidget {
  final _phoneController = TextEditingController();
  final _otpController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        if (state is AuthUninitialized) {
          return Container();
        }

        if (state is AuthInProgress) {
          return Scaffold(body: Center(child: CircularProgressIndicator()));
        }

        if (state is UserUnauthenticated) {
          return _buildPhoneScaffold(context);
        }

        if (state is SmsCodeSent) {
          return _buildSmsCodeScaffold(context, state);
        }

        if (state is UserAuthenticated) {
          return Scaffold(body: Center(child: CircularProgressIndicator()));
        }

        if (state is AuthFailed) {
          return ErrorMessage(state.errorMessage,
              onRefresh: () => AuthBloc.of(context).add(InitializeAuth()));
        }

        return null;
      },
    );
  }

  Scaffold _buildPhoneScaffold(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SizedBox(
          width: 250.0,
          height: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image.asset('assets/logo_v4.png', height: 200.0),
              Container(height: 32.0),
              Text("Phone Number"),
              InternationalPhoneInput(
                initialPhoneNumber: _phoneController.text,
                onPhoneNumberChange:
                    (phoneNumber, internationalizedPhoneNumber, isoCode) {
                  _phoneController.text = internationalizedPhoneNumber;
                },
                hintText: "eg. 0815029249",
                initialSelection: "+27",
                errorText: "Invalid Phone Number",
              ),
              Container(height: 8.0),
              SizedBox(
                width: double.infinity,
                child: RaisedButton(
                  child: Text("VERIFY"),
                  color: Theme.of(context).primaryColor,
                  onPressed: () async {
                    AuthBloc.of(context).add(
                      SendSmsCode(_phoneController.text),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Scaffold _buildSmsCodeScaffold(BuildContext context, SmsCodeSent state) {
    return Scaffold(
      body: Center(
        child: SizedBox(
          width: 250.0,
          height: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image.asset(
                'assets/logo_v4.png',
                height: 200.0,
              ),
              Container(height: 32.0),
              Text('Enter the code sent to ${state.phoneNumber}'),
              TextFormField(
                controller: _otpController,
                autofocus: true,
                textAlign: TextAlign.center,
                keyboardType: TextInputType.number,
                style: TextStyle(letterSpacing: 24.0),
                decoration: InputDecoration(
                  hintText: '000000',
                  hintStyle: TextStyle(letterSpacing: 24.0),
                  counterText: '',
                ),
                maxLength: 6,
              ),
              Container(height: 8.0),
              SizedBox(
                width: double.infinity,
                child: RaisedButton(
                  child: Text("SUBMIT"),
                  color: Theme.of(context).primaryColor,
                  onPressed: () {
                    AuthBloc.of(context).add(
                      SubmitSmsCode(_otpController.text),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
