import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

part 'full_position_review_event.dart';

part 'full_position_review_state.dart';

part 'full_position_review_bloc.freezed.dart';
@injectable
class FullPositionReviewBloc extends Bloc<FullPositionReviewEvent, FullPositionReviewState> {
  FullPositionReviewBloc() : super(const FullPositionReviewState()) {
    on<FullPositionReviewEvent>((event, emit) {
      event.map(
        onIncludeCallChanged: (value) {
          emit(state.copyWith(includeCall: value.value));
        },
        onSaveTemplateFutureChanged: (value) {
          emit(state.copyWith(saveTemplateFuture: value.value));
        },
      );
    });
  }
}
