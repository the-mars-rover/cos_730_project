import 'package:equatable/equatable.dart';
import 'package:invite_only_docs/invite_only_docs.dart';

abstract class ProfileState extends Equatable {
  const ProfileState();
}

class LoadingProfileDetails extends ProfileState {
  @override
  List<Object> get props => [];
}

class ProfileDetailsLoaded extends ProfileState {
  final String phoneNumber;
  final Stream<DocumentedUser> documentedUserStream;

  ProfileDetailsLoaded(this.phoneNumber, this.documentedUserStream);

  @override
  List<Object> get props => [];
}

class CapturingDocument extends ProfileState {
  @override
  List<Object> get props => [];
}
