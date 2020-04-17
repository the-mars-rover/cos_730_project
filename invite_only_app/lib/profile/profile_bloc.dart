import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:invite_only_auth/invite_only_auth.dart';
import 'package:invite_only_docs/invite_only_docs.dart';
import 'package:rsa_scan/rsa_scan.dart';

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
      yield* _mapUploadDocumentToState(event);
    }
  }

  Stream<ProfileState> _mapLoadProfileDetailsToState(
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
        _idDocsRepository.submitDocument(
          currentState.user.id,
          _convertIdCard(event.scannedIdCard),
        );
      }

      if (event.scannedIdBook != null) {
        _idDocsRepository.submitDocument(
          currentState.user.id,
          _convertIdBook(event.scannedIdBook),
        );
      }

      yield ProfileDetailsLoaded(
        currentState.user,
        currentState.documentedUserStream,
      );
    }
  }

  /// This is a helper method which returns an IdCard (required by the [_idDocsRepository])
  /// from the given RsaIdCard (scanned using the `rsa_scan` package).
  IdCard _convertIdCard(RsaIdCard scannedIdCard) {
    return IdDocument.idCard(
      idNumber: scannedIdCard.idNumber,
      firstNames: scannedIdCard.firstNames,
      surname: scannedIdCard.surname,
      gender: scannedIdCard.gender,
      birthDate: scannedIdCard.birthDate,
      issueDate: scannedIdCard.issueDate,
      smartIdNumber: scannedIdCard.smartIdNumber,
      nationality: scannedIdCard.nationality,
      countryOfBirth: scannedIdCard.countryOfBirth,
      citizenshipStatus: scannedIdCard.citizenshipStatus,
    );
  }

  /// This is a helper method which returns an IdCard (required by the [_idDocsRepository])
  /// from the given RsaIdCard (scanned using the `rsa_scan` package).
  IdBook _convertIdBook(RsaIdBook scannedIdBook) {
    return IdDocument.idBook(
      idNumber: scannedIdBook.idNumber,
      gender: scannedIdBook.gender,
      birthDate: scannedIdBook.birthDate,
      citizenshipStatus: scannedIdBook.citizenshipStatus,
    );
  }
}
