part of 'document_bloc.dart';

@freezed
class DocumentState with _$DocumentState {
  const factory DocumentState({
    required int currentPage,

    /// FOR GOVERNMENT DOCUMENT
    required InputEmptyOrNot govermentDoc,
    required bool showGovernmentIdErrorMessages,
    required bool isGovermentDocSubmitting,
    required Option<Either<AuthFailure, String>>
        governmentDocAuthFailureOrSuccessOption,

    /// FOR COVID DOCUMENT
    required InputEmptyOrNot covidVaccinationDoc,
    required bool showCovidErrorMessages,
    required bool isCovidDocSubmitting,
    required Option<Either<AuthFailure, String>>
        coviDocAuthFailureOrSuccessOption,

    /// SUBMIT
    required bool isSubmitting,
    required Option<Either<AuthFailure, String>> authFailureOrSuccessOption,
  }) = _DocumentState;
  factory DocumentState.initial() => DocumentState(
        currentPage: 0,

        /// FOR GOVERNMENT DOCUMENT
        govermentDoc: InputEmptyOrNot(""),
        showGovernmentIdErrorMessages: false,
        isGovermentDocSubmitting: false,
        governmentDocAuthFailureOrSuccessOption: none(),

        /// FOR COVID DOCUMENT
        covidVaccinationDoc: InputEmptyOrNot(""),
        showCovidErrorMessages: false,
        isCovidDocSubmitting: false,
        coviDocAuthFailureOrSuccessOption: none(),

        ///
        isSubmitting: false,
        authFailureOrSuccessOption: none(),
      );
}
