import 'package:equatable/equatable.dart';
import 'package:invite_only_repo/invite_only_repo.dart';

abstract class EntryEvent extends Equatable {
  const EntryEvent();
}

class GrantResidentEntry extends EntryEvent {
  final Space space;

  final IdDocument idDocument;

  GrantResidentEntry(this.space, this.idDocument);

  @override
  List<Object> get props => [space, idDocument];
}

class GrantVisitorEntry extends EntryEvent {
  final Space space;

  final IdDocument idDocument;

  final String code;

  GrantVisitorEntry(this.space, this.idDocument, this.code);

  @override
  List<Object> get props => [space, idDocument, code];
}
