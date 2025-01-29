import 'package:auto_route/auto_route.dart';
import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:shift/application/auth/contractor_auth/card_bloc/card_bloc.dart';
import 'package:shift/domain/main/i_main_facade.dart';
import 'package:shift/domain/main/main_failure.dart';
import 'package:shift/infrastructure/core/employer_long_term_add_detail_dto/employer_long_term_add_detail_dto.dart';
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
class EmployerLongTermConfirmationBloc
    extends Bloc<EmployerLongTermConfirmationEvent, EmployerLongTermConfirmationState> {
  final IMainFacade _mainFacade;

  EmployerLongTermConfirmationBloc(this._mainFacade) : super(EmployerLongTermConfirmationState.initial()) {
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
              employerAddDetailDto: state.employerAddDetailDto.copyWith(share_team_status: value.value),
            ),
          );
        },
        selectFuturePosting: (value) {
          emit(
            state.copyWith(
              employerAddDetailDto: state.employerAddDetailDto.copyWith(save_template_status: value.value),
            ),
          );
        },
        selectTermsAndCondition: (value) {
          emit(
            state.copyWith(
              employerAddDetailDto: state.employerAddDetailDto.copyWith(employer_payment_confirmation: value.value),
            ),
          );
        },
        onContinue: (value) async {
          print(state.employerAddDetailDto.toJson());
          print(state.postShiftDTO.toJson());
          print("id=> ${state.employerAddDetailDto.id}");

          final postShift = state.postShiftDTO;
          final employer = state.employerAddDetailDto.copyWith(
            rate_hour: postShift.rate_hour,
            languages_list_id: postShift.languages_list_id,
          );
          print("¢${state.selectedTeamList.join(",")}");
          print("00000>${postShift.languages_list_id}");
          print("00000rrrr>${postShift.location_unit}");
          print("00000rrrr>${postShift.vacancie_type}");
          final Map<String, dynamic> data = {
            "post_type": "1",
            "roles_list_id": postShift.roles_list_id,
            "specialties_detail_id": postShift.specialties_detail_id,
            "softwares_skill_list_id": postShift.softwares_skill_list_id,
            "location_id": postShift.location_id,
            "location_unit": postShift.location_unit,
            if (postShift.specialties_detail_other != null)
              "specialties_detail_other": postShift.specialties_detail_other,
            if (postShift.software_skill_other != null) "software_skill_other": postShift.software_skill_other,
            if (postShift.language_other != null) "language_other": postShift.language_other,
            if (state.selectedTeamList.isNotEmpty)
              "team_id": state.selectedTeamList.map((e) => e.id).toList().join(","),
            ...employer.toJson(),
          };

          print("========>${data}");
          emit(state.copyWith(postDataLoading: true));
          Either<MainFailure, CommonResponse<dynamic>> result;
          if (employer.id == null) {
            result = await _mainFacade.createLongFullTermPost(data: data);
          } else {
            result = await _mainFacade.updateLongFullTermPost(data: data);
          }

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
              value.context.router.push(
                PageRouteInfo(EmployerLongTermReviewDetailView.name,
                    args: EmployerLongTermReviewDetailViewArgs(employerLongTermSuccessDto: data)),
              );
            },
          );
        },
        onCreate: (value) async {
          emit(state.copyWith(postShiftDTO: value.postDetail, employerAddDetailDto: value.employer));
          final teamList = await _mainFacade.getTeamsList();
          teamList.fold(
            (l) => emit(
              state.copyWith(teamList: []),
            ),
            (r) {
              emit(state.copyWith(teamList: r, selectedTeamList: value.employer.teams ?? []));
              print("==>> ${value.employer.teams}");
              print("==> ${state.selectedTeamList}");
            },
          );
        },
      );
    });
  }
}
