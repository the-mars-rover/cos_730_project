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

  IdBookInfo idBookInfo({@required String userId}) {
    return IdBookInfo(
      userId: userId,
    );
  }

  IdCardInfo idCardInfo({@required String userId}) {
    return IdCardInfo(
      userId: userId,
    );
  }

  DriversLicenseInfo driversLicenseInfo({@required String userId}) {
    return DriversLicenseInfo(
      userId: userId,
    );
  }

  PassportInfo passportInfo({@required String userId}) {
    return PassportInfo(
      userId: userId,
    );
  }
}

// ignore: unused_element
const $IdDocumentInfo = _$IdDocumentInfoTearOff();

mixin _$IdDocumentInfo {
  String get userId;

  @optionalTypeArgs
  Result when<Result extends Object>({
    @required Result idBookInfo(@required String userId),
    @required Result idCardInfo(@required String userId),
    @required Result driversLicenseInfo(@required String userId),
    @required Result passportInfo(@required String userId),
  });
  @optionalTypeArgs
  Result maybeWhen<Result extends Object>({
    Result idBookInfo(@required String userId),
    Result idCardInfo(@required String userId),
    Result driversLicenseInfo(@required String userId),
    Result passportInfo(@required String userId),
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
  $IdDocumentInfoCopyWith<IdDocumentInfo> get copyWith;
}

abstract class $IdDocumentInfoCopyWith<$Res> {
  factory $IdDocumentInfoCopyWith(
          IdDocumentInfo value, $Res Function(IdDocumentInfo) then) =
      _$IdDocumentInfoCopyWithImpl<$Res>;
  $Res call({String userId});
}

class _$IdDocumentInfoCopyWithImpl<$Res>
    implements $IdDocumentInfoCopyWith<$Res> {
  _$IdDocumentInfoCopyWithImpl(this._value, this._then);

  final IdDocumentInfo _value;
  // ignore: unused_field
  final $Res Function(IdDocumentInfo) _then;

  @override
  $Res call({
    Object userId = freezed,
  }) {
    return _then(_value.copyWith(
      userId: userId == freezed ? _value.userId : userId as String,
    ));
  }
}

abstract class $IdBookInfoCopyWith<$Res>
    implements $IdDocumentInfoCopyWith<$Res> {
  factory $IdBookInfoCopyWith(
          IdBookInfo value, $Res Function(IdBookInfo) then) =
      _$IdBookInfoCopyWithImpl<$Res>;
  @override
  $Res call({String userId});
}

class _$IdBookInfoCopyWithImpl<$Res> extends _$IdDocumentInfoCopyWithImpl<$Res>
    implements $IdBookInfoCopyWith<$Res> {
  _$IdBookInfoCopyWithImpl(IdBookInfo _value, $Res Function(IdBookInfo) _then)
      : super(_value, (v) => _then(v as IdBookInfo));

  @override
  IdBookInfo get _value => super._value as IdBookInfo;

  @override
  $Res call({
    Object userId = freezed,
  }) {
    return _then(IdBookInfo(
      userId: userId == freezed ? _value.userId : userId as String,
    ));
  }
}

@JsonSerializable()
class _$IdBookInfo with DiagnosticableTreeMixin implements IdBookInfo {
  const _$IdBookInfo({@required this.userId}) : assert(userId != null);

  factory _$IdBookInfo.fromJson(Map<String, dynamic> json) =>
      _$_$IdBookInfoFromJson(json);

  @override
  final String userId;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'IdDocumentInfo.idBookInfo(userId: $userId)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'IdDocumentInfo.idBookInfo'))
      ..add(DiagnosticsProperty('userId', userId));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is IdBookInfo &&
            (identical(other.userId, userId) ||
                const DeepCollectionEquality().equals(other.userId, userId)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^ const DeepCollectionEquality().hash(userId);

  @override
  $IdBookInfoCopyWith<IdBookInfo> get copyWith =>
      _$IdBookInfoCopyWithImpl<IdBookInfo>(this, _$identity);

  @override
  @optionalTypeArgs
  Result when<Result extends Object>({
    @required Result idBookInfo(@required String userId),
    @required Result idCardInfo(@required String userId),
    @required Result driversLicenseInfo(@required String userId),
    @required Result passportInfo(@required String userId),
  }) {
    assert(idBookInfo != null);
    assert(idCardInfo != null);
    assert(driversLicenseInfo != null);
    assert(passportInfo != null);
    return idBookInfo(userId);
  }

  @override
  @optionalTypeArgs
  Result maybeWhen<Result extends Object>({
    Result idBookInfo(@required String userId),
    Result idCardInfo(@required String userId),
    Result driversLicenseInfo(@required String userId),
    Result passportInfo(@required String userId),
    @required Result orElse(),
  }) {
    assert(orElse != null);
    if (idBookInfo != null) {
      return idBookInfo(userId);
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
  const factory IdBookInfo({@required String userId}) = _$IdBookInfo;

  factory IdBookInfo.fromJson(Map<String, dynamic> json) =
      _$IdBookInfo.fromJson;

  @override
  String get userId;
  @override
  $IdBookInfoCopyWith<IdBookInfo> get copyWith;
}

abstract class $IdCardInfoCopyWith<$Res>
    implements $IdDocumentInfoCopyWith<$Res> {
  factory $IdCardInfoCopyWith(
          IdCardInfo value, $Res Function(IdCardInfo) then) =
      _$IdCardInfoCopyWithImpl<$Res>;
  @override
  $Res call({String userId});
}

class _$IdCardInfoCopyWithImpl<$Res> extends _$IdDocumentInfoCopyWithImpl<$Res>
    implements $IdCardInfoCopyWith<$Res> {
  _$IdCardInfoCopyWithImpl(IdCardInfo _value, $Res Function(IdCardInfo) _then)
      : super(_value, (v) => _then(v as IdCardInfo));

  @override
  IdCardInfo get _value => super._value as IdCardInfo;

  @override
  $Res call({
    Object userId = freezed,
  }) {
    return _then(IdCardInfo(
      userId: userId == freezed ? _value.userId : userId as String,
    ));
  }
}

@JsonSerializable()
class _$IdCardInfo with DiagnosticableTreeMixin implements IdCardInfo {
  const _$IdCardInfo({@required this.userId}) : assert(userId != null);

  factory _$IdCardInfo.fromJson(Map<String, dynamic> json) =>
      _$_$IdCardInfoFromJson(json);

  @override
  final String userId;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'IdDocumentInfo.idCardInfo(userId: $userId)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'IdDocumentInfo.idCardInfo'))
      ..add(DiagnosticsProperty('userId', userId));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is IdCardInfo &&
            (identical(other.userId, userId) ||
                const DeepCollectionEquality().equals(other.userId, userId)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^ const DeepCollectionEquality().hash(userId);

  @override
  $IdCardInfoCopyWith<IdCardInfo> get copyWith =>
      _$IdCardInfoCopyWithImpl<IdCardInfo>(this, _$identity);

  @override
  @optionalTypeArgs
  Result when<Result extends Object>({
    @required Result idBookInfo(@required String userId),
    @required Result idCardInfo(@required String userId),
    @required Result driversLicenseInfo(@required String userId),
    @required Result passportInfo(@required String userId),
  }) {
    assert(idBookInfo != null);
    assert(idCardInfo != null);
    assert(driversLicenseInfo != null);
    assert(passportInfo != null);
    return idCardInfo(userId);
  }

  @override
  @optionalTypeArgs
  Result maybeWhen<Result extends Object>({
    Result idBookInfo(@required String userId),
    Result idCardInfo(@required String userId),
    Result driversLicenseInfo(@required String userId),
    Result passportInfo(@required String userId),
    @required Result orElse(),
  }) {
    assert(orElse != null);
    if (idCardInfo != null) {
      return idCardInfo(userId);
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
  const factory IdCardInfo({@required String userId}) = _$IdCardInfo;

  factory IdCardInfo.fromJson(Map<String, dynamic> json) =
      _$IdCardInfo.fromJson;

  @override
  String get userId;
  @override
  $IdCardInfoCopyWith<IdCardInfo> get copyWith;
}

abstract class $DriversLicenseInfoCopyWith<$Res>
    implements $IdDocumentInfoCopyWith<$Res> {
  factory $DriversLicenseInfoCopyWith(
          DriversLicenseInfo value, $Res Function(DriversLicenseInfo) then) =
      _$DriversLicenseInfoCopyWithImpl<$Res>;
  @override
  $Res call({String userId});
}

class _$DriversLicenseInfoCopyWithImpl<$Res>
    extends _$IdDocumentInfoCopyWithImpl<$Res>
    implements $DriversLicenseInfoCopyWith<$Res> {
  _$DriversLicenseInfoCopyWithImpl(
      DriversLicenseInfo _value, $Res Function(DriversLicenseInfo) _then)
      : super(_value, (v) => _then(v as DriversLicenseInfo));

  @override
  DriversLicenseInfo get _value => super._value as DriversLicenseInfo;

  @override
  $Res call({
    Object userId = freezed,
  }) {
    return _then(DriversLicenseInfo(
      userId: userId == freezed ? _value.userId : userId as String,
    ));
  }
}

@JsonSerializable()
class _$DriversLicenseInfo
    with DiagnosticableTreeMixin
    implements DriversLicenseInfo {
  const _$DriversLicenseInfo({@required this.userId}) : assert(userId != null);

  factory _$DriversLicenseInfo.fromJson(Map<String, dynamic> json) =>
      _$_$DriversLicenseInfoFromJson(json);

  @override
  final String userId;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'IdDocumentInfo.driversLicenseInfo(userId: $userId)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'IdDocumentInfo.driversLicenseInfo'))
      ..add(DiagnosticsProperty('userId', userId));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is DriversLicenseInfo &&
            (identical(other.userId, userId) ||
                const DeepCollectionEquality().equals(other.userId, userId)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^ const DeepCollectionEquality().hash(userId);

  @override
  $DriversLicenseInfoCopyWith<DriversLicenseInfo> get copyWith =>
      _$DriversLicenseInfoCopyWithImpl<DriversLicenseInfo>(this, _$identity);

  @override
  @optionalTypeArgs
  Result when<Result extends Object>({
    @required Result idBookInfo(@required String userId),
    @required Result idCardInfo(@required String userId),
    @required Result driversLicenseInfo(@required String userId),
    @required Result passportInfo(@required String userId),
  }) {
    assert(idBookInfo != null);
    assert(idCardInfo != null);
    assert(driversLicenseInfo != null);
    assert(passportInfo != null);
    return driversLicenseInfo(userId);
  }

  @override
  @optionalTypeArgs
  Result maybeWhen<Result extends Object>({
    Result idBookInfo(@required String userId),
    Result idCardInfo(@required String userId),
    Result driversLicenseInfo(@required String userId),
    Result passportInfo(@required String userId),
    @required Result orElse(),
  }) {
    assert(orElse != null);
    if (driversLicenseInfo != null) {
      return driversLicenseInfo(userId);
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
  const factory DriversLicenseInfo({@required String userId}) =
      _$DriversLicenseInfo;

  factory DriversLicenseInfo.fromJson(Map<String, dynamic> json) =
      _$DriversLicenseInfo.fromJson;

  @override
  String get userId;
  @override
  $DriversLicenseInfoCopyWith<DriversLicenseInfo> get copyWith;
}

abstract class $PassportInfoCopyWith<$Res>
    implements $IdDocumentInfoCopyWith<$Res> {
  factory $PassportInfoCopyWith(
          PassportInfo value, $Res Function(PassportInfo) then) =
      _$PassportInfoCopyWithImpl<$Res>;
  @override
  $Res call({String userId});
}

class _$PassportInfoCopyWithImpl<$Res>
    extends _$IdDocumentInfoCopyWithImpl<$Res>
    implements $PassportInfoCopyWith<$Res> {
  _$PassportInfoCopyWithImpl(
      PassportInfo _value, $Res Function(PassportInfo) _then)
      : super(_value, (v) => _then(v as PassportInfo));

  @override
  PassportInfo get _value => super._value as PassportInfo;

  @override
  $Res call({
    Object userId = freezed,
  }) {
    return _then(PassportInfo(
      userId: userId == freezed ? _value.userId : userId as String,
    ));
  }
}

@JsonSerializable()
class _$PassportInfo with DiagnosticableTreeMixin implements PassportInfo {
  const _$PassportInfo({@required this.userId}) : assert(userId != null);

  factory _$PassportInfo.fromJson(Map<String, dynamic> json) =>
      _$_$PassportInfoFromJson(json);

  @override
  final String userId;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'IdDocumentInfo.passportInfo(userId: $userId)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'IdDocumentInfo.passportInfo'))
      ..add(DiagnosticsProperty('userId', userId));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is PassportInfo &&
            (identical(other.userId, userId) ||
                const DeepCollectionEquality().equals(other.userId, userId)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^ const DeepCollectionEquality().hash(userId);

  @override
  $PassportInfoCopyWith<PassportInfo> get copyWith =>
      _$PassportInfoCopyWithImpl<PassportInfo>(this, _$identity);

  @override
  @optionalTypeArgs
  Result when<Result extends Object>({
    @required Result idBookInfo(@required String userId),
    @required Result idCardInfo(@required String userId),
    @required Result driversLicenseInfo(@required String userId),
    @required Result passportInfo(@required String userId),
  }) {
    assert(idBookInfo != null);
    assert(idCardInfo != null);
    assert(driversLicenseInfo != null);
    assert(passportInfo != null);
    return passportInfo(userId);
  }

  @override
  @optionalTypeArgs
  Result maybeWhen<Result extends Object>({
    Result idBookInfo(@required String userId),
    Result idCardInfo(@required String userId),
    Result driversLicenseInfo(@required String userId),
    Result passportInfo(@required String userId),
    @required Result orElse(),
  }) {
    assert(orElse != null);
    if (passportInfo != null) {
      return passportInfo(userId);
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
  const factory PassportInfo({@required String userId}) = _$PassportInfo;

  factory PassportInfo.fromJson(Map<String, dynamic> json) =
      _$PassportInfo.fromJson;

  @override
  String get userId;
  @override
  $PassportInfoCopyWith<PassportInfo> get copyWith;
}
