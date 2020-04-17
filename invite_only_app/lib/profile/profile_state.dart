import 'package:equatable/equatable.dart';
import 'package:invite_only_auth/invite_only_auth.dart';
import 'package:invite_only_docs/invite_only_docs.dart';

abstract class ProfileState extends Equatable {
  const ProfileState();
}

class LoadingProfileDetails extends ProfileState {
  @override
  List<Object> get props => [];
}

class ProfileDetailsLoaded extends ProfileState {
  final User user;
  final Stream<DocumentedUser> documentedUserStream;

  ProfileDetailsLoaded(this.user, this.documentedUserStream);

  @override
  List<Object> get props => [];
}

class DocumentUploadError extends ProfileState {
  final String errorMessage;

  DocumentUploadError(this.errorMessage);

  @override
  List<Object> get props => [errorMessage];
}

class UploadingDocument extends ProfileState {
  @override
  List<Object> get props => [];
}
