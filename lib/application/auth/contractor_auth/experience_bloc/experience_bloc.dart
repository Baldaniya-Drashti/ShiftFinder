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

part 'experience_event.dart';

part 'experience_state.dart';

part 'experience_bloc.freezed.dart';

@Injectable()
class ExperienceBloc extends Bloc<ExperienceEvent, ExperienceState> {
  final IAccountRepository _repository;

  ExperienceBloc(this._repository) : super(ExperienceState.initial()) {
    on<ExperienceEvent>((event, emit) async {
      await event.map(
        getExperinceDataEvent: (e) async {
          emit(
            state.copyWith(
              isLoading: true,
              authFailureOrSuccessOption: none(),
            ),
          );
          await getExistingRoleDetail(emit);
          /* if (e.isUpdate) {
            // await getExistingRoleDetail(emit);
          } else {
            final roleList = await _repository.getExperienceRoleList();
            roleList.fold(
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
          } */
        },
        updateRecordEvent: (e) {
          List<ExperienceDTO> updatedRecords = List.from(state.records);
          updatedRecords[e.index] = ExperienceDTO(
            role: updatedRecords[e.index].role,
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

            failureOrSuccess = await _repository.addExperienceApi(
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

  getExistingRoleDetail(Emitter<ExperienceState> emit) async {
    try {
      final failureOrSuccess = await _repository.getCurrentUserApi();
      failureOrSuccess.fold(
        (l) => emit(
          state.copyWith(
            isLoading: false,
          ),
        ),
        (r) {
          print("Current user complete profile----> ${r.experience}");
          return emit(
            state.copyWith(
              isLoading: false,
              records: (r.experience != null && r.experience!.isNotEmpty)
                  ? r.experience!
                  : [],
              authFailureOrSuccessOption: none(),
              // roleTypeChipList: ListInputEmptyOrNot(
              //     (r.complete_profile != null &&
              //             r.complete_profile!.roles_list != null)
              //         ? r.complete_profile!.roles_list!
              //             .map((element) => element.name ?? "")
              //             .toList()
              //         : []),
              // requiredSoftwareSkillChipList: ListInputEmptyOrNot(
              //     (r.complete_profile != null &&
              //             r.complete_profile?.softwares_skill_list != null)
              //         ? r.complete_profile!.softwares_skill_list!
              //             .map((element) => element.name ?? "")
              //             .toList()
              //         : []),
              // softwareSkillOther:
              //     r.complete_profile?.software_skill_other?.split(',') ?? [],
              // requiredSpecialityChipList: ListInputEmptyOrNot((r
              //                 .complete_profile !=
              //             null &&
              //         r.complete_profile!.specialties_detail != null)
              //     ? r.complete_profile!.specialties_detail!
              //         .where((element) => element.specialtie_lists != null)
              //         .map((element) => element.specialtie_lists?.name ?? "")
              //         .toList()
              //     : []),
              // specialityOther: (r.complete_profile != null &&
              //         r.complete_profile!.specialties_detail != null)
              //     ? r.complete_profile!.specialties_detail!
              //         .where(
              //             (element) => element.specialtie_lists_other != null)
              //         .map((element) => element.specialtie_lists_other ?? "")
              //         .toList()
              //     : [],
              // // r.complete_profile?.specialties_other?.split(',') ?? [],
              // languageChipList: ListInputEmptyOrNot(
              //     (r.complete_profile != null &&
              //             r.complete_profile!.languages_list != null)
              //         ? r.complete_profile!.languages_list!
              //             .map((element) => element.name ?? "")
              //             .toList()
              //         : []),
              // languageOther: (r.complete_profile != null &&
              //         r.complete_profile!.language_other != null)
              //     ? r.complete_profile!.language_other?.split(',') ?? []
              //     : [],
            ),
          );
        },
      );
    } catch (e) {
      print("Current user ERRORRR--> $e");
    }
  }

  List<Map<String, dynamic>> mapExperienceDTOToApiFormat(
      List<ExperienceDTO?> experienceRoleList) {
    return experienceRoleList.map((role) {
      return {
        'role_id': role?.role?.id,
        'experience_year': role?.experience_year,
        'experience_month': role?.experience_month,
      };
    }).toList();
  }
}
