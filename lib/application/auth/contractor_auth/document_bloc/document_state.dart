// ignore_for_file: prefer_const_constructors

part of 'document_bloc.dart';

@freezed
class DocumentState with _$DocumentState {
  const factory DocumentState({
    required bool isUpdate,
    required int currentPage,
    required List<DocumentDTO> allDocumentList,
    required bool allListLoading,

    /// FOR GOVERNMENT DOCUMENT
    required bool isLoading,
    required int govermentDocId,
    required DocumentDTO existingGovermentDoc,
    required SkillDTO currentGovermentDocType,
    required List<SkillDTO> govermentDropDownList,
    required InputEmptyOrNot govmentDocTitle,
    required InputEmptyOrNot govermentDoc,
    required InputEmptyOrNot govermentFrontDoc,
    required InputEmptyOrNot govermentBackDoc,
    required bool isGovernemtExpiryCheck,
    required String governmentExpiryDate,
    required bool showGovernmentIdErrorMessages,
    required bool isGovermentDocSubmitting,
    required Option<Either<AccountFailure, String>>
        governmentDocAuthFailureOrSuccessOption,

    /// FOR COVID DOCUMENT
    required InputEmptyOrNot covidVaccinationDoc,
    required bool showCovidErrorMessages,
    required int covidDocId,
    required bool isCovidDocSubmitting,
    required Option<Either<AccountFailure, String>>
        coviDocAuthFailureOrSuccessOption,

    /// SUBMIT
    required bool isSubmitting,
    required bool showErrorMessages,
    required Option<Either<AccountFailure, Account>>
        continueFailureOrSuccessOption,
    required Option<Either<AccountFailure, List<DocumentDTO>>>
        authFailureOrSuccessOption,
  }) = _DocumentState;
  factory DocumentState.initial() => DocumentState(
        isUpdate: false,
        currentPage: 0,
        isLoading: false,
        allDocumentList: [],
        allListLoading: false,

        /// FOR GOVERNMENT DOCUMENT
        govermentDoc: InputEmptyOrNot(""),
        govermentFrontDoc: InputEmptyOrNot(""),
        govermentBackDoc: InputEmptyOrNot(""),
        currentGovermentDocType: SkillDTO(),
        govermentDropDownList: CommonList.govermentIdList,
        govmentDocTitle: InputEmptyOrNot(""),
        showGovernmentIdErrorMessages: false,
        isGovermentDocSubmitting: false,
        isGovernemtExpiryCheck: false,
        governmentExpiryDate: "",
        govermentDocId: -1,
        governmentDocAuthFailureOrSuccessOption: none(),

        /// FOR COVID DOCUMENT
        covidVaccinationDoc: InputEmptyOrNot(""),
        showCovidErrorMessages: false,
        isCovidDocSubmitting: false,
        covidDocId: -1,

        coviDocAuthFailureOrSuccessOption: none(),

        ///
        isSubmitting: false,
        showErrorMessages: false,
        authFailureOrSuccessOption: none(),
        continueFailureOrSuccessOption: none(),
        existingGovermentDoc: DocumentDTO(),
      );
}

@freezed
class CredentialState with _$CredentialState {
  const factory CredentialState({
    /// FOR CREDENTIALS-REGISTRATION DOCUMENT
    required bool isLoading,
    required List<DocumentDTO> credentialRegistrationList,
    required String registrationNumber,
    // required InputEmptyOrNot provinceRegistration,
    required InputEmptyOrNot documentTitle,
    required InputEmptyOrNot credentialRegistrationDoc,
    required InputEmptyOrNot selectedProvinceRegistration,
    required bool isCredExpiryCheck,
    required String credentialExpiryDate,
    required bool showCredintialErrorMessages,
    required bool isCredintialDocSubmitting,
    required Option<Either<AccountFailure, Account>>
        credintialDocAuthFailureOrSuccessOption,
  }) = _CredentialState;
  factory CredentialState.initial() => CredentialState(
        /// FOR CREDENTIALS-REGISTRATION DOCUMENT
        isLoading: false,
        credentialRegistrationList: [],
        registrationNumber: "",
        documentTitle: InputEmptyOrNot(""),
        credentialRegistrationDoc: InputEmptyOrNot(""),
        selectedProvinceRegistration: InputEmptyOrNot(""),
        showCredintialErrorMessages: false,
        isCredintialDocSubmitting: false,
        credentialExpiryDate: "",
        isCredExpiryCheck: false,
        credintialDocAuthFailureOrSuccessOption: none(),
      );
}

