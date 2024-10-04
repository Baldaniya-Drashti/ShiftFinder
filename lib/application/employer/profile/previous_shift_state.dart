part of 'previous_shift_bloc.dart';

@freezed
class PreviousShiftState with _$PreviousShiftState {
  const factory PreviousShiftState({
    @Default(0) int currentTabIndex,
    @Default(5.0) double selectedRating,
  }) = _PreviousShiftState;
}
