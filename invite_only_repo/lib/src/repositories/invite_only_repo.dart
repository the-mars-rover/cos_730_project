import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:invite_only_repo/src/errors/auth_failure.dart';
import 'package:invite_only_repo/src/errors/document_invalid.dart';
import 'package:invite_only_repo/src/errors/permission_denied.dart';
import 'package:invite_only_repo/src/models/access/access.dart';
import 'package:invite_only_repo/src/models/id_document/id_document.dart';
import 'package:invite_only_repo/src/models/space/space.dart';
import 'package:invite_only_repo/src/models/user/user.dart';

import 'firebase_invite_only_repo.dart';

abstract class InviteOnlyRepo {
  static final _instance = FirebaseInviteOnlyRepo();

  static InviteOnlyRepo get instance => _instance;

  /// Starts the phone number verification process for a given phone number.
  ///
  /// - [phoneNumber] The phone number for the account the user is signing up
  ///   for or signing into. Make sure to pass in a phone number with country
  ///   code prefixed with plus sign ('+').
  /// - [timeout] The maximum amount of time you are willing to wait for SMS
  ///   auto-retrieval to be completed by the library. Maximum allowed value
  ///   is 2 minutes. Use 0 to disable SMS-auto-retrieval.
  /// - [verificationCompleted] will trigger when an SMS is auto-retrieved or the
  ///   phone number has been instantly verified. The callback receives an Invite Only
  ///   credential that can be passed to [signInWithCredential].
  /// - [verificationFailed] is Triggered when an error occurred during phone number verification.
  /// - [codeSent] will trigger when an SMS has been sent to the users phone, and
  ///   will include a [verificationId] to use with [getAuthCredential] when validating
  ///   an SMS code.
  Future<void> verifyPhoneNumber({
    @required String phoneNumber,
    @required Duration retrievalTimeout,
    @required Function(InviteOnlyCredential) verificationCompleted,
    @required Function(AuthFailure) verificationFailed,
    @required Function(String) codeSent,
  });

  /// Returns an [InviteOnlyCredential]
  ///
  /// [phoneVerificationId] is the verification ID obtained from the codeSent
  /// callback passed to [verifyPhoneNumber].
  ///
  /// [smsCode] is the SMS code manually submitted by the user.
  InviteOnlyCredential getAuthCredential(
      String phoneVerificationId, String smsCode);

  /// Sign in the user using the [InviteOnlyCredential]] provided by
  /// the verificationCompleted callback passed to [verifyPhoneNumber] or manually
  /// retrieved using [getAuthCredential].
  ///
  /// Throws [AuthFailure] if the sign in was unsuccessful. [AuthFailure.reason]
  /// will contain the reason for the failed sign in.
  Future<void> signInWithCredential(InviteOnlyCredential inviteOnlyCredential);

  /// Returns a stream of the currently authenticated user's details. Will return
  /// null if there is no currently authenticated user.
  ///
  /// If the currently authenticated user is deleted during the emission of the
  /// stream, the stream will emit null instead of any User details.
  Future<Stream<User>> currentUser();

  /// Deletes the currently authenticated user.
  ///
  /// Throws [Unauthenticated] if there is no currently authenticated user.
  Future<void> deleteUser();

  /// Submit an ID Document for the currently authenticated user.
  ///
  /// Throws [Unauthenticated] if there is no currently authenticated user.
  ///
  /// Throws [DocumentInvalid] if the document could not be added.
  Future<void> submitDocument(IdDocument idDocument);

  /// Creates a new access-controlled space with the given details.
  ///
  /// Arguments:
  /// * [title] - The title for the space, describes the space briefly.
  ///
  /// * [inviteOnly] - If true, only managers, guards, inviters and people with
  /// valid invites will be allowed to enter the space.
  ///
  /// * [managerPhones] - A list of phone numbers identifying managers of this space.
  ///
  /// * [guardPhones] - A list of phone numbers identifying guards of this space.
  ///
  /// * [inviterPhones] - A list of phone numbers identifying inviters of this space.
  ///
  /// * [minAge] - The minimum age of people allowed to enter this space if
  /// [inviteOnly] is false. Defaults to 0 if not passed.
  ///
  /// * [image] - An identifying image for the space. May be left as null.
  ///
  /// * [locationLatitude] and [locationLongitude] - represent the location of the
  /// space, may be left as null.
  ///
  /// Throws [PermissionDenied] if there is no currently authenticated user.
  Future<void> createSpace({
    @required String title,
    @required bool inviteOnly,
    @required List<String> managerPhones,
    @required List<String> guardPhones,
    @required List<String> inviterPhones,
    int minAge,
    File image,
    double locationLatitude,
    double locationLongitude,
  });

  /// Update the given space with the properties that are set. If no space exists
  /// with the given ID, nothing will be done.
  ///
  /// Throws [PermissionDenied] if the currently authenticated user is not
  /// a manager for the given space.
  Future<void> updateSpace(Space space);

  /// Delete the given space. If no space exists with the same id as the given space,
  /// nothing will happen.
  ///
  /// Throws [PermissionDenied] if the currently authenticated user is not
  /// a manager for the given space.
  Future<void> deleteSpace(Space space);

  /// Creates an invite and returns an invite code for the new invite to the given space.
  /// The currently authenticated user will be marked as the inviter of the invite
  /// so if there is no currently authenticated user, null will be returned.
  ///
  /// Throws [Unauthenticated] if there is no currently authenticated user.
  ///
  /// Throws [PermissionDenied] if the currently authenticated user is not
  /// a manager or inviter for the given space.
  Future<String> invite(Space space);

  /// Grant access to a manager, inviter or guard to the space with the given ID.
  ///
  /// [idDocument] is the ID document of the person to whom entry is being granted.
  ///
  /// Throws [Unauthenticated] if there is no currently authenticated user.
  ///
  /// Throws [PermissionDenied] if the currently authenticated user is not
  /// a manager or guard for the given space.
  ///
  /// Throws [AccessDenied] if the person with the presented document is not a
  /// manager, inviter or guard for the given space.
  Future<void> grantAccess(Space space, IdDocument idDocument);

  /// Grant access to a manager, inviter or guard to the space with the given ID.
  ///
  /// [idDocument] is the ID document of the person to whom entry is being granted.
  ///
  /// Throws [Unauthenticated] if there is no currently authenticated user.
  ///
  /// Throws [PermissionDenied] if the currently authenticated user is not
  /// a manager or guard for the given space.
  ///
  /// Throws [AccessDenied] if the invite code is not valid.
  Future<void> grantVisitorAccess(
      Space space, IdDocument idDocument, String code);

  /// Returns a stream of access controlled spaces which the currently
  /// authenticated user may view.
  ///
  /// Throws [Unauthenticated] if there is no currently authenticated user.
  Future<Stream<List<Space>>> spaces();

  /// Returns a stream of a single access controlled space.
  ///
  /// Throws [PermissionDenied] if the currently authenticated user is not a manager,
  /// guard or inviter for the given space.
  ///
  /// The stream will emit null if the space does not exist.
  Future<Stream<Space>> space(Space space);

  /// Returns a stream of accesses for the given space which may be viewed by the
  /// currently authenticated user.
  ///
  /// Throws [PermissionDenied] if the currently authenticated user is not a manager,
  /// guard or inviter for the given space.
  Future<Stream<List<Access>>> accesses(Space space);
}

class InviteOnlyCredential {
  final credential;

  InviteOnlyCredential(this.credential);
}
