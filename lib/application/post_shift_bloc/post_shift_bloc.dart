// ignore_for_file: prefer_const_constructors, avoid_print, prefer_const_literals_to_create_immutables, unnecessary_brace_in_string_interps
import 'dart:convert';

import 'package:auto_route/auto_route.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:shift/domain/auth/auth_failure.dart';
import 'package:shift/domain/auth/auth_value_objects.dart';
import 'package:shift/domain/main/i_main_facade.dart';
import 'package:shift/domain/main/main_failure.dart';
import 'package:shift/infrastructure/core/skill_list_model/skill_dto.dart';
import 'package:shift/infrastructure/main/date_time_dto/date_time_dto.dart';
import 'package:shift/infrastructure/main/healthcare_post/healthcare_post_dto.dart';
import 'package:shift/infrastructure/main/multi_shift_dto/multi_shift_dto.dart';
import 'package:shift/infrastructure/main/post_shift_dto/post_shift_dto.dart';
import 'package:shift/infrastructure/main/shift_date_detail_dto/shift_date_detail_dto.dart';
import 'package:shift/infrastructure/main/team_dto/team_dto.dart';
import 'package:shift/presentation/common/utils/date_time_format.dart';
import 'package:shift/presentation/core/app_router.gr.dart';
import 'package:shift/presentation/core/common_lisitng/common_listing.dart';
part 'post_shift_event.dart';
part 'post_shift_state.dart';
part 'post_shift_bloc.freezed.dart';

@injectable
class PostShiftBloc extends Bloc<PostShiftEvent, PostShiftState> {
  static List<SkillDTO> shiftTypeList = [
    SkillDTO(id: 1, name: "Single"),
    SkillDTO(id: 2, name: "Multi"),
    // SkillDTO(id: 3, name: "Long-Term"),
  ];
  static bool isAllownceValid(
      {required InputEmptyOrNot selectedValue,
      required InputEmptyOrNot hourValue,
      required Rate rateValue}) {
    final parsedRate = double.tryParse(rateValue.getValue());
    final rateValid = parsedRate != null && parsedRate > 0;

    if (selectedValue.getValue() == "Flat Rate" &&
        rateValue.isValid() &&
        rateValid) {
      return true;
    } else if (selectedValue.getValue() == "Hours" && hourValue.isValid()) {
      return true;
    } else if (selectedValue.getValue() == "None") {
      return true;
    } else if (selectedValue.getValue() == "Flat Rate" && rateValue.isValid()) {
      return true;
    }
    return false;
  }

  static bool timeIsPast(
    PostShiftState state,
    InputEmptyOrNot selectedHour,
    InputEmptyOrNot selectedMin, {
    int shiftType = 0,
    DateTimeDTO? multiDate,
  }) {
    DateTime currentDate = DateTime.now();
    DateTime selectedDate = (shiftType == 2)
        ? DateTime.parse(multiDate!.date ?? "")
        : (state.signleShiftDate.isValid())
            ? DateTime.parse(state.signleShiftDate.getValue() ?? "")
            : DateTime.now();
    bool isSameDate = (shiftType == 1)
        ? isCurrentDateInList(state.selectedMultiDates.getValue())
        : (selectedDate.year == currentDate.year &&
            selectedDate.month == currentDate.month &&
            selectedDate.day == currentDate.day);

    if (selectedHour.isValid() && selectedMin.isValid()) {
      final selectedTime = CustomDateTimeFormat.parseTime(
          selectedHour.getValue()!, selectedMin.getValue()!);
      if (isSameDate) {
        final isBefore = selectedTime.isBefore(currentDate);

        return isBefore;
      } else {
        return false;
      }
    } else {
      return false;
    }
  }

  static bool isCurrentDateInList(List<DateTime> selectedMultiDates) {
    DateTime today = DateTime.now();
    for (DateTime date in selectedMultiDates) {
      if (date.year == today.year &&
          date.month == today.month &&
          date.day == today.day) {
        return true;
      }
    }
    return false;
  }

  static bool timeIsBefore(
    PostShiftState state, {
    int shiftType = 0,
    List<DateTimeDTO>? multiDate,
  }) {
    bool isPast = false;
    DateTime today = DateTime.now();

    multiDate?.any((currentObj) {
      if (currentObj.date != null) {
        InputEmptyOrNot selectedHour =
            InputEmptyOrNot(currentObj.startHour ?? "");
        InputEmptyOrNot selectedMin =
            InputEmptyOrNot(currentObj.startMinute ?? "");

        final date = DateTime.parse(currentObj.date!);
        final isSameDate = (date.year == today.year &&
            date.month == today.month &&
            date.day == today.day);

        if (selectedHour.isValid() && selectedMin.isValid()) {
          final selectedTime = CustomDateTimeFormat.parseTime(
              selectedHour.getValue()!, selectedMin.getValue()!);
          if (isSameDate) {
            isPast = selectedTime.isBefore(DateTime.now());
          }
        }
      }
      return isPast;
    });
    return isPast;
  }

