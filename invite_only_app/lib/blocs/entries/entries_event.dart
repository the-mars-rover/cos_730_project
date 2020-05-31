import 'package:equatable/equatable.dart';
import 'package:invite_only_repo/invite_only_repo.dart';

abstract class EntriesEvent extends Equatable {
  const EntriesEvent();
}

class LoadEntries extends EntriesEvent {
  final Space space;

  LoadEntries(this.space);

  @override
  List<Object> get props => [space];
}
