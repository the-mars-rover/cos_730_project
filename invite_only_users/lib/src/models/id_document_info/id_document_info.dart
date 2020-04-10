import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

part 'id_document_info.freezed.dart';

part 'id_document_info.g.dart';

@freezed
abstract class IdDocumentInfo with _$IdDocumentInfo {
  const factory IdDocumentInfo.idBookInfo() = IdBookInfo;

  const factory IdDocumentInfo.idCardInfo() = IdCardInfo;

  const factory IdDocumentInfo.driversLicenseInfo() = DriversLicenseInfo;

  const factory IdDocumentInfo.passportInfo() = PassportInfo;

  factory IdDocumentInfo.fromJson(Map<String, dynamic> json) =>
      _$IdDocumentInfoFromJson(json);
}
