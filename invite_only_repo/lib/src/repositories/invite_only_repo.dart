import 'package:flutter/foundation.dart';
import 'package:invite_only_repo/src/errors/auth_failure.dart';
import 'package:invite_only_repo/src/errors/conflict.dart';
import 'package:invite_only_repo/src/errors/not_found.dart';
import 'package:invite_only_repo/src/errors/uknown_error.dart';
import 'package:invite_only_repo/src/errors/unauthenticated.dart';
import 'package:invite_only_repo/src/errors/unauthorized.dart';
import 'package:invite_only_repo/src/models/entry/entry.dart';
import 'package:invite_only_repo/src/models/id_document/id_document.dart';
import 'package:invite_only_repo/src/models/invite/invite.dart';
import 'package:invite_only_repo/src/models/space/space.dart';

import 'invite_only_repo_impl.dart';

abstract class InviteOnlyRepo {
  /// Just a simple getter to retrieve the singleton instance of the  class.
  ///
  /// If [initialize] has not been called, this will be null.
  static InviteOnlyRepo get instance =>
      InviteOnlyRepoImpl.getInstance('https://core.inviteonly.co.za');

  /// Returns the current user's phone number, or null if there is no authenticated user.
  Future<String> currentUser();

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
    @required Function(String, [int]) codeSent,
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

  /// Sign out the currently authenticated user.
  Future<void> signOut();

  /// Add an ID document to the currently authenticated user and return the
  /// document that was added.
  ///
  /// Throws [Unauthenticated] if there is no authenticated user.
  /// Throws [Conflict] if the document has already been added by someone else.
  /// Throws [UnknownError] if an unknown error occurred.
  Future<IdDocument> addIdDocument(IdDocument idDocument);

  /// Fetch all ID documents linked to the currently authenticated user; or,
  /// an empty list if no documents have been added to the user.
  ///
  /// Throws [Unauthenticated] if there is no authenticated user.
  /// Throws [UnknownError] if an unknown error occurred.
  Future<List<IdDocument>> fetchIdDocuments();

  /// Remove an ID document from the currently authenticated user.
  ///
  /// Throws [Unauthenticated] if there is no authenticated user.
  /// Throws [NotFound] if the document could not be found.
  /// Throws [Unauthorized] if the document is not allowed to be deleted.
  /// Throws [UnknownError] if an unknown error occurred.
  Future<void> deleteIdDocument(IdDocument idDocument);

  /// Add a new access-controlled space and return the newly created space.
  ///
  /// Throws [Unauthenticated] if there is no authenticated user.
  /// Throws [UnknownError] if an unknown error occurred.
  Future<Space> addSpace(Space space);

  /// Fetch all spaces for which the currently authenticated user is a manager,
  /// inviter or guard. Returns an empty list if no such spaces exist.
  ///
  /// Throws [Unauthenticated] if there is no authenticated user.
  /// Throws [UnknownError] if an unknown error occurred.
  Future<List<Space>> fetchSpaces();

  /// Update an existing access-controlled space and return the updated space.
  ///
  /// Throws [Unauthenticated] if there is no authenticated user.
  /// Throws [NotFound] if the space could not be found.
  /// Throws [Unauthorized] if the space is not allowed to be deleted.
  /// Throws [UnknownError] if an unknown error occurred.
  Future<Space> updateSpace(Space space);

  /// Remove the given space entirely - this will delete the space for all users.
  ///
  /// Throws [Unauthenticated] if there is no authenticated user.
  /// Throws [NotFound] if the space could not be found.
  /// Throws [Unauthorized] if the space is not allowed to be deleted.
  /// Throws [UnknownError] if an unknown error occurred.
  Future<void> deleteSpace(Space space);

  /// Create a new invite for the given space. Only inviters for the space are
  /// authorized to create invites.
  ///
  /// Throws [Unauthenticated] if there is no authenticated user.
  /// Throws [NotFound] if the space could not be found.
  /// Throws [Unauthorized] if the invite was not allowed to be created.
  /// Throws [UnknownError] if an unknown error occurred.
  Future<Invite> createInvite(Space space);

  /// Add a new entry for the given space. Only guards for the space are
  /// authorized to add entries. If the person with the given document is not
  /// a manager, inviter or guard for the space, [code] must also be provided.
  ///
  /// Throws [Unauthenticated] if there is no authenticated user.
  /// Throws [NotFound] if the space could not be found or if [code] was
  /// not given and no user exists with the given ID Document.
  /// Throws [Unauthorized] if the entry was not allowed to be added.
  /// Throws [UnknownError] if an unknown error occurred.
  /// Throws [InvalidInvite] if the invite code given is not valid.
  Future<Entry> addEntry(Space space, IdDocument idDocument, [String code]);

  /// Fetch all entries for the given space, allowed to be seen by the currently
  /// authenticated user. Returns an empty list if there are no such entries.
  /// This method is paginated so requires the size and number of a page.
  ///
  /// Throws [Unauthenticated] if there is no authenticated user.
  /// Throws [NotFound] if the space could not be found.
  /// Throws [UnknownError] if an unknown error occurred.
  Future<List<Entry>> fetchEntries(Space space, int pageSize, int pageNum);
}

class InviteOnlyCredential {
  final credential;

  InviteOnlyCredential(this.credential);
}
