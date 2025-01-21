import 'package:auto_route/auto_route.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:shift/application/employer/add_full_position/add_full_position_bloc.dart';
import 'package:shift/domain/auth/auth_value_objects.dart';
import 'package:shift/infrastructure/core/employer_long_term_add_detail_dto/employer_long_term_add_detail_dto.dart';
import 'package:shift/infrastructure/core/employer_proposal_dto/employer_proposal_dto.dart';
import 'package:shift/infrastructure/main/post_shift_dto/post_shift_dto.dart';
import 'package:shift/presentation/core/app_router.gr.dart';

part 'employer_long_term_position_add_detail_event.dart';

part 'employer_long_term_position_add_detail_state.dart';

part 'employer_long_term_position_add_detail_bloc.freezed.dart';

@injectable
class EmployerLongTermPositionAddDetailBloc
    extends Bloc<EmployerLongTermPositionAddDetailEvent, EmployerLongTermPositionAddDetailState> {
  EmployerLongTermPositionAddDetailBloc() : super(EmployerLongTermPositionAddDetailState.initial()) {
    on<EmployerLongTermPositionAddDetailEvent>(
      (event, emit) {
        event.map(selectStartDate: (value) {
          emit(
            state.copyWith(
              employerLongTermAddDetailDto: state.employerLongTermAddDetailDto.copyWith(start_date: value.startDate),
            ),
          );
        }, selectEndDate: (value) {
          emit(
            state.copyWith(
              employerLongTermAddDetailDto: state.employerLongTermAddDetailDto.copyWith(end_date: value.endaDate),
            ),
          );
        }, selectApplicationDeadline: (value) {
          emit(
            state.copyWith(
              employerLongTermAddDetailDto: state.employerLongTermAddDetailDto.copyWith(
                application_deadline: value.deadLine,
              ),
            ),
          );
        }, selectEstimatedHour: (value) {
          emit(
            state.copyWith(
              employerLongTermAddDetailDto: state.employerLongTermAddDetailDto.copyWith(
                estimated_weekly_hours: value.estimatedHour,
              ),
            ),
          );
        }, onShiftScheduleChanged: (OnShiftScheduleChanged value) {
          emit(state.copyWith(selectedShiftSchedule: value.value));
        }, selectDocument: (SelectDocument value) {
          emit(
            state.copyWith(
              employerLongTermAddDetailDto: state.employerLongTermAddDetailDto.copyWith(
                terms_document: value.path,
              ),
            ),
          );
        }, addMoreVacancy: (AddMoreVacancy value) {
          emit(
            state.copyWith(
              employerLongTermAddDetailDto: state.employerLongTermAddDetailDto.copyWith(
                vacancie_type: value.value,
              ),
            ),
          );
        }, onCreate: (OnCreate value) {
          emit(state.copyWith(postShiftDto: value.postShitDto));
        }, removeDocument: (RemoveDocument value) {
          emit(
            state.copyWith(
              employerLongTermAddDetailDto: state.employerLongTermAddDetailDto.copyWith(
                terms_document: null,
              ),
            ),
          );
        }, onContinue: (OnContinue value) {
          final postShift = state.postShiftDto;
          final employer = state.employerLongTermAddDetailDto.copyWith(
            job_description: value.jobDescription,
            requirements: value.requirements,
            responsibilities: value.responsibilities,
            qualifications: value.qualification,
            licenses_certifications: value.licences,
            onboarding_process: value.onboarding,
            shift_schedule_type: state.selectedShiftSchedule?.id,
            number_of_vacancie: int.tryParse(value.numberOfVacancy ?? ""),
          );
          print("employer => ${employer.toJson()}");

          value.context.router.push(
            PageRouteInfo(
              EmployerLongTermPostConfirmationView.name,
              args: EmployerLongTermPostConfirmationViewArgs(postShiftDTO: postShift, employerAddDetailDto: employer),
            ),
          );
        }, onChangeContractIncludeCall: (OnChangeContractIncludeCall value) {
          emit(
            state.copyWith(
              employerLongTermAddDetailDto: state.employerLongTermAddDetailDto.copyWith(
                on_call_included: value.value,
              ),
            ),
          );
        }, removeShiftSchedule: (value) {
          emit(
            state.copyWith(
              requiredSoftwareSkillChipList: ListInputEmptyOrNot(
                List.from(
                  List.of(state.requiredSoftwareSkillChipList.getValue())..remove(value.selectedValue),
                ),
              ),
            ),
          );
        }, confirmShiftSchedule: (value) {
          emit(state.copyWith(
            requiredSoftwareSkillChipList: ListInputEmptyOrNot(value.skillList),
          ));
        });
      },
    );
  }
}
