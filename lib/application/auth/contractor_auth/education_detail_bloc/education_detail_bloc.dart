// ignore_for_file: avoid_print, unnecessary_overrides

import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:shift/domain/auth/auth_failure.dart';
import 'package:shift/domain/auth/auth_value_objects.dart';

part 'education_detail_event.dart';
part 'education_detail_state.dart';
part 'education_detail_bloc.freezed.dart';

@injectable
class EducationDetailBloc
    extends Bloc<EducationDetailEvent, EducationDetailState> {
  EducationDetailBloc() : super(EducationDetailState.initial()) {
    on<EducationDetailEvent>((event, emit) {
      event.map(
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
        onAddBtnPressed: (e) {
          Either<AuthFailure, String>? failureOrSuccess;
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
            // failureOrSuccess = await _authFacade.login(
            //   mobileNumber: state.emailId,
            //   countryCode: '+${state.selectedCountrycode}',
            // );
            failureOrSuccess = right("success");
          }
          emit(
            state.copyWith(
              isSubmitting: false,
              showAddEducationErrorMessages: true,
              authFailureOrSuccessOption: optionOf(failureOrSuccess),
            ),
          );
        },
      );
    });
  }

  @override
  Future<void> close() {
    return super.close();
  }
}
