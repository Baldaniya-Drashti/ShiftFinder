import 'package:auto_route/auto_route.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:shift/domain/core/string_constant.dart';
import 'package:shift/domain/main/i_main_facade.dart';
import 'package:shift/domain/main/main_failure.dart';
import 'package:shift/infrastructure/core/network/common_response.dart';
import 'package:shift/infrastructure/employer_long_term_success/employer_long_term_success_dto.dart';
import 'package:shift/presentation/common/utils/flushbar_creator.dart';
import 'package:shift/presentation/common/utils/get_cookie.dart';
import 'package:shift/presentation/core/app_router.gr.dart';
import 'package:shift/presentation/core/common_lisitng/common_listing.dart';
import 'package:shift/presentation/core/widgets/dialogs/app_dialog.dart';
part 'employer_full_posting_review_event.dart';
part 'employer_full_posting_review_state.dart';
part 'employer_full_posting_review_bloc.freezed.dart';

@injectable
class EmployerFullPostingReviewBloc extends Bloc<EmployerFullPostingReviewEvent,
    EmployerFullPostingReviewState> {
  final IMainFacade _mainFacade;

  EmployerFullPostingReviewBloc(this._mainFacade)
      : super(const EmployerFullPostingReviewState()) {
    on<EmployerFullPostingReviewEvent>((event, emit) async {
      await event.map(
        onSubmit: (OnSubmit value) async {
          final result = await AppDialog.showCommonDialog(
            context: value.context,
            title:
                "${(value.postId != null && value.postId != -1 && !value.isCreate && !value.fromTemplate) ? StringConstant.update : StringConstant.post} Full Time Position",
            content:
                "Are you sure you want to ${(value.postId != null && value.postId != -1 && !value.isCreate && !value.fromTemplate) ? 'update' : 'post'} this full time position?",
            successLabel:
                "${(value.postId != null && value.postId != -1 && !value.isCreate && !value.fromTemplate) ? StringConstant.update : StringConstant.post} ",
          );
          if (result ?? false) {
            emit(state.copyWith(loading: true));
            Either<MainFailure, CommonResponse<dynamic>> response;
            if (value.postId != null &&
                value.postId != -1 &&
                !value.isCreate &&
                !value.fromTemplate) {
              response = await _mainFacade.updateLongFullTermPost(data: {
                ...value.data.toJson(),
                "update_status": 1,
                'isSendNotification': 1,
              });
            } else {
              response = await _mainFacade.updateLongTermStatus(id: value.id);
            }

            emit(state.copyWith(loading: false));
            response.fold(
              (l) {
                showError(
                  message: l.maybeMap(
                    showAPIResponseMessage: (value) => value.message,
                    networkError: (value) =>
                        'Please check your internet connectivity',
                    orElse: () => "Something went wrong!",
                  ),
                ).show(value.context);
              },
              (r) async {
                final industry = CommonList.industryList
                    .where((item) => item.id == getCurrentIndustry())
                    .map((item) => item.title);
                AppDialog.showSuccess(
                  value.context,
                  title: StringConstant.allSet,
                  infoMessage: (r.dioMessage != null &&
                          r.dioMessage!.isNotEmpty)
                      ? r.dioMessage!
                      : (value.postId != null &&
                              value.postId != -1 &&
                              !value.isCreate)
                          ? "Your $industry full time position has been successfully updated."
                          : "Your $industry full time position has been successfully posted.",
                  onOkClick: () {
                    // value.context.router.popUntil((route) => route.isFirst);
                    value.context.router.popUntil((route) {
                      /// When Create/Update From Full Time

                      if (route.settings.name == EmployerFullPostingView.name) {
                        bool argument = true;
                        route.onPopInvokedWithResult(true, argument);
                        return true;
                      }

                      /// When Create From Save template
                      else if (route.settings.name == SaveTemplateView.name) {
                        return true;
                      } else {
                        return false;
                      }
                    });
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
