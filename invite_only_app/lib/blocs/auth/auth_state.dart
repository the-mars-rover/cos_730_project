import 'package:meta/meta.dart';

@immutable
abstract class AuthState {}

class AuthUninitialized extends AuthState {}

class AuthInProgress extends AuthState {}

class UserUnauthenticated extends AuthState {}

class UserAuthenticated extends AuthState {
  final String phoneNumber;

  UserAuthenticated(this.phoneNumber);
}

class AuthFailed extends AuthState {
  final String errorMessage;

  AuthFailed(this.errorMessage);
}
