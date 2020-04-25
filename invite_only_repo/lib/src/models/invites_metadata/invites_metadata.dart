import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'invites_metadata.freezed.dart';
part 'invites_metadata.g.dart';

@freezed
abstract class InvitesMetadata with _$InvitesMetadata {
  const factory InvitesMetadata({
    @required int numInvites,
  }) = _InvitesMetadata;

  factory InvitesMetadata.fromJson(Map<String, dynamic> json) =>
      _$InvitesMetadataFromJson(json);
}
