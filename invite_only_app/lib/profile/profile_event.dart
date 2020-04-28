import 'package:equatable/equatable.dart';
import 'package:invite_only_repo/invite_only_repo.dart';

abstract class ProfileEvent extends Equatable {
  const ProfileEvent();
}

class LoadProfileDetails extends ProfileEvent {
  @override
  List<Object> get props => [];
}

class UpdateUser extends ProfileEvent {
  final User updatedUser;

  UpdateUser(this.updatedUser);

  @override
  List<Object> get props => [updatedUser];
}
