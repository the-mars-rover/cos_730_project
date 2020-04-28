import 'package:meta/meta.dart';

@immutable
abstract class AuthenticationEvent {}

class SignIn extends AuthenticationEvent {
  final authCredential;

  SignIn(this.authCredential);
}
