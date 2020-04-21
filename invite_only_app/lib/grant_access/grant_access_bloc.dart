import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:invite_only/app/id_doc_converter.dart';
import 'package:invite_only_auth/invite_only_auth.dart';
import 'package:invite_only_docs/invite_only_docs.dart';
import 'package:invite_only_spaces/invite_only_spaces.dart';

import 'grant_access_event.dart';
import 'grant_access_state.dart';

class GrantAccessBloc extends Bloc<GrantAccessEvent, GrantAccessState> {
  final AuthRepository _authRepository = AuthRepository.instance;

  final SpaceRepository _spaceRepository =
      SpaceRepository.instance;

  final IdDocsRepository _idDocsRepository =
      IdDocsRepository.instance;

  @override
  GrantAccessState get initialState => InitialGrantAccessState();

  @override
  Stream<GrantAccessState> mapEventToState(
    GrantAccessEvent event,
  ) async* {
    if (event is GrantAccess) {
      yield* _mapGrantAccessToState(event);
    }

    if (event is GrantVisitorAccess) {
      yield* _mapGrantVisitorAccessToState(event);
    }
  }

  Stream<GrantAccessState> _mapGrantAccessToState(GrantAccess event) async* {
    yield GrantingAccess();

    final currentUser = await _authRepository.currentUser();
    final enteringUser = await _idDocsRepository.userWithDocument(
      IdDocConverter.rsaToDocs(event.scannedIdDocument),
    );
    try {
      _spaceRepository.grantEntry(
        event.space.id,
        enteringUser.phoneNumber,
        IdDocConverter.rsaToSpaces(event.scannedIdDocument),
        currentUser.phoneNumber,
      );

      yield AccessGranted();
    } catch (e) {
      yield AccessDenied();
    }
  }

  Stream<GrantAccessState> _mapGrantVisitorAccessToState(
      GrantVisitorAccess event) async* {
    yield GrantingAccess();

    final currentUser = await _authRepository.currentUser();
    try {
      _spaceRepository.grantVisitorEntry(
        event.space.id,
        IdDocConverter.rsaToSpaces(event.scannedIdDocument),
        event.code,
        currentUser.phoneNumber,
      );

      yield AccessGranted();
    } catch (e) {
      yield AccessDenied();
    }
  }
}
