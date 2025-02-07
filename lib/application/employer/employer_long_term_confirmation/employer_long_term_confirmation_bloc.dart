import 'package:auto_route/auto_route.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:shift/domain/main/i_main_facade.dart';
import 'package:shift/domain/main/main_failure.dart';
import 'package:shift/infrastructure/core/network/common_response.dart';
import 'package:shift/infrastructure/employer_long_term_success/employer_long_term_success_dto.dart';
import 'package:shift/infrastructure/main/post_shift_dto/post_shift_dto.dart';
import 'package:shift/infrastructure/main/team_dto/team_dto.dart';
import 'package:shift/presentation/common/utils/flushbar_creator.dart';
import '../../../presentation/core/app_router.gr.dart';
part 'employer_long_term_confirmation_event.dart';
part 'employer_long_term_confirmation_state.dart';
part 'employer_long_term_confirmation_bloc.freezed.dart';

@injectable
class EmployerLongTermConfirmationBloc extends Bloc<
    EmployerLongTermConfirmationEvent, EmployerLongTermConfirmationState> {
  final IMainFacade _mainFacade;

  EmployerLongTermConfirmationBloc(this._mainFacade)
      : super(EmployerLongTermConfirmationState.initial()) {
    on<EmployerLongTermConfirmationEvent>((event, emit) async {
      await event.map(
        getTeamList: (value) async {},
        selectTeam: (value) {
          List<TeamDTO> tempList = List.from(state.selectedTeamList);
          if (tempList.contains(value.team)) {
            tempList.remove(value.team);
          } else {
            tempList.add(value.team);
          }

          emit(state.copyWith(selectedTeamList: tempList));
        },
        selectSharePostWithTeam: (value) {
          emit(
            state.copyWith(
              employerAddDetailDto: state.employerAddDetailDto
                  .copyWith(share_team_status: value.value),
            ),
          );
        },
        selectFuturePosting: (value) {
          emit(
            state.copyWith(
              employerAddDetailDto: state.employerAddDetailDto
                  .copyWith(save_template_status: value.value),
            ),
          );
        },
        selectTermsAndCondition: (value) {
          emit(
            state.copyWith(
              isTermsCheck: value.value,
              employerAddDetailDto: state.employerAddDetailDto
                  .copyWith(employer_payment_confirmation: value.value ? 1 : 0),
            ),
          );
        },
        onContinue: (value) async {
          final isTermsValid = state.isTermsCheck == true;

          if (isTermsValid) {
            final postShift = state.postShiftDTO;
            final employer = state.employerAddDetailDto.copyWith(
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
                  state.selectedTeamList.map((e) => e.id).toList().join(","),
              softwares_skill_list_id: postShift.softwares_skill_list_id,
            );

            final Map<String, dynamic> data = {
              ...employer.toJson(),
            };

            emit(state.copyWith(postDataLoading: true));
            Either<MainFailure, CommonResponse<dynamic>> result;
            if (state.postId == null || (state.postId ?? -1) < 0) {
              result = await _mainFacade.createLongFullTermPost(data: data);
            } else {
              result = await _mainFacade.updateLongFullTermPost(data: {
                ...data,
                "update_status": 0,
              });
            }

            emit(state.copyWith(postDataLoading: false));
            result.fold(
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
                final data = EmployerLongTermSuccessDto.fromJson(r.data);
                value.context.router.push(
                  PageRouteInfo(
                    EmployerLongTermReviewDetailView.name,
                    args: EmployerLongTermReviewDetailViewArgs(
                        employerLongTermSuccessDto: data,
                        postId: state.postId,
                        postShiftDTO: postShift),
                  ),
                );
              },
            );
          }
          emit(state.copyWith(showErrorMessage: true));
        },
        onCreate: (value) async {
          emit(state.copyWith(
              postShiftDTO: value.postDetail,
              employerAddDetailDto: value.employer,
              postId: value.postId));
          final teamList = await _mainFacade.getTeamsList();
          teamList.fold(
            (l) => emit(
              state.copyWith(teamList: []),
            ),
            (r) {
              emit(state.copyWith(
                  teamList: r, selectedTeamList: value.employer.teams ?? []));
            },
          );
        },
      );
    });
  }
}
