part of 'previous_shift_bloc.dart';

@freezed
class PreviousShiftState with _$PreviousShiftState {
  const factory PreviousShiftState({
    @Default(0) int currentTabIndex,
    @Default(5) int selectedRating,
    @Default(false) getDataLoading ,
    @Default(false) favoriteListLoading ,
    @Default(false) blockedListLoading ,
    @Default(false) remarkedListLoading ,
    @Default(false) postDataLoading ,

    @Default(false) noDataFound,
    @Default(false) favoriteListNoDataFound ,
    @Default(false) blockedListNoDataFound ,
    @Default(false)  remarkedListNoDataFound,


    @Default(false) errorApi,
    @Default(false) favoriteListIsErrorApi ,
    @Default(false) blockedListIsErrorApi ,
    @Default(false)  remarkedListIsErrorApi,

  @Default([]) List<EmployerPreviousShiftDto> employerPreviousList,
  @Default([]) List<EmployerPreviousShiftDto> favoritesList,
  @Default([]) List<EmployerPreviousShiftDto> blockedList,
  @Default([]) List<EmployerPreviousShiftDto> remarkedList,

}) = _PreviousShiftState;
}
