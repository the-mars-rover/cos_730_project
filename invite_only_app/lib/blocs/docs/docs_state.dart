import 'package:equatable/equatable.dart';
import 'package:invite_only_repo/invite_only_repo.dart';

abstract class DocsState extends Equatable {
  const DocsState();
}

class LoadingDocs extends DocsState {
  @override
  List<Object> get props => [];
}

class DocsLoaded extends DocsState {
  final IdCard idCard;
  final IdBook idBook;
  final DriversLicense driversLicense;
  final Passport passport;

  DocsLoaded(
    this.idCard,
    this.idBook,
    this.driversLicense,
    this.passport,
  );

  @override
  List<Object> get props => [
        this.idCard,
        this.idBook,
        this.driversLicense,
        this.passport,
      ];
}

class DocsError extends DocsState {
  final String error;

  DocsError(this.error);

  @override
  List<Object> get props => [error];
}

class AllDeleted extends DocsState {
  @override
  List<Object> get props => [];
}
