import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'shift_action_event.dart';
part 'shift_action_state.dart';
part 'shift_action_bloc.freezed.dart';

class ShiftActionBloc extends Bloc<ShiftActionEvent, ShiftActionState> {
  ShiftActionBloc() : super(const ShiftActionState.initial()) {
    on<ShiftActionEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
