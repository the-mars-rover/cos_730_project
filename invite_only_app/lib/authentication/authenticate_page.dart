import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:international_phone_input/international_phone_input.dart';
import 'package:invite_only/app/app.dart';
import 'package:invite_only/home/home.dart';
import 'package:invite_only/phone_verification/phone_verification.dart';

import 'authentication.dart';

class AuthenticatePage extends StatelessWidget {
  static const String ROUTE = '/authenticate';

  final _phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AuthenticationBloc>(
      create: (context) => AuthenticationBloc()..add(AuthInit()),
      child: BlocConsumer<AuthenticationBloc, AuthenticationState>(
        listener: (context, state) {
          if (state is AuthenticationFailed) {
            showDialog(
              context: context,
              builder: (context) => ErrorDialog(message: state.errorMessage),
            );
          }

          if (state is UserAuthenticated) {
            Navigator.of(context).pushNamedAndRemoveUntil(
              UserHomePage.ROUTE,
              (route) => false,
            );
          }
        },
        builder: (context, state) {
          if (state is InitialAuthenticationState) {
            return _buildScaffold(context);
          }

          if (state is AuthenticationInProgress) {
            return LoadingScaffold();
          }

          if (state is UserAuthenticated) {
            // irrelevant due to re-navigation
            return LoadingScaffold();
          }

          if (state is AuthenticationFailed) {
            return _buildScaffold(context);
          }

          return null;
        },
      ),
    );
  }

  Scaffold _buildScaffold(BuildContext context) {
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
              Text("Phone Number"),
              InternationalPhoneInput(
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
                  child: Text("SUBMIT"),
                  color: Theme.of(context).primaryColor,
                  onPressed: () async {
                    var authCredential = await showDialog(
                      context: context,
                      barrierDismissible: false,
                      builder: (context) => PhoneVerificationDialog(
                        phoneNumber: _phoneController.text,
                      ),
                    );

                    if (authCredential != null) {
                      BlocProvider.of<AuthenticationBloc>(context)
                          .add(SignIn(authCredential));
                    }
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
