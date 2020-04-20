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

  /// Grant access to the manager, guard or resident of this space with the given phone number.
  Future<void> grantEntry(String spaceId, String phoneNumber);

  /// Grant access to the manager, guard or resident of this space with the given phone number.
  Future<void> grantExit(String spaceId, String phoneNumber);

  /// Creates and returns an invite for a new invite to the given space.
  ///
  /// [phoneNumber] is the phone number of the manager or inviter creating the invite.
  Future<Invite> invite(String spaceId, String phoneNumber);
}
