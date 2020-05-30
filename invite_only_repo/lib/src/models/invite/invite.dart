import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'invite.freezed.dart';
part 'invite.g.dart';

@freezed
abstract class Invite with _$Invite {
  const factory Invite({
    /// The unique identifier for the invite.
    @required int id,

    /// The six-digit code that can be submitted to use this invite.
    @required String code,

    /// The identifier for the [ControlledSpace] for which this invite was created.
    @required String spaceId,

    /// The phone number of the person who generated this invite
    @required String inviterPhone,

    /// The date at which this invite is no longer valid.
    @required DateTime expiryDate,
  }) = _Invite;

  factory Invite.fromJson(Map<String, dynamic> json) => _$InviteFromJson(json);
}
