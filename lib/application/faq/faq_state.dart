part of 'faq_bloc.dart';

@freezed
class FaqState with _$FaqState {
  const factory FaqState({
    // required List<bool> expandedStates,
    required bool isLoading,
    required List<Item> faqList,
    required bool showErrorMessages,
    required Option<Either<MainFailure, CommonResponse<dynamic>>>
        failureOrSuccessOption,
  }) = _FaqState;

  factory FaqState.initial() => FaqState(
        // expandedStates: [],
        faqList: [],
        isLoading: false,
        showErrorMessages: false,
        failureOrSuccessOption: none(),
      );
}
