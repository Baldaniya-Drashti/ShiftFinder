part of 'previous_shift_bloc.dart';

@freezed
class PreviousShiftState with _$PreviousShiftState {
  factory PreviousShiftState({
    required int selectedTab,
  }) = _PreviousShiftState;

  factory PreviousShiftState.initial() => PreviousShiftState(
        selectedTab: 0,
      );
}
