import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:shift/domain/main/i_main_facade.dart';
import 'package:shift/infrastructure/main/team_dto/team_dto.dart';

part 'employer_long_term_confirmation_event.dart';

part 'employer_long_term_confirmation_state.dart';

part 'employer_long_term_confirmation_bloc.freezed.dart';

@injectable
class EmployerLongTermConfirmationBloc
    extends Bloc<EmployerLongTermConfirmationEvent, EmployerLongTermConfirmationState> {
  final IMainFacade _mainFacade;

  EmployerLongTermConfirmationBloc(this._mainFacade) : super(EmployerLongTermConfirmationState.initial()) {
    on<EmployerLongTermConfirmationEvent>((event, emit) async {
      await event.map(
        getTeamList: (value) async {
          final teamList = await _mainFacade.getTeamsList();
          teamList.fold(
            (l) => emit(
              state.copyWith(teamList: []),
            ),
            (r) {
              return emit(
                state.copyWith(teamList: r),
              );
            },
          );
        },
        selectTeam: (value) {
          List<TeamDTO> tempList = List.from(state.selectedTeamList);
          if (tempList.contains(value.team)) {
            tempList.remove(value.team);
          } else {
            tempList.add(value.team);
          }

          emit(state.copyWith(selectedTeamList: tempList));
        },
        selectSharePostWithTeam: (value) {
          emit(state.copyWith(shareWithTeam: value.value));
        },
        selectFuturePosting: (value) {
          emit(state.copyWith(saveAsFuturePost: value.value));
        },
        selectTermsAndCondition: (value) {
          emit(state.copyWith(agreeTermsAndCondition: value.value));
        },
      );
    });
  }
}
