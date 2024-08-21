import 'package:auto_route/auto_route.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:shift/domain/main/i_main_facade.dart';
import 'package:shift/domain/main/main_failure.dart';
import 'package:shift/infrastructure/core/network/common_response.dart';
import 'package:shift/infrastructure/employer_long_term_success/employer_long_term_success_dto.dart';
import 'package:shift/infrastructure/main/post_shift_dto/post_shift_dto.dart';
import 'package:shift/presentation/common/utils/flushbar_creator.dart';
import 'package:shift/presentation/core/app_router.gr.dart';
import 'package:shift/presentation/core/widgets/dialogs/app_dialog.dart';

part 'employer_long_term_payable_event.dart';

part 'employer_long_term_payable_state.dart';

part 'employer_long_term_payable_bloc.freezed.dart';

@injectable
class EmployerLongTermPayableBloc
    extends Bloc<EmployerLongTermPayableEvent, EmployerLongTermPayableState> {
  final IMainFacade _iMainFacade;

  EmployerLongTermPayableBloc(this._iMainFacade)
      : super(EmployerLongTermPayableState.initial()) {
    on<EmployerLongTermPayableEvent>((event, emit) async {
      await event.map(
        onPostShift: (value) async {
          Either<MainFailure, CommonResponse<dynamic>> response;
          emit(state.copyWith(postDataLoading: true));
          if (value.postId != null &&
              value.postId != -1 &&
              !value.isCreate &&
              !value.fromTemplate) {
            final postShift = value.postShift;
            final employer = value.employer.copyWith(
                rate_hour: postShift.rate_hour,
                languages_list_id: postShift.languages_list_id,
                location_unit: postShift.location_unit,
                location_id: postShift.location_id,
                post_type: 1,
                roles_list_id: postShift.roles_list_id,
                specialties_detail_id: postShift.specialties_detail_id,
                specialties_detail_other: postShift.specialties_detail_other,
                software_skill_other: postShift.software_skill_other,
                language_other: postShift.language_other,
                team_id:
                    value.employer.teams?.map((e) => e.id).toList().join(","),
                softwares_skill_list_id: postShift.softwares_skill_list_id);

            response = await _iMainFacade.updateLongFullTermPost(data: {
              ...employer.toJson(),
              "update_status": 1,
            });
          } else {
            response = await _iMainFacade.updateLongTermStatus(id: value.id);
          }

          emit(state.copyWith(postDataLoading: false));
          response.fold(
            (l) {
              showError(
                message: l.maybeMap(
                  showAPIResponseMessage: (value) => value.message,
                  networkError: (value) =>
                      'Please check your internet connectivity',
                  orElse: () => "Server Error. Try again later.",
                ),
              ).show(value.context);
            },
            (r) {
              AppDialog.showSuccess(
                barrierDismissible: false,
                value.context,
                title: "All Set!",
                infoMessage:
                    "Your healthcare long term position has been successfully ${(value.postId != null && value.postId != -1 && !value.isCreate && !value.fromTemplate) ? "update" : "add"}, with a total of ${value.totalVacancy} vacancy.",
                onOkClick: () {
                  // value.context.router.popUntil((route) => route.isFirst);

                  value.context.router.popUntil((route) {
                    /// When Create/Update From Long term
                    if (route.settings.name == EmployerLongTermView.name) {
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
        },
      );
    });
  }
}
