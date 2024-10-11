part of 'contractor_shift_bloc.dart';

@freezed
class ContractorShiftState with _$ContractorShiftState {
  factory ContractorShiftState({
    required int selectedTab,
    required int selectedAppliedTab,
    required InputEmptyOrNot deletePostReason,
    required bool showErrorMessages,
    required bool isLoading,
    required bool isNoDataFound,
    required bool isErrorInAPI,

    /// upcoming
    required bool isUpcomingLoading,
    required bool isUpcomingNoDataFound,
    required bool isUpcomingErrorInAPI,

    /// applied
    required bool isAppliedLoading,
    required bool isAppliedNoDataFound,
    required bool isAppliedErrorInAPI,

    /// applied
    required bool isCounterLoading,
    required bool isCounterNoDataFound,
    required bool isCounterErrorInAPI,

    ///
    required List<CurrentShiftDTO> currentShiftList,
    required List<AppliedShiftDTO> appliedList,
    required List<AppliedShiftDTO> counterList,
    required List<UpComingShiftDTO> upcomingShiftList,
    required Option<Either<MainFailure, HealthcarePostDTO>>
        currentShiftFailureOrSuccessOption,
    // required Duration remainingRevokeTime,
  }) = _ContractorShiftState;
  factory ContractorShiftState.initial() => ContractorShiftState(
        // remainingRevokeTime: Duration(hours: 2),
        selectedTab: 1,
        selectedAppliedTab: 0,
        deletePostReason: InputEmptyOrNot(""),
        currentShiftList: [],
        upcomingShiftList: [],
        appliedList: [],
        counterList: [],
        isCounterErrorInAPI: false,
        isCounterLoading: false,
        isCounterNoDataFound: false,
        isErrorInAPI: false,
        isLoading: false,
        isNoDataFound: false,
        isUpcomingErrorInAPI: false,
        isUpcomingLoading: false,
        isUpcomingNoDataFound: false,
        isAppliedErrorInAPI: false,
        isAppliedLoading: false,
        isAppliedNoDataFound: false,
        showErrorMessages: false,
        currentShiftFailureOrSuccessOption: none(),
      );
}
