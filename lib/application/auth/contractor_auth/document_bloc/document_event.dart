part of 'document_bloc.dart';

@freezed
class DocumentEvent with _$DocumentEvent {
  const factory DocumentEvent.nextPage(int page) = _NextPage;
  const factory DocumentEvent.submitDocumentsEvent() = _SubmitDocumentsEvent;
  const factory DocumentEvent.getAllDocumentStatus({bool? isUpdate}) =
      _GetAllDocumentStatus;
  // FOR GOVERNMENT DOCUMENT

  const factory DocumentEvent.selectGovermentDoc(String govermentDoc) =
      _SelectGovermentDoc;
  const factory DocumentEvent.selectGovermentFrontDoc(String govermentDoc) =
      _SelectGovermentFrontDoc;
  const factory DocumentEvent.selectGovermentBackDoc(String govermentDoc) =
      _SelectGovermentBackDoc;
  factory DocumentEvent.selectGovenmentType(SkillDTO selectedType) =
      SelectGovenmentType;
  const factory DocumentEvent.getGovermentDoc() = _GetGovermentDoc;
  const factory DocumentEvent.checkNAGovermentExpiryDate(bool isCheck) =
      CheckNAGovermentExpiryDate;
  const factory DocumentEvent.govermentExpiryDateChanged(String expiryDate) =
      _GovermentExpiryDateChanged;
  const factory DocumentEvent.deleteGovermentDoc(String govermentDoc) =
      _DeleteGovermentDoc;
  const factory DocumentEvent.deleteGovermentFrontDoc(
      String govermentFrontDoc) = _DeleteGovermentFrontDoc;
  const factory DocumentEvent.deleteGovermentBackDoc(String govermentBackDoc) =
      _DeleteGovermentBackDoc;
  const factory DocumentEvent.govermentDocSubmit(BuildContext context) =
      _GovermentDocSubmit;

  // FOR COVID DOCUMENT
  const factory DocumentEvent.selectCovidVaccinationDoc(String covidDoc) =
      _SelectCovidVaccinationDoc;
  const factory DocumentEvent.deleteCovidDoc(String covidDoc) = _DeleteCovidDoc;
  const factory DocumentEvent.getCovidDoc() = _GetCovidDoc;

  const factory DocumentEvent.covidDocSubmit(BuildContext context,
      {required bool isSkip}) = _CovidDocSubmit;
  const factory DocumentEvent.govtDocumentTitleChanged(String documentTitle) =
      GovtDocumentTitleChanged;

  // /// FOR CREDENTIALS-REGISTRATION DOCUMENT
  // const factory DocumentEvent.registrationNumberChanegd(String registrationNo) =
  //     _RegistrationNumberChanegd;
  // const factory DocumentEvent.documentTitleChanged(String documentTitle) =
  //     _DocumentTitleChanged;
  // const factory DocumentEvent.selectProvinceRegistration(
  //     String provinceRegistration) = _SelectProvinceRegistration;
  // const factory DocumentEvent.selectCredentialDoc(String credentialDoc) =
  //     _SelectCredentialRegistrationDoc;
  // const factory DocumentEvent.deleteCredentialDoc(String credentialDoc) =
  //     _DeleteCredentialDoc;
  // const factory DocumentEvent.addMoreCredentialDoc() = _AddMoreCredentialDoc;
  // const factory DocumentEvent.deleteCredentialObject(int index) =
  //     _DeleteCredentialObject;
  // const factory DocumentEvent.credentialDocSubmit(
  //     {required bool isAddMoreBtnClick}) = _CredentialDocSubmit;
}

