import 'package:meta/meta.dart';

@immutable
abstract class AuthEvent {}

class InitializeAuth extends AuthEvent {}

class SignIn extends AuthEvent {
  final authCredential;

  SignIn(this.authCredential);
}
