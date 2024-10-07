part of 'previous_shift_bloc.dart';

@freezed
class PreviousShiftState with _$PreviousShiftState {
  const factory PreviousShiftState({
    @Default(0) int currentTabIndex,
    @Default(5.0) double selectedRating,
    @Default(false) allListLoading ,
    @Default(false) favoriteListLoading ,
    @Default(false) blockedListLoading ,
    @Default(false) remarkedListLoading ,

    @Default(false) allListNoDataFound,
    @Default(false) favoriteListNoDataFound ,
    @Default(false) blockedListNoDataFound ,
    @Default(false)  remarkedListNoDataFound,


    @Default(false) allListIsErrorApi,
    @Default(false) favoriteListIsErrorApi ,
    @Default(false) blockedListIsErrorApi ,
    @Default(false)  remarkedListIsErrorApi,

  @Default([]) List<dynamic> allPostList,
  @Default([]) List<dynamic> favoritesList,
  @Default([]) List<dynamic> blockedList,
  @Default([]) List<dynamic> remarkedList,

}) = _PreviousShiftState;
}
