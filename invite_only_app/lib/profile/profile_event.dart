import 'package:equatable/equatable.dart';

abstract class ProfileEvent extends Equatable {
  const ProfileEvent();
}

class LoadProfileDetails extends ProfileEvent {
  @override
  List<Object> get props => [];
}
