import 'package:equatable/equatable.dart';
import 'package:invite_only_repo/invite_only_repo.dart';

abstract class EntriesState extends Equatable {
  const EntriesState();
}

class InitialEntriesLoading extends EntriesState {
  @override
  List<Object> get props => [];
}

class EntriesLoaded extends EntriesState {
  final Space space;
  final int page;
  final List<Entry> entries;
  final bool hasReachedMax;

  EntriesLoaded(this.space, this.page, this.entries, this.hasReachedMax);

  @override
  List<Object> get props =>
      [this.space, this.page, this.entries, this.hasReachedMax];
}

class EntriesError extends EntriesState {
  final String error;

  EntriesError(this.error);

  @override
  List<Object> get props => [this.error];
}
