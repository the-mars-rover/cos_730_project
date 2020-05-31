import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:invite_only_repo/src/models/id_document/id_document.dart';
import 'package:invite_only_repo/src/models/invite/invite.dart';

part 'entry.freezed.dart';
part 'entry.g.dart';

/// Stores the access details for a particular access to a [ControlledSpace].
@freezed
abstract class Entry implements _$Entry {
  const Entry._();

  const factory Entry(
      {

      /// The unique identifier for the entry.
      int id,

      /// The phone number of the guard who scanned the [idDocument] on entry.
      @required String guardPhone,

      /// The [DateTime] representing the entrance time of the access.
      @required DateTime entryDate,

      /// The [IdDocument] of the person accessing the space.
      @required IdDocument idDocument,

      /// The [Invite] used for this entry - if one was used.
      Invite invite}) = _Entry;

  factory Entry.fromJson(Map<String, dynamic> json) => _$EntryFromJson(json);
}
