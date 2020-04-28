import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:invite_only_repo/src/errors/auth_failure.dart';
import 'package:invite_only_repo/src/models/access/access.dart';
import 'package:invite_only_repo/src/models/id_document/id_document.dart';
import 'package:invite_only_repo/src/models/space/space.dart';
import 'package:invite_only_repo/src/models/user/user.dart';

import 'firebase_invite_only_repo.dart';

abstract class InviteOnlyRepo {
  /// The initialize method should be called as soon as the app starts.
  static Future<void> initialize() async {
    _instance = await FirebaseInviteOnlyRepo.getInstance();
  }

  /// The singleton instance of this class, instantiated during [initialize]
  static FirebaseInviteOnlyRepo _instance;

  /// Just a simple getter to retrieve the singleton instance of this class.
  ///
  /// If [initialize] has not been called, this will be null.
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
  /// The stream may emit null if the user's details are busy being recorded.
  Stream<User> currentUser();

  /// Sign out the currently authenticated user.
  Future<void> signOut();

  /// Deletes the user, retrieved using [currentUser].
  Future<void> deleteUser(User user);

  /// Save new details for the user, retrieved using [currentUser].
  Future<void> updateUser(User user);

  /// Returns a stream of access controlled spaces for which the currently
  /// authenticated is a manager, guard or inviter.
  Stream<List<Space>> spaces();

  /// Creates an access-controlled space with the given details.
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

  /// Update the given space that was read using [spaces].
  Future<void> updateSpace(Space space);

  /// Delete the given space that was read using [spaces].
  Future<void> deleteSpace(Space space);

  /// Creates an invite and returns an invite code for the new invite to the given space,
  /// that was read using [spaces]. The currently authenticated user will be
  /// marked as the inviter of the invite.
  Future<String> invite(Space space);

  /// Grant access to an access controlled space.
  ///
  /// Arguments:
  /// * [space] is the space to which access is being granted, read using [spaces].
  ///
  /// * [idDocument] is the ID document of the person to whom entry is being granted.
  ///
  /// * [inviteCode] is optional. Retrieved using [invite], it should only be passed
  /// if the person with the given ID is not a manager, guard or inviter for the space.
  ///
  /// Throws [AccessDenied] if:
  /// - No invite code was given and the person with the presented document is not a
  /// manager, inviter or guard for the space.
  /// - or, if the invite code was invalid.
  Future<void> grantAccess(Space space, IdDocument idDocument,
      [String inviteCode]);

  /// Returns a stream of accesses for the space with the given id.
  ///
  /// If the space with the given id is deleted during the emission of this stream,
  /// null will be emitted.
  Stream<List<Access>> accesses(Space space);
}

class InviteOnlyCredential {
  final credential;

  InviteOnlyCredential(this.credential);
}
