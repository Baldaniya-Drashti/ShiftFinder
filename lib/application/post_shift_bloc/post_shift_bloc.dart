// ignore_for_file: prefer_const_constructors, avoid_print, prefer_const_literals_to_create_immutables, unnecessary_brace_in_string_interps

import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:intl/intl.dart';
import 'package:shift/domain/auth/auth_failure.dart';
import 'package:shift/domain/auth/auth_value_objects.dart';
import 'package:shift/domain/main/i_main_facade.dart';
import 'package:shift/infrastructure/core/skill_list_model/skill_dto.dart';
import 'package:shift/infrastructure/main/date_time_dto/date_time_dto.dart';
import 'package:shift/infrastructure/main/start_end_time_dto/start_end_time_dto.dart';
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

        continueBtnPressed: (e) {
          Either<AuthFailure, String>? failureOrSuccess;

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
          final isVacancyValid = isMoreVacancyValid(
              isMoreVacancy: state.isMoreVacancy,
              vacancyValue: state.selectedVacancy);

          if (isSingleDateValid &&
              isCommuteAllownceValid &&
              isAccomdationAllownceValid &&
              isStartHourValid &&
              isStartMinuteValid &&
              isEndHourValid &&
              isEndMinuteValid &&
              isUnpaidBreakValid &&
              isVacancyValid) {
            print("All details are valid!");
            failureOrSuccess = right("Success");
          } else {
            print("Some details are invalid!");
          }

          emit(
            state.copyWith(
              singleShiftErrorMessages: true,
              singleShiftFailureOrSuccessOption: optionOf(failureOrSuccess),
            ),
          );
        },

        /// For recurring,share with teams, save as template
        recurringCheck: (e) {
          emit(
            state.copyWith(
              isToBeRecurring: e.isCheck,
              recurringErrorMessage: false,
              recurringFailureOrSuccessOption: none(),
            ),
          );
        },
        saveAsTemplateCheck: (e) {
          emit(
            state.copyWith(
              isSaveAsTemplate: e.isCheck,
              recurringErrorMessage: false,
              recurringFailureOrSuccessOption: none(),
            ),
          );
        },
        shareWithTeamsCheck: (e) {
          emit(
            state.copyWith(
              isShareWithTeams: e.isCheck,
              selectedTeamList: ListInputEmptyOrNot([]),
              recurringErrorMessage: false,
              recurringFailureOrSuccessOption: none(),
            ),
          );
        },
        disclaimerChanged: (e) {
          emit(
            state.copyWith(
              disclaimerNote: e.note,
              recurringFailureOrSuccessOption: none(),
            ),
          );
        },
        recurringStartDateChanged: (e) {
          emit(
            state.copyWith(
              recurringStartDate: InputEmptyOrNot(e.selectedDate),
              recurringEndDate: InputEmptyOrNot(""),
              recurringFailureOrSuccessOption: none(),
            ),
          );
        },
        recurrenceModeChanged: (e) {
          emit(state.copyWith(
            recurrenceMode: InputEmptyOrNot(e.mode),
            recurrenceWeekList: ListInputEmptyOrNot([]),
            singleShiftFailureOrSuccessOption: none(),
          ));
        },
        recurrenceWeeksChanged: (e) {
          List<SkillDTO> list = state.recurrenceWeekList.getValue();
          bool isAlreadyInList = list.any((item) => item.id == e.day.id);
          List<SkillDTO> updatedList;
          if (isAlreadyInList) {
            updatedList = list.where((item) => item.id != e.day.id).toList();
          } else {
            updatedList = List.from(list)..add(e.day);
          }

          emit(state.copyWith(
            recurrenceWeekList: ListInputEmptyOrNot(updatedList),
            singleShiftFailureOrSuccessOption: none(),
          ));
        },

        recurringEndDateChanged: (e) {
          emit(
            state.copyWith(
              recurringEndDate: InputEmptyOrNot(e.selectedDate),
              recurringFailureOrSuccessOption: none(),
            ),
          );
        },
        selectTeamEvent: (e) {
          List<SkillDTO> list = state.selectedTeamList.getValue();
          bool isAlreadyInList = list.any((item) => item.id == e.team.id);
          List<SkillDTO> updatedList;
          if (isAlreadyInList) {
            updatedList = list.where((item) => item.id != e.team.id).toList();
          } else {
            updatedList = List.from(list)..add(e.team);
          }

          emit(state.copyWith(
            selectedTeamList: ListInputEmptyOrNot(updatedList),
            singleShiftFailureOrSuccessOption: none(),
          ));
        },
        recurringButtonEvent: (e) {
          Either<AuthFailure, String>? failureOrSuccess;
          if (isRecurringValid(state) && isTeamsValid(state)) {
            print("save as template---> ${state.isSaveAsTemplate}");
            print("All details are valid!");
            failureOrSuccess = right("Success");
          } else {
            print("Some details are invalid!");
          }
          print("recurringErrorMessage---> ${state.recurringErrorMessage}");
          emit(
            state.copyWith(
              recurringErrorMessage: true,
              recurringFailureOrSuccessOption: optionOf(failureOrSuccess),
            ),
          );
        },

        /// Multi Shift
        multiDateSameDiffTypeChanged: (e) async {
          emit(
            state.copyWith(
              isLoading: true,
              singleShiftFailureOrSuccessOption: none(),
            ),
          );
          await Future.delayed(Duration(seconds: 2));
          emit(
            state.copyWith(
              isLoading: false,
              selectedMultiShiftType: e.selectedType,
              singleShiftFailureOrSuccessOption: none(),
            ),
          );
        },
        checkIsIndividualPost: (e) {
          emit(
            state.copyWith(
              isIndividualPost: e.isIndividualPost,
              singleShiftFailureOrSuccessOption: none(),
            ),
          );
        },

        multiDateSelectionChanged: (e) {
          emit(
            state.copyWith(
              selectedMultiDates: ListInputEmptyOrNot(e.selectedDates),
              singleShiftFailureOrSuccessOption: none(),
            ),
          );
        },
        multidateContinueButtonPressed: (e) {
          Either<AuthFailure, String>? failureOrSuccess;
          final isMultiDateValid = state.selectedMultiDates.isValid();
          final isCommuteAllownceValid = isAllownceValid(
              selectedValue: state.selectedCommuteAllownce,
              hourValue: state.commuteHour,
              rateValue: state.commuteRate);
          final isAccomdationAllownceValid = isAllownceValid(
              selectedValue: state.selectedCommuteAllownce,
              hourValue: state.commuteHour,
              rateValue: state.commuteRate);

          final isVacancyValid = isMoreVacancyValid(
              isMoreVacancy: state.isMoreVacancy,
              vacancyValue: state.selectedVacancy);

          if (isMultiDateValid &&
              isCommuteAllownceValid &&
              isAccomdationAllownceValid &&
              isVacancyValid) {
            print("All details are valid!  $failureOrSuccess");
            failureOrSuccess = right("Success");
          } else {
            print("Some details are invalid!");
          }
          print("failureOrSuccess  $failureOrSuccess");

          emit(
            state.copyWith(
              singleShiftErrorMessages: true,
              singleShiftFailureOrSuccessOption: optionOf(failureOrSuccess),
            ),
          );
        },
        startHourListChanged: (e) {
          final list = createOrUpdateDateTimeDTO(
            state,
            index: e.index,
            condition: 1,
            value: e.hour,
            date: e.date,
          );

          emit(state.copyWith(
            multiDateTimeList: list,
            totalPaybleHours: allTimesFilled(list),
            singleShiftFailureOrSuccessOption: none(),
          ));
        },
        startMinuteListChanged: (e) {
          final list = createOrUpdateDateTimeDTO(
            state,
            index: e.index,
            condition: 2,
            value: e.minute,
            date: e.date,
          );
          emit(state.copyWith(
            multiDateTimeList: list,
            totalPaybleHours: allTimesFilled(list),
            singleShiftFailureOrSuccessOption: none(),
          ));
        },
        endHourListChanged: (e) {
          final list = createOrUpdateDateTimeDTO(
            state,
            index: e.index,
            condition: 3,
            value: e.hour,
            date: e.date,
          );
          emit(state.copyWith(
            multiDateTimeList: list,
            totalPaybleHours: allTimesFilled(list),
            singleShiftFailureOrSuccessOption: none(),
          ));
        },
        endMinuteListChanged: (e) {
          final list = createOrUpdateDateTimeDTO(
            state,
            index: e.index,
            condition: 4,
            value: e.minute,
            date: e.date,
          );
          emit(state.copyWith(
            multiDateTimeList: list,
            totalPaybleHours: allTimesFilled(list),
            singleShiftFailureOrSuccessOption: none(),
          ));
        },
        initMultiDifferentDateEvent: (e) async {
          emit(
            state.copyWith(
              isLoading: true,
              singleShiftFailureOrSuccessOption: none(),
            ),
          );
          await getUnpaidBreakListApi(emit);
          // SkillDTO? selectedSkillDTO = shiftTypeList.firstWhere(
          //   (skill) => skill.name == e.shiftType,
          //   orElse: () => SkillDTO(),
          // );
          emit(
            state.copyWith(
              isLoading: false,
              multiDateTimeList: e.list,
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

  bool isRecurringValid(
    PostShiftState state,
  ) {
    if (state.isToBeRecurring &&
        (state.recurringStartDate.isValid() &&
            state.recurringEndDate.isValid() &&
            state.recurrenceMode.isValid())) {
      if (state.recurrenceMode.getValue() == "Weekly" &&
          !state.recurrenceWeekList.isValid()) {
        return false;
      } else {
        return true;
      }
    } else if (!state.isToBeRecurring) {
      return true;
    } else {
      return false;
    }
  }

  bool isTeamsValid(
    PostShiftState state,
  ) {
    if (state.isShareWithTeams && (state.selectedTeamList.isValid())) {
      return true;
    } else if (!state.isShareWithTeams) {
      return true;
    } else {
      return false;
    }
  }

  List<DateTimeDTO> createOrUpdateDateTimeDTO(
    PostShiftState state, {
    required String date,
    required int condition,
    required String value,
    required int index,
  }) {
    final list = List<DateTimeDTO>.from(state.multiDateTimeList);

    // Check if the item with the given date exists
    final existingIndex = list.indexWhere((item) => item.date == date);

    // Create or update the DTO
    DateTimeDTO updatedDTO = existingIndex != -1
        ? list[existingIndex]
        : DateTimeDTO(
            date: date,
            objId: index,
          );

    // Update fields based on the condition
    updatedDTO = updatedDTO.copyWith(
      startHour: condition == 1 ? value : updatedDTO.startHour,
      startMinute: condition == 2 ? value : updatedDTO.startMinute,
      endHour: condition == 3 ? value : updatedDTO.endHour,
      endMinute: condition == 4 ? value : updatedDTO.endMinute,
    );

    // Update start_time if startHour and startMinute are set
    if (updatedDTO.startHour != null && updatedDTO.startMinute != null) {
      final startTime = CustomDateTimeFormat.parseTime(
          updatedDTO.startHour!, updatedDTO.startMinute!);
      updatedDTO = updatedDTO.copyWith(start_time: startTime.toString());
    }

    // Update end_time if endHour and endMinute are set
    if (updatedDTO.endHour != null && updatedDTO.endMinute != null) {
      final endTime = CustomDateTimeFormat.parseTime(
          updatedDTO.endHour!, updatedDTO.endMinute!);
      updatedDTO = updatedDTO.copyWith(end_time: endTime.toString());
    }
    if (isTimeFilled(updatedDTO)) {
      // final unpaidBreak = CustomDateTimeFormat.extractUnpaidBreak(
      //     state.unpaidBreak.getValue()!);
      var timeDiffBetweenEndStartTime = DateTime.parse(updatedDTO.end_time!)
          .difference(DateTime.parse(updatedDTO.start_time!));
      // final timeDifference =
      //     timeDiffBetweenEndStartTime - Duration(minutes: unpaidBreak);
      updatedDTO = updatedDTO.copyWith(
          totalPaybleHours: timeDiffBetweenEndStartTime.toString());
    }

    if (existingIndex != -1) {
      // If the item exists, update it
      list[existingIndex] = updatedDTO;
    } else {
      // If the item does not exist, insert it
      list.add(updatedDTO);
      list.sort((a, b) => a.date!.compareTo(b.date!));
    }

    return list;
  }

  String allTimesFilled(List<DateTimeDTO> multiDateTimeList) {
    bool isAllFilled = multiDateTimeList.every((dto) =>
        dto.totalPaybleHours != null && dto.totalPaybleHours!.isNotEmpty);
    if (isAllFilled) {
      final totalHour = CustomDateTimeFormat.formatDuration(
          sumTotalPayableHours(multiDateTimeList));
      // final timeDifference =
      //       timeDiffBetweenEndStartTime - Duration(minutes: unpaidBreak);
      print("totalHour--> ${totalHour}");
      return totalHour;
    } else {
      return "00h 00min";
    }
  }

  Duration parseDuration(String duration) {
    final parts = duration.split(':');
    final hours = int.parse(parts[0]);
    final minutes = int.parse(parts[1]);
    final seconds = double.parse(parts[2])
        .round(); // Handles the case of fractional seconds
    return Duration(hours: hours, minutes: minutes, seconds: seconds);
  }

  Duration sumTotalPayableHours(List<DateTimeDTO> multiDateTimeList) {
    return multiDateTimeList.fold(Duration.zero,
        (total, dto) => total + parseDuration(dto.totalPaybleHours ?? ""));
  }

  bool isTimeFilled(DateTimeDTO dto) {
    return (dto.start_time != null &&
        dto.start_time!.isNotEmpty &&
        dto.end_time != null &&
        dto.end_time!.isNotEmpty);
  }
}
