import 'package:equatable/equatable.dart';
import 'package:invite_only_repo/invite_only_repo.dart';
import 'package:rsa_scan/rsa_scan.dart';

abstract class GrantAccessEvent extends Equatable {
  const GrantAccessEvent();
}

class GrantAccess extends GrantAccessEvent {
  final Space space;

  final RsaIdDocument scannedIdDocument;

  GrantAccess(this.space, this.scannedIdDocument);

  @override
  List<Object> get props => [space, scannedIdDocument];
}

class GrantVisitorAccess extends GrantAccessEvent {
  final Space space;

  final RsaIdDocument scannedIdDocument;

  final String code;

  GrantVisitorAccess(this.space, this.scannedIdDocument, this.code);

  @override
  List<Object> get props => [space, scannedIdDocument, code];
}
