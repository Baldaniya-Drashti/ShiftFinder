import 'package:auto_route/auto_route.dart';
import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:shift/domain/main/i_main_facade.dart';
import 'package:shift/domain/main/main_failure.dart';
import 'package:shift/infrastructure/core/network/common_response.dart';
import 'package:shift/infrastructure/employer_long_term_success/employer_long_term_success_dto.dart';
import 'package:shift/infrastructure/main/main_facade.dart';
import 'package:shift/presentation/common/utils/flushbar_creator.dart';
import 'package:shift/presentation/core/widgets/dialogs/app_dialog.dart';

part 'employer_full_posting_review_event.dart';

part 'employer_full_posting_review_state.dart';

part 'employer_full_posting_review_bloc.freezed.dart';

@injectable
class EmployerFullPostingReviewBloc extends Bloc<EmployerFullPostingReviewEvent, EmployerFullPostingReviewState> {
  final IMainFacade _mainFacade;

  EmployerFullPostingReviewBloc(this._mainFacade) : super(const EmployerFullPostingReviewState()) {
    on<EmployerFullPostingReviewEvent>((event, emit) async {
      await event.map(
        onSubmit: (OnSubmit value) async {
          final result = await AppDialog.showCommonDialog(
            context: value.context,
            title: "Post Full Time Position",
            content: "Are you sure you want to post this full time position?",
            successLabel: "Post",
          );
          if (result ?? false) {
            emit(state.copyWith(loading: true));
            Either<MainFailure, CommonResponse<dynamic>> response;
            if ((value.postId ?? -1) < 0) {
              response = await _mainFacade.updateLongTermStatus(id: value.id);
            } else {
              response = await _mainFacade.updateLongFullTermPost(data: {
                ...value.data.toJson(),
                "update_status": 1,
              });
            }

            emit(state.copyWith(loading: false));
            response.fold(
              (l) {
                showError(
                  message: l.maybeMap(
                    showAPIResponseMessage: (value) => value.message,
                    networkError: (value) => 'Please check your internet connectivity',
                    orElse: () => "Something went wrong!",
                  ),
                ).show(value.context);
              },
              (r) async {
                AppDialog.showSuccess(
                  value.context,
                  title: "All Set!",
                  infoMessage: "Your healthcare full time position has been successfully posted.",
                  onOkClick: () {
                    value.context.router.popUntil((route) => route.isFirst);
                  },
                );
              },
            );
          }
        },
      );
    });
  }
}
