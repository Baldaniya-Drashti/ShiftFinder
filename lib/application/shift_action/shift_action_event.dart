part of 'shift_action_bloc.dart';

@freezed
class ShiftActionEvent with _$ShiftActionEvent {
  const factory ShiftActionEvent.started() = _Started;
}
