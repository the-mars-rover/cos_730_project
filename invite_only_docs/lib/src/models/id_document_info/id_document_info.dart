import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

part 'id_document_info.freezed.dart';

part 'id_document_info.g.dart';

@freezed
abstract class IdDocumentInfo with _$IdDocumentInfo {
  const factory IdDocumentInfo.idBookInfo({
    /// The string identifying the user to which this ID Book is linked.
    @required String userId,
  }) = IdBookInfo;

  const factory IdDocumentInfo.idCardInfo({
    /// The string identifying the user to which this ID card is linked.
    @required String userId,
  }) = IdCardInfo;

  const factory IdDocumentInfo.driversLicenseInfo({
    /// The string identifying the user to which this Driver's license is linked.
    @required String userId,
  }) = DriversLicenseInfo;

  const factory IdDocumentInfo.passportInfo({
    /// The string identifying the user to which this Passport is linked.
    @required String userId,
  }) = PassportInfo;

  factory IdDocumentInfo.fromJson(Map<String, dynamic> json) =>
      _$IdDocumentInfoFromJson(json);
}
