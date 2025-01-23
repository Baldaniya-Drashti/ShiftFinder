import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:shift/domain/account/i_account_repository.dart';
import 'package:shift/domain/auth/auth_value_objects.dart';
import 'package:shift/domain/main/i_main_facade.dart';
import 'package:shift/infrastructure/core/employer_long_term_add_detail_dto/employer_long_term_add_detail_dto.dart';
import 'package:shift/infrastructure/core/location_dto/location_dto.dart';
import 'package:shift/presentation/common/utils/flushbar_creator.dart';

part 'add_full_position_event.dart';

part 'add_full_position_state.dart';

part 'add_full_position_bloc.freezed.dart';

@injectable
class AddFullPositionBloc extends Bloc<AddFullPositionEvent, AddFullPositionState> {
  final IAccountRepository _repository;
  final IMainFacade _mainFacade;

  AddFullPositionBloc(this._repository, this._mainFacade) : super(AddFullPositionState.initial()) {
    on<AddFullPositionEvent>((event, emit) async {
      await event.map(
        onCreate: (value) {
          add(AddFullPositionEvent.fetchLocationList(context: value.context));
        },
        fetchLocationList: (value) async {
          emit(state.copyWith(loading: true));
          final locationList = await _repository.getLocationListApi();
          emit(state.copyWith(loading: false));
          locationList.fold(
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
              emit(state.copyWith(locationList: r));
            },
          );
        },
        onJobTypeChanged: (value) {
          emit(state.copyWith(selectedJobType: value.value));
        },
        onShiftScheduleChanged: (value) {
          emit(state.copyWith(selectedShiftSchedule: value.value));
        },
        onLocationChanged: (OnLocationChanged value) {
          emit(state.copyWith(selectedLocation: value.selectedLocation));
        },
        onCompensationTypeChanged: (OnCompensationTypeChanged value) {
          emit(state.copyWith(selectedRadioOption: value.type));
        },
        onEstimatedDateChanged: (OnEstimatedDateChanged value) {
          emit(state.copyWith(selectedEstimatedHours: value.value));
        },
        removeShiftSchedule: (RemoveShiftSchedule value) {
          emit(
            state.copyWith(
              requiredShiftScheduleChipList: ListInputEmptyOrNot(
                List.from(
                  List.of(state.requiredShiftScheduleChipList.getValue())..remove(value.selectedValue),
                ),
              ),
            ),
          );
        },
        confirmShiftSchedule: (ConfirmSoftwareSkill value) {
          emit(state.copyWith(
            requiredShiftScheduleChipList: ListInputEmptyOrNot(value.shiftSchedule),
          ));
        },
      );
    });
  }
}
