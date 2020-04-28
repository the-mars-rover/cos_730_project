import 'package:equatable/equatable.dart';
import 'package:invite_only_repo/invite_only_repo.dart';

abstract class SpaceDetailsState extends Equatable {
  const SpaceDetailsState();
}

class SpaceDetailsLoading extends SpaceDetailsState {
  @override
  List<Object> get props => [];
}

class SpaceDetailsLoaded extends SpaceDetailsState {
  final Stream<User> userStream;
  final Stream<List<Access>> accessesStream;

  SpaceDetailsLoaded(this.userStream, this.accessesStream);

  @override
  List<Object> get props => [this.userStream, this.accessesStream];
}
