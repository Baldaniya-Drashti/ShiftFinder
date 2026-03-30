part of 'background_doc_bloc.dart';

@freezed
class BackgroundDocState with _$BackgroundDocState {
  const factory BackgroundDocState({
    required bool isLoading,
    required int bgDocId,
    required DocumentDTO existingBgDoc,
    required SkillDTO currentBgDocType,
    required List<SkillDTO> bgDocDropDownList,
    required InputEmptyOrNot bgDocFrontDoc,
    required InputEmptyOrNot bgDocBackDoc,
    required String bgDocIssueDate,
    required bool showErrorMesages,
    required bool isBgDocDocSubmitting,
    required Option<Either<AccountFailure, String>> bgDocFailureOrSuccessOption,

    /// SUBMIT
    required bool isSubmitting,
  }) = _BackgroundDocState;
  factory BackgroundDocState.initial() => BackgroundDocState(
        isLoading: false,
        bgDocBackDoc: InputEmptyOrNot(""),
        bgDocFrontDoc: InputEmptyOrNot(""),
        currentBgDocType: SkillDTO(),
        bgDocDropDownList: CommonList.addressProofList,
        showErrorMesages: false,
        isBgDocDocSubmitting: false,
        bgDocId: -1,
        bgDocFailureOrSuccessOption: none(),
        isSubmitting: false,
        bgDocIssueDate: "",
        existingBgDoc: DocumentDTO(),
      );
}
