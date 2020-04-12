import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

part 'id_document.freezed.dart';

part 'id_document.g.dart';

@freezed
abstract class IdDocument with _$IdDocument {
  const factory IdDocument.idBook({
    /// The string identifying the user to which this ID Book is linked.
    @required String userId,
  }) = IdBook;

  const factory IdDocument.idCard({
    /// The string identifying the user to which this ID card is linked.
    @required String userId,
  }) = IdCard;

  const factory IdDocument.driversLicense({
    /// The string identifying the user to which this Driver's license is linked.
    @required String userId,
  }) = DriversLicense;

  const factory IdDocument.passport({
    /// The string identifying the user to which this Passport is linked.
    @required String userId,
  }) = Passport;

  factory IdDocument.fromJson(Map<String, dynamic> json) =>
      _$IdDocumentFromJson(json);
}
