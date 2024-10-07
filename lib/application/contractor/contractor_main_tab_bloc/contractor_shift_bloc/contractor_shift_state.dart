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

    ///
    required bool isUpcomingLoading,
    required bool isUpcomingNoDataFound,
    required bool isUpcomingErrorInAPI,

    ///
    required List<CurrentShiftDTO> currentShiftList,
    required List<UpComingShiftDTO> upcomingShiftList,
    required Option<Either<MainFailure, HealthcarePostDTO>>
        currentShiftFailureOrSuccessOption,
  }) = _ContractorShiftState;
  factory ContractorShiftState.initial() => ContractorShiftState(
        selectedTab: 1,
        selectedAppliedTab: 0,
        deletePostReason: InputEmptyOrNot(""),
        currentShiftList: [],
        upcomingShiftList: [],
        isErrorInAPI: false,
        isLoading: false,
        isNoDataFound: false,
        isUpcomingErrorInAPI: false,
        isUpcomingLoading: false,
        isUpcomingNoDataFound: false,
        showErrorMessages: false,
        currentShiftFailureOrSuccessOption: none(),
      );
}
