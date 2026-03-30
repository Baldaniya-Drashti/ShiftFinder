part of 'faq_bloc.dart';

@freezed
class FaqState with _$FaqState {
  const factory FaqState({
    required bool isLoading,
    required List<FaqDTO> faqList,
    required bool showErrorMessages,
    required bool noDataFound,
    required bool errorApi,
    required bool getDataLoading,
  }) = _FaqState;

  factory FaqState.initial() => FaqState(
        faqList: [],
        isLoading: false,
        showErrorMessages: false,
        errorApi: false,
        getDataLoading: false,
        noDataFound: false,
      );
}