  static bool isMoreVacancyValid({
    required bool isMoreVacancy,
    required Vacancy vacancyValue,
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
          SkillDTO? selectedSkillDTO = shiftTypeList.firstWhere(
            (skill) => skill.name == e.shiftType,
            orElse: () => SkillDTO(),
          );

          final getShiftName = shiftTypeList.firstWhere(
            (skill) => skill.id == state.shiftType,
            orElse: () => SkillDTO(),
          );
          if (e.shiftType != getShiftName.name) {
            emit(
              state.copyWith(
                updateShift: e.updateShift ?? HealthcarePostDTO(),
                post: (e.post != null) ? e.post! : state.post,
                isLoading: true,
                singleShiftFailureOrSuccessOption: none(),
              ),
            );
            add(PostShiftEvent.getBreakAllownceListApi(e.updateShift));

            emit(
              state.copyWith(
                shiftType: selectedSkillDTO.id ?? -1,
                postId: e.postId,
                // isLoading: false,
                singleShiftFailureOrSuccessOption: none(),
              ),
            );
          }
        },

        /// Single Shift
        getBreakAllownceListApi: (e) async {
          // Either<AuthFailure, SkillListDTO>? res;
          // emit(
          //   state.copyWith(
          //     // isLoading: true,
          //     singleShiftFailureOrSuccessOption: none(),
          //   ),
          // );

          await getUnpaidBreakListApi(emit);
          await getaAccomdationHoursListApi(emit);
          if (e.updateShift != null) {
            setShiftDataToUpdate(emit, e.updateShift!);
            // await Future.delayed(Duration(seconds: 2));
          }
          emit(
            state.copyWith(
              isLoading: false,
              singleShiftFailureOrSuccessOption: none(),
            ),
          );
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
          /// shift_type: 1 means Single Shift
          if (state.shiftType == 2 && state.selectedMultiShiftType == 2) {
            emit(state.copyWith(
              unpaidBreak: InputEmptyOrNot(e.breakTime),
              singleShiftFailureOrSuccessOption: none(),
            ));

            // Substract unpaid break with allTimesFilled method
            emit(state.copyWith(
              totalPaybleHours: allTimesFilled(
                  List<DateTimeDTO>.from(state.multiDateTimeList)),
              singleShiftFailureOrSuccessOption: none(),
            ));
          } else {
            emit(state.copyWith(
              unpaidBreak: InputEmptyOrNot(e.breakTime),
              singleShiftFailureOrSuccessOption: none(),
            ));
            add(PostShiftEvent.totalPayableHoursChanged());
          }
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
            DateTime endTime = CustomDateTimeFormat.parseTime(
                state.endHour.getValue()!, state.endMinute.getValue()!);

            if (!endTime.isAfter(startTime)) {
              endTime = endTime.add(Duration(days: 1));
            }

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
            DateTime startTime = CustomDateTimeFormat.parseTime(
                state.startHour.getValue()!, state.startMinute.getValue()!);
            DateTime endTime = CustomDateTimeFormat.parseTime(
                state.endHour.getValue()!, state.endMinute.getValue()!);

            if (!endTime.isAfter(startTime)) {
              endTime = endTime.add(Duration(days: 1));
            }
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
          if (e.selectedValue != state.selectedCommuteAllownce.getValue()) {
            emit(state.copyWith(
              selectedCommuteAllownce: InputEmptyOrNot(e.selectedValue),
              commuteHour: InputEmptyOrNot(""),
              commuteRate: Rate(""),
              singleShiftFailureOrSuccessOption: none(),
            ));
          }
        },
        commuteHoursChanged: (e) {
          emit(state.copyWith(
            commuteHour: InputEmptyOrNot(e.selectedValue),
            singleShiftFailureOrSuccessOption: none(),
          ));
        },
        commuteRateChanged: (e) {
          emit(state.copyWith(
            commuteRate: Rate(e.selectedValue),
            singleShiftFailureOrSuccessOption: none(),
          ));
        },
        accomdationAllownceChanged: (e) {
          if (e.selectedValue != state.selectedAccomdationAllownce.getValue()) {
            emit(state.copyWith(
              selectedAccomdationAllownce: InputEmptyOrNot(e.selectedValue),
              accomdationHour: InputEmptyOrNot(""),
              accomdationRate: Rate(""),
              singleShiftFailureOrSuccessOption: none(),
            ));
          }
        },
        accomdationHoursChanged: (e) {
          emit(state.copyWith(
            accomdationHour: InputEmptyOrNot(e.selectedValue),
            singleShiftFailureOrSuccessOption: none(),
          ));
        },
        accomdationRateChanged: (e) {
          emit(state.copyWith(
            accomdationRate: Rate(e.selectedValue),
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
              selectedVacancy: Vacancy(e.vacancy),
              singleShiftFailureOrSuccessOption: none(),
            ),
          );
        },
        checkIsMoreVancancy: (e) {
          emit(
            state.copyWith(
              isMoreVacancy: e.isMoreVacancy,
              selectedVacancy: Vacancy(""),
              singleShiftFailureOrSuccessOption: none(),
            ),
          );
        },

        singleShiftSubmitted: (e) async {
          Either<MainFailure, HealthcarePostDTO>? failureOrSuccess;

          final isCommuteAllownceValid = isAllownceValid(
              selectedValue: state.selectedCommuteAllownce,
              hourValue: state.commuteHour,
              rateValue: state.commuteRate);
          final isAccomdationAllownceValid = isAllownceValid(
              selectedValue: state.selectedAccomdationAllownce,
              hourValue: state.accomdationHour,
              rateValue: state.accomdationRate);
          final isSingleDateValid = state.signleShiftDate.isValid();
          final isUnpaidBreakValid = state.unpaidBreak.isValid();
          final isStartHourValid = state.startHour.isValid();
          final isStartMinuteValid = state.startMinute.isValid();
          final isEndHourValid = state.endHour.isValid();
          final isEndMinuteValid = state.endMinute.isValid();
          final isBeforeStartTime =
              timeIsPast(state, state.startHour, state.startMinute);
          final isBeforeEndTime =
              timeIsPast(state, state.endHour, state.endMinute);

          final isVacancyValid = isMoreVacancyValid(
              isMoreVacancy: state.isMoreVacancy,
              vacancyValue: state.selectedVacancy);
          emit(
            state.copyWith(
              isLoading: true,
              singleShiftFailureOrSuccessOption: none(),
            ),
          );
          if (isSingleDateValid &&
              isCommuteAllownceValid &&
              isAccomdationAllownceValid &&
              isStartHourValid &&
              isStartMinuteValid &&
              isEndHourValid &&
              isEndMinuteValid &&
              isUnpaidBreakValid &&
              isVacancyValid &&
              !isBeforeStartTime &&
              !isBeforeEndTime) {
            print("All details are valid!");
            /*failureOrSuccess = await _mainFacade.createPostShiftApi(
                shift: passShiftData(state));*/
            final post = continueWithPostDetail(state, passShiftData(state));

            e.context.router.push(PageRouteInfo(
              PostShiftRecurring.name,
              args: PostShiftRecurringArgs(
                shiftType: state.shiftType,
                updateShift: state.updateShift,
                post: post,
              ),
            ));
          } else {
            print("Some details are invalid!");
          }
          emit(
            state.copyWith(
              isLoading: false,
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
              // selectedTeamList: ListInputEmptyOrNot([]),
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
          /*String recurrenceMode = e.mode;
          DateTime? startDate = state.recurringStartDate.isValid()
              ? DateTime.parse(state.recurringStartDate.getValue() ?? "")
              : null;

          DateTime? endDate = state.recurringEndDate.isValid()
              ? DateTime.parse(state.recurringEndDate.getValue() ?? "")
              : null;

          if (e.mode == "Weekly" && startDate != null && endDate != null) {
            int difference = endDate.difference(startDate).inDays;
            if (difference < 7) {
              showError(
                      message:
                          'End date must be at least 7 days after the start date for weekly recurrence.')
                  .show(e.context);
              recurrenceMode = state.recurrenceMode.getValue() ?? "";
              print("recurrenceMode111---> ${recurrenceMode}");
            }
          }
          print("recurrenceMode---> ${recurrenceMode}");*/

          emit(state.copyWith(
            recurrenceMode: InputEmptyOrNot(e.mode),
            // recurrenceWeekList: ListInputEmptyOrNot([]),
            recurringFailureOrSuccessOption: none(),
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
            recurringFailureOrSuccessOption: none(),
          ));
        },

        recurringEndDateChanged: (e) {
          int? difference;
          DateTime? startDate = state.recurringStartDate.isValid()
              ? DateTime.parse(state.recurringStartDate.getValue() ?? "")
              : null;

          DateTime? endDate = DateTime.parse(e.selectedDate);

          if (startDate != null) {
            difference = endDate.difference(startDate).inDays;
            print("Total days difference ${difference}");
            // if (difference >= 7) {
            // isRangeMoreThanWeek = true;
            // print("isRengeMoreThanWeek---> $isRangeMoreThanWeek");
            // }
          }
          emit(
            state.copyWith(
              recurringEndDate: InputEmptyOrNot(e.selectedDate),
              isRangeMoreThanWeek: (difference != null && difference > 7),
              recurrenceMode: (difference != null && difference > 7)
                  ? InputEmptyOrNot('Weekly')
                  : InputEmptyOrNot('Daily'),
              recurrenceWeekList: ListInputEmptyOrNot([]),
              recurringFailureOrSuccessOption: none(),
            ),
          );
        },
        selectTeamEvent: (e) {
          List<TeamDTO> list = state.selectedTeamList.getValue();
          bool isAlreadyInList = list.any((item) => item.id == e.team.id);
          List<TeamDTO> updatedList;
          if (isAlreadyInList) {
            updatedList = list.where((item) => item.id != e.team.id).toList();
          } else {
            updatedList = List.from(list)..add(e.team);
          }

          emit(state.copyWith(
            selectedTeamList: ListInputEmptyOrNot(updatedList),
            recurringFailureOrSuccessOption: none(),
          ));
        },
        getTeamsListEvent: (e) async {
          emit(
            state.copyWith(
              post: e.post,
              updateShift: e.updateShift ?? HealthcarePostDTO(),
              isLoading: true,
              recurringFailureOrSuccessOption: none(),
            ),
          );
          await getTeamsListApi(emit);
          if (e.updateShift != null) {
            setShiftDataToUpdate(emit, e.updateShift!);
            // await Future.delayed(Duration(seconds: 2));
          }

          emit(
            state.copyWith(
              isLoading: false,
              singleShiftFailureOrSuccessOption: none(),
            ),
          );
        },
        recurringButtonEvent: (e) async {
          Either<MainFailure, HealthcarePostDTO>? failureOrSuccess;
          PostShiftDTO postObj = state.post;
          emit(
            state.copyWith(
              isLoading: true,
              recurringFailureOrSuccessOption: none(),
            ),
          );
          if (isRecurringValid(state) && isTeamsValid(state)) {
            print(
                "Recurrence iD--->>  ${state.updateShift.shift_detail?.recurrence_id}");
            /*failureOrSuccess = await _mainFacade.createPostShiftRecurringApi(
                postShiftId: e.postShiftId,
                recurringStatus: (state.isToBeRecurring) ? 1 : 0,
                startDate: state.recurringStartDate.getValue() ?? "",
                recurrenceMode:
                    (state.recurrenceMode.getValue() == "Weekly") ? 2 : 1,
                days: getSelectedRecurringDayIds(
                    state.recurrenceWeekList.getValue()),
                endDate: state.recurringEndDate.getValue() ?? "",
                disclaimer: state.disclaimerNote,
                shareTeamStatus: (state.isShareWithTeams) ? 1 : 0,
                teamId: getSelectedRecurringDayIds(
                    state.selectedTeamList.getValue()),
                saveTemplateStatus: (state.isSaveAsTemplate) ? 1 : 0);*/

            postObj = state.post.copyWith(
              update_status:
                  (state.updateShift.id != null && state.updateShift.id != -1)
                      ? 0
                      : null,
              recurrence_id: (state.post.shift_type == 1)
                  ? state.updateShift.shift_detail?.recurrence_id
                  : null,
              id: (state.updateShift.id != null && state.updateShift.id != -1)
                  ? state.updateShift.id
                  : null,
              // post_shift_id: e.postShiftId,
              recurring_status: (state.isToBeRecurring) ? "1" : "0",
              recurring_start_date:
                  (state.recurringStartDate.getValue() != null &&
                          state.recurringStartDate.getValue()!.isNotEmpty)
                      ? (DateTime.parse(state.recurringStartDate.getValue()!)
                                  .toUtc()
                                  .millisecondsSinceEpoch /
                              1000)
                          .toString()
                      : "",
              recurrence_mode:
                  (state.recurrenceMode.getValue() == "Weekly") ? 2 : 1,
              days: (state.isToBeRecurring &&
                      state.recurrenceMode.getValue() == "Weekly")
                  ? getSelectedRecurringDayIds(
                      state.recurrenceWeekList.getValue())
                  : "",
              recurring_end_date: (state.recurringEndDate.getValue() != null &&
                      state.recurringEndDate.getValue()!.isNotEmpty)
                  ? (DateTime.parse(state.recurringEndDate.getValue()!)
                              .toUtc()
                              .millisecondsSinceEpoch /
                          1000)
                      .toString()
                  : "",
              disclaimer: state.disclaimerNote,
              share_team_status: (state.isShareWithTeams) ? "1" : "0",
              team_id: (state.isShareWithTeams)
                  ? getSelectedRecurringDayIds(
                      state.selectedTeamList.getValue())
                  : "",
              save_template_status: (state.isSaveAsTemplate) ? "1" : "0",
            );
            if (state.updateShift.id != null && state.updateShift.id != -1) {
              failureOrSuccess = await _mainFacade.updatePostApi(
                postShiftDetail: postObj,
              );
            } else {
              failureOrSuccess = await _mainFacade.createPostApi(
                postShiftDetail: postObj,
              );
            }
            print("All details are valid!--->  ${jsonEncode(postObj)}");
          } else {
            print("Some details are invalid!");
          }

          emit(
            state.copyWith(
              isLoading: false,
              recurringErrorMessage: true,
              post: postObj,
              recurringFailureOrSuccessOption: optionOf(failureOrSuccess),
            ),
          );
        },

        /// Multi Shift
        initMultiDifferentDateEvent: (e) async {
          final updatedList = e.list.map((item) {
            return item.copyWith(
              startMinute: item.startMinute?.isEmpty ?? true
                  ? "00 Min"
                  : item.startMinute,
              endMinute:
                  item.endMinute?.isEmpty ?? true ? "00 Min" : item.endMinute,
            );
          }).toList();

          emit(
            state.copyWith(
              isLoading: true,
              multiDateTimeList: updatedList,
              updateShift: e.updateShift ?? HealthcarePostDTO(),
              singleShiftFailureOrSuccessOption: none(),
            ),
          );
          await getUnpaidBreakListApi(emit);
          if (e.updateShift != null) {
            setShiftDataToUpdate(emit, e.updateShift!);
            // await Future.delayed(Duration(seconds: 2));
          }
          // SkillDTO? selectedSkillDTO = shiftTypeList.firstWhere(
          //   (skill) => skill.name == e.shiftType,
          //   orElse: () => SkillDTO(),
          // );
          emit(
            state.copyWith(
              isLoading: false,
              post: e.post,
              singleShiftFailureOrSuccessOption: none(),
            ),
          );
        },

        multiDateSameDiffTypeChanged: (e) async {
          emit(
            state.copyWith(
              isLoading: true,
              singleShiftFailureOrSuccessOption: none(),
            ),
          );
          // await Future.delayed(Duration(seconds: 2));
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
          final isMultiDateValid = state.selectedMultiDates.isValid();
          final isCommuteAllownceValid = isAllownceValid(
              selectedValue: state.selectedCommuteAllownce,
              hourValue: state.commuteHour,
              rateValue: state.commuteRate);
          final isAccomdationAllownceValid = isAllownceValid(
              selectedValue: state.selectedAccomdationAllownce,
              hourValue: state.accomdationHour,
              rateValue: state.accomdationRate);

          final isVacancyValid = isMoreVacancyValid(
              isMoreVacancy: state.isMoreVacancy,
              vacancyValue: state.selectedVacancy);

          if (isMultiDateValid &&
              isCommuteAllownceValid &&
              isAccomdationAllownceValid &&
              isVacancyValid) {
            print("All details are valid!");
            emit(
              state.copyWith(
                isDifferentDateDataValid: true,
                singleShiftErrorMessages: true,
                differentDateFailureOrSuccessOption: none(),
              ),
            );
          } else {
            print("Some details are invalid!");
            emit(
              state.copyWith(
                isDifferentDateDataValid: false,
                singleShiftErrorMessages: true,
                differentDateFailureOrSuccessOption: none(),
              ),
            );
          }
        },
        backEvent: (e) {
          emit(
            state.copyWith(
              isDifferentDateDataValid: false,
              differentDateFailureOrSuccessOption: none(),
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
        payableHourListChanged: (e) {},
        unpaidBreakListChanged: (e) {
          final list = createOrUpdateDateTimeDTO(
            state,
            index: e.index,
            condition: 5,
            value: e.breakTime,
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
        differentTimeShiftSubmitted: (e) async {
          Either<MainFailure, HealthcarePostDTO>? failureOrSuccess;

          // final isUnPaidBreakValid = state.unpaidBreak.isValid();
          final isAllDatesValid = state.multiDateTimeList.every((dto) =>
              dto.totalPaybleHours != null && dto.totalPaybleHours!.isNotEmpty);
          final timeIsBefore = PostShiftBloc.timeIsBefore(
            state,
            multiDate: state.multiDateTimeList,
            shiftType: 2,
          );

          if (isAllDatesValid && !timeIsBefore) {
            /*failureOrSuccess = await _mainFacade.createPostShiftApi(
                shift: passShiftData(
              state,
              shiftDetail: e.shiftDetail,
            ));*/

            final post = continueWithPostDetail(
                state, passShiftData(state, shiftDetail: e.shiftDetail));

            /*PostShiftDTO post = state.post.copyWith(
              shiftDetail: passShiftData(state, shiftDetail: e.shiftDetail),
            );*/

            print("Post from push222:--> ${jsonEncode(post)}");

            e.context.router.push(PageRouteInfo(
              PostShiftRecurring.name,
              args: PostShiftRecurringArgs(
                shiftType: state.shiftType,
                updateShift: state.updateShift,
                post: post,
              ),
            ));
          }
          emit(
            state.copyWith(
              singleShiftErrorMessages: true,
              singleShiftFailureOrSuccessOption: optionOf(failureOrSuccess),
            ),
          );
        },
        sameTimeShiftSubmitted: (e) async {
          Either<MainFailure, HealthcarePostDTO>? failureOrSuccess;

          final isCommuteAllownceValid = isAllownceValid(
              selectedValue: state.selectedCommuteAllownce,
              hourValue: state.commuteHour,
              rateValue: state.commuteRate);
          final isAccomdationAllownceValid = isAllownceValid(
              selectedValue: state.selectedAccomdationAllownce,
              hourValue: state.accomdationHour,
              rateValue: state.accomdationRate);
          final isMultiDateValid = state.selectedMultiDates.isValid();
          final isUnpaidBreakValid = state.unpaidBreak.isValid();
          final isStartHourValid = state.startHour.isValid();
          final isStartMinuteValid = state.startMinute.isValid();
          final isEndHourValid = state.endHour.isValid();
          final isEndMinuteValid = state.endMinute.isValid();
          final isVacancyValid = isMoreVacancyValid(
              isMoreVacancy: state.isMoreVacancy,
              vacancyValue: state.selectedVacancy);
          final isBeforeStartTime = timeIsPast(
              state, state.startHour, state.startMinute,
              shiftType: 1);
          final isBeforeEndTime =
              timeIsPast(state, state.endHour, state.endMinute, shiftType: 1);

          if (isMultiDateValid &&
              isCommuteAllownceValid &&
              isAccomdationAllownceValid &&
              isStartHourValid &&
              isStartMinuteValid &&
              isEndHourValid &&
              isEndMinuteValid &&
              isUnpaidBreakValid &&
              isVacancyValid &&
              !isBeforeStartTime &&
              !isBeforeEndTime) {
            print("All details are valid!");
            /*failureOrSuccess = await _mainFacade.createPostShiftApi(
                shift: passShiftData(state));*/

            final post = continueWithPostDetail(state, passShiftData(state));

            /*PostShiftDTO post = state.post.copyWith(
              shiftDetail: passShiftData(state),
            );*/
            print("Post from push111:--> ${jsonEncode(post)}");

            e.context.router.push(PageRouteInfo(
              PostShiftRecurring.name,
              args: PostShiftRecurringArgs(
                shiftType: state.shiftType,
                updateShift: state.updateShift,
                post: post,
              ),
            ));
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
        postTheShiftEvent: (e) async {
          emit(
            state.copyWith(
              isLoading: true,
              recurringFailureOrSuccessOption: none(),
              postShiftFailureOrSuccessOption: none(),
            ),
          );
          print("All details are valid! ");
          if (e.updatedPost != null) {
            Either<MainFailure, HealthcarePostDTO>? updateFailureOrSuccess;
            PostShiftDTO postObj = e.updatedPost!.copyWith(
              update_status: 1,
            );
            updateFailureOrSuccess = await _mainFacade.updatePostApi(
              postShiftDetail: postObj,
            );
            emit(
              state.copyWith(
                isLoading: false,
                singleShiftErrorMessages: true,
                postShiftFailureOrSuccessOption: none(),
                recurringFailureOrSuccessOption:
                    optionOf(updateFailureOrSuccess),
              ),
            );
          } else {
            Either<MainFailure, String>? failureOrSuccess;

            failureOrSuccess = await _mainFacade.postShiftApi(postId: e.postId);
            emit(
              state.copyWith(
                isLoading: false,
                singleShiftErrorMessages: true,
                recurringFailureOrSuccessOption: none(),
                postShiftFailureOrSuccessOption: optionOf(failureOrSuccess),
              ),
            );
          }
        },
      );
    });
  }

  setShiftDataToUpdate(
      Emitter<PostShiftState> emit, HealthcarePostDTO updatedShift) async {
    final r = updatedShift.shift_detail;
    if (r != null) {
      print("Update r---> ${jsonEncode(r.recurrence_mode)}");
      emit(
        state.copyWith(
          isLoading: true,
          shiftType: r.shift_type ?? 1,
          unpaidBreak: InputEmptyOrNot(r.unpaid_break?.name ?? ""),
          totalPaybleHours: r.total_payable_hour ?? "",
          selectedCommuteAllownce:
              InputEmptyOrNot((r.commute_allowance_type == 1)
                  ? "Flat Rate"
                  : (r.commute_allowance_type == 2)
                      ? "Hours"
                      : "None"),
          commuteHour: InputEmptyOrNot((r.commute_allowance_type == 2)
              ? getAccomdationHourName(r.commute_allowance_type_details ?? 0)
              : ""),
          commuteRate: Rate((r.commute_allowance_type == 1)
              ? "${r.commute_allowance_type_details ?? 0}"
              : ""),
          selectedAccomdationAllownce:
              InputEmptyOrNot((r.accommodation_allowance_type == 1)
                  ? "Flat Rate"
                  : (r.accommodation_allowance_type == 2)
                      ? "Hours"
                      : "None"),
          accomdationHour: InputEmptyOrNot((r.accommodation_allowance_type == 2)
              ? getAccomdationHourName(
                  r.accommodation_allowance_type_details ?? 0)
              : ""),
          accomdationRate: Rate((r.accommodation_allowance_type == 1)
              ? "${r.accommodation_allowance_type_details ?? 0}"
              : ""),
          singleShiftNote: r.shift_note ?? "",
          isMoreVacancy: (r.vacancie_type == 1) ? true : false,
          selectedVacancy: Vacancy("${r.number_of_vacancie ?? 0}"),

          /// Set for Same time for all date data
          isIndividualPost: (r.individual_shift == 1) ? true : false,
          selectedMultiDates: (r.shift_type == 1)
              ? ListInputEmptyOrNot([])
              : convertMultiDate(r.detail ?? []),
          startHour: InputEmptyOrNot(
              CustomDateTimeFormat.getHour(timestamp: r.start_time ?? 0)),
          startMinute: InputEmptyOrNot(
              CustomDateTimeFormat.getMinute(timestamp: r.start_time ?? 0)),
          endHour: InputEmptyOrNot(
              CustomDateTimeFormat.getHour(timestamp: r.end_time ?? 0)),
          endMinute: InputEmptyOrNot(
              CustomDateTimeFormat.getMinute(timestamp: r.end_time ?? 0)),
          signleShiftDate: InputEmptyOrNot((r.date != null)
              ? DateTime.fromMillisecondsSinceEpoch(r.date! * 1000).toString()
              : ""),

          /// Different time for each date
          selectedMultiShiftType: r.same_or_different_time ?? -1,
          multiDateTimeList:
              (r.shift_type == 2 && r.same_or_different_time == 2)
                  ? getDifferentMultiDate(r.detail ?? [])
                  : [],

          /// Set for recurring Screening data
          isToBeRecurring: (r.recurring_status == 1) ? true : false,
          isShareWithTeams: (r.share_team_status == 1) ? true : false,
          isSaveAsTemplate: (r.save_template_status == 1) ? true : false,
          disclaimerNote: r.disclaimer ?? "",
          selectedTeamList: setTeamList(r.teams ?? []),
          recurringStartDate: InputEmptyOrNot((r.recurring_start_date != null)
              ? DateTime.fromMillisecondsSinceEpoch(
                      r.recurring_start_date! * 1000)
                  .toString()
              : ""),
          recurringEndDate: InputEmptyOrNot((r.recurring_end_date != null)
              ? DateTime.fromMillisecondsSinceEpoch(
                      r.recurring_end_date! * 1000)
                  .toString()
              : ""),
          recurrenceMode:
              InputEmptyOrNot((r.recurrence_mode == '2') ? 'Weekly' : 'Daily'),
          isRangeMoreThanWeek: setRecurringRange(
              endDate: r.recurring_end_date, startDate: r.recurring_start_date),
          recurrenceWeekList: setWeekList(r.days ?? ""),
        ),
      );
    }
  }

  bool setRecurringRange({required int? startDate, required int? endDate}) {
    int? difference;

    DateTime? formattedstartDate = (startDate != null)
        ? DateTime.fromMillisecondsSinceEpoch(startDate * 1000)
        : null;
    DateTime? formattedEndDate = (endDate != null)
        ? DateTime.fromMillisecondsSinceEpoch(endDate * 1000)
        : null;

    if (formattedstartDate != null && formattedEndDate != null) {
      difference = formattedEndDate.difference(formattedstartDate).inDays;
      print("Total days difference ${difference}");
      if (difference > 7) {
        return true;
      }
    }
    return false;
  }

  ListInputEmptyOrNot<TeamDTO> setTeamList(List<TeamDTO> teamList) {
    List<TeamDTO> list = state.selectedTeamList.getValue();
    for (TeamDTO team in teamList) {
      bool isAlreadyInList = list.any((item) => item.id == team.id);
      if (isAlreadyInList) {
        list = list.where((item) => item.id != team.id).toList();
      } else {
        list = List.from(list)..add(team);
      }
    }
    return ListInputEmptyOrNot(list);
  }

  ListInputEmptyOrNot<SkillDTO> setWeekList(String day) {
    print("Get List day --> ${day}");
    if (day.isNotEmpty) {
      List<int> dayIndexes = day.split(',').map((e) => int.parse(e)).toList();
      List<SkillDTO> recurrenceWeekList = CommonList.weekList
          .where((day) => dayIndexes.contains(day.id))
          .toList();
      print("Get List of week --> ${jsonEncode(recurrenceWeekList)}");
      return ListInputEmptyOrNot(recurrenceWeekList);
    } else {
      return ListInputEmptyOrNot([]);
    }
  }

  PostShiftDTO continueWithPostDetail(
      PostShiftState state, MultiShiftDTO shift) {
    String mapMultiDateToApiFormat() {
      if (shift.multi_date != null && shift.multi_date!.isNotEmpty) {
        final list = shift.multi_date!.map((multiDate) {
          final map = {
            if (state.updateShift.id == null) ...{
              'date': DateTime.parse(multiDate.date ?? "")
                      .toUtc()
                      .millisecondsSinceEpoch /
                  1000,
              'start_time': DateTime.parse((shift.same_or_different_time == 1)
                          ? shift.start_time ?? ""
                          : multiDate.start_time ?? "")
                      .toUtc()
                      .millisecondsSinceEpoch /
                  1000,
              'end_time': DateTime.parse((shift.same_or_different_time == 1)
                          ? shift.end_time ?? ""
                          : multiDate.end_time ?? "")
                      .toUtc()
                      .millisecondsSinceEpoch /
                  1000,
              'payable_hour': multiDate.totalPaybleHours,
              'unpaid_break_id':
                  getSelectedUnPaidBreakId(breakTime: multiDate.unpaidBreak),
            } else ...{
              'id': multiDate.id,
              'unpaid_break_id':
                  getSelectedUnPaidBreakId(breakTime: multiDate.unpaidBreak),
            }
          };
          return map;
        }).toList();
        return jsonEncode(list);
      } else {
        return "";
      }
    }

    PostShiftDTO mapData = state.post.copyWith(
      shift_type: shift.shift_type,
      unpaid_break_id: shift.unpaid_break_id,
      total_payable_hour: shift.total_payable_hour,
      commute_allowance_type: shift.commute_allowance_type,
      accommodation_allowance_type: shift.accommodation_allowance_type,
      vacancie_type: shift.vacancie_type.toString(),
      date: (shift.date != null && shift.date!.isNotEmpty)
          ? (DateTime.parse(shift.date ?? "").toUtc().millisecondsSinceEpoch /
                  1000)
              .toString()
          : null,
      start_time: (shift.start_time != null && shift.start_time!.isNotEmpty)
          ? (DateTime.parse(shift.start_time ?? "")
                      .toUtc()
                      .millisecondsSinceEpoch /
                  1000)
              .toString()
          : null,
      end_time: (shift.end_time != null && shift.end_time!.isNotEmpty)
          ? (DateTime.parse(shift.end_time ?? "")
                      .toUtc()
                      .millisecondsSinceEpoch /
                  1000)
              .toString()
          : null,
      same_or_different_time: shift.same_or_different_time,
      multi_date: mapMultiDateToApiFormat(),
      individual_shift: shift.individual_shift,
      commute_allowance: shift.commute_allowance,
      accommodation_allowance: shift.accommodation_allowance,
      shift_note: shift.shift_note,
      number_of_vacancie: shift.number_of_vacancie,
    );
    return mapData;
  }

  getUnpaidBreakListApi(Emitter<PostShiftState> emit) async {
    final breakList = await _mainFacade.getUnpaidBreakListApi();
    print("Break List ---> $breakList");
    breakList.fold(
      (l) => emit(
        state.copyWith(
          breakList: [],
        ),
      ),
      (r) {
        return emit(
          state.copyWith(
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
            accomdationHoursList: r,
          ),
        );
      },
    );
  }

  getTeamsListApi(Emitter<PostShiftState> emit) async {
    final teamList = await _mainFacade.getTeamsList();
    print("Team List ---> $teamList");
    teamList.fold(
      (l) => emit(
        state.copyWith(
          // isLoading: false,
          teamList: [],
        ),
      ),
      (r) {
        return emit(
          state.copyWith(
            teamList: r,
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
    required int? index,
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
      unpaidBreak: condition == 5 ? value : updatedDTO.unpaidBreak,
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

    // Calculate total payable hours
    if (isTimeFilled(updatedDTO)) {
      DateTime endTime = DateTime.parse(updatedDTO.end_time ?? "");
      DateTime startTime = DateTime.parse(updatedDTO.start_time ?? "");

      if (!endTime.isAfter(startTime)) {
        endTime = endTime.add(Duration(days: 1));
      }
      var timeDiffBetweenEndStartTime = endTime.difference(startTime);
      Duration? timeDifference;
      if (updatedDTO.unpaidBreak != null &&
          updatedDTO.unpaidBreak!.isNotEmpty) {
        final unpaidBreak = (updatedDTO.unpaidBreak != null &&
                updatedDTO.unpaidBreak!.isNotEmpty)
            ? CustomDateTimeFormat.extractUnpaidBreak(updatedDTO.unpaidBreak!)
            : 0;
        timeDifference =
            timeDiffBetweenEndStartTime - Duration(minutes: unpaidBreak);
      }

      // var timeDiffBetweenEndStartTime = DateTime.parse(updatedDTO.end_time!)
      //     .difference(DateTime.parse(updatedDTO.start_time!));

      print("total hours---> ${timeDiffBetweenEndStartTime}");
      print("total hours---> timeDifference ${timeDifference}");
      updatedDTO = updatedDTO.copyWith(
          totalPaybleHours: (timeDifference != null)
              ? CustomDateTimeFormat.formatDuration(timeDifference)
              : "");
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

  /// Addition of total_payable_hours
  String allTimesFilled(List<DateTimeDTO> multiDateTimeList) {
    bool areAllTimesFilled = multiDateTimeList.every((dto) =>
        dto.totalPaybleHours != null && dto.totalPaybleHours!.isNotEmpty);

    if (areAllTimesFilled) {
      // Substract unpaid break list
      List<DateTimeDTO> updatedList = multiDateTimeList.map((dto) {
        if (isTimeFilled(dto)) {
          final unpaidBreak =
              CustomDateTimeFormat.extractUnpaidBreak(dto.unpaidBreak ?? "0");
          var timeDiffBetweenEndStartTime = DateTime.parse(dto.end_time!)
              .difference(DateTime.parse(dto.start_time!));

          final timeDifference =
              timeDiffBetweenEndStartTime - Duration(minutes: unpaidBreak);
          // print("timeDifference---> timeDifference ${timeDifference}");
          print("timeDifference---> timeDifference ${unpaidBreak}");

          return dto.copyWith(totalPaybleHours: timeDifference.toString());
        } else {
          return dto;
        }
      }).toList();

      final totalHour = CustomDateTimeFormat.formatDuration(
          sumTotalPayableHours(updatedList));

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
    final duration1 =
        Duration(hours: hours, minutes: minutes, seconds: seconds);
    return duration1;
  }

  Duration sumTotalPayableHours(List<DateTimeDTO> multiDateTimeList) {
    print("payable hours: ${multiDateTimeList}");
    final totalDuration = multiDateTimeList.fold(Duration.zero, (total, dto) {
      return total + parseDuration(dto.totalPaybleHours ?? "");
    });
    return totalDuration;
  }

  bool isTimeFilled(DateTimeDTO dto) {
    return (dto.start_time != null &&
        dto.start_time!.isNotEmpty &&
        dto.end_time != null &&
        dto.end_time!.isNotEmpty);
  }

  int getSelectedUnPaidBreakId({String? breakTime}) {
    final breakId = state.breakList.firstWhere((unpaidBreak) {
      if (breakTime != null) {
        return unpaidBreak.name == breakTime;
      } else {
        return unpaidBreak.name == state.unpaidBreak.getValue();
      }
    }, orElse: () => SkillDTO());
    print("Break ID --> $breakId");
    return breakId.id ?? -1;
  }

  String getAccomdationHourId(String selectedHour) {
    final hourId = state.accomdationHoursList.firstWhere(
        (hour) => hour.name == selectedHour,
        orElse: () => SkillDTO());
    print("Hour ID --> $hourId");
    return "${hourId.id ?? -1}";
  }

  String getAccomdationHourName(int id) {
    print("id of hour--> ${state.accomdationHoursList}");
    final hour = state.accomdationHoursList
        .firstWhere((hour) => hour.id == id, orElse: () => SkillDTO());
    print("Hour --> $hour");
    return hour.name ?? "";
  }

  String getUnpaidBreakName(int id) {
    final breakTime = state.breakList.firstWhere(
        (unpaidBreak) => unpaidBreak.id == id,
        orElse: () => SkillDTO());
    print("breakTime --> $breakTime");
    return breakTime.name ?? "";
  }

  /*MultiShiftDTO passShiftData(PostShiftState state,
      {MultiShiftDTO? shiftDetail}) {
    String startTime = "";
    String endTime = "";

    if (state.shiftType == 1 ||
        (state.shiftType == 2 && state.selectedMultiShiftType == 1)) {
      startTime = CustomDateTimeFormat.parseTime(
              state.startHour.getValue() ?? "",
              state.startMinute.getValue() ?? "")
          .toString();
      endTime = CustomDateTimeFormat.parseTime(
              state.endHour.getValue() ?? "", state.endMinute.getValue() ?? "")
          .toString();
    }

    /// Only true when submit from different time for each shift
    if (shiftDetail != null) {
      var data = shiftDetail.copyWith(
        unpaid_break_id: getSelectedUnPaidBreakId(),
        total_payable_hour: state.totalPaybleHours,
        multi_date: (shiftDetail.same_or_different_time == 1)
            ? mapMultiDateToApiFormat(state)
            : state.multiDateTimeList,
      );
      return data;
    } else {
      return MultiShiftDTO(
        post_id: state.postId,
        shift_type: state.shiftType,
        date: state.signleShiftDate.getValue(),
        start_time: startTime,
        end_time: endTime,
        unpaid_break_id: getSelectedUnPaidBreakId(),
        total_payable_hour: state.totalPaybleHours,
        commute_allowance_type:
            (state.selectedCommuteAllownce.getValue() == "Flat Rate")
                ? 1
                : (state.selectedCommuteAllownce.getValue() == "Hours")
                    ? 2
                    : (state.selectedCommuteAllownce.getValue() == "None")
                        ? 0
                        : null,
        commute_allowance:
            (state.selectedCommuteAllownce.getValue() == "Flat Rate")
                ? state.commuteRate.getValue()
                : (state.selectedCommuteAllownce.getValue() == "Hours")
                    ? getAccomdationHourId(state.commuteHour.getValue() ?? "")
                    : null,
        accommodation_allowance_type:
            (state.selectedAccomdationAllownce.getValue() == "Flat Rate")
                ? 1
                : (state.selectedAccomdationAllownce.getValue() == "Hours")
                    ? 2
                    : (state.selectedAccomdationAllownce.getValue() == "None")
                        ? 0
                        : null,
        accommodation_allowance: (state.selectedAccomdationAllownce
                    .getValue() ==
                "Flat Rate")
            ? state.accomdationRate.getValue()
            : (state.selectedAccomdationAllownce.getValue() == "Hours")
                ? getAccomdationHourId(state.accomdationHour.getValue() ?? "")
                : null,
        shift_note: state.singleShiftNote,
        vacancie_type: (state.isMoreVacancy) ? 1 : 0,
        number_of_vacancie: (state.selectedVacancy.isValid())
            ? int.parse(state.selectedVacancy.getValue() ?? "0")
            : null,

        /// Extra params of Multi shift
        individual_shift: (state.isIndividualPost) ? 1 : 0,
        multi_date: (state.selectedMultiShiftType == 1)
            ? mapMultiDateToApiFormat(state)
            : state.multiDateTimeList,
        same_or_different_time: state.selectedMultiShiftType,
      );
    }
  }*/

  MultiShiftDTO passShiftData(PostShiftState state,
      {MultiShiftDTO? shiftDetail}) {
    String startTime = "";
    String endTime = "";

    if (state.shiftType == 1 ||
        (state.shiftType == 2 && state.selectedMultiShiftType == 1)) {
      startTime = CustomDateTimeFormat.parseTime(
              state.startHour.getValue() ?? "",
              state.startMinute.getValue() ?? "")
          .toString();
      endTime = CustomDateTimeFormat.parseTime(
              state.endHour.getValue() ?? "", state.endMinute.getValue() ?? "")
          .toString();
    }

    /// Only true when submit from different time for each shift
    if (shiftDetail != null) {
      var data = shiftDetail.copyWith(
        unpaid_break_id: getSelectedUnPaidBreakId(),
        total_payable_hour: state.totalPaybleHours,
        multi_date: (shiftDetail.same_or_different_time == 1)
            ? mapMultiDateToApiFormat(state)
            : state.multiDateTimeList,
      );
      return data;
    } else {
      return MultiShiftDTO(
        post_id: state.postId,
        shift_type: state.shiftType,
        commute_allowance_type:
            (state.selectedCommuteAllownce.getValue() == "Flat Rate")
                ? 1
                : (state.selectedCommuteAllownce.getValue() == "Hours")
                    ? 2
                    : (state.selectedCommuteAllownce.getValue() == "None")
                        ? 0
                        : null,
        commute_allowance:
            (state.selectedCommuteAllownce.getValue() == "Flat Rate")
                ? state.commuteRate.getValue()
                : (state.selectedCommuteAllownce.getValue() == "Hours")
                    ? getAccomdationHourId(state.commuteHour.getValue() ?? "")
                    : null,
        accommodation_allowance_type:
            (state.selectedAccomdationAllownce.getValue() == "Flat Rate")
                ? 1
                : (state.selectedAccomdationAllownce.getValue() == "Hours")
                    ? 2
                    : (state.selectedAccomdationAllownce.getValue() == "None")
                        ? 0
                        : null,
        accommodation_allowance: (state.selectedAccomdationAllownce
                    .getValue() ==
                "Flat Rate")
            ? state.accomdationRate.getValue()
            : (state.selectedAccomdationAllownce.getValue() == "Hours")
                ? getAccomdationHourId(state.accomdationHour.getValue() ?? "")
                : null,
        shift_note: state.singleShiftNote,
        vacancie_type: (state.isMoreVacancy) ? 1 : 0,
        number_of_vacancie: (state.selectedVacancy.isValid())
            ? int.parse(state.selectedVacancy.getValue())
            : null,

        /// Extra params of Multi shift
        individual_shift: (state.isIndividualPost) ? 1 : 0,
        multi_date: (state.selectedMultiShiftType == 1)
            ? mapMultiDateToApiFormat(state)
            : state.multiDateTimeList,
        same_or_different_time: state.selectedMultiShiftType,

        ///
        date: state.signleShiftDate.getValue(),
        start_time: startTime,
        end_time: endTime,
        unpaid_break_id: getSelectedUnPaidBreakId(),
        total_payable_hour: state.totalPaybleHours,
      );
    }
  }

  List<DateTimeDTO> mapMultiDateToApiFormat(PostShiftState state) {
    return state.selectedMultiDates.getValue().map((multiDate) {
      return DateTimeDTO(
        date: multiDate.toString(),
      );
    }).toList();
  }

  ListInputEmptyOrNot<DateTime> convertMultiDate(
      List<ShiftDateDetailDTO> detail) {
    print("detail is empty--> ${detail}");
    final list = ListInputEmptyOrNot(detail.map((multiDate) {
      final timestamp = multiDate.date;
      return (timestamp != null)
          ? DateTime.fromMillisecondsSinceEpoch(timestamp * 1000)
          : DateTime.now();
    }).toList());
    print("get selected date list--> ${list}");

    return list;
  }

  List<DateTimeDTO> getDifferentMultiDate(List<ShiftDateDetailDTO> detail) {
    print("detail is empty--> ${detail}");
    final list = detail.map((multiDate) {
      final timestamp = multiDate.date;
      // return (timestamp != null)
      //     ? DateTime.fromMillisecondsSinceEpoch(timestamp * 1000)
      //     : DateTime.now();

      return DateTimeDTO(
          id: multiDate.id,
          date: (timestamp != null)
              ? DateTime.fromMillisecondsSinceEpoch(timestamp * 1000).toString()
              : DateTime.now().toString(),
          startHour: CustomDateTimeFormat.getHour(
              timestamp: multiDate.start_time ?? 0),
          startMinute: CustomDateTimeFormat.getMinute(
              timestamp: multiDate.start_time ?? 0),
          endHour:
              CustomDateTimeFormat.getHour(timestamp: multiDate.end_time ?? 0),
          endMinute: CustomDateTimeFormat.getMinute(
              timestamp: multiDate.end_time ?? 0),
          totalPaybleHours: multiDate.payable_hour ?? "",
          start_time: (multiDate.start_time != null)
              ? DateTime.fromMillisecondsSinceEpoch(
                      multiDate.start_time! * 1000)
                  .toString()
              : DateTime.now().toString(),
          end_time: (multiDate.end_time != null)
              ? DateTime.fromMillisecondsSinceEpoch(multiDate.end_time! * 1000)
                  .toString()
              : DateTime.now().toString(),
          unpaidBreak: getUnpaidBreakName(multiDate.unpaid_break?.id ?? -1));
    }).toList();
    print("get selected date list--> ${list}");
    return list;
  }

  String getSelectedRecurringDayIds(List<dynamic> list) {
    final dayIds = list
        .map((day) => day.id) // Extract IDs
        .toList();
    String commaSeparated = dayIds.join(',');
    print('Get IDs from list: $commaSeparated');

    return commaSeparated;
  }
}
