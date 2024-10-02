part of 'previous_shift_bloc.dart';

@freezed
class PreviousShiftEvent with _$PreviousShiftEvent {
  factory PreviousShiftEvent.tabChange(int tabIndex) = TabChange;
}
