import 'package:equatable/equatable.dart';
import 'package:invite_only_auth/invite_only_auth.dart';
import 'package:invite_only_spaces/invite_only_spaces.dart';

abstract class SpaceDetailsState extends Equatable {
  const SpaceDetailsState();
}

class SpaceDetailsLoading extends SpaceDetailsState {
  @override
  List<Object> get props => [];
}

class SpaceDetailsLoaded extends SpaceDetailsState {
  final User currentUser;
  final Stream<List<Access>> accessesStream;

  SpaceDetailsLoaded(this.currentUser, this.accessesStream);

  @override
  List<Object> get props => [currentUser, accessesStream];
}
