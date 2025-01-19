import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:shift/application/employer/add_full_position/add_full_position_bloc.dart';
import 'package:shift/infrastructure/core/employer_long_term_add_detail_dto/employer_long_term_add_detail_dto.dart';
import 'package:shift/infrastructure/core/employer_proposal_dto/employer_proposal_dto.dart';
import 'package:shift/infrastructure/main/post_shift_dto/post_shift_dto.dart';

part 'employer_long_term_position_add_detail_event.dart';

part 'employer_long_term_position_add_detail_state.dart';

part 'employer_long_term_position_add_detail_bloc.freezed.dart';

@injectable
class EmployerLongTermPositionAddDetailBloc
    extends Bloc<EmployerLongTermPositionAddDetailEvent, EmployerLongTermPositionAddDetailState> {
  EmployerLongTermPositionAddDetailBloc() : super(EmployerLongTermPositionAddDetailState.initial()) {
    on<EmployerLongTermPositionAddDetailEvent>(
      (event, emit) {
        event.map(
          selectStartDate: (value) {
            emit(
              state.copyWith(
                employerLongTermAddDetailDto: state.employerLongTermAddDetailDto.copyWith(start_date: value.startDate),
              ),
            );
          },
          selectEndDate: (value) {
            emit(
              state.copyWith(
                employerLongTermAddDetailDto: state.employerLongTermAddDetailDto.copyWith(end_date: value.endaDate),
              ),
            );
          },
          selectApplicationDeadline: (value) {
            emit(state.copyWith(startDate: value.deadLine));
            emit(
              state.copyWith(
                employerLongTermAddDetailDto: state.employerLongTermAddDetailDto.copyWith(
                  applicationDeadline: value.deadLine,
                ),
              ),
            );
          },
          selectEstimatedHour: (value) {
            emit(state.copyWith(estimatedWeeklyHours: value.estimatedHour));
          },
          onShiftScheduleChanged: (OnShiftScheduleChanged value) {
            emit(state.copyWith(selectedShiftSchedule: value.value));
          },
          selectDocument: (SelectDocument value) {
            emit(state.copyWith(documentPath: value.path));
            print("=> ${value.path}");
          },
          addMoreVacancy: (AddMoreVacancy value) {
            emit(state.copyWith(hasMoreVacancy: value.value));
          },
          onCreate: (OnCreate value) {
            emit(state.copyWith(postShiftDto: value.postShitDto));
          },
        );
      },
    );
  }
}
