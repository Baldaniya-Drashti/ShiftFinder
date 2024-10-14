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
    required SingleValueDropDownController cancelledShiftSortByLocationController,
    required SingleValueDropDownController singleValueApprovedShiftDropDownController,
    required List<DropDownValueModel> locationList,
    required TimeOfDay clockIn,
    required TimeOfDay clockOut,
    required Option<Either<AccountFailure, Account>> authFailureOrSuccessOption,
    required bool postDataLoading,
    required bool noDataFound,
    required bool errorApi,
    required bool getDataLoading,
    required List<EmployerShiftDto> filledShiftList,
    required List<EmployerShiftDto> approveShiftList,
    required List<EmployerShiftDto> cancelledShiftList,











  }) = _ShiftsBlocState;

  factory ShiftsBlocState.initial() => ShiftsBlocState(
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
        singleValueApprovedShiftDropDownController: SingleValueDropDownController(),
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
