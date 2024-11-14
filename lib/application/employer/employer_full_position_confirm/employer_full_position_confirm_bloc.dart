import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

part 'employer_full_position_confirm_event.dart';

part 'employer_full_position_confirm_state.dart';

part 'employer_full_position_confirm_bloc.freezed.dart';

@injectable
class EmployerFullPositionConfirmBloc extends Bloc<EmployerFullPositionConfirmEvent, EmployerFullPositionConfirmState> {
  EmployerFullPositionConfirmBloc() : super(const EmployerFullPositionConfirmState()) {
    on<EmployerFullPositionConfirmEvent>((event, emit) {
      event.map(
        onApplicationDeadlineChanged: (value) {
          emit(state.copyWith(applicationDeadline: value.selectedDateTime));
        },
        onIncludeOnCallChanged: (value) {
          emit(state.copyWith(includeOnCall: value.value));
        },
        onFuturePostingChanged: (value) {
          emit(state.copyWith(saveFuturePosting: value.value));
        },
        onMoreVacancyChanged: (value) {
          emit(state.copyWith(moreVacancy: value.value));
        },
        onTermsAndConditionChanged: (value) {
          emit(state.copyWith(termsAndCondition: value.value));
        },
      );
    });
  }
}
