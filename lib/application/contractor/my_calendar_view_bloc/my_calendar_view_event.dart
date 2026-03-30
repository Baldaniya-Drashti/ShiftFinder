part of 'my_calendar_view_bloc.dart';

@freezed
class MyCalendarViewEvent with _$MyCalendarViewEvent {
  const factory MyCalendarViewEvent.selectDateEvent(
      BuildContext context, List<DateTime> selectedDateList,
      {DateTime? selectedMonthFirstDate}) = SelectDateEvent;
  const factory MyCalendarViewEvent.getMyCalendarList(BuildContext context) =
      GetMyCalendarList;

  const factory MyCalendarViewEvent.removeChatCount(
    BuildContext context, {
    required int selectedDate,
    required String selectedId,
  }) = RemoveChatCount;
}
