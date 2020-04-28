import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:invite_only_repo/invite_only_repo.dart';

import 'profile_event.dart';
import 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final _inviteOnlyRepo = InviteOnlyRepo.instance;

  @override
  ProfileState get initialState => LoadingProfileDetails();

  @override
  Stream<ProfileState> mapEventToState(
    ProfileEvent event,
  ) async* {
    if (event is LoadProfileDetails) {
      yield* _mapLoadProfileDetailsToState(event);
    }

    if (event is UpdateUser) {
      yield* _mapUpdateUserToState(event);
    }
  }

  Stream<ProfileState> _mapLoadProfileDetailsToState(
      LoadProfileDetails event) async* {
    final userStream = _inviteOnlyRepo.currentUser();

    yield ProfileDetailsLoaded(userStream);
  }

  Stream<ProfileState> _mapUpdateUserToState(UpdateUser event) async* {
    final currentState = state;
    if (currentState is ProfileDetailsLoaded) {
      yield UploadingDocument();

      await _inviteOnlyRepo.updateUser(event.updatedUser);

      yield ProfileDetailsLoaded(currentState.userStream);
    }
  }
}
