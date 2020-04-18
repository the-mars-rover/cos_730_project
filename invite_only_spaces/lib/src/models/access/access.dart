import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../models.dart';

part 'access.freezed.dart';
part 'access.g.dart';

/// Stores the access details for a particular access to a [Access].
@freezed
abstract class Access with _$Access {
  const factory Access({
    /// The identifier for the access - can be anything as long as it is unique.
    @required String id,

    /// The identifier of the [ControlledSpace] to which the [Access] was made.
    @required String spaceId,

    /// The phone number of the guard who scanned the [idDocument] on entry.
    /// Null if access has not yet ended.
    @required String entryGuardPhone,

    /// The [DateTime] representing the entrance time of the access.
    @required DateTime entryDate,

    /// The [IdDocument] of the person accessing the space.
    @required IdDocument idDocument,

    /// The phone number of the person who granted access the person being allowed to
    /// access the space.
    ///
    /// If the person accessing the space is a manager, guard or inviter for the space
    /// then this will be their own phone number.
    ///
    /// If the person accessing the space has received an invite to enter the space,
    /// then this will me the phone number of the manager or inviter who sent the invite.
    @required String granterPhoneNumber,

    /// The phone number of the guard who scanned the [idDocument] on exit.
    /// Null if access has not yet ended.
    String exitGuardPhone,

    /// The [DateTime] representing the exit time of the access.
    /// Null if access has not yet ended.
    DateTime exitDate,
  }) = _Access;

  factory Access.fromJson(Map<String, dynamic> json) => _$AccessFromJson(json);
}
