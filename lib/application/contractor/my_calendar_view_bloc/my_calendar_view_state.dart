part of 'my_calendar_view_bloc.dart';

@freezed
class MyCalendarViewState with _$MyCalendarViewState {
  factory MyCalendarViewState({
    required bool isLoading,
    required bool isSubmitting,
    required bool showErrorMessages,
    required Option<Either<MainFailure, List<MyCalendarDTO>>>
        failureOrSuccessOption,
    required List<MyCalendarDTO> multiDates,
    required List<MyCalendarDTO> calendarDates,
    required List<MyCalendarDTO> unAvailableDates,
    required bool isGetting,
    required ContractorMyCalendarDTO? contractorDetail,
  }) = _MyCalendarViewState;
  factory MyCalendarViewState.initial() => MyCalendarViewState(
        multiDates: [],
        calendarDates: [],
        unAvailableDates: [],
        isLoading: false,
        isSubmitting: false,
        showErrorMessages: false,
        failureOrSuccessOption: none(),
        contractorDetail: null,
        isGetting: false,
      );
}
