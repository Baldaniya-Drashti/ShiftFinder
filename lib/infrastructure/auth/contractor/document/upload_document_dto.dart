import 'package:freezed_annotation/freezed_annotation.dart';

part 'upload_document_dto.freezed.dart';
part 'upload_document_dto.g.dart';

@freezed
class CredentialRegistrationDTO with _$CredentialRegistrationDTO {
  CredentialRegistrationDTO._();
  factory CredentialRegistrationDTO({
    String? registrationNo,
    String? documentTitle,
    String? credentialDocument,
    String? provinceRegistration,
  }) = _CredentialRegistrationDTO;

  factory CredentialRegistrationDTO.fromJson(Map<String, dynamic> json) =>
      _$CredentialRegistrationDTOFromJson(json);
}

@freezed
class ImmunizationDTO with _$ImmunizationDTO {
  ImmunizationDTO._();
  factory ImmunizationDTO({
    String? nameOfImmunization,
    String? immunizationDocument,
  }) = _ImmunizationDTO;

  factory ImmunizationDTO.fromJson(Map<String, dynamic> json) =>
      _$ImmunizationDTOFromJson(json);
}
