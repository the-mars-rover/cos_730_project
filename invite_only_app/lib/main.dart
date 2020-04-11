import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:invite_only/blocs/authentication/bloc.dart';
import 'package:invite_only/screens/screens.dart';

void main() {
  runApp(
    InviteOnlyApp(),
  );
}

class InviteOnlyApp extends StatelessWidget {
  const InviteOnlyApp({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthenticationBloc>(
          create: (context) {
            return AuthenticationBloc();
          },
        )
      ],
      child: MaterialApp(
        title: 'Invite Only',
        theme: ThemeData(primarySwatch: Colors.green),
        routes: {
          '/': (context) {
            return BlocBuilder<AuthenticationBloc, AuthenticationState>(
              builder: (context, state) {
                if (!(state is AuthSuccess)) {
                  return AuthenticatePage();
                }

                return UserHomePage();
              },
            );
          },
        },
      ),
    );
  }
}
