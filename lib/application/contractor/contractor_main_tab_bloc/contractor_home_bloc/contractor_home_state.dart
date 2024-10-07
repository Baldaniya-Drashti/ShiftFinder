part of 'contractor_home_bloc.dart';

@freezed
class ContractorHomeState with _$ContractorHomeState {
  const factory ContractorHomeState({
    required int filterType,
    required bool showErrorMessages,
    required Option<Either<MainFailure, String>> failureOrSuccessOption,
    required bool isSubmitting,
    required bool isLoading,
    required bool isNoDataFound,
    required bool isErrorInAPI,
    required List<ContactorDashboardDTO> contractorDashboardList,
    required Option<Either<MainFailure, HealthcarePostDTO>>
        shiftFailureOrSuccessOption,
    required HealthcarePostDTO shift,
    required Option<Either<MainFailure, String>> applyShiftSuccessOption,
    required bool applyShiftErrorMessages,
  }) = _ContractorHomeState;
  factory ContractorHomeState.initial() => ContractorHomeState(
        showErrorMessages: false,
        failureOrSuccessOption: none(),
        isSubmitting: false,
        contractorDashboardList: [],
        isLoading: false,
        isNoDataFound: false,
        isErrorInAPI: false,
        filterType: 0,
        shift: HealthcarePostDTO(),
        shiftFailureOrSuccessOption: none(),

        /// ON CLICK APPLY BTN
        applyShiftErrorMessages: false,
        applyShiftSuccessOption: none(),
      );
}
