part of 'shifts_bloc_bloc.dart';

@freezed
class ShiftsBlocState with _$ShiftsBlocState {
  factory ShiftsBlocState({
    required int selectedTab,
    required int pageIndex,
    required bool isSubmitting,
    required bool isLoading,
    required bool showErrorMessages,
    required InputEmptyOrNot deleteReason,
    required List<Predictions> searchLocationList,
    required PlaceDetailDTO selectedAddress,
    required SingleValueDropDownController singleValueDropDownController,
    required SingleValueDropDownController cancelledShiftSortByController,
    required SingleValueDropDownController
        cancelledShiftSortByLocationController,
    required SingleValueDropDownController
        singleValueApprovedShiftDropDownController,
    required List<LocationDTO> locationList,
    required TimeOfDay clockIn,
    required TimeOfDay clockOut,
    required Option<Either<AccountFailure, Account>> authFailureOrSuccessOption,
    required bool postDataLoading,
    required bool noDataFound,
    required bool errorApi,
    required bool getDataLoading,
    required List<EmployerShiftDto> filledShiftList,

    /// Approve
    required bool noApproveDataFound,
    required bool approveErrorApi,
    required bool approveLoading,
    required List<EmployerShiftDto> approveShiftList,

    /// Cancel
    required bool noCancelDataFound,
    required bool cancelErrorApi,
    required bool cancelLoading,
    required List<EmployerShiftDto> cancelledShiftList,

    ///
    required LocationDTO currentFilledFilter,
    required LocationDTO currentApproveFilter,
    required LocationDTO currentCancelLocationFilter,
    required SkillDTO currentCancelFilter,
  }) = _ShiftsBlocState;

  factory ShiftsBlocState.initial() => ShiftsBlocState(
        currentFilledFilter: LocationDTO(),

        /// APPROVE
        approveErrorApi: false,
        approveLoading: false,
        noApproveDataFound: false,
        currentApproveFilter: LocationDTO(),

        /// CACNEL SHIFT
        currentCancelFilter: SkillDTO(
          id: 1,
          name: StringConstant.cancelledByYou,
        ),
        currentCancelLocationFilter: LocationDTO(),
        cancelErrorApi: false,
        cancelLoading: false,
        noCancelDataFound: false,

        ///
        selectedTab: 0,
        pageIndex: 0,
        isSubmitting: false,
        isLoading: false,
        showErrorMessages: false,
        deleteReason: InputEmptyOrNot(''),
        searchLocationList: [],
        selectedAddress: PlaceDetailDTO(),
        authFailureOrSuccessOption: none(),
        locationList: [],
        singleValueDropDownController: SingleValueDropDownController(),
        singleValueApprovedShiftDropDownController:
            SingleValueDropDownController(),
        clockIn: TimeOfDay.now(),
        clockOut: TimeOfDay.now(),
        cancelledShiftSortByController: SingleValueDropDownController(
          data: DropDownValueModel(name: "Cancelled by You", value: 1),
        ),
        cancelledShiftSortByLocationController: SingleValueDropDownController(),
        errorApi: false,
        getDataLoading: false,
        noDataFound: false,
        postDataLoading: false,
        approveShiftList: [],
        cancelledShiftList: [],
        filledShiftList: [],
      );
}
