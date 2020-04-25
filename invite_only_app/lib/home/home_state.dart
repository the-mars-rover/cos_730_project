import 'package:equatable/equatable.dart';
import 'package:invite_only_repo/invite_only_repo.dart';

abstract class HomeState extends Equatable {
  const HomeState();
}

class HomeLoading extends HomeState {
  @override
  List<Object> get props => [];
}

class HomeReady extends HomeState {
  final Stream<User> userStream;
  final Stream<List<Space>> spacesStream;

  HomeReady(this.userStream, this.spacesStream);

  @override
  List<Object> get props => [userStream, spacesStream];
}
