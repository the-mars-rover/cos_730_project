import 'package:equatable/equatable.dart';
import 'package:invite_only_auth/invite_only_auth.dart';
import 'package:invite_only_spaces/invite_only_spaces.dart';

abstract class HomeState extends Equatable {
  const HomeState();
}

class HomeLoading extends HomeState {
  @override
  List<Object> get props => [];
}

class HomeReady extends HomeState {
  final User currentUser;
  final Stream<List<ControlledSpace>> managedSpacesStream;
  final Stream<List<ControlledSpace>> guardingSpacesStream;
  final Stream<List<ControlledSpace>> invitingSpacesStream;

  HomeReady(
    this.currentUser,
    this.managedSpacesStream,
    this.guardingSpacesStream,
    this.invitingSpacesStream,
  );

  @override
  List<Object> get props => [
        currentUser,
        managedSpacesStream,
        guardingSpacesStream,
        invitingSpacesStream,
      ];
}
