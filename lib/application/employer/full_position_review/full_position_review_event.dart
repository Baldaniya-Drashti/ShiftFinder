part of 'full_position_review_bloc.dart';

@freezed
class FullPositionReviewEvent with _$FullPositionReviewEvent {
  const factory FullPositionReviewEvent.onIncludeCallChanged({
    required bool value,
  }) = onIncludeCallChanged;

  const factory FullPositionReviewEvent.onSaveTemplateFutureChanged({
    required bool value,
  }) = OnSaveTemplateFutureChanged;
}
