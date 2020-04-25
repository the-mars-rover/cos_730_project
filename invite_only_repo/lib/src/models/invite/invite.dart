import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'invite.freezed.dart';
part 'invite.g.dart';

@freezed
abstract class Invite with _$Invite {
  const factory Invite({
    /// The identifier for the invite - can be anything as long as it is unique.
    @required String id,

    /// The six-digit code that can be submitted to use this invite.
    @required String code,

    /// The identifier for the [ControlledSpace] for which this invite was created.
    @required String spaceId,

    /// The date until which this invite may be used.
    @required DateTime expiryDate,

    /// The phone number of the person who generated this invite
    @required String inviterPhoneNumber,
  }) = _Invite;

  factory Invite.fromJson(Map<String, dynamic> json) => _$InviteFromJson(json);
}
