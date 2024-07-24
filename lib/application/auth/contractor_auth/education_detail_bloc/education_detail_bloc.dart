// ignore_for_file: avoid_print, unnecessary_overrides

import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:shift/domain/account/account.dart';
import 'package:shift/domain/account/account_failure.dart';
import 'package:shift/domain/account/i_account_repository.dart';
import 'package:shift/domain/auth/auth_failure.dart';
import 'package:shift/domain/auth/auth_value_objects.dart';
import 'package:shift/domain/auth/i_auth_facade.dart';
import 'package:shift/infrastructure/core/education_dto/education_dto.dart';

part 'education_detail_event.dart';
part 'education_detail_state.dart';
part 'education_detail_bloc.freezed.dart';

@injectable
class EducationDetailBloc
    extends Bloc<EducationDetailEvent, EducationDetailState> {
  final IAccountRepository _repository;

  EducationDetailBloc(this._repository)
      : super(EducationDetailState.initial()) {
    on<EducationDetailEvent>((event, emit) async {
      await event.map(
        getEducationList: (e) async {
          emit(
            state.copyWith(
              isSubmitting: true,
              authFailureOrSuccessOption: none(),
            ),
          );
          final failureOrSuccess = await _repository.getCurrentUserApi();
          failureOrSuccess.fold(
            (l) => emit(
              state.copyWith(
                isSubmitting: false,
                educationList: [],
              ),
            ),
            (r) {
              return emit(
                state.copyWith(
                  isSubmitting: false,
                  educationList: r.education ?? [],
                ),
              );
            },
          );

          emit(
            state.copyWith(
              isSubmitting: false,
              showAddEducationErrorMessages: true,
            ),
          );
        },
        addProgramChanged: (e) {
          emit(
            state.copyWith(
              selectedProgram: InputEmptyOrNot(e.program),
              authFailureOrSuccessOption: none(),
            ),
          );
        },
        addCompletionYearChanged: (e) {
          emit(
            state.copyWith(
              yearOfCompletion: InputEmptyOrNot(e.year),
              authFailureOrSuccessOption: none(),
            ),
          );
        },
        addInstituteChanged: (e) {
          emit(
            state.copyWith(
              selectedGraduation: InputEmptyOrNot(e.institute),
              authFailureOrSuccessOption: none(),
            ),
          );
        },
        onAddBtnPressed: (e) async {
          // Either<AuthFailure, String>? failureOrSuccess;
          Either<AccountFailure, String>? failureOrSuccess;
          final isProgramSelected = state.selectedProgram.isValid();
          final isYearSelected = state.yearOfCompletion.isValid();
          final isGraduationSelected = state.selectedGraduation.isValid();
          if (isProgramSelected && isYearSelected && isGraduationSelected) {
            print("All details are valid!");
            emit(
              state.copyWith(
                isSubmitting: true,
                authFailureOrSuccessOption: none(),
              ),
            );
            failureOrSuccess = await _repository.addEducationApi(
              programCompleted: state.selectedProgram,
              yearOfCompletion: state.yearOfCompletion,
              graduatingInstitution: state.selectedGraduation,
            );
          }
          emit(
            state.copyWith(
              isSubmitting: false,
              showAddEducationErrorMessages: true,
              failureOrSuccessOption: optionOf(failureOrSuccess),
            ),
          );
        },
        deleteEducation: (e) async {
          Either<AccountFailure, Account>? failureOrSuccess;

          emit(
            state.copyWith(
              isSubmitting: true,
              listFailureOrSuccessOption: none(),
            ),
          );

          print("Delete Id-> ${e.educationId}");
           failureOrSuccess =
              await _repository.deleteEducationApi(educationId: e.educationId);


          failureOrSuccess.fold(
                (l) => emit(
              state.copyWith(
                isSubmitting: false,
                educationList: List.from(state.educationList),
              ),
            ),
                (r) {
              return emit(
                state.copyWith(
                  isSubmitting: false,
                  educationList: r.education ?? [],
                ),
              );
            },
          );
          // emit(
          //   state.copyWith(
          //     isSubmitting: false,
          //     showAddEducationErrorMessages: true,
          //     listFailureOrSuccessOption: optionOf(failureOrSuccess),
          //   ),
          // );
        },
      );
    });
  }

  @override
  Future<void> close() {
    return super.close();
  }
}
