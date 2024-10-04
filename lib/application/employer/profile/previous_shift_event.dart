part of 'previous_shift_bloc.dart';

@freezed
class PreviousShiftEvent with _$PreviousShiftEvent {
  factory PreviousShiftEvent.tabChangeEvent({
    required int tabIndex,
  }) = TabChangeEvent;

  factory PreviousShiftEvent.ratingChangeEvent({
    required double rating,
  }) = RatingChangeEvent;
}
