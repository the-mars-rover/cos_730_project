// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named

part of 'access.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;
Access _$AccessFromJson(Map<String, dynamic> json) {
  return _Access.fromJson(json);
}

class _$AccessTearOff {
  const _$AccessTearOff();

  _Access call(
      {@required String id,
      @required String spaceId,
      @required DateTime entryDate,
      @required DateTime exitDate,
      @required IdDocument idDocument}) {
    return _Access(
      id: id,
      spaceId: spaceId,
      entryDate: entryDate,
      exitDate: exitDate,
      idDocument: idDocument,
    );
  }
}

// ignore: unused_element
const $Access = _$AccessTearOff();

mixin _$Access {
  String get id;
  String get spaceId;
  DateTime get entryDate;
  DateTime get exitDate;
  IdDocument get idDocument;

  Map<String, dynamic> toJson();
  $AccessCopyWith<Access> get copyWith;
}

abstract class $AccessCopyWith<$Res> {
  factory $AccessCopyWith(Access value, $Res Function(Access) then) =
      _$AccessCopyWithImpl<$Res>;
  $Res call(
      {String id,
      String spaceId,
      DateTime entryDate,
      DateTime exitDate,
      IdDocument idDocument});

  $IdDocumentCopyWith<$Res> get idDocument;
}

class _$AccessCopyWithImpl<$Res> implements $AccessCopyWith<$Res> {
  _$AccessCopyWithImpl(this._value, this._then);

  final Access _value;
  // ignore: unused_field
  final $Res Function(Access) _then;

  @override
  $Res call({
    Object id = freezed,
    Object spaceId = freezed,
    Object entryDate = freezed,
    Object exitDate = freezed,
    Object idDocument = freezed,
  }) {
    return _then(_value.copyWith(
      id: id == freezed ? _value.id : id as String,
      spaceId: spaceId == freezed ? _value.spaceId : spaceId as String,
      entryDate:
          entryDate == freezed ? _value.entryDate : entryDate as DateTime,
      exitDate: exitDate == freezed ? _value.exitDate : exitDate as DateTime,
      idDocument:
          idDocument == freezed ? _value.idDocument : idDocument as IdDocument,
    ));
  }

  @override
  $IdDocumentCopyWith<$Res> get idDocument {
    if (_value.idDocument == null) {
      return null;
    }
    return $IdDocumentCopyWith<$Res>(_value.idDocument, (value) {
      return _then(_value.copyWith(idDocument: value));
    });
  }
}

abstract class _$AccessCopyWith<$Res> implements $AccessCopyWith<$Res> {
  factory _$AccessCopyWith(_Access value, $Res Function(_Access) then) =
      __$AccessCopyWithImpl<$Res>;
  @override
  $Res call(
      {String id,
      String spaceId,
      DateTime entryDate,
      DateTime exitDate,
      IdDocument idDocument});

  @override
  $IdDocumentCopyWith<$Res> get idDocument;
}

class __$AccessCopyWithImpl<$Res> extends _$AccessCopyWithImpl<$Res>
    implements _$AccessCopyWith<$Res> {
  __$AccessCopyWithImpl(_Access _value, $Res Function(_Access) _then)
      : super(_value, (v) => _then(v as _Access));

  @override
  _Access get _value => super._value as _Access;

  @override
  $Res call({
    Object id = freezed,
    Object spaceId = freezed,
    Object entryDate = freezed,
    Object exitDate = freezed,
    Object idDocument = freezed,
  }) {
    return _then(_Access(
      id: id == freezed ? _value.id : id as String,
      spaceId: spaceId == freezed ? _value.spaceId : spaceId as String,
      entryDate:
          entryDate == freezed ? _value.entryDate : entryDate as DateTime,
      exitDate: exitDate == freezed ? _value.exitDate : exitDate as DateTime,
      idDocument:
          idDocument == freezed ? _value.idDocument : idDocument as IdDocument,
    ));
  }
}

@JsonSerializable()
class _$_Access with DiagnosticableTreeMixin implements _Access {
  const _$_Access(
      {@required this.id,
      @required this.spaceId,
      @required this.entryDate,
      @required this.exitDate,
      @required this.idDocument})
      : assert(id != null),
        assert(spaceId != null),
        assert(entryDate != null),
        assert(exitDate != null),
        assert(idDocument != null);

  factory _$_Access.fromJson(Map<String, dynamic> json) =>
      _$_$_AccessFromJson(json);

  @override
  final String id;
  @override
  final String spaceId;
  @override
  final DateTime entryDate;
  @override
  final DateTime exitDate;
  @override
  final IdDocument idDocument;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'Access(id: $id, spaceId: $spaceId, entryDate: $entryDate, exitDate: $exitDate, idDocument: $idDocument)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'Access'))
      ..add(DiagnosticsProperty('id', id))
      ..add(DiagnosticsProperty('spaceId', spaceId))
      ..add(DiagnosticsProperty('entryDate', entryDate))
      ..add(DiagnosticsProperty('exitDate', exitDate))
      ..add(DiagnosticsProperty('idDocument', idDocument));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _Access &&
            (identical(other.id, id) ||
                const DeepCollectionEquality().equals(other.id, id)) &&
            (identical(other.spaceId, spaceId) ||
                const DeepCollectionEquality()
                    .equals(other.spaceId, spaceId)) &&
            (identical(other.entryDate, entryDate) ||
                const DeepCollectionEquality()
                    .equals(other.entryDate, entryDate)) &&
            (identical(other.exitDate, exitDate) ||
                const DeepCollectionEquality()
                    .equals(other.exitDate, exitDate)) &&
            (identical(other.idDocument, idDocument) ||
                const DeepCollectionEquality()
                    .equals(other.idDocument, idDocument)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(id) ^
      const DeepCollectionEquality().hash(spaceId) ^
      const DeepCollectionEquality().hash(entryDate) ^
      const DeepCollectionEquality().hash(exitDate) ^
      const DeepCollectionEquality().hash(idDocument);

  @override
  _$AccessCopyWith<_Access> get copyWith =>
      __$AccessCopyWithImpl<_Access>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$_$_AccessToJson(this);
  }
}

abstract class _Access implements Access {
  const factory _Access(
      {@required String id,
      @required String spaceId,
      @required DateTime entryDate,
      @required DateTime exitDate,
      @required IdDocument idDocument}) = _$_Access;

  factory _Access.fromJson(Map<String, dynamic> json) = _$_Access.fromJson;

  @override
  String get id;
  @override
  String get spaceId;
  @override
  DateTime get entryDate;
  @override
  DateTime get exitDate;
  @override
  IdDocument get idDocument;
  @override
  _$AccessCopyWith<_Access> get copyWith;
}
