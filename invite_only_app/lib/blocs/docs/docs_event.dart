import 'package:equatable/equatable.dart';
import 'package:invite_only_repo/invite_only_repo.dart';

abstract class DocsEvent extends Equatable {
  const DocsEvent();
}

class LoadDocs extends DocsEvent {
  @override
  List<Object> get props => [];
}

class SubmitDoc extends DocsEvent {
  final IdDocument idDocument;

  SubmitDoc(this.idDocument);

  @override
  List<Object> get props => [idDocument];
}

class DeleteDoc extends DocsEvent {
  final IdDocument idDocument;

  DeleteDoc(this.idDocument);

  @override
  List<Object> get props => [idDocument];
}

class DeleteAll extends DocsEvent {
  @override
  List<Object> get props => [];
}
