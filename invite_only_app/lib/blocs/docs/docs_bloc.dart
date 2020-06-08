import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:invite_only_repo/invite_only_repo.dart';
import 'package:rsa_scan/rsa_scan.dart';

import 'docs_event.dart';
import 'docs_state.dart';

class DocsBloc extends Bloc<DocsEvent, DocsState> {
  final _inviteOnlyRepo = InviteOnlyRepo.instance;

  @override
  DocsState get initialState => LoadingDocs();

  @override
  Stream<DocsState> mapEventToState(
    DocsEvent event,
  ) async* {
    if (event is LoadDocs) {
      yield* _mapLoadDocsToState(event);
    }

    if (event is SubmitDoc) {
      yield* _mapSubmitDocToState(event);
    }

    if (event is DeleteDoc) {
      yield* _mapDeleteDocToState(event);
    }
  }

  Stream<DocsState> _mapLoadDocsToState(LoadDocs event) async* {
    yield LoadingDocs();

    try {
      final idDocuments = await _inviteOnlyRepo.fetchIdDocuments();
      idDocuments.sort((a, b) => a.id - b.id);
      final idCard =
          idDocuments.firstWhere((d) => d is IdCard, orElse: () => null);
      final idBook =
          idDocuments.firstWhere((d) => d is IdBook, orElse: () => null);
      final drivers = idDocuments.firstWhere((d) => d is DriversLicense,
          orElse: () => null);
      final passport =
          idDocuments.firstWhere((d) => d is Passport, orElse: () => null);
      yield DocsLoaded(idCard, idBook, drivers, passport);
    } catch (e) {
      yield DocsError(
          'Sorry, an unexpected error occurred. Please try again later.');
    }
  }

  Stream<DocsState> _mapSubmitDocToState(SubmitDoc event) async* {
    yield LoadingDocs();
    try {
      await _inviteOnlyRepo.addIdDocument(event.idDocument);

      this.add(LoadDocs());
    } on Conflict {
      yield DocsError(
          'It looks like that document is already linked to you or someone else.');
    } catch (e) {
      yield DocsError(
          'Sorry, an unexpected error occurred. Please try again later.');
    }
  }

  Stream<DocsState> _mapDeleteDocToState(DeleteDoc event) async* {
    try {
      yield LoadingDocs();
      await _inviteOnlyRepo.deleteIdDocument(event.idDocument);

      this.add(LoadDocs());
    } catch (e) {
      yield DocsError(
          'Sorry, an unexpected error occurred. Please try again later.');
    }
  }

  /// The app works with packages which use different structures for the modelling
  /// of identification documents.
  ///
  /// This method provides utilities to easily convert between classes used by each package.
  static IdDocument rsaToDocs(RsaIdDocument document) {
    if (document is RsaIdBook) {
      return IdDocument.idBook(
          idNumber: document.idNumber,
          birthDate: document.birthDate,
          gender: document.gender,
          citizenshipStatus: document.citizenshipStatus);
    }

    if (document is RsaIdCard) {
      return IdDocument.idCard(
        idNumber: document.idNumber,
        firstNames: document.firstNames,
        surname: document.surname,
        gender: document.gender,
        birthDate: document.birthDate,
        issueDate: document.issueDate,
        smartIdNumber: document.smartIdNumber,
        nationality: document.nationality,
        countryOfBirth: document.countryOfBirth,
        citizenshipStatus: document.citizenshipStatus,
      );
    }

    if (document is RsaDriversLicense) {
      return IdDocument.driversLicense(
        idNumber: document.idNumber,
        firstNames: document.firstNames,
        surname: document.surname,
        gender: document.gender,
        birthDate: document.birthDate,
        licenseNumber: document.licenseNumber,
        vehicleCodes: document.vehicleCodes,
        prdpCode: document.prdpCode,
        idCountryOfIssue: document.idCountryOfIssue,
        licenseCountryOfIssue: document.licenseCountryOfIssue,
        vehicleRestrictions: document.vehicleRestrictions,
        idNumberType: document.idNumberType,
        driverRestrictions: document.driverRestrictions,
        prdpExpiry: document.prdpExpiry,
        licenseIssueNumber: document.licenseIssueNumber,
        validFrom: document.validFrom,
        validTo: document.validTo,
      );
    }

    throw Exception('Unsupported type: ${document.runtimeType}');
  }

  static of(BuildContext context) => BlocProvider.of<DocsBloc>(context);
}
