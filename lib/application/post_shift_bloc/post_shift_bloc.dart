// ignore_for_file: prefer_const_constructors, avoid_print

import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:shift/domain/auth/auth_failure.dart';
import 'package:shift/domain/auth/auth_value_objects.dart';
import 'package:shift/domain/main/i_main_facade.dart';
import 'package:shift/infrastructure/core/skill_list_model/skill_dto.dart';
import 'package:shift/presentation/common/utils/date_time_format.dart';
part 'post_shift_event.dart';
part 'post_shift_state.dart';
part 'post_shift_bloc.freezed.dart';

@injectable
class PostShiftBloc extends Bloc<PostShiftEvent, PostShiftState> {
  static List<SkillDTO> shiftTypeList = [
    SkillDTO(id: 1, name: "Single"),
    SkillDTO(id: 2, name: "Multi"),
    SkillDTO(id: 3, name: "Long-Term"),
  ];
  static bool isAllownceValid(
      {required InputEmptyOrNot selectedValue,
      required InputEmptyOrNot hourValue,
      required InputEmptyOrNot rateValue}) {
    if (selectedValue.getValue() == "Flat Rate" && rateValue.isValid()) {
      return true;
    } else if (selectedValue.getValue() == "Hours" && hourValue.isValid()) {
      return true;
    } else if (selectedValue.getValue() == "None") {
      return true;
    }
    return false;
  }

  static bool isMoreVacancyValid({
    required bool isMoreVacancy,
    required InputEmptyOrNot vacancyValue,
  }) {
    if (isMoreVacancy && vacancyValue.isValid()) {
      return true;
    } else if (!isMoreVacancy) {
      return true;
    } else {
      return false;
    }
  }

