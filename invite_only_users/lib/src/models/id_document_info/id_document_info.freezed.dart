// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named

part of 'id_document_info.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;
IdDocumentInfo _$IdDocumentInfoFromJson(Map<String, dynamic> json) {
  switch (json['runtimeType'] as String) {
    case 'idBookInfo':
      return IdBookInfo.fromJson(json);
    case 'idCardInfo':
      return IdCardInfo.fromJson(json);
    case 'driversLicenseInfo':
      return DriversLicenseInfo.fromJson(json);
    case 'passportInfo':
      return PassportInfo.fromJson(json);

    default:
      throw FallThroughError();
  }
}

class _$IdDocumentInfoTearOff {
  const _$IdDocumentInfoTearOff();

  IdBookInfo idBookInfo() {
    return const IdBookInfo();
  }

  IdCardInfo idCardInfo() {
    return const IdCardInfo();
  }

  DriversLicenseInfo driversLicenseInfo() {
    return const DriversLicenseInfo();
  }

  PassportInfo passportInfo() {
    return const PassportInfo();
  }
}

// ignore: unused_element
const $IdDocumentInfo = _$IdDocumentInfoTearOff();

mixin _$IdDocumentInfo {
  @optionalTypeArgs
  Result when<Result extends Object>({
    @required Result idBookInfo(),
    @required Result idCardInfo(),
    @required Result driversLicenseInfo(),
    @required Result passportInfo(),
  });
  @optionalTypeArgs
  Result maybeWhen<Result extends Object>({
    Result idBookInfo(),
    Result idCardInfo(),
    Result driversLicenseInfo(),
    Result passportInfo(),
    @required Result orElse(),
  });
  @optionalTypeArgs
  Result map<Result extends Object>({
    @required Result idBookInfo(IdBookInfo value),
    @required Result idCardInfo(IdCardInfo value),
    @required Result driversLicenseInfo(DriversLicenseInfo value),
    @required Result passportInfo(PassportInfo value),
  });
  @optionalTypeArgs
  Result maybeMap<Result extends Object>({
    Result idBookInfo(IdBookInfo value),
    Result idCardInfo(IdCardInfo value),
    Result driversLicenseInfo(DriversLicenseInfo value),
    Result passportInfo(PassportInfo value),
    @required Result orElse(),
  });
  Map<String, dynamic> toJson();
}

abstract class $IdDocumentInfoCopyWith<$Res> {
  factory $IdDocumentInfoCopyWith(
          IdDocumentInfo value, $Res Function(IdDocumentInfo) then) =
      _$IdDocumentInfoCopyWithImpl<$Res>;
}

class _$IdDocumentInfoCopyWithImpl<$Res>
    implements $IdDocumentInfoCopyWith<$Res> {
  _$IdDocumentInfoCopyWithImpl(this._value, this._then);

  final IdDocumentInfo _value;
  // ignore: unused_field
  final $Res Function(IdDocumentInfo) _then;
}

abstract class $IdBookInfoCopyWith<$Res> {
  factory $IdBookInfoCopyWith(
          IdBookInfo value, $Res Function(IdBookInfo) then) =
      _$IdBookInfoCopyWithImpl<$Res>;
}

class _$IdBookInfoCopyWithImpl<$Res> extends _$IdDocumentInfoCopyWithImpl<$Res>
    implements $IdBookInfoCopyWith<$Res> {
  _$IdBookInfoCopyWithImpl(IdBookInfo _value, $Res Function(IdBookInfo) _then)
      : super(_value, (v) => _then(v as IdBookInfo));

  @override
  IdBookInfo get _value => super._value as IdBookInfo;
}

@JsonSerializable()
class _$IdBookInfo with DiagnosticableTreeMixin implements IdBookInfo {
  const _$IdBookInfo();

