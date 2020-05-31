import 'package:equatable/equatable.dart';

abstract class EntryState extends Equatable {
  const EntryState();
}

class GrantingEntry extends EntryState {
  @override
  List<Object> get props => [];
}

class EntryGranted extends EntryState {
  @override
  List<Object> get props => [];
}

class ResidentEntryDenied extends EntryState {
  final String reason;

  ResidentEntryDenied(this.reason);

  @override
  List<Object> get props => [reason];
}

class EntryDenied extends EntryState {
  final String reason;

  EntryDenied(this.reason);

  @override
  List<Object> get props => [reason];
}

class EntryError extends EntryState {
  final String error;

  EntryError(this.error);

  @override
  List<Object> get props => [error];
}
