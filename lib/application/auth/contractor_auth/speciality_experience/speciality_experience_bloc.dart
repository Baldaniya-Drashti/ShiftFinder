// ignore_for_file: avoid_print, prefer_const_constructors

import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:shift/domain/account/account_failure.dart';
import 'package:shift/domain/account/i_account_repository.dart';
import 'package:shift/infrastructure/core/applicant_dto/applicant_dto.dart';
import 'package:shift/infrastructure/core/experience_model/experience_dto.dart';
import 'package:shift/infrastructure/core/speciality/speciality_dto.dart';
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

          if (e.isUpdate) {
            await getExistingSpecialityDetail(emit);
          } else {
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
          }
        },
        updateRecordEvent: (e) {
          List<ExperienceDTO> updatedRecords = List.from(state.records);

          print("e.year---> ${e.year}");
          print("e.month---> ${e.month}");
          updatedRecords[e.index] = ExperienceDTO(
            role: updatedRecords[e.index].role,
            specialtie_lists_other:
                updatedRecords[e.index].specialtie_lists_other,
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
              experienceDetail: jsonEncode(mapExperienceDTOToApiFormat(
                  state.records,
                  isUpdate: e.isUpdate)),
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

  getExistingSpecialityDetail(Emitter<SpecialityExperienceState> emit) async {
    try {
      final failureOrSuccess = await _repository.getCurrentUserApi();
      failureOrSuccess.fold(
        (l) => emit(
          state.copyWith(
            isLoading: false,
          ),
        ),
        (r) {
          print(
              "Current user complete profile----> ${r.complete_profile?.specialties_detail}");
          return emit(
            state.copyWith(
              isLoading: false,
              records: (r.complete_profile != null &&
                      r.complete_profile!.specialties_detail != null)
                  ? r.complete_profile!.specialties_detail!
                  : [],
              authFailureOrSuccessOption: none(),
            ),
          );
        },
      );
    } catch (e) {
      print("Current user ERRORRR--> $e");
    }
  }

  List<Map<String, dynamic>> mapExperienceDTOToApiFormat(
      List<ExperienceDTO?> experienceSpecialityList,
      {bool isUpdate = false}) {
    return experienceSpecialityList.map((speciality) {
      return {
        'specialtie_id': speciality?.id,
        'experience_year': speciality?.experience_year,
        'experience_month': speciality?.experience_month,
      };
    }).toList();
  }
}
