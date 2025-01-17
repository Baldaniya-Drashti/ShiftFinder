import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:shift/application/employer/add_full_position/add_full_position_bloc.dart';

part 'employer_long_term_position_add_detail_event.dart';

part 'employer_long_term_position_add_detail_state.dart';

part 'employer_long_term_position_add_detail_bloc.freezed.dart';

@injectable
class EmployerLongTermPositionAddDetailBloc extends Bloc<EmployerLongTermPositionAddDetailEvent, EmployerLongTermPositionAddDetailState> {
  EmployerLongTermPositionAddDetailBloc() : super(EmployerLongTermPositionAddDetailState.initial()) {
    on<EmployerLongTermPositionAddDetailEvent>((event, emit) {
      event.map(
        selectStartDate: (value) {
          emit(state.copyWith(startDate: value.startDate, endDate: null));
        },
        selectEndDate: (value) {
          emit(state.copyWith(startDate: value.endaDate));
        },
        selectApplicationDeadline: (value) {
          emit(state.copyWith(startDate: value.deadLine));
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
      );
    });
  }
}
