// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'upload_document_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$CredentialRegistrationDTOImpl _$$CredentialRegistrationDTOImplFromJson(
        Map<String, dynamic> json) =>
    _$CredentialRegistrationDTOImpl(
      registrationNo: json['registrationNo'] as String?,
      documentTitle: json['documentTitle'] as String?,
      credentialDocument: json['credentialDocument'] as String?,
      provinceRegistration: json['provinceRegistration'] as String?,
      expiryDate: json['expiryDate'] as String?,
      isExpiryNotApplicable: json['isExpiryNotApplicable'] as bool?,
    );

Map<String, dynamic> _$$CredentialRegistrationDTOImplToJson(
        _$CredentialRegistrationDTOImpl instance) =>
    <String, dynamic>{
      'registrationNo': instance.registrationNo,
      'documentTitle': instance.documentTitle,
      'credentialDocument': instance.credentialDocument,
      'provinceRegistration': instance.provinceRegistration,
      'expiryDate': instance.expiryDate,
      'isExpiryNotApplicable': instance.isExpiryNotApplicable,
    };

_$ImmunizationDTOImpl _$$ImmunizationDTOImplFromJson(
        Map<String, dynamic> json) =>
    _$ImmunizationDTOImpl(
      nameOfImmunization: json['nameOfImmunization'] as String?,
      immunizationDocument: json['immunizationDocument'] as String?,
      expiryDate: json['expiryDate'] as String?,
      isExpiryNotApplicable: json['isExpiryNotApplicable'] as bool?,
    );

Map<String, dynamic> _$$ImmunizationDTOImplToJson(
        _$ImmunizationDTOImpl instance) =>
    <String, dynamic>{
      'nameOfImmunization': instance.nameOfImmunization,
      'immunizationDocument': instance.immunizationDocument,
      'expiryDate': instance.expiryDate,
      'isExpiryNotApplicable': instance.isExpiryNotApplicable,
    };