@freezed
class ProfessionalLicensesState with _$ProfessionalLicensesState {
  const factory ProfessionalLicensesState({
    /// FOR PROFESSIONAL LICENSES DOCUMENT
    required List<DocumentDTO> professionalLicensesList,
    required String registrationNumber,
    required InputEmptyOrNot documentTitle,
    required bool isLicensesExpiryCheck,
    required String licensesExpiryDate,
    required InputEmptyOrNot professionalLicensesDoc,
    required InputEmptyOrNot selectedProvinceRegistration,
    required bool showLicensesErrorMessages,
    required bool isLicensesDocSubmitting,
    required Option<Either<AccountFailure, Account>>
        licensesDocAuthFailureOrSuccessOption,
  }) = _ProfessionalLicensesState;
  factory ProfessionalLicensesState.initial() => ProfessionalLicensesState(
        /// FOR PROFESSIONAL LICENSES DOCUMENT

        professionalLicensesList: [],
        isLicensesExpiryCheck: false,
        licensesExpiryDate: "",
        registrationNumber: "",
        documentTitle: InputEmptyOrNot(""),
        professionalLicensesDoc: InputEmptyOrNot(""),
        selectedProvinceRegistration: InputEmptyOrNot(""),
        showLicensesErrorMessages: false,
        isLicensesDocSubmitting: false,
        licensesDocAuthFailureOrSuccessOption: none(),
      );
}

@freezed
class ImmunizationState with _$ImmunizationState {
  const factory ImmunizationState({
    /// FOR Immunizations-Vaccinations DOCUMENT
    required List<DocumentDTO> immunizationList,
    required InputEmptyOrNot immunizationName,
    required InputEmptyOrNot immunizationDoc,
    required bool showImmunizationErrorMessages,
    required bool isImmunizationExpiryCheck,
    required String immunizationExpiryDate,
    required bool isImmunizationDocSubmitting,
    required Option<Either<AccountFailure, Account>>
        immunizationDocAuthFailureOrSuccessOption,
  }) = _ImmunizationState;
  factory ImmunizationState.initial() => ImmunizationState(
        /// FOR Immunizations-Vaccinations DOCUMENT
        immunizationList: [],
        immunizationName: InputEmptyOrNot(""),
        immunizationExpiryDate: "",
        isImmunizationExpiryCheck: false,
        immunizationDoc: InputEmptyOrNot(""),
        showImmunizationErrorMessages: false,
        isImmunizationDocSubmitting: false,
        immunizationDocAuthFailureOrSuccessOption: none(),
      );
}

@freezed
class ProfessionalLiabilityState with _$ProfessionalLiabilityState {
  const factory ProfessionalLiabilityState({
    /// FOR Professional Liability Protection DOCUMENT
    required List<DocumentDTO> liabilityList,
    required InputEmptyOrNot liabilityDoc,
    required bool isLiabilityExpiryCheck,
    required String liabilityExpiryDate,
    required bool showLiabilityErrorMessages,
    required bool isLiabilityDocSubmitting,
    required Option<Either<AccountFailure, Account>>
        liabilityDocAuthFailureOrSuccessOption,
  }) = _ProfessionalLiabilityState;
  factory ProfessionalLiabilityState.initial() => ProfessionalLiabilityState(
        /// FOR Professional Liability Protection DOCUMENT
        liabilityList: [],
        liabilityDoc: InputEmptyOrNot(""),
        liabilityExpiryDate: "",
        isLiabilityExpiryCheck: false,
        showLiabilityErrorMessages: false,
        isLiabilityDocSubmitting: false,
        liabilityDocAuthFailureOrSuccessOption: none(),
      );
}

@freezed
class ResumeState with _$ResumeState {
  const factory ResumeState({
    /// FOR RESUME DOCUMENT
    // required InputEmptyOrNot resumeDoc,
    required DocumentDTO resume,
    required bool showResumeErrorMessages,
    required bool isResumeDocSubmitting,
    required Option<Either<AccountFailure, Account>>
        resumeDocAuthFailureOrSuccessOption,
  }) = _ResumeState;
  factory ResumeState.initial() => ResumeState(
        /// FOR RESUME DOCUMENT
        // resumeDoc: InputEmptyOrNot(""),
        resume: DocumentDTO(),
        showResumeErrorMessages: false,
        isResumeDocSubmitting: false,
        resumeDocAuthFailureOrSuccessOption: none(),
      );
}

@freezed
class EquipmentState with _$EquipmentState {
  const factory EquipmentState({
    /// FOR Apparel/Equipment DOCUMENT
    required List<DocumentDTO> equipmentList,
    required InputEmptyOrNot equipmentName,
    required InputEmptyOrNot equipmentDoc,
    required bool showEquipmentErrorMessages,
    required bool isEquipmentDocSubmitting,
    required Option<Either<AccountFailure, Account>>
        equipmentDocAuthFailureOrSuccessOption,
    required Option<Either<AccountFailure, Account>>
        submitDocAuthFailureOrSuccessOption,
  }) = _EquipmentState;
  factory EquipmentState.initial() => EquipmentState(
        equipmentList: [],
        equipmentName: InputEmptyOrNot(""),
        equipmentDoc: InputEmptyOrNot(""),
        showEquipmentErrorMessages: false,
        isEquipmentDocSubmitting: false,
        submitDocAuthFailureOrSuccessOption: none(),
        equipmentDocAuthFailureOrSuccessOption: none(),
      );
}
