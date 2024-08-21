import 'package:dartz/dartz.dart';
import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:shift/domain/auth/auth_failure.dart';
import 'package:shift/domain/auth/auth_value_objects.dart';

part 'teams_state.dart';
part 'teams_event.dart';
part 'teams_bloc.freezed.dart';

class TeamsBloc extends Bloc<TeamsEvent, TeamsState> {
  var locationList = [
    DropDownValueModel(name: 'Location 1', value: '1'),
    DropDownValueModel(name: 'Location 2', value: '2'),
    DropDownValueModel(name: 'Location 3', value: '3'),
    DropDownValueModel(name: 'Location 4', value: '4'),
  ];
  var singleValueDropDownController = SingleValueDropDownController();
  TeamsBloc() : super(TeamsState.initial()) {
    on<TeamsEvent>((event, emit) async {
      await event.map(
        initialEvent: (e) async {},
        changeLocation: (ChangeLocation value) async {
          emit(
            state.copyWith(
              locationTextField: InputEmptyOrNot(value.location),
            ),
          );
        },
        changeTeamName: (ChangeTeamName value) async {
          emit(
            state.copyWith(
              teamNameTextField: InputEmptyOrNot(value.teamName),
            ),
          );
        },
        createTeam: (CreateTeam value) async {
          var isLocationValid = state.locationTextField.isValid();
          var isTeamNameValid = state.teamNameTextField.isValid();
          if (isLocationValid && isTeamNameValid) {
            print("Location: ${state.locationTextField.value}");
            print("Team Name: ${state.teamNameTextField.value}");
            emit(
              state.copyWith(
                isSubmitting: true,
                failureOrSuccessOption: none(),
              ),
            );
          }

          emit(
            state.copyWith(
              isSubmitting: false,
              showErrorMessages: true,
              // authFailureOrSuccessOption: optionOf(failureOrSuccess),
              // verificationFailureOrSuccessOption: none(),
            ),
          );
        },
      );
    });
  }
}
