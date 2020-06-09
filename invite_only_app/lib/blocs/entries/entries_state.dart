import 'package:equatable/equatable.dart';
import 'package:invite_only_repo/invite_only_repo.dart';

abstract class EntriesState extends Equatable {
  const EntriesState();
}

class EntriesLoading extends EntriesState {
  @override
  List<Object> get props => [];
}

class EntriesLoaded extends EntriesState {
  final List<Entry> entries;

  EntriesLoaded(this.entries);

  @override
  List<Object> get props => [this.entries];
}

class EntriesError extends EntriesState {
  final String error;

  EntriesError(this.error);

  @override
  List<Object> get props => [this.error];
}
