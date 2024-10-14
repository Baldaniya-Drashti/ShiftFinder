import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

part 'my_calendar_view_event.dart';
part 'my_calendar_view_state.dart';
part 'my_calendar_view_bloc.freezed.dart';

@injectable
class MyCalendarViewBloc
    extends Bloc<MyCalendarViewEvent, MyCalendarViewState> {
  MyCalendarViewBloc() : super(MyCalendarViewState.initial()) {
    on<MyCalendarViewEvent>((event, emit) {});
  }
}
