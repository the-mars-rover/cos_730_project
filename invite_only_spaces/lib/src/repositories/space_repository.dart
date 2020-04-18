import '../models/models.dart';

abstract class SpaceRepository {
  /// Returns a stream of access controlled spaces for which the person with
  /// the given phone number is a manager, guard or inviter.
  Stream<List<ControlledSpace>> spaces(String phoneNumber);

  /// Returns a streamed list of accesses for the space with the given id,
  /// which may be seen by the user with the given phone number.
  ///
  /// If the user with the given phone number is a manager for the space:
  /// - all accesses of the space will be streamed.
  ///
  /// If the user with the given phone number is a guard for the space:
  /// - accesses where the guard's phone number matches [Access.granterPhoneNumber]
  /// will me streamed.
  /// - accesses for which [Access.entryGuardPhone] or [Access.exitGuardPhone]
  /// matches the user's phone number the will also be streamed.
  ///
  /// If the user with the given phone number is an inviter for the space:
  /// - accesses where the inviter's phone number matches [Access.granterPhoneNumber]
  /// will me streamed.
  Stream<List<Access>> accesses(String spaceId, String phoneNumber);

  /// Updates the properties of the given space. If no space exists with the
  /// [space.id] then a new space will be created.
  ///
  /// [phoneNumber] is the phone number of the manager making the update to the space.
  Future<void> updateSpace(ControlledSpace space, String phoneNumber);

  /// Delete the space with the given id.
  ///
  /// [phoneNumber] is the phone number of the manager deleting the space.
  Future<void> deleteSpace(String spaceId, String phoneNumber);

  /// Grant access to the manager, guard or resident of this space with the given phone number.
  Future<void> grantAccess(String spaceId, String phoneNumber);

  /// Grant visitor access to the space using a provided invite code.
  Future<void> grantVisitorAccess(String spaceId, String inviteCode);

  /// Creates and returns the invite code for a new invite to the given space.
  ///
  /// [phoneNumber] is the phone number of the manager or inviter creating the invite.
  Future<String> invite(String spaceId, String phoneNumber);
}
