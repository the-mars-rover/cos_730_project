import 'package:invite_only_auth/invite_only_auth.dart';
import 'package:meta/meta.dart';

@immutable
abstract class AuthenticationState {}

class InitialAuthenticationState extends AuthenticationState {}

class AuthenticationInProgress extends AuthenticationState {}

class UserAuthenticated extends AuthenticationState {
  final User user;

  UserAuthenticated(this.user);
}

class AuthenticationFailed extends AuthenticationState {
  final String errorMessage;

  AuthenticationFailed(this.errorMessage);
}