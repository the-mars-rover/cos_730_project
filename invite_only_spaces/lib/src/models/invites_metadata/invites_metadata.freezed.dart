// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named

part of 'invites_metadata.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;
InvitesMetadata _$InvitesMetadataFromJson(Map<String, dynamic> json) {
  return _InvitesMetadata.fromJson(json);
}

class _$InvitesMetadataTearOff {
  const _$InvitesMetadataTearOff();

  _InvitesMetadata call({@required int numInvites}) {
    return _InvitesMetadata(
      numInvites: numInvites,
    );
  }
}

// ignore: unused_element
const $InvitesMetadata = _$InvitesMetadataTearOff();

mixin _$InvitesMetadata {
  int get numInvites;

  Map<String, dynamic> toJson();
  $InvitesMetadataCopyWith<InvitesMetadata> get copyWith;
}

abstract class $InvitesMetadataCopyWith<$Res> {
  factory $InvitesMetadataCopyWith(
          InvitesMetadata value, $Res Function(InvitesMetadata) then) =
      _$InvitesMetadataCopyWithImpl<$Res>;
  $Res call({int numInvites});
}

class _$InvitesMetadataCopyWithImpl<$Res>
    implements $InvitesMetadataCopyWith<$Res> {
  _$InvitesMetadataCopyWithImpl(this._value, this._then);

  final InvitesMetadata _value;
  // ignore: unused_field
  final $Res Function(InvitesMetadata) _then;

  @override
  $Res call({
    Object numInvites = freezed,
  }) {
    return _then(_value.copyWith(
      numInvites: numInvites == freezed ? _value.numInvites : numInvites as int,
    ));
  }
}

abstract class _$InvitesMetadataCopyWith<$Res>
    implements $InvitesMetadataCopyWith<$Res> {
  factory _$InvitesMetadataCopyWith(
          _InvitesMetadata value, $Res Function(_InvitesMetadata) then) =
      __$InvitesMetadataCopyWithImpl<$Res>;
  @override
  $Res call({int numInvites});
}

class __$InvitesMetadataCopyWithImpl<$Res>
    extends _$InvitesMetadataCopyWithImpl<$Res>
    implements _$InvitesMetadataCopyWith<$Res> {
  __$InvitesMetadataCopyWithImpl(
      _InvitesMetadata _value, $Res Function(_InvitesMetadata) _then)
      : super(_value, (v) => _then(v as _InvitesMetadata));

  @override
  _InvitesMetadata get _value => super._value as _InvitesMetadata;

  @override
  $Res call({
    Object numInvites = freezed,
  }) {
    return _then(_InvitesMetadata(
      numInvites: numInvites == freezed ? _value.numInvites : numInvites as int,
    ));
  }
}

@JsonSerializable()
class _$_InvitesMetadata
    with DiagnosticableTreeMixin
    implements _InvitesMetadata {
  const _$_InvitesMetadata({@required this.numInvites})
      : assert(numInvites != null);

  factory _$_InvitesMetadata.fromJson(Map<String, dynamic> json) =>
      _$_$_InvitesMetadataFromJson(json);

  @override
  final int numInvites;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'InvitesMetadata(numInvites: $numInvites)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'InvitesMetadata'))
      ..add(DiagnosticsProperty('numInvites', numInvites));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _InvitesMetadata &&
            (identical(other.numInvites, numInvites) ||
                const DeepCollectionEquality()
                    .equals(other.numInvites, numInvites)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^ const DeepCollectionEquality().hash(numInvites);

  @override
  _$InvitesMetadataCopyWith<_InvitesMetadata> get copyWith =>
      __$InvitesMetadataCopyWithImpl<_InvitesMetadata>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$_$_InvitesMetadataToJson(this);
  }
}

abstract class _InvitesMetadata implements InvitesMetadata {
  const factory _InvitesMetadata({@required int numInvites}) =
      _$_InvitesMetadata;

  factory _InvitesMetadata.fromJson(Map<String, dynamic> json) =
      _$_InvitesMetadata.fromJson;

  @override
  int get numInvites;
  @override
  _$InvitesMetadataCopyWith<_InvitesMetadata> get copyWith;
}