  final IMainFacade _mainFacade;
  PostShiftBloc(this._mainFacade) : super(PostShiftState.initial()) {
    on<PostShiftEvent>((event, emit) async {
      await event.map(
        /// Change Shift (Single, Multi, Long-Term)
        changeShiftType: (e) async {
          emit(
            state.copyWith(
              isLoading: true,
              singleShiftFailureOrSuccessOption: none(),
            ),
          );
          add(PostShiftEvent.getBreakAllownceListApi());
          SkillDTO? selectedSkillDTO = shiftTypeList.firstWhere(
            (skill) => skill.name == e.shiftType,
            orElse: () => SkillDTO(),
          );
          emit(
            state.copyWith(
              shiftType: selectedSkillDTO.id ?? -1,
              isLoading: false,
              singleShiftFailureOrSuccessOption: none(),
            ),
          );
        },
        addVacancyChanged: (e) {
          emit(
            state.copyWith(
              selectedVacancy: InputEmptyOrNot(e.vacancy),
              singleShiftFailureOrSuccessOption: none(),
            ),
          );
        },
        checkIsMoreVancancy: (e) {
          emit(
            state.copyWith(
              isMoreVacancy: e.isMoreVacancy,
              singleShiftFailureOrSuccessOption: none(),
            ),
          );
        },

        /// Single Shift
        getBreakAllownceListApi: (e) async {
          // Either<AuthFailure, SkillListDTO>? res;
          emit(
            state.copyWith(
              isLoading: true,
              singleShiftFailureOrSuccessOption: none(),
            ),
          );
          await getUnpaidBreakListApi(emit);
          await getaAccomdationHoursListApi(emit);
        },

        singleShiftDateChangedEvent: (e) {
          emit(
            state.copyWith(
              signleShiftDate: InputEmptyOrNot(e.selectedDate),
              singleShiftFailureOrSuccessOption: none(),
            ),
          );
        },
        startHourChanged: (e) {
          emit(state.copyWith(
            startHour: InputEmptyOrNot(e.hour),
            singleShiftFailureOrSuccessOption: none(),
          ));
          add(PostShiftEvent.totalPayableHoursChanged());
        },
        startMinuteChanged: (e) {
          emit(state.copyWith(
            startMinute: InputEmptyOrNot(e.minute),
            singleShiftFailureOrSuccessOption: none(),
          ));
          add(PostShiftEvent.totalPayableHoursChanged());
        },
        endHourChanged: (e) {
          emit(state.copyWith(
            endHour: InputEmptyOrNot(e.hour),
            singleShiftFailureOrSuccessOption: none(),
          ));
          add(PostShiftEvent.totalPayableHoursChanged());
        },
        endMinuteChanged: (e) {
          emit(state.copyWith(
            endMinute: InputEmptyOrNot(e.minute),
            singleShiftFailureOrSuccessOption: none(),
          ));
          add(PostShiftEvent.totalPayableHoursChanged());
        },
        unpaidBreakChanged: (e) {
          emit(state.copyWith(
            unpaidBreak: InputEmptyOrNot(e.breakTime),
            singleShiftFailureOrSuccessOption: none(),
          ));
          add(PostShiftEvent.totalPayableHoursChanged());
        },
        totalPayableHoursChanged: (e) {
          final isStartHourValid = state.startHour.isValid();
          final isStartMinuteValid = state.startMinute.isValid();
          final isEndHourValid = state.endHour.isValid();
          final isEndMinuteValid = state.endMinute.isValid();
          final isUnpaidBreakValid = state.unpaidBreak.isValid();

          if (isStartHourValid &&
              isStartMinuteValid &&
              isEndHourValid &&
              isEndMinuteValid &&
              isUnpaidBreakValid) {
            final startTime = CustomDateTimeFormat.parseTime(
                state.startHour.getValue()!, state.startMinute.getValue()!);
            final endTime = CustomDateTimeFormat.parseTime(
                state.endHour.getValue()!, state.endMinute.getValue()!);
            final unpaidBreak = CustomDateTimeFormat.extractUnpaidBreak(
                state.unpaidBreak.getValue()!);
            var timeDiffBetweenEndStartTime = endTime.difference(startTime);
            final timeDifference =
                timeDiffBetweenEndStartTime - Duration(minutes: unpaidBreak);

            emit(state.copyWith(
              totalPaybleHours:
                  CustomDateTimeFormat.formatDuration(timeDifference),
            ));
          } else if (isStartHourValid &&
              isStartMinuteValid &&
              isEndHourValid &&
              isEndMinuteValid) {
            final startTime = CustomDateTimeFormat.parseTime(
                state.startHour.getValue()!, state.startMinute.getValue()!);
            final endTime = CustomDateTimeFormat.parseTime(
                state.endHour.getValue()!, state.endMinute.getValue()!);
            var timeDifference = endTime.difference(startTime);
            emit(state.copyWith(
              totalPaybleHours:
                  CustomDateTimeFormat.formatDuration(timeDifference),
            ));
          } else {
            print("start time data is not valid!");
          }
        },
        commuteAllownceChanged: (e) {
          emit(state.copyWith(
            selectedCommuteAllownce: InputEmptyOrNot(e.selectedValue),
            commuteHour: InputEmptyOrNot(""),
            commuteRate: InputEmptyOrNot(""),
            singleShiftFailureOrSuccessOption: none(),
          ));
        },
        commuteHoursChanged: (e) {
          emit(state.copyWith(
            commuteHour: InputEmptyOrNot(e.selectedValue),
            singleShiftFailureOrSuccessOption: none(),
          ));
        },
        commuteRateChanged: (e) {
          emit(state.copyWith(
            commuteRate: InputEmptyOrNot(e.selectedValue),
            singleShiftFailureOrSuccessOption: none(),
          ));
        },
        accomdationAllownceChanged: (e) {
          emit(state.copyWith(
            selectedAccomdationAllownce: InputEmptyOrNot(e.selectedValue),
            accomdationHour: InputEmptyOrNot(""),
            accomdationRate: InputEmptyOrNot(""),
            singleShiftFailureOrSuccessOption: none(),
          ));
        },
        accomdationHoursChanged: (e) {
          emit(state.copyWith(
            accomdationHour: InputEmptyOrNot(e.selectedValue),
            singleShiftFailureOrSuccessOption: none(),
          ));
        },
        accomdationRateChanged: (e) {
          emit(state.copyWith(
            accomdationRate: InputEmptyOrNot(e.selectedValue),
            singleShiftFailureOrSuccessOption: none(),
          ));
        },
        singleShiftNotesChanged: (e) {
          emit(
            state.copyWith(
              singleShiftNote: e.note,
              singleShiftFailureOrSuccessOption: none(),
            ),
          );
        },
        continueBtnPressed: (e) {
          final isCommuteAllownceValid = isAllownceValid(
              selectedValue: state.selectedCommuteAllownce,
              hourValue: state.commuteHour,
              rateValue: state.commuteRate);
          final isAccomdationAllownceValid = isAllownceValid(
              selectedValue: state.selectedCommuteAllownce,
              hourValue: state.commuteHour,
              rateValue: state.commuteRate);
          final isSingleDateValid = state.signleShiftDate.isValid();
          final isUnpaidBreakValid = state.unpaidBreak.isValid();
          final isStartHourValid = state.startHour.isValid();
          final isStartMinuteValid = state.startMinute.isValid();
          final isEndHourValid = state.endHour.isValid();
          final isEndMinuteValid = state.endMinute.isValid();
          final isMoreVacancyValid = (state);

          if (isSingleDateValid &&
              isCommuteAllownceValid &&
              isAccomdationAllownceValid &&
              isStartHourValid &&
              isStartMinuteValid &&
              isEndHourValid &&
              isEndMinuteValid &&
              isUnpaidBreakValid &&
              isMoreVacancyValid) {
            print("All details are valid!");
          } else {
            print("Some details are invalid!");
          }

          emit(
            state.copyWith(
              singleShiftErrorMessages: true,
              singleShiftFailureOrSuccessOption: none(),
            ),
          );
        },
      );
    });
  }

  getUnpaidBreakListApi(Emitter<PostShiftState> emit) async {
    final breakList = await _mainFacade.getUnpaidBreakListApi();
    print("Break List ---> $breakList");
    breakList.fold(
      (l) => emit(
        state.copyWith(
          isLoading: false,
          breakList: [],
        ),
      ),
      (r) {
        return emit(
          state.copyWith(
            isLoading: false,
            breakList: r,
          ),
        );
      },
    );
  }

  getaAccomdationHoursListApi(Emitter<PostShiftState> emit) async {
    final hoursList = await _mainFacade.getAccomdationHoursListApi();
    hoursList.fold(
      (l) => emit(
        state.copyWith(
          isLoading: false,
          accomdationHoursList: [],
        ),
      ),
      (r) {
        print("Hours List ---> $hoursList");
        return emit(
          state.copyWith(
            isLoading: false,
            accomdationHoursList: r,
          ),
        );
      },
    );
  }
}
