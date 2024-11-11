part of 'full_time_position_bloc.dart';

@freezed
class FullTimePositionState with _$FullTimePositionState {
  const factory FullTimePositionState({
    @Default(1) int tabIndex,
  }) = _FullTimePositionState;
}
