import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:invite_only_repo/src/models/id_document/id_document.dart';

part 'access.freezed.dart';
part 'access.g.dart';

/// Stores the access details for a particular access to a [ControlledSpace].
@freezed
abstract class Access implements _$Access {
  const Access._();

  const factory Access({
    /// The identifier for the access - can be anything as long as it is unique.
    @required String id,

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
  }) = _Access;

  factory Access.fromJson(Map<String, dynamic> json) => _$AccessFromJson(json);

  bool canView(String phoneNumber) => granterPhoneNumber == phoneNumber;
}
