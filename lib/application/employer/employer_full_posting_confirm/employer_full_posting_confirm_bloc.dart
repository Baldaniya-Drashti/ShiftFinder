import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:shift/domain/main/i_main_facade.dart';
import 'package:shift/infrastructure/employer_long_term_success/employer_long_term_success_dto.dart';

part 'employer_full_posting_confirm_event.dart';

part 'employer_full_posting_confirm_state.dart';

part 'employer_full_posting_confirm_bloc.freezed.dart';

@injectable
class EmployerFullPostingConfirmBloc extends Bloc<EmployerFullPostingConfirmEvent, EmployerFullPostingConfirmState> {
  final IMainFacade _iMainFacade;
  EmployerFullPostingConfirmBloc(this._iMainFacade) : super(const EmployerFullPostingConfirmState()) {
    on<EmployerFullPostingConfirmEvent>((event, emit) {
      event.map(
        onApplicationDeadlineChanged: (value) {
          emit(
            state.copyWith(
              employerFullPosting: state.employerFullPosting.copyWith(
                application_deadline: value.selectedDateTime,
              ),
            ),
          );
        },
        onIncludeOnCallChanged: (value) {
          emit(
            state.copyWith(
              employerFullPosting: state.employerFullPosting.copyWith(
                on_call_included: value.value ? 1 : 0,
              ),
            ),
          );
        },
        onFuturePostingChanged: (value) {
          emit(
            state.copyWith(
              employerFullPosting: state.employerFullPosting.copyWith(save_template_status: value.value ? 1 : 0),
            ),
          );
        },
        onMoreVacancyChanged: (value) {
          emit(
            state.copyWith(
              employerFullPosting: state.employerFullPosting.copyWith(vacancie_type: value.value ? 1 : 0),
            ),
          );
        },
        onTermsAndConditionChanged: (value) {
          emit(
            state.copyWith(
              employerFullPosting: state.employerFullPosting.copyWith(employer_payment_confirmation: value.value ? 1 : 0),
            ),
          );
        },
        onCreate: (OnCreate value) {
          emit(state.copyWith(employerFullPosting: value.employerLongTermSuccessDto));
        },
      );
    });
  }
}