@freezed
class CredentialEvent with _$CredentialEvent {
  /// FOR CREDENTIALS-REGISTRATION DOCUMENT
  const factory CredentialEvent.getCredentialDocList() = GetCredentialDocList;
  const factory CredentialEvent.checkNACredExpiryDate(bool isCheck) =
      CheckNACredExpiryDate;
  const factory CredentialEvent.credExpiryDateChanged(String expiryDate) =
      _CredExpiryDateChanged;
  const factory CredentialEvent.registrationNumberChanegd(
      String registrationNo) = _RegistrationNumberChanegd;
  const factory CredentialEvent.documentTitleChanged(String documentTitle) =
      _DocumentTitleChanged;
  const factory CredentialEvent.selectProvinceRegistration(
      String provinceRegistration) = _SelectProvinceRegistration;
  const factory CredentialEvent.selectCredentialDoc(String credentialDoc) =
      _SelectCredentialRegistrationDoc;
  const factory CredentialEvent.deleteCredentialDoc(String credentialDoc) =
      _DeleteCredentialDoc;
  const factory CredentialEvent.addMoreCredentialDoc() = _AddMoreCredentialDoc;
  const factory CredentialEvent.deleteCredentialObject(int index) =
      _DeleteCredentialObject;
  const factory CredentialEvent.credentialDocSubmit(BuildContext context,
      {required bool isAddMoreBtnClick,
      required bool isSkip}) = _CredentialDocSubmit;

  const factory CredentialEvent.credDocUpdate(BuildContext context,
      {required int? id}) = CredDocUpdate;

  const factory CredentialEvent.getCurrentCredDoc(DocumentDTO? currentCred) =
      GetCurrentCredDoc;
}

@freezed
class ProfessionalLicensesEvent with _$ProfessionalLicensesEvent {
  /// FOR PROFESSIONAL LICENSES DOCUMENT
  const factory ProfessionalLicensesEvent.getCurrentLicenseDoc(
      DocumentDTO? currentCred) = GetCurrentLicenseDoc;
  const factory ProfessionalLicensesEvent.licenseDocUpdate(BuildContext context,
      {required int? id}) = LicenseDocUpdate;
  const factory ProfessionalLicensesEvent.getProfessinalLicensesList() =
      GetProfessinalLicensesList;
  const factory ProfessionalLicensesEvent.checkNALicensesExpiryDate(
      bool isCheck) = CheckNALicensesExpiryDate;
  const factory ProfessionalLicensesEvent.licensesExpiryDateChanged(
      String expiryDate) = _LicensesExpiryDateChanged;
  const factory ProfessionalLicensesEvent.licensesRegistrationNumberChanegd(
      String registrationNo) = _LicensesRegistrationNumberChanegd;
  const factory ProfessionalLicensesEvent.licensesDocumentTitleChanged(
      String documentTitle) = _LicensesDocumentTitleChanged;
  const factory ProfessionalLicensesEvent.selectProvinceLicenses(
      String provinceRegistration) = _SelectProvinceLicenses;
  const factory ProfessionalLicensesEvent.selectLicensesDoc(
      String licensesDoc) = _SelectLicensesDoc;
  const factory ProfessionalLicensesEvent.deleteLicensesDoc(
      String licensesDoc) = _DeleteLicensesDoc;
  const factory ProfessionalLicensesEvent.addMoreLicensesDoc() =
      _AddMoreLicensesDoc;
  const factory ProfessionalLicensesEvent.deleteLicensesObject(int index) =
      _DeleteLicensesObject;
  const factory ProfessionalLicensesEvent.licensesDocSubmit(
      BuildContext context,
      {required bool isAddMoreBtnClick,
      required bool isSkip}) = _LicensesDocSubmit;
}

@freezed
class ImmunizationEvent with _$ImmunizationEvent {
  /// FOR Immunizations-Vaccinations DOCUMENT
  const factory ImmunizationEvent.getCurrentImmunizationDoc(
      DocumentDTO? currentCred) = GetCurrentImmunizationDoc;
  const factory ImmunizationEvent.immunizationDocUpdate(BuildContext context,
      {required int? id}) = ImmunizationDocUpdate;
  const factory ImmunizationEvent.getImmunizationDataOnInit() =
      _GetImmunizationDataOnInit;
  const factory ImmunizationEvent.immunizationsNameChanegd(
      String immunizationsName) = _ImmunizationsNameChanegd;
  const factory ImmunizationEvent.checkNAImmunizationExpiryDate(bool isCheck) =
      CheckNAImmunizationExpiryDate;
  const factory ImmunizationEvent.immunizationExpiryDateChanged(
      String expiryDate) = _ImmunizationExpiryDateChanged;
  const factory ImmunizationEvent.selectImmunizationDoc(
      String immunizationDoc) = _SelectImmunizationDoc;
  const factory ImmunizationEvent.deleteImmunizationDoc(
      String immunizationDoc) = _DeleteImmunizationDoc;
  const factory ImmunizationEvent.addMoreImmunizationDoc() =
      _AddMoreImmunizationDoc;
  const factory ImmunizationEvent.deleteImmunizationObject(int index) =
      _DeleteImmunizationObject;
  const factory ImmunizationEvent.immunizationDocSubmit(BuildContext context,
      {required bool isAddMoreBtnClick,
      required bool isSkip}) = _ImmunizationDocSubmit;
}

