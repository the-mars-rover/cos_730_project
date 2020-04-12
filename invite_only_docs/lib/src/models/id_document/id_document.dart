import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

part 'id_document.freezed.dart';

part 'id_document.g.dart';

@freezed
abstract class IdDocument with _$IdDocument {
  const factory IdDocument.idBook() = IdBook;

  const factory IdDocument.idCard() = IdCard;

  const factory IdDocument.driversLicense() = DriversLicense;

  const factory IdDocument.passport() = Passport;

  factory IdDocument.fromJson(Map<String, dynamic> json) =>
      _$IdDocumentFromJson(json);
}