  factory _$IdBookInfo.fromJson(Map<String, dynamic> json) =>
      _$_$IdBookInfoFromJson(json);

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'IdDocumentInfo.idBookInfo()';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties..add(DiagnosticsProperty('type', 'IdDocumentInfo.idBookInfo'));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) || (other is IdBookInfo);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  Result when<Result extends Object>({
    @required Result idBookInfo(),
    @required Result idCardInfo(),
    @required Result driversLicenseInfo(),
    @required Result passportInfo(),
  }) {
    assert(idBookInfo != null);
    assert(idCardInfo != null);
    assert(driversLicenseInfo != null);
    assert(passportInfo != null);
    return idBookInfo();
  }

  @override
  @optionalTypeArgs
  Result maybeWhen<Result extends Object>({
    Result idBookInfo(),
    Result idCardInfo(),
    Result driversLicenseInfo(),
    Result passportInfo(),
    @required Result orElse(),
  }) {
    assert(orElse != null);
    if (idBookInfo != null) {
      return idBookInfo();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  Result map<Result extends Object>({
    @required Result idBookInfo(IdBookInfo value),
    @required Result idCardInfo(IdCardInfo value),
    @required Result driversLicenseInfo(DriversLicenseInfo value),
    @required Result passportInfo(PassportInfo value),
  }) {
    assert(idBookInfo != null);
    assert(idCardInfo != null);
    assert(driversLicenseInfo != null);
    assert(passportInfo != null);
    return idBookInfo(this);
  }

  @override
  @optionalTypeArgs
  Result maybeMap<Result extends Object>({
    Result idBookInfo(IdBookInfo value),
    Result idCardInfo(IdCardInfo value),
    Result driversLicenseInfo(DriversLicenseInfo value),
    Result passportInfo(PassportInfo value),
    @required Result orElse(),
  }) {
    assert(orElse != null);
    if (idBookInfo != null) {
      return idBookInfo(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$_$IdBookInfoToJson(this)..['runtimeType'] = 'idBookInfo';
  }
}

abstract class IdBookInfo implements IdDocumentInfo {
  const factory IdBookInfo() = _$IdBookInfo;

  factory IdBookInfo.fromJson(Map<String, dynamic> json) =
      _$IdBookInfo.fromJson;
}

abstract class $IdCardInfoCopyWith<$Res> {
  factory $IdCardInfoCopyWith(
          IdCardInfo value, $Res Function(IdCardInfo) then) =
      _$IdCardInfoCopyWithImpl<$Res>;
}

class _$IdCardInfoCopyWithImpl<$Res> extends _$IdDocumentInfoCopyWithImpl<$Res>
    implements $IdCardInfoCopyWith<$Res> {
  _$IdCardInfoCopyWithImpl(IdCardInfo _value, $Res Function(IdCardInfo) _then)
      : super(_value, (v) => _then(v as IdCardInfo));

  @override
  IdCardInfo get _value => super._value as IdCardInfo;
}

@JsonSerializable()
class _$IdCardInfo with DiagnosticableTreeMixin implements IdCardInfo {
  const _$IdCardInfo();

  factory _$IdCardInfo.fromJson(Map<String, dynamic> json) =>
      _$_$IdCardInfoFromJson(json);

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'IdDocumentInfo.idCardInfo()';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties..add(DiagnosticsProperty('type', 'IdDocumentInfo.idCardInfo'));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) || (other is IdCardInfo);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  Result when<Result extends Object>({
    @required Result idBookInfo(),
    @required Result idCardInfo(),
    @required Result driversLicenseInfo(),
    @required Result passportInfo(),
  }) {
    assert(idBookInfo != null);
    assert(idCardInfo != null);
    assert(driversLicenseInfo != null);
    assert(passportInfo != null);
    return idCardInfo();
  }

  @override
  @optionalTypeArgs
  Result maybeWhen<Result extends Object>({
    Result idBookInfo(),
    Result idCardInfo(),
    Result driversLicenseInfo(),
    Result passportInfo(),
    @required Result orElse(),
  }) {
    assert(orElse != null);
    if (idCardInfo != null) {
      return idCardInfo();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  Result map<Result extends Object>({
    @required Result idBookInfo(IdBookInfo value),
    @required Result idCardInfo(IdCardInfo value),
    @required Result driversLicenseInfo(DriversLicenseInfo value),
    @required Result passportInfo(PassportInfo value),
  }) {
    assert(idBookInfo != null);
    assert(idCardInfo != null);
    assert(driversLicenseInfo != null);
    assert(passportInfo != null);
    return idCardInfo(this);
  }

  @override
  @optionalTypeArgs
  Result maybeMap<Result extends Object>({
    Result idBookInfo(IdBookInfo value),
    Result idCardInfo(IdCardInfo value),
    Result driversLicenseInfo(DriversLicenseInfo value),
    Result passportInfo(PassportInfo value),
    @required Result orElse(),
  }) {
    assert(orElse != null);
    if (idCardInfo != null) {
      return idCardInfo(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$_$IdCardInfoToJson(this)..['runtimeType'] = 'idCardInfo';
  }
}

abstract class IdCardInfo implements IdDocumentInfo {
  const factory IdCardInfo() = _$IdCardInfo;

  factory IdCardInfo.fromJson(Map<String, dynamic> json) =
      _$IdCardInfo.fromJson;
}

abstract class $DriversLicenseInfoCopyWith<$Res> {
  factory $DriversLicenseInfoCopyWith(
          DriversLicenseInfo value, $Res Function(DriversLicenseInfo) then) =
      _$DriversLicenseInfoCopyWithImpl<$Res>;
}

class _$DriversLicenseInfoCopyWithImpl<$Res>
    extends _$IdDocumentInfoCopyWithImpl<$Res>
    implements $DriversLicenseInfoCopyWith<$Res> {
  _$DriversLicenseInfoCopyWithImpl(
      DriversLicenseInfo _value, $Res Function(DriversLicenseInfo) _then)
      : super(_value, (v) => _then(v as DriversLicenseInfo));

  @override
  DriversLicenseInfo get _value => super._value as DriversLicenseInfo;
}

@JsonSerializable()
class _$DriversLicenseInfo
    with DiagnosticableTreeMixin
    implements DriversLicenseInfo {
  const _$DriversLicenseInfo();

  factory _$DriversLicenseInfo.fromJson(Map<String, dynamic> json) =>
      _$_$DriversLicenseInfoFromJson(json);

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'IdDocumentInfo.driversLicenseInfo()';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'IdDocumentInfo.driversLicenseInfo'));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) || (other is DriversLicenseInfo);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  Result when<Result extends Object>({
    @required Result idBookInfo(),
    @required Result idCardInfo(),
    @required Result driversLicenseInfo(),
    @required Result passportInfo(),
  }) {
    assert(idBookInfo != null);
    assert(idCardInfo != null);
    assert(driversLicenseInfo != null);
    assert(passportInfo != null);
    return driversLicenseInfo();
  }

  @override
  @optionalTypeArgs
  Result maybeWhen<Result extends Object>({
    Result idBookInfo(),
    Result idCardInfo(),
    Result driversLicenseInfo(),
    Result passportInfo(),
    @required Result orElse(),
  }) {
    assert(orElse != null);
    if (driversLicenseInfo != null) {
      return driversLicenseInfo();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  Result map<Result extends Object>({
    @required Result idBookInfo(IdBookInfo value),
    @required Result idCardInfo(IdCardInfo value),
    @required Result driversLicenseInfo(DriversLicenseInfo value),
    @required Result passportInfo(PassportInfo value),
  }) {
    assert(idBookInfo != null);
    assert(idCardInfo != null);
    assert(driversLicenseInfo != null);
    assert(passportInfo != null);
    return driversLicenseInfo(this);
  }

  @override
  @optionalTypeArgs
  Result maybeMap<Result extends Object>({
    Result idBookInfo(IdBookInfo value),
    Result idCardInfo(IdCardInfo value),
    Result driversLicenseInfo(DriversLicenseInfo value),
    Result passportInfo(PassportInfo value),
    @required Result orElse(),
  }) {
    assert(orElse != null);
    if (driversLicenseInfo != null) {
      return driversLicenseInfo(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$_$DriversLicenseInfoToJson(this)
      ..['runtimeType'] = 'driversLicenseInfo';
  }
}

abstract class DriversLicenseInfo implements IdDocumentInfo {
  const factory DriversLicenseInfo() = _$DriversLicenseInfo;

  factory DriversLicenseInfo.fromJson(Map<String, dynamic> json) =
      _$DriversLicenseInfo.fromJson;
}

abstract class $PassportInfoCopyWith<$Res> {
  factory $PassportInfoCopyWith(
          PassportInfo value, $Res Function(PassportInfo) then) =
      _$PassportInfoCopyWithImpl<$Res>;
}

class _$PassportInfoCopyWithImpl<$Res>
    extends _$IdDocumentInfoCopyWithImpl<$Res>
    implements $PassportInfoCopyWith<$Res> {
  _$PassportInfoCopyWithImpl(
      PassportInfo _value, $Res Function(PassportInfo) _then)
      : super(_value, (v) => _then(v as PassportInfo));

  @override
  PassportInfo get _value => super._value as PassportInfo;
}

@JsonSerializable()
class _$PassportInfo with DiagnosticableTreeMixin implements PassportInfo {
  const _$PassportInfo();

  factory _$PassportInfo.fromJson(Map<String, dynamic> json) =>
      _$_$PassportInfoFromJson(json);

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'IdDocumentInfo.passportInfo()';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties..add(DiagnosticsProperty('type', 'IdDocumentInfo.passportInfo'));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) || (other is PassportInfo);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  Result when<Result extends Object>({
    @required Result idBookInfo(),
    @required Result idCardInfo(),
    @required Result driversLicenseInfo(),
    @required Result passportInfo(),
  }) {
    assert(idBookInfo != null);
    assert(idCardInfo != null);
    assert(driversLicenseInfo != null);
    assert(passportInfo != null);
    return passportInfo();
  }

  @override
  @optionalTypeArgs
  Result maybeWhen<Result extends Object>({
    Result idBookInfo(),
    Result idCardInfo(),
    Result driversLicenseInfo(),
    Result passportInfo(),
    @required Result orElse(),
  }) {
    assert(orElse != null);
    if (passportInfo != null) {
      return passportInfo();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  Result map<Result extends Object>({
    @required Result idBookInfo(IdBookInfo value),
    @required Result idCardInfo(IdCardInfo value),
    @required Result driversLicenseInfo(DriversLicenseInfo value),
    @required Result passportInfo(PassportInfo value),
  }) {
    assert(idBookInfo != null);
    assert(idCardInfo != null);
    assert(driversLicenseInfo != null);
    assert(passportInfo != null);
    return passportInfo(this);
  }

  @override
  @optionalTypeArgs
  Result maybeMap<Result extends Object>({
    Result idBookInfo(IdBookInfo value),
    Result idCardInfo(IdCardInfo value),
    Result driversLicenseInfo(DriversLicenseInfo value),
    Result passportInfo(PassportInfo value),
    @required Result orElse(),
  }) {
    assert(orElse != null);
    if (passportInfo != null) {
      return passportInfo(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$_$PassportInfoToJson(this)..['runtimeType'] = 'passportInfo';
  }
}

abstract class PassportInfo implements IdDocumentInfo {
  const factory PassportInfo() = _$PassportInfo;

  factory PassportInfo.fromJson(Map<String, dynamic> json) =
      _$PassportInfo.fromJson;
}