@freezed
class ProfessionalLiabilityEvent with _$ProfessionalLiabilityEvent {
  /// FOR Professional Liability Protection DOCUMENT
  const factory ProfessionalLiabilityEvent.getCurrentDoc(
      DocumentDTO? currentCred) = GetCurrentDoc;

  const factory ProfessionalLiabilityEvent.liabilityDocUpdate(
      BuildContext context,
      {required int? id}) = LiabilityDocUpdate;
  const factory ProfessionalLiabilityEvent.getLiabilityList() =
      GetLiabilityList;
  const factory ProfessionalLiabilityEvent.checkNALiabilityExpiryDate(
      bool isCheck) = CheckNALiabilityExpiryDate;
  const factory ProfessionalLiabilityEvent.liabilityExpiryDateChanged(
      String expiryDate) = _LiabilityExpiryDateChanged;
  const factory ProfessionalLiabilityEvent.selectLiabilityDoc(
      String liabilityDoc) = _SelectLiabilityDoc;
  const factory ProfessionalLiabilityEvent.deleteLiabilityDoc(
      String liabilityDoc) = _DeleteLiabilityDoc;
  const factory ProfessionalLiabilityEvent.addMoreLiabilityDoc() =
      _AddMoreLiabilityDoc;
  const factory ProfessionalLiabilityEvent.deleteLiabilityObject(int index) =
      _DeleteLiabilityObject;
  const factory ProfessionalLiabilityEvent.liabilityDocSubmit(
      BuildContext context,
      {required bool isAddMoreBtnClick,
      required bool isSkip}) = _LiabilityDocSubmit;
}

@freezed
class ResumeEvent with _$ResumeEvent {
  /// FOR Resume DOCUMENT
  const factory ResumeEvent.getResumeDoc() = GetResumeDoc;
  const factory ResumeEvent.selectResumeDoc(String resumeDoc) =
      _SelectResumeDoc;
  const factory ResumeEvent.deleteResumeDoc(String resumeDoc) =
      _DeleteResumeDoc;
  const factory ResumeEvent.resumeDocSubmit(BuildContext context,
      {required bool isSkip}) = _ResumeDocSubmit;
}

@freezed
class EquipmentEvent with _$EquipmentEvent {
  /// FOR Apparel/Equipment DOCUMENT
  const factory EquipmentEvent.getCurrentEquipmentDoc(
      DocumentDTO? currentCred) = GetCurrentEquipmentDoc;

  const factory EquipmentEvent.equipmentDocUpdate(BuildContext context,
      {required int? id}) = EquipmentDocUpdate;
  const factory EquipmentEvent.getEquipmentList() = GetEquipmentList;
  const factory EquipmentEvent.equipmentNameChanegd(String equipmentName) =
      _EquipmentNameChanegd;

  const factory EquipmentEvent.selectEquipmentDoc(String equipmentDoc) =
      _SelectEquipmentDoc;
  const factory EquipmentEvent.deleteEquipmentDoc(String equipmentDoc) =
      _DeleteEquipmentDoc;
  const factory EquipmentEvent.addMoreEquipmentDoc() = _AddMoreEquipmentDoc;
  const factory EquipmentEvent.deleteEquipmentObject(int index) =
      _DeleteEquipmentObject;
  const factory EquipmentEvent.equipmentDocSubmit(BuildContext context,
      {required bool isAddMoreBtnClick,
      required bool isSkip}) = _EquipmentDocSubmit;
}
