import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'space.freezed.dart';
part 'space.g.dart';

/// A [Space] is any space to which access is being controlled.
@freezed
abstract class Space implements _$Space {
  const Space._();

  const factory Space({
    /// The unique identifier for the space.
    int id,

    /// The title for the space - describes the space briefly.
    @required String title,

    /// A list of phone numbers identifying managers of this space.
    ///
    /// Managers have the authority to update the users and properties of the
    /// space as well as to delete the space entirely.
    @required Set<String> managerPhones,

    /// A list of phone numbers identifying guards of this space
    ///
    /// Guards have the authority to Grant/Deny an access to a space.
    @required Set<String> guardPhones,

    /// A list of phone numbers identifying inviters of this space.
    ///
    /// Inviters have the authority to Generate invite's for the space.
    @required Set<String> inviterPhones,

    /// The url to the image for this space.
    String imageUrl,

    /// The location latitude of the space
    double locationLatitude,

    /// The location longitude of the space
    double locationLongitude,
  }) = _Space;

  factory Space.fromJson(Map<String, dynamic> json) => _$SpaceFromJson(json);

  bool canEdit(String phoneNumber) => managerPhones.contains(phoneNumber);

  bool canGuard(String phoneNumber) => guardPhones.contains(phoneNumber);

  bool canInvite(String phoneNumber) => inviterPhones.contains(phoneNumber);

  bool isResident(String phoneNumber) =>
      managerPhones.contains(phoneNumber) ||
      guardPhones.contains(phoneNumber) ||
      inviterPhones.contains(phoneNumber);
}
