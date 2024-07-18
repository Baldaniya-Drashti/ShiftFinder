// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:shift/domain/auth/auth_failure.dart';
import 'package:shift/infrastructure/core/experience_model/experience_dto.dart';

part 'experience_event.dart';
part 'experience_state.dart';
part 'experience_bloc.freezed.dart';

@Injectable()
class ExperienceBloc extends Bloc<ExperienceEvent, ExperienceState> {
  ExperienceBloc() : super(ExperienceState.initial()) {
    on<ExperienceEvent>((event, emit) {
      event.map(getExperinceDataEvent: (e) {
        emit(
          state.copyWith(
            records: experienceList,
            authFailureOrSuccessOption: none(),
          ),
        );
      }, updateRecordEvent: (e) {
        List<ExperienceDTO> updatedRecords = List.from(state.records);
        updatedRecords[e.index] = ExperienceDTO(
          name: updatedRecords[e.index].name,
          year: e.year,
          month: e.month,
        );

        print("UPDATED RECORDS------->  ${jsonEncode(updatedRecords)}");
        emit(
          state.copyWith(
            records: updatedRecords,
            authFailureOrSuccessOption: none(),
          ),
        );
      }, continueBtnPressedEvent: (e) {
        Either<AuthFailure, String>? failureOrSuccess;

        bool isValid = true;

        for (var record in state.records) {
          if ((record.year == null || record.year!.isEmpty) ||
              record.month == null ||
              record.month!.isEmpty) {
            isValid = false;
            break;
          }
        }
        if (isValid) {
          print("Experience list is validdddddd! ");
          emit(
            state.copyWith(
              isSubmitting: true,
              authFailureOrSuccessOption: none(),
            ),
          );
          // failureOrSuccess = await _authFacade.login(
          //   mobileNumber: state.emailId,
          //   countryCode: '+${state.selectedCountrycode}',
          // );
          failureOrSuccess = right("success");
        }
        emit(
          state.copyWith(
            isSubmitting: false,
            showErrorMessages: true,
            authFailureOrSuccessOption: optionOf(failureOrSuccess),
          ),
        );
      });
    });
  }
}

List<ExperienceDTO> experienceList = [
  ExperienceDTO(name: "Registerd Nurse"),
  ExperienceDTO(name: "Paramedic"),
];
