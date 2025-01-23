import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

part 'employer_full_posting_review_event.dart';

part 'employer_full_posting_review_state.dart';

part 'employer_full_posting_review_bloc.freezed.dart';
@injectable
class EmployerFullPostingReviewBloc extends Bloc<EmployerFullPostingReviewEvent, EmployerFullPostingReviewState> {
  EmployerFullPostingReviewBloc() : super(const EmployerFullPostingReviewState()) {
    on<EmployerFullPostingReviewEvent>((event, emit) {
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
