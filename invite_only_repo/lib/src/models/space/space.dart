import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'space.freezed.dart';
part 'space.g.dart';

/// A [Space] is any space to which access is being controlled.
@freezed
abstract class Space implements _$Space {
  const Space._();

  const factory Space({
    /// The identifier for the space - can be anything as long as it is unique.
    @required String id,

    /// The title for the space - describes the space briefly
    @required String title,

    /// If true, only managers, guards, inviters and people with valid invites
    /// will be allowed to enter the space.
    @required bool inviteOnly,

    /// A list of phone numbers identifying managers of this space
    ///
    /// Managers have the authority to:
    /// * Edit the properties of the [Space]
    /// * Grant/Deny an [Access] to the [Space]
    /// * Generate [Invite]'s for the [Space]
    @required List<String> managerPhones,

    /// A list of phone numbers identifying guards of this space
    ///
    /// Guards have the authority to:
    /// * Grant/Deny an [Access] to the [Space]
    @required List<String> guardPhones,

    /// A list of phone numbers identifying inviters of this space
    ///
    /// Inviters have the authority to:
    /// * Generate [Invite]'s for the [Space]
    @required List<String> inviterPhones,

    /// The minimum age of people allowed into the location if [inviteOnly] is
    /// false. Defaults to 0.
    int minAge,

    /// The url to the image for this space.
    String imageUrl,

    /// The location latitude of the space
    double locationLatitude,

    /// The location longitude of the space
    double locationLongitude,
  }) = _Space;

  factory Space.fromJson(Map<String, dynamic> json) => _$SpaceFromJson(json);

  bool canEdit(String phoneNumber) => managerPhones.contains(phoneNumber);

  bool canGuard(String phoneNumber) =>
      managerPhones.contains(phoneNumber) || guardPhones.contains(phoneNumber);

  bool canInvite(String phoneNumber) =>
      managerPhones.contains(phoneNumber) ||
      inviterPhones.contains(phoneNumber);

  bool canEnter(String phoneNumber) =>
      managerPhones.contains(phoneNumber) ||
      guardPhones.contains(phoneNumber) ||
      inviterPhones.contains(phoneNumber);
}
