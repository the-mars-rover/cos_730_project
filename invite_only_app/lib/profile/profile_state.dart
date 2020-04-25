import 'package:equatable/equatable.dart';
import 'package:invite_only_repo/invite_only_repo.dart';

abstract class ProfileState extends Equatable {
  const ProfileState();
}

class LoadingProfileDetails extends ProfileState {
  @override
  List<Object> get props => [];
}

class ProfileDetailsLoaded extends ProfileState {
  final Stream<User> userStream;

  ProfileDetailsLoaded(this.userStream);

  @override
  List<Object> get props => [userStream];
}

class DocumentUploadError extends ProfileState {
  final Stream<User> userStream;
  final Exception exception;

  DocumentUploadError(this.userStream, this.exception);

  @override
  List<Object> get props => [userStream, exception];
}

class UploadingDocument extends ProfileState {
  @override
  List<Object> get props => [];
}
