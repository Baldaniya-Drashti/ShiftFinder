import 'package:auto_route/auto_route.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:shift/domain/main/i_main_facade.dart';
import 'package:shift/infrastructure/employer_long_term_success/employer_long_term_success_dto.dart';
import 'package:shift/presentation/common/utils/flushbar_creator.dart';
import 'package:shift/presentation/core/app_router.gr.dart';

part 'employer_full_posting_confirm_event.dart';

part 'employer_full_posting_confirm_state.dart';

part 'employer_full_posting_confirm_bloc.freezed.dart';

@injectable
class EmployerFullPostingConfirmBloc extends Bloc<EmployerFullPostingConfirmEvent, EmployerFullPostingConfirmState> {
  final IMainFacade _iMainFacade;

  EmployerFullPostingConfirmBloc(this._iMainFacade) : super(const EmployerFullPostingConfirmState()) {
    on<EmployerFullPostingConfirmEvent>((event, emit) async {
      await event.map(
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
              employerFullPosting:
                  state.employerFullPosting.copyWith(employer_payment_confirmation: value.value ? 1 : 0),
            ),
          );
        },
        onCreate: (OnCreate value) {
          emit(state.copyWith(employerFullPosting: value.employerLongTermSuccessDto));
        },
        onContinue: (OnContinue value) async {
          print("data => ${state.employerFullPosting.toJson()}");
          final employer = state.employerFullPosting;
          //employer.copyWith(lo);
          final Map<String, dynamic> data = {
            "post_type": "2",
            "location_id": employer.location?.id,
            ...state.employerFullPosting.toJson(),
          };

          emit(state.copyWith(postDataLoading: true));
          final result = await _iMainFacade.createLongFullTermPost(data: data);
          emit(state.copyWith(postDataLoading: false));
          result.fold(
            (l) {
              showError(
                message: l.maybeMap(
                  showAPIResponseMessage: (value) => value.message,
                  networkError: (value) => 'Please check your internet connectivity',
                  orElse: () => "Server Error. Try again later.",
                ),
              ).show(value.context);
            },
            (r) {
              final data = EmployerLongTermSuccessDto.fromJson(r.data);
              value.context.router.navigate(
                PageRouteInfo(
                  EmployerFullPostingReviewView.name,
                  args: EmployerFullPostingReviewViewArgs(employerFullPosting: data),
                ),
              );
            },
          );
        },
      );
    });
  }
}
