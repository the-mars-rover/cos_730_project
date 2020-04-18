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

    /// The [DateTime] representing the entrance time of the access.
    @required DateTime entryDate,

    /// The [DateTime] representing the exit time of the access.
    @required DateTime exitDate,

    /// The [IdDocument] of the person accessing the space.
    @required IdDocument idDocument,
  }) = _Access;

  factory Access.fromJson(Map<String, dynamic> json) => _$AccessFromJson(json);
}
