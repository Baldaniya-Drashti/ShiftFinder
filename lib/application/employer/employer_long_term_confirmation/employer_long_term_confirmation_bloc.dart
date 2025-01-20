import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:shift/domain/main/i_main_facade.dart';
import 'package:shift/infrastructure/core/employer_long_term_add_detail_dto/employer_long_term_add_detail_dto.dart';
import 'package:shift/infrastructure/main/post_shift_dto/post_shift_dto.dart';
import 'package:shift/infrastructure/main/team_dto/team_dto.dart';

part 'employer_long_term_confirmation_event.dart';

part 'employer_long_term_confirmation_state.dart';

part 'employer_long_term_confirmation_bloc.freezed.dart';

@injectable
class EmployerLongTermConfirmationBloc extends Bloc<EmployerLongTermConfirmationEvent, EmployerLongTermConfirmationState> {
  final IMainFacade _mainFacade;

  EmployerLongTermConfirmationBloc(this._mainFacade) : super(EmployerLongTermConfirmationState.initial()) {
    on<EmployerLongTermConfirmationEvent>((event, emit) async {
      await event.map(
        getTeamList: (value) async {
          final teamList = await _mainFacade.getTeamsList();
          teamList.fold(
            (l) => emit(
              state.copyWith(teamList: []),
            ),
            (r) {
              return emit(
                state.copyWith(teamList: r),
              );
            },
          );
        },
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
          final employer = state.employerAddDetailDto;
          final postShift = state.postShiftDTO;
          final Map<String, dynamic> data = {
            "roles_list_id": postShift.roles_list_id,
            "specialties_detail_id": postShift.specialties_detail_id,
            "softwares_skill_list_id": postShift.softwares_skill_list_id,
            "languages_list_id": postShift.languages_list_id,
            "location_id": postShift.location_id,
            "location_unit": postShift.location_unit,
            "rate_hour": postShift.rate_hour,
            if (postShift.specialties_detail_other != null) "specialties_detail_other": postShift.specialties_detail_other,
            if (postShift.software_skill_other != null) "software_skill_other": postShift.software_skill_other,
            if (postShift.language_other != null) "language_other": postShift.language_other,
            if (state.selectedTeamList.isNotEmpty) "team_id": state.selectedTeamList.join(","),
            ...employer.toJson(),
          };
      print("=> ${data}");
/*          await _mainFacade.createLongFullTermPost(
            roleListId: roleListId,
            languagesListId: languagesListId,
            locationId: locationId,
            locationUnit: locationUnit,
            rateHour: rateHour,
            startDate: startDate,
            endDate: endDate,
            applicationDeadline: applicationDeadline,
            estimatedWeeklyHours: estimatedWeeklyHours,
            shiftScheduleType: shiftScheduleType,
            jobDescription: jobDescription,
            requirements: requirements,
            responsibilities: responsibilities,
            qualifications: qualifications,
            licensesCertifications: licensesCertifications,
            onboardingProcess: onboardingProcess,
            onCallIncluded: onCallIncluded,
            numberOfVacancy: numberOfVacancy,
            shareTeamStatus: shareTeamStatus,
            saveTemplateStatus: saveTemplateStatus,
            employerPaymentConfirmation: employerPaymentConfirmation,
          );*/
        },
        onCreate: (value) {
          emit(state.copyWith(postShiftDTO: value.postDetail, employerAddDetailDto: value.employer));
          add(EmployerLongTermConfirmationEvent.getTeamList());
        },
      );
    });
  }
}
