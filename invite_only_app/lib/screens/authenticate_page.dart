import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:international_phone_input/international_phone_input.dart';
import 'package:invite_only/blocs/authentication/authentication_bloc.dart';
import 'package:invite_only/blocs/authentication/authentication_event.dart';
import 'package:invite_only/widgets/widgets.dart';

class AuthenticatePage extends StatelessWidget {
  final _phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
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
                    BlocProvider.of<AuthenticationBloc>(context)
                        .add(PhoneSubmitted(_phoneController.text));
                    showDialog(
                      context: context,
//                      barrierDismissible: false,
                      builder: (context) => OtpDialog(
                        phoneNumber: _phoneController.text,
                      ),
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
