part of 'address_proof_bloc.dart';

@freezed
class AddressProofState with _$AddressProofState {
  const factory AddressProofState({
    required bool isLoading,
    required int addressProofDocId,
    required DocumentDTO existingAddressProof,
    required SkillDTO currentAddressProofType,
    required List<SkillDTO> addressProofDropDownList,
    required InputEmptyOrNot addressproofFrontDoc,
    required InputEmptyOrNot addressProofBackDoc,
    required bool showErrorMesages,
    required bool isAddressProofDocSubmitting,
    required Option<Either<AccountFailure, String>>
        addressProofFailureOrSuccessOption,

    /// SUBMIT
    required bool isSubmitting,
  }) = _AddressProofState;
  factory AddressProofState.initial() => AddressProofState(
        isLoading: false,
        addressProofBackDoc: InputEmptyOrNot(""),
        addressproofFrontDoc: InputEmptyOrNot(""),
        currentAddressProofType: SkillDTO(),
        addressProofDropDownList: CommonList.addressProofList,
        showErrorMesages: false,
        isAddressProofDocSubmitting: false,
        addressProofDocId: -1,
        addressProofFailureOrSuccessOption: none(),
        isSubmitting: false,
        existingAddressProof: DocumentDTO(),
      );
}
