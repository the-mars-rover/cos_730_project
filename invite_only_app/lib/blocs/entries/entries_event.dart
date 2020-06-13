import 'package:equatable/equatable.dart';
import 'package:invite_only_repo/invite_only_repo.dart';

abstract class EntriesEvent extends Equatable {
  const EntriesEvent();
}

class LoadInitialEntries extends EntriesEvent {
  final Space space;

  LoadInitialEntries(this.space);

  @override
  List<Object> get props => [space];
}

class LoadMoreEntries extends EntriesEvent {
  @override
  List<Object> get props => [];
}
