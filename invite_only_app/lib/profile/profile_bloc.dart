import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:invite_only/app/id_doc_converter.dart';
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
  Stream<ProfileState> mapEventToState(
    ProfileEvent event,
  ) async* {
    if (event is LoadProfileDetails) {
      yield* _mapLoadProfileDetailsToState(event);
    }

    if (event is UploadDocument) {
      yield* _mapUploadIdCardToState(event);
    }
  }

  Stream<ProfileState> _mapLoadProfileDetailsToState(
      LoadProfileDetails event) async* {
    final user = await _authRepository.currentUser();
    final documentedUserStream =
        await _idDocsRepository.documentedUser(user.phoneNumber);

    yield ProfileDetailsLoaded(user, documentedUserStream);
  }

  Stream<ProfileState> _mapUploadIdCardToState(UploadDocument event) async* {
    final currentState = state;
    if (currentState is ProfileDetailsLoaded) {
      yield UploadingDocument();

      try {
        _idDocsRepository.submitDocument(
          currentState.user.phoneNumber,
          IdDocConverter.rsaToDocs(event.scannedDocument),
        );

        yield ProfileDetailsLoaded(
          currentState.user,
          currentState.documentedUserStream,
        );
      } on DocumentedRejected catch (e) {
        yield DocumentUploadError(
          e.reason,
          currentState.user,
          currentState.documentedUserStream,
        );
      }
    }
  }
}
