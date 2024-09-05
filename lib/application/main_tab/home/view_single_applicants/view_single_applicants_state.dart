part of 'view_single_applicants_bloc.dart';

@freezed
class ViewSingleApplicantsState with _$ViewSingleApplicantsState {
  const factory ViewSingleApplicantsState({
    required Username cardHoldersName,
    required CardNumber cardNumber,
    required CardDate cardDate,
    required bool showErrorMessages,
    required CVV cvv,
    required Option<Either<MainFailure, String>> failureOrSuccessOption,
    required Option<Either<MainFailure, HealthcarePostDTO>>
        shiftFailureOrSuccessOption,
    required bool isSubmitting,
    required bool isLoading,
    required bool isNoDataFound,
    required bool isErrorInAPI,

    /// View Shift Detail
    required HealthcarePostDTO shift,
  }) = _PaymentMethodState;
  factory ViewSingleApplicantsState.initial() => ViewSingleApplicantsState(
        cardHoldersName: Username(''),
        cardNumber: CardNumber(''),
        cardDate: CardDate(''),
        showErrorMessages: false,
        cvv: CVV(''),
        failureOrSuccessOption: none(),
        isSubmitting: false,
        isLoading: false,
        isNoDataFound: false,
        isErrorInAPI: false,

        /// View Shift Detail
        shift: HealthcarePostDTO(),
        shiftFailureOrSuccessOption: none(),
      );
}
