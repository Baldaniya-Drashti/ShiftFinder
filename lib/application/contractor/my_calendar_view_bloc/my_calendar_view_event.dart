part of 'my_calendar_view_bloc.dart';

@freezed
class MyCalendarViewEvent with _$MyCalendarViewEvent {
  const factory MyCalendarViewEvent.selectDateEvent(
      BuildContext context, List<DateTime> selectedDateList) = SelectDateEvent;
  const factory MyCalendarViewEvent.getMyCalendarList(BuildContext context) =
      GetMyCalendarList;
}
