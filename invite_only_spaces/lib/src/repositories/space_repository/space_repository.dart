import 'package:invite_only_spaces/src/repositories/space_repository/firebase_space_repository.dart';

import '../../../invite_only_spaces.dart';

abstract class SpaceRepository {
  /// The singleton instance of [SpaceRepository]. Currently, [FirebaseSpaceRepository]
  /// is being used since Firestore is the preferred Data Storage Provider.
  static final _instance = FirebaseSpaceRepository();

  /// The getter for the singleton instance of this class.
  static SpaceRepository get instance => _instance;

  /// Creates the given space.
  Future<void> createSpace(ControlledSpace space);

  /// Returns a stream of access controlled spaces for which the person with
  /// the given phone number is a manager.
  Stream<List<ControlledSpace>> managerSpaces(String phoneNumber);

  /// Returns a stream of access controlled spaces for which the person with
  /// the given phone number is a guard.
  Stream<List<ControlledSpace>> guardSpaces(String phoneNumber);

  /// Returns a stream of access controlled spaces for which the person with
  /// the given phone number is an inviter.
  Stream<List<ControlledSpace>> inviterSpaces(String phoneNumber);

  /// Returns a streamed list of accesses for the space with the given id.
  Stream<List<Access>> accesses(String spaceId);

  /// Updates the properties of the given space.
  ///
  /// If no space exists yet, the update will fail.
  Future<void> updateSpace(ControlledSpace space);

  /// Delete the space with the given id.
  Future<void> deleteSpace(String spaceId);

  /// Creates and returns an invite for a new invite to the given space.
  ///
  /// [phoneNumber] is the phone number of the manager or inviter creating the invite.
  Future<Invite> createInvite(String spaceId, String phoneNumber);

  /// Grant access to a manager, inviter or guard to the space with the given ID.
  ///
  /// [phoneNumber] is the phone number of the person being granted entry.
  /// [idDocument] is the ID document of the person to whom entry is being granted.
  /// [guardPhone] is the phone number of the person who is granting entry.
  ///
  /// Throws an exception if [phoneNumber] is not the phone number of a manager,
  /// guard or inviter for the given space.
  Future<void> grantEntry(String spaceId, String phoneNumber,
      IdDocument idDocument, String guardPhone);

  /// Grant access to a visitor to the space with the given ID.
  ///
  /// [guardPhone] is the phone number of the manager or guard who is granting entry.
  /// [idDocument] is the ID document of the person to whom entry is being granted.
  /// [entryCode] is the invite code presented (generated using [createInvite]).
  Future<void> grantVisitorEntry(String spaceId, IdDocument idDocument,
      String entryCode, String guardPhone);
}
