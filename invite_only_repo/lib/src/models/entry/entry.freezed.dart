// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named

part of 'entry.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;
Entry _$EntryFromJson(Map<String, dynamic> json) {
  return _Entry.fromJson(json);
}

class _$EntryTearOff {
  const _$EntryTearOff();

  _Entry call(
      {int id,
      @required String guardPhone,
      @required DateTime entryDate,
      @required IdDocument idDocument,
      Invite invite}) {
    return _Entry(
      id: id,
      guardPhone: guardPhone,
      entryDate: entryDate,
      idDocument: idDocument,
      invite: invite,
    );
  }
}

// ignore: unused_element
const $Entry = _$EntryTearOff();

mixin _$Entry {
  int get id;
  String get guardPhone;
  DateTime get entryDate;
  IdDocument get idDocument;
  Invite get invite;

  Map<String, dynamic> toJson();
  $EntryCopyWith<Entry> get copyWith;
}

abstract class $EntryCopyWith<$Res> {
  factory $EntryCopyWith(Entry value, $Res Function(Entry) then) =
      _$EntryCopyWithImpl<$Res>;
  $Res call(
      {int id,
      String guardPhone,
      DateTime entryDate,
      IdDocument idDocument,
      Invite invite});

  $IdDocumentCopyWith<$Res> get idDocument;
  $InviteCopyWith<$Res> get invite;
}

class _$EntryCopyWithImpl<$Res> implements $EntryCopyWith<$Res> {
  _$EntryCopyWithImpl(this._value, this._then);

  final Entry _value;
  // ignore: unused_field
  final $Res Function(Entry) _then;

  @override
  $Res call({
    Object id = freezed,
    Object guardPhone = freezed,
    Object entryDate = freezed,
    Object idDocument = freezed,
    Object invite = freezed,
  }) {
    return _then(_value.copyWith(
      id: id == freezed ? _value.id : id as int,
      guardPhone:
          guardPhone == freezed ? _value.guardPhone : guardPhone as String,
      entryDate:
          entryDate == freezed ? _value.entryDate : entryDate as DateTime,
      idDocument:
          idDocument == freezed ? _value.idDocument : idDocument as IdDocument,
      invite: invite == freezed ? _value.invite : invite as Invite,
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

  @override
  $InviteCopyWith<$Res> get invite {
    if (_value.invite == null) {
      return null;
    }
    return $InviteCopyWith<$Res>(_value.invite, (value) {
      return _then(_value.copyWith(invite: value));
    });
  }
}

abstract class _$EntryCopyWith<$Res> implements $EntryCopyWith<$Res> {
  factory _$EntryCopyWith(_Entry value, $Res Function(_Entry) then) =
      __$EntryCopyWithImpl<$Res>;
  @override
  $Res call(
      {int id,
      String guardPhone,
      DateTime entryDate,
      IdDocument idDocument,
      Invite invite});

  @override
  $IdDocumentCopyWith<$Res> get idDocument;
  @override
  $InviteCopyWith<$Res> get invite;
}

class __$EntryCopyWithImpl<$Res> extends _$EntryCopyWithImpl<$Res>
    implements _$EntryCopyWith<$Res> {
  __$EntryCopyWithImpl(_Entry _value, $Res Function(_Entry) _then)
      : super(_value, (v) => _then(v as _Entry));

  @override
  _Entry get _value => super._value as _Entry;

  @override
  $Res call({
    Object id = freezed,
    Object guardPhone = freezed,
    Object entryDate = freezed,
    Object idDocument = freezed,
    Object invite = freezed,
  }) {
    return _then(_Entry(
      id: id == freezed ? _value.id : id as int,
      guardPhone:
          guardPhone == freezed ? _value.guardPhone : guardPhone as String,
      entryDate:
          entryDate == freezed ? _value.entryDate : entryDate as DateTime,
      idDocument:
          idDocument == freezed ? _value.idDocument : idDocument as IdDocument,
      invite: invite == freezed ? _value.invite : invite as Invite,
    ));
  }
}

@JsonSerializable()
class _$_Entry extends _Entry with DiagnosticableTreeMixin {
  const _$_Entry(
      {this.id,
      @required this.guardPhone,
      @required this.entryDate,
      @required this.idDocument,
      this.invite})
      : assert(guardPhone != null),
        assert(entryDate != null),
        assert(idDocument != null),
        super._();

  factory _$_Entry.fromJson(Map<String, dynamic> json) =>
      _$_$_EntryFromJson(json);

  @override
  final int id;
  @override
  final String guardPhone;
  @override
  final DateTime entryDate;
  @override
  final IdDocument idDocument;
  @override
  final Invite invite;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'Entry(id: $id, guardPhone: $guardPhone, entryDate: $entryDate, idDocument: $idDocument, invite: $invite)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'Entry'))
      ..add(DiagnosticsProperty('id', id))
      ..add(DiagnosticsProperty('guardPhone', guardPhone))
      ..add(DiagnosticsProperty('entryDate', entryDate))
      ..add(DiagnosticsProperty('idDocument', idDocument))
      ..add(DiagnosticsProperty('invite', invite));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _Entry &&
            (identical(other.id, id) ||
                const DeepCollectionEquality().equals(other.id, id)) &&
            (identical(other.guardPhone, guardPhone) ||
                const DeepCollectionEquality()
                    .equals(other.guardPhone, guardPhone)) &&
            (identical(other.entryDate, entryDate) ||
                const DeepCollectionEquality()
                    .equals(other.entryDate, entryDate)) &&
            (identical(other.idDocument, idDocument) ||
                const DeepCollectionEquality()
                    .equals(other.idDocument, idDocument)) &&
            (identical(other.invite, invite) ||
                const DeepCollectionEquality().equals(other.invite, invite)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(id) ^
      const DeepCollectionEquality().hash(guardPhone) ^
      const DeepCollectionEquality().hash(entryDate) ^
      const DeepCollectionEquality().hash(idDocument) ^
      const DeepCollectionEquality().hash(invite);

  @override
  _$EntryCopyWith<_Entry> get copyWith =>
      __$EntryCopyWithImpl<_Entry>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$_$_EntryToJson(this);
  }
}

abstract class _Entry extends Entry {
  const _Entry._() : super._();
  const factory _Entry(
      {int id,
      @required String guardPhone,
      @required DateTime entryDate,
      @required IdDocument idDocument,
      Invite invite}) = _$_Entry;

  factory _Entry.fromJson(Map<String, dynamic> json) = _$_Entry.fromJson;

  @override
  int get id;
  @override
  String get guardPhone;
  @override
  DateTime get entryDate;
  @override
  IdDocument get idDocument;
  @override
  Invite get invite;
  @override
  _$EntryCopyWith<_Entry> get copyWith;
}
