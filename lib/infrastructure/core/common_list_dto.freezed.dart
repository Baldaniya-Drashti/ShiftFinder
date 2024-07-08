// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'common_list_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

ListDTO _$ListDTOFromJson(Map<String, dynamic> json) {
  return _ListDTO.fromJson(json);
}

/// @nodoc
mixin _$ListDTO {
  String? get title => throw _privateConstructorUsedError;
  int? get id => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ListDTOCopyWith<ListDTO> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ListDTOCopyWith<$Res> {
  factory $ListDTOCopyWith(ListDTO value, $Res Function(ListDTO) then) =
      _$ListDTOCopyWithImpl<$Res, ListDTO>;
  @useResult
  $Res call({String? title, int? id});
}

/// @nodoc
class _$ListDTOCopyWithImpl<$Res, $Val extends ListDTO>
    implements $ListDTOCopyWith<$Res> {
  _$ListDTOCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? title = freezed,
    Object? id = freezed,
  }) {
    return _then(_value.copyWith(
      title: freezed == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String?,
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ListDTOImplCopyWith<$Res> implements $ListDTOCopyWith<$Res> {
  factory _$$ListDTOImplCopyWith(
          _$ListDTOImpl value, $Res Function(_$ListDTOImpl) then) =
      __$$ListDTOImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String? title, int? id});
}

/// @nodoc
class __$$ListDTOImplCopyWithImpl<$Res>
    extends _$ListDTOCopyWithImpl<$Res, _$ListDTOImpl>
    implements _$$ListDTOImplCopyWith<$Res> {
  __$$ListDTOImplCopyWithImpl(
      _$ListDTOImpl _value, $Res Function(_$ListDTOImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? title = freezed,
    Object? id = freezed,
  }) {
    return _then(_$ListDTOImpl(
      title: freezed == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String?,
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ListDTOImpl implements _ListDTO {
  _$ListDTOImpl({this.title, this.id});

  factory _$ListDTOImpl.fromJson(Map<String, dynamic> json) =>
      _$$ListDTOImplFromJson(json);

  @override
  final String? title;
  @override
  final int? id;

  @override
  String toString() {
    return 'ListDTO(title: $title, id: $id)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ListDTOImpl &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.id, id) || other.id == id));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, title, id);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ListDTOImplCopyWith<_$ListDTOImpl> get copyWith =>
      __$$ListDTOImplCopyWithImpl<_$ListDTOImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ListDTOImplToJson(
      this,
    );
  }
}

abstract class _ListDTO implements ListDTO {
  factory _ListDTO({final String? title, final int? id}) = _$ListDTOImpl;

  factory _ListDTO.fromJson(Map<String, dynamic> json) = _$ListDTOImpl.fromJson;

  @override
  String? get title;
  @override
  int? get id;
  @override
  @JsonKey(ignore: true)
  _$$ListDTOImplCopyWith<_$ListDTOImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
