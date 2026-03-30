part of 'proof_of_legal_status_bloc.dart';

@freezed
class ProofOfLegalStatusState with _$ProofOfLegalStatusState {
  const factory ProofOfLegalStatusState({
    required bool isLoading,
    required int selectedDocId,
    required DocumentDTO existingProofDoc,
    required SkillDTO currentProofType,
    required List<SkillDTO> proofDropDownList,
    required InputEmptyOrNot proofFrontDoc,
    required InputEmptyOrNot proofBackDoc,
    required bool showErrorMesages,
    required bool isExpiryInValid,
    required String docExpiryDate,
    required bool isProofDocSubmitting,
    required Option<Either<AccountFailure, String>> proofFailureOrSuccessOption,

    /// SUBMIT
    required bool isSubmitting,
  }) = _ProofOfLegalStatusState;
  factory ProofOfLegalStatusState.initial() => ProofOfLegalStatusState(
        isLoading: false,
        proofBackDoc: InputEmptyOrNot(""),
        proofFrontDoc: InputEmptyOrNot(""),
        currentProofType: SkillDTO(),
        proofDropDownList: CommonList.proofLegalWorkList,
        showErrorMesages: false,
        isExpiryInValid: false,
        isProofDocSubmitting: false,
        selectedDocId: -1,
        proofFailureOrSuccessOption: none(),
        isSubmitting: false,
        docExpiryDate: "",
        existingProofDoc: DocumentDTO(),
      );
}
