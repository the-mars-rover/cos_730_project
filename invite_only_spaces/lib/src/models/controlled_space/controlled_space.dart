import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'controlled_space.freezed.dart';
part 'controlled_space.g.dart';

/// A [ControlledSpace] is any space to which access is being controlled.
@freezed
abstract class ControlledSpace with _$ControlledSpace {
  const factory ControlledSpace({
    /// The identifier for the space - can be anything as long as it is unique.
    @required String id,

    /// The title for the space - describes the space briefly
    @required String title,

    /// The location latitude of the space
    double locationLatitude,

    /// The location longitude of the space
    double locationLongitude,

    /// The minimum age of people allowed into the location
    int minAge,

    /// The maximum people allowed inside the space at one time
    int maxCapacity,

    /// A list of phone numbers identifying managers of this space
    ///
    /// Managers have the authority to:
    /// * Edit the properties of the [ControlledSpace]
    /// * Grant/Deny an [Access] to the [ControlledSpace]
    /// * Generate [Invite]'s for the [ControlledSpace]
    List<String> managerPhones,

    /// A list of phone numbers identifying guards of this space
    ///
    /// Guards have the authority to:
    /// * Grant/Deny an [Access] to the [ControlledSpace]
    List<String> guardPhones,

    /// A list of phone numbers identifying inviters of this space
    ///
    /// Inviters have the authority to:
    /// * Generate [Invite]'s for the [ControlledSpace]
    List<String> inviterPhones,
  }) = _ControlledSpace;

  factory ControlledSpace.fromJson(Map<String, dynamic> json) =>
      _$ControlledSpaceFromJson(json);
}
