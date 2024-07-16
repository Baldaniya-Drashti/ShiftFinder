// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'upload_document_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

CredentialRegistrationDTO _$CredentialRegistrationDTOFromJson(
    Map<String, dynamic> json) {
  return _CredentialRegistrationDTO.fromJson(json);
}

/// @nodoc
mixin _$CredentialRegistrationDTO {
  String? get registrationNo => throw _privateConstructorUsedError;
  String? get documentTitle => throw _privateConstructorUsedError;
  String? get credentialDocument => throw _privateConstructorUsedError;
  String? get provinceRegistration => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $CredentialRegistrationDTOCopyWith<CredentialRegistrationDTO> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CredentialRegistrationDTOCopyWith<$Res> {
  factory $CredentialRegistrationDTOCopyWith(CredentialRegistrationDTO value,
          $Res Function(CredentialRegistrationDTO) then) =
      _$CredentialRegistrationDTOCopyWithImpl<$Res, CredentialRegistrationDTO>;
  @useResult
  $Res call(
      {String? registrationNo,
      String? documentTitle,
      String? credentialDocument,
      String? provinceRegistration});
}

/// @nodoc
class _$CredentialRegistrationDTOCopyWithImpl<$Res,
        $Val extends CredentialRegistrationDTO>
    implements $CredentialRegistrationDTOCopyWith<$Res> {
  _$CredentialRegistrationDTOCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? registrationNo = freezed,
    Object? documentTitle = freezed,
    Object? credentialDocument = freezed,
    Object? provinceRegistration = freezed,
  }) {
    return _then(_value.copyWith(
      registrationNo: freezed == registrationNo
          ? _value.registrationNo
          : registrationNo // ignore: cast_nullable_to_non_nullable
              as String?,
      documentTitle: freezed == documentTitle
          ? _value.documentTitle
          : documentTitle // ignore: cast_nullable_to_non_nullable
              as String?,
      credentialDocument: freezed == credentialDocument
          ? _value.credentialDocument
          : credentialDocument // ignore: cast_nullable_to_non_nullable
              as String?,
      provinceRegistration: freezed == provinceRegistration
          ? _value.provinceRegistration
          : provinceRegistration // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$CredentialRegistrationDTOImplCopyWith<$Res>
    implements $CredentialRegistrationDTOCopyWith<$Res> {
  factory _$$CredentialRegistrationDTOImplCopyWith(
          _$CredentialRegistrationDTOImpl value,
          $Res Function(_$CredentialRegistrationDTOImpl) then) =
      __$$CredentialRegistrationDTOImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? registrationNo,
      String? documentTitle,
      String? credentialDocument,
      String? provinceRegistration});
}

/// @nodoc
class __$$CredentialRegistrationDTOImplCopyWithImpl<$Res>
    extends _$CredentialRegistrationDTOCopyWithImpl<$Res,
        _$CredentialRegistrationDTOImpl>
    implements _$$CredentialRegistrationDTOImplCopyWith<$Res> {
  __$$CredentialRegistrationDTOImplCopyWithImpl(
      _$CredentialRegistrationDTOImpl _value,
      $Res Function(_$CredentialRegistrationDTOImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? registrationNo = freezed,
    Object? documentTitle = freezed,
    Object? credentialDocument = freezed,
    Object? provinceRegistration = freezed,
  }) {
    return _then(_$CredentialRegistrationDTOImpl(
      registrationNo: freezed == registrationNo
          ? _value.registrationNo
          : registrationNo // ignore: cast_nullable_to_non_nullable
              as String?,
      documentTitle: freezed == documentTitle
          ? _value.documentTitle
          : documentTitle // ignore: cast_nullable_to_non_nullable
              as String?,
      credentialDocument: freezed == credentialDocument
          ? _value.credentialDocument
          : credentialDocument // ignore: cast_nullable_to_non_nullable
              as String?,
      provinceRegistration: freezed == provinceRegistration
          ? _value.provinceRegistration
          : provinceRegistration // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$CredentialRegistrationDTOImpl extends _CredentialRegistrationDTO {
  _$CredentialRegistrationDTOImpl(
      {this.registrationNo,
      this.documentTitle,
      this.credentialDocument,
      this.provinceRegistration})
      : super._();

  factory _$CredentialRegistrationDTOImpl.fromJson(Map<String, dynamic> json) =>
      _$$CredentialRegistrationDTOImplFromJson(json);

  @override
  final String? registrationNo;
  @override
  final String? documentTitle;
  @override
  final String? credentialDocument;
  @override
  final String? provinceRegistration;

  @override
  String toString() {
    return 'CredentialRegistrationDTO(registrationNo: $registrationNo, documentTitle: $documentTitle, credentialDocument: $credentialDocument, provinceRegistration: $provinceRegistration)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CredentialRegistrationDTOImpl &&
            (identical(other.registrationNo, registrationNo) ||
                other.registrationNo == registrationNo) &&
            (identical(other.documentTitle, documentTitle) ||
                other.documentTitle == documentTitle) &&
            (identical(other.credentialDocument, credentialDocument) ||
                other.credentialDocument == credentialDocument) &&
            (identical(other.provinceRegistration, provinceRegistration) ||
                other.provinceRegistration == provinceRegistration));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, registrationNo, documentTitle,
      credentialDocument, provinceRegistration);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$CredentialRegistrationDTOImplCopyWith<_$CredentialRegistrationDTOImpl>
      get copyWith => __$$CredentialRegistrationDTOImplCopyWithImpl<
          _$CredentialRegistrationDTOImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CredentialRegistrationDTOImplToJson(
      this,
    );
  }
}

abstract class _CredentialRegistrationDTO extends CredentialRegistrationDTO {
  factory _CredentialRegistrationDTO(
      {final String? registrationNo,
      final String? documentTitle,
      final String? credentialDocument,
      final String? provinceRegistration}) = _$CredentialRegistrationDTOImpl;
  _CredentialRegistrationDTO._() : super._();

  factory _CredentialRegistrationDTO.fromJson(Map<String, dynamic> json) =
      _$CredentialRegistrationDTOImpl.fromJson;

  @override
  String? get registrationNo;
  @override
  String? get documentTitle;
  @override
  String? get credentialDocument;
  @override
  String? get provinceRegistration;
  @override
  @JsonKey(ignore: true)
  _$$CredentialRegistrationDTOImplCopyWith<_$CredentialRegistrationDTOImpl>
      get copyWith => throw _privateConstructorUsedError;
}

ImmunizationDTO _$ImmunizationDTOFromJson(Map<String, dynamic> json) {
  return _ImmunizationDTO.fromJson(json);
}

/// @nodoc
mixin _$ImmunizationDTO {
  String? get nameOfImmunization => throw _privateConstructorUsedError;
  String? get immunizationDocument => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ImmunizationDTOCopyWith<ImmunizationDTO> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ImmunizationDTOCopyWith<$Res> {
  factory $ImmunizationDTOCopyWith(
          ImmunizationDTO value, $Res Function(ImmunizationDTO) then) =
      _$ImmunizationDTOCopyWithImpl<$Res, ImmunizationDTO>;
  @useResult
  $Res call({String? nameOfImmunization, String? immunizationDocument});
}

/// @nodoc
class _$ImmunizationDTOCopyWithImpl<$Res, $Val extends ImmunizationDTO>
    implements $ImmunizationDTOCopyWith<$Res> {
  _$ImmunizationDTOCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? nameOfImmunization = freezed,
    Object? immunizationDocument = freezed,
  }) {
    return _then(_value.copyWith(
      nameOfImmunization: freezed == nameOfImmunization
          ? _value.nameOfImmunization
          : nameOfImmunization // ignore: cast_nullable_to_non_nullable
              as String?,
      immunizationDocument: freezed == immunizationDocument
          ? _value.immunizationDocument
          : immunizationDocument // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ImmunizationDTOImplCopyWith<$Res>
    implements $ImmunizationDTOCopyWith<$Res> {
  factory _$$ImmunizationDTOImplCopyWith(_$ImmunizationDTOImpl value,
          $Res Function(_$ImmunizationDTOImpl) then) =
      __$$ImmunizationDTOImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String? nameOfImmunization, String? immunizationDocument});
}

/// @nodoc
class __$$ImmunizationDTOImplCopyWithImpl<$Res>
    extends _$ImmunizationDTOCopyWithImpl<$Res, _$ImmunizationDTOImpl>
    implements _$$ImmunizationDTOImplCopyWith<$Res> {
  __$$ImmunizationDTOImplCopyWithImpl(
      _$ImmunizationDTOImpl _value, $Res Function(_$ImmunizationDTOImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? nameOfImmunization = freezed,
    Object? immunizationDocument = freezed,
  }) {
    return _then(_$ImmunizationDTOImpl(
      nameOfImmunization: freezed == nameOfImmunization
          ? _value.nameOfImmunization
          : nameOfImmunization // ignore: cast_nullable_to_non_nullable
              as String?,
      immunizationDocument: freezed == immunizationDocument
          ? _value.immunizationDocument
          : immunizationDocument // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ImmunizationDTOImpl extends _ImmunizationDTO {
  _$ImmunizationDTOImpl({this.nameOfImmunization, this.immunizationDocument})
      : super._();

  factory _$ImmunizationDTOImpl.fromJson(Map<String, dynamic> json) =>
      _$$ImmunizationDTOImplFromJson(json);

  @override
  final String? nameOfImmunization;
  @override
  final String? immunizationDocument;

  @override
  String toString() {
    return 'ImmunizationDTO(nameOfImmunization: $nameOfImmunization, immunizationDocument: $immunizationDocument)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ImmunizationDTOImpl &&
            (identical(other.nameOfImmunization, nameOfImmunization) ||
                other.nameOfImmunization == nameOfImmunization) &&
            (identical(other.immunizationDocument, immunizationDocument) ||
                other.immunizationDocument == immunizationDocument));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, nameOfImmunization, immunizationDocument);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ImmunizationDTOImplCopyWith<_$ImmunizationDTOImpl> get copyWith =>
      __$$ImmunizationDTOImplCopyWithImpl<_$ImmunizationDTOImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ImmunizationDTOImplToJson(
      this,
    );
  }
}

abstract class _ImmunizationDTO extends ImmunizationDTO {
  factory _ImmunizationDTO(
      {final String? nameOfImmunization,
      final String? immunizationDocument}) = _$ImmunizationDTOImpl;
  _ImmunizationDTO._() : super._();

  factory _ImmunizationDTO.fromJson(Map<String, dynamic> json) =
      _$ImmunizationDTOImpl.fromJson;

  @override
  String? get nameOfImmunization;
  @override
  String? get immunizationDocument;
  @override
  @JsonKey(ignore: true)
  _$$ImmunizationDTOImplCopyWith<_$ImmunizationDTOImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
