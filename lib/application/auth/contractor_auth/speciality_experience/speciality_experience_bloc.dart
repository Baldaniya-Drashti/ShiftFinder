// ignore_for_file: avoid_print, prefer_const_constructors

import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:shift/domain/account/account_failure.dart';
import 'package:shift/domain/account/i_account_repository.dart';
import 'package:shift/infrastructure/core/experience_model/experience_dto.dart';
import '../../../../domain/account/account.dart';

part 'speciality_experience_event.dart';

part 'speciality_experience_state.dart';

part 'speciality_experience_bloc.freezed.dart';

@Injectable()
class SpecialityExperienceBloc
    extends Bloc<SpecialityExperienceEvent, SpecialityExperienceState> {
  final IAccountRepository _repository;

  SpecialityExperienceBloc(this._repository)
      : super(SpecialityExperienceState.initial()) {
    on<SpecialityExperienceEvent>((event, emit) async {
      await event.map(
        getSpecialityExperinceDataEvent: (e) async {
          emit(
            state.copyWith(
              isLoading: true,
              authFailureOrSuccessOption: none(),
            ),
          );
          final specialityList =
              await _repository.getExperienceSpecialityList();

          specialityList.fold(
            (l) => emit(
              state.copyWith(
                  isLoading: false,
                  records: [],
                  authFailureOrSuccessOption:
                      optionOf(left(AccountFailure.serverError()))),
            ),
            (r) {
              return emit(
                state.copyWith(
                  isLoading: false,
                  records: List.from(state.records)..addAll(r),
                  authFailureOrSuccessOption: none(),
                ),
              );
            },
          );
          // emit(
          //   state.copyWith(
          //     records: experienceList,
          //     authFailureOrSuccessOption: none(),
          //   ),
          // );
        },
        updateRecordEvent: (e) {
          List<ExperienceDTO> updatedRecords = List.from(state.records);
          updatedRecords[e.index] = ExperienceDTO(
            name: updatedRecords[e.index].name,
            id: updatedRecords[e.index].id,
            experience_year: e.year,
            experience_month: e.month,
          );
          print("UPDATED RECORDS------->  ${jsonEncode(updatedRecords)}");

          emit(
            state.copyWith(
              records: updatedRecords,
              authFailureOrSuccessOption: none(),
            ),
          );
        },
        continueBtnPressedEvent: (e) async {
          Either<AccountFailure, Account>? failureOrSuccess;

          bool isValid = true;

          for (var record in state.records) {
            if ((record.experience_year == null ||
                    record.experience_year!.isEmpty) ||
                record.experience_month == null ||
                record.experience_month!.isEmpty) {
              isValid = false;
              break;
            }
          }
          if (isValid) {
            print("Experience list is validdddddd!   ${state.records} ");
            emit(
              state.copyWith(
                isSubmitting: true,
                authFailureOrSuccessOption: none(),
              ),
            );

            failureOrSuccess = await _repository.addSpecialityExperienceApi(
              experienceDetail:
                  jsonEncode(mapExperienceDTOToApiFormat(state.records)),
            );
          }
          print("failureOrSuccess--> $failureOrSuccess");
          emit(
            state.copyWith(
              isSubmitting: false,
              showErrorMessages: true,
              authFailureOrSuccessOption: optionOf(failureOrSuccess),
            ),
          );
        },
      );
    });
  }

  List<Map<String, dynamic>> mapExperienceDTOToApiFormat(
      List<ExperienceDTO?> experienceSpecialityList) {
    return experienceSpecialityList.map((speciality) {
      return {
        'specialtie_id': speciality?.id,
        'experience_year': speciality?.experience_year,
        'experience_month': speciality?.experience_month,
      };
    }).toList();
  }
}
