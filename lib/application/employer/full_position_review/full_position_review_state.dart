part of 'full_position_review_bloc.dart';

@freezed
class FullPositionReviewState with _$FullPositionReviewState {
  const factory FullPositionReviewState({
    @Default(false) final bool includeCall,
    @Default(false) final bool saveTemplateFuture,
  }) = _FullPositionReviewState;
}
