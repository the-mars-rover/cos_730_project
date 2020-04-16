import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:invite_only_auth/invite_only_auth.dart';
import 'package:invite_only_docs/invite_only_docs.dart';

import 'profile.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  /// The repository for retrieving authentication details
  final _authRepository = AuthRepository.instance;

  /// The repository for retrieving documented users
  final _idDocsRepository = IdDocsRepository.instance;

  @override
  ProfileState get initialState => LoadingProfileDetails();

  @override
  Stream<ProfileState> mapEventToState(ProfileEvent event,) async* {
    if (event is LoadProfileDetails) {
      yield* _mapLoadProfilDetailsToState(event);
    }

    if (event is UploadDocument) {
      yield* _mapUploadDocumentToState(event);
    }
  }

  Stream<ProfileState> _mapLoadProfilDetailsToState(
      LoadProfileDetails event) async* {
    final user = await _authRepository.currentUser();
    final documentedUserStream =
    await _idDocsRepository.documentedUser(user.id);

    yield ProfileDetailsLoaded(user, documentedUserStream);
  }

  Stream<ProfileState> _mapUploadDocumentToState(UploadDocument event) async* {
    final currentState = state;
    if (currentState is ProfileDetailsLoaded) {
      yield UploadingDocument();

      if (event.scannedIdCard != null) {
        // TODO: submit the ID Card
      }

      if (event.scannedIdBook != null) {
        // TODO: submit the ID Book
      }

      yield ProfileDetailsLoaded(
        currentState.user,
        currentState.documentedUserStream,
      );
    }
  }
}
