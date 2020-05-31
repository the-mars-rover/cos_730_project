import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:international_phone_input/international_phone_input.dart';
import 'package:invite_only_app/blocs/auth/auth_bloc.dart';
import 'package:invite_only_app/blocs/auth/auth_event.dart';
import 'package:invite_only_app/blocs/auth/auth_state.dart';
import 'package:invite_only_app/widgets/dialogs/error_dialog.dart';
import 'package:invite_only_app/widgets/dialogs/phone_verification_dialog.dart';

class AuthPage extends StatelessWidget {
  final _phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) async {
        if (state is AuthFailed) {
          await showError(context, "Auth Failed. Pleasy Try Again.");
          AuthBloc.of(context).add(InitializeAuth());
        }
      },
      builder: (context, state) {
        if (state is UserUnauthenticated) {
          return _buildScaffold(context);
        }

        if (state is AuthInProgress) {
          return Scaffold(body: Center(child: CircularProgressIndicator()));
        }

        if (state is UserAuthenticated) {
          return Scaffold(body: Center(child: CircularProgressIndicator()));
        }

        if (state is AuthFailed) {
          return Scaffold(body: Center(child: CircularProgressIndicator()));
        }

        return null;
      },
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
                    var authCredential = await verifyPhoneNumber(
                      context,
                      _phoneController.text,
                    );

                    if (authCredential != null) {
                      AuthBloc.of(context).add(SignIn(authCredential));
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
