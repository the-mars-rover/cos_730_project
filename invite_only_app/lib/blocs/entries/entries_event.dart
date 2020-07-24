import 'package:equatable/equatable.dart';
import 'package:invite_only_repo/invite_only_repo.dart';

abstract class EntriesEvent extends Equatable {
  const EntriesEvent();
}

class LoadInitialEntries extends EntriesEvent {
  final Space space;
  final DateTime from;
  final DateTime to;

  LoadInitialEntries(this.space, {this.from, this.to});

  @override
  List<Object> get props => [space, from, to];
}

class LoadMoreEntries extends EntriesEvent {
  @override
  List<Object> get props => [];
}
