// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'onboarding_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

OnBoardingDTO _$OnBoardingDTOFromJson(Map<String, dynamic> json) {
  return _OnBoardingDTO.fromJson(json);
}

/// @nodoc
mixin _$OnBoardingDTO {
  int? get id => throw _privateConstructorUsedError;
  String? get title => throw _privateConstructorUsedError;
  String? get image => throw _privateConstructorUsedError;
  String? get backgroundImage => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $OnBoardingDTOCopyWith<OnBoardingDTO> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $OnBoardingDTOCopyWith<$Res> {
  factory $OnBoardingDTOCopyWith(
          OnBoardingDTO value, $Res Function(OnBoardingDTO) then) =
      _$OnBoardingDTOCopyWithImpl<$Res, OnBoardingDTO>;
  @useResult
  $Res call(
      {int? id,
      String? title,
      String? image,
      String? backgroundImage,
      String? description});
}

/// @nodoc
class _$OnBoardingDTOCopyWithImpl<$Res, $Val extends OnBoardingDTO>
    implements $OnBoardingDTOCopyWith<$Res> {
  _$OnBoardingDTOCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? title = freezed,
    Object? image = freezed,
    Object? backgroundImage = freezed,
    Object? description = freezed,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      title: freezed == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String?,
      image: freezed == image
          ? _value.image
          : image // ignore: cast_nullable_to_non_nullable
              as String?,
      backgroundImage: freezed == backgroundImage
          ? _value.backgroundImage
          : backgroundImage // ignore: cast_nullable_to_non_nullable
              as String?,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$OnBoardingDTOImplCopyWith<$Res>
    implements $OnBoardingDTOCopyWith<$Res> {
  factory _$$OnBoardingDTOImplCopyWith(
          _$OnBoardingDTOImpl value, $Res Function(_$OnBoardingDTOImpl) then) =
      __$$OnBoardingDTOImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int? id,
      String? title,
      String? image,
      String? backgroundImage,
      String? description});
}

/// @nodoc
class __$$OnBoardingDTOImplCopyWithImpl<$Res>
    extends _$OnBoardingDTOCopyWithImpl<$Res, _$OnBoardingDTOImpl>
    implements _$$OnBoardingDTOImplCopyWith<$Res> {
  __$$OnBoardingDTOImplCopyWithImpl(
      _$OnBoardingDTOImpl _value, $Res Function(_$OnBoardingDTOImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? title = freezed,
    Object? image = freezed,
    Object? backgroundImage = freezed,
    Object? description = freezed,
  }) {
    return _then(_$OnBoardingDTOImpl(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      title: freezed == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String?,
      image: freezed == image
          ? _value.image
          : image // ignore: cast_nullable_to_non_nullable
              as String?,
      backgroundImage: freezed == backgroundImage
          ? _value.backgroundImage
          : backgroundImage // ignore: cast_nullable_to_non_nullable
              as String?,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$OnBoardingDTOImpl implements _OnBoardingDTO {
  _$OnBoardingDTOImpl(
      {this.id,
      this.title,
      this.image,
      this.backgroundImage,
      this.description});

  factory _$OnBoardingDTOImpl.fromJson(Map<String, dynamic> json) =>
      _$$OnBoardingDTOImplFromJson(json);

  @override
  final int? id;
  @override
  final String? title;
  @override
  final String? image;
  @override
  final String? backgroundImage;
  @override
  final String? description;

  @override
  String toString() {
    return 'OnBoardingDTO(id: $id, title: $title, image: $image, backgroundImage: $backgroundImage, description: $description)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$OnBoardingDTOImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.image, image) || other.image == image) &&
            (identical(other.backgroundImage, backgroundImage) ||
                other.backgroundImage == backgroundImage) &&
            (identical(other.description, description) ||
                other.description == description));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, id, title, image, backgroundImage, description);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$OnBoardingDTOImplCopyWith<_$OnBoardingDTOImpl> get copyWith =>
      __$$OnBoardingDTOImplCopyWithImpl<_$OnBoardingDTOImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$OnBoardingDTOImplToJson(
      this,
    );
  }
}

abstract class _OnBoardingDTO implements OnBoardingDTO {
  factory _OnBoardingDTO(
      {final int? id,
      final String? title,
      final String? image,
      final String? backgroundImage,
      final String? description}) = _$OnBoardingDTOImpl;

  factory _OnBoardingDTO.fromJson(Map<String, dynamic> json) =
      _$OnBoardingDTOImpl.fromJson;

  @override
  int? get id;
  @override
  String? get title;
  @override
  String? get image;
  @override
  String? get backgroundImage;
  @override
  String? get description;
  @override
  @JsonKey(ignore: true)
  _$$OnBoardingDTOImplCopyWith<_$OnBoardingDTOImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
