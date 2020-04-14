import 'package:meta/meta.dart';

@immutable
abstract class AuthenticationEvent {}

class AuthInit extends AuthenticationEvent {}

class SignIn extends AuthenticationEvent {
  final authCredential;

  SignIn(this.authCredential);
}