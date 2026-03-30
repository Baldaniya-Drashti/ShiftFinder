part of 'employer_completed_shift_bloc.dart';

@freezed
class EmployerCompletedShiftState with _$EmployerCompletedShiftState {
  const factory EmployerCompletedShiftState({
    @Default(0) int currentTabIndex,
    @Default(
      RatingDropdownModel(
        value: 1,
        title: "Rating (Ascending to Descending)",
        icon: SvgImageConstant.starFilled,
      ),
    )
    RatingDropdownModel selectedRating,
    @Default(false) postDataLoading,
    @Default(false) allDataListLoading,
    @Default(false) favoriteListLoading,
    @Default(false) blockedListLoading,
    @Default(false) remarkedListLoading,
    @Default(false) allDataListNoDataFound,
    @Default(false) favoriteListNoDataFound,
    @Default(false) blockedListNoDataFound,
    @Default(false) remarkedListNoDataFound,
    @Default(false) allDataListIsErrorApi,
    @Default(false) favoriteListIsErrorApi,
    @Default(false) blockedListIsErrorApi,
    @Default(false) remarkedListIsErrorApi,
    @Default([]) List<EmployerPreviousShiftDto> employerPreviousList,
    @Default([]) List<EmployerPreviousShiftDto> favoritesList,
    @Default([]) List<EmployerPreviousShiftDto> blockedList,
    @Default([]) List<EmployerPreviousShiftDto> remarkedList,
    @Default([]) List<LocationDTO> locationList,
    @Default(LocationDTO()) LocationDTO currentFilledFilter,
  }) = _EmployerCompletedShiftState;
}
