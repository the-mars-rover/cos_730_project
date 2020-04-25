import 'package:equatable/equatable.dart';

abstract class GrantAccessState extends Equatable {
  const GrantAccessState();
}

class GrantingAccess extends GrantAccessState {
  @override
  List<Object> get props => [];
}

class RequireCode extends GrantAccessState {
  @override
  List<Object> get props => [];
}

class AccessGranted extends GrantAccessState {
  @override
  List<Object> get props => [];
}

class AccessDenied extends GrantAccessState {
  final Exception e;

  AccessDenied(this.e);

  @override
  List<Object> get props => [];
}
