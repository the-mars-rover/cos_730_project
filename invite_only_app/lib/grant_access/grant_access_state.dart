import 'package:equatable/equatable.dart';

abstract class GrantAccessState extends Equatable {
  const GrantAccessState();
}

class InitialGrantAccessState extends GrantAccessState {
  @override
  List<Object> get props => [];
}

class GrantingAccess extends GrantAccessState {
  @override
  List<Object> get props => [];
}

class AccessGranted extends GrantAccessState {
  @override
  List<Object> get props => [];
}

class AccessDenied extends GrantAccessState {
  @override
  List<Object> get props => [];
}
