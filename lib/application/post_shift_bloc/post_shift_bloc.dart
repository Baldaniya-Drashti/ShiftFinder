// ignore_for_file: prefer_const_constructors, avoid_print, prefer_const_literals_to_create_immutables, unnecessary_brace_in_string_interps
import 'dart:convert';

import 'package:auto_route/auto_route.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:intl/intl.dart';
import 'package:shift/domain/auth/auth_failure.dart';
import 'package:shift/domain/auth/auth_value_objects.dart';
import 'package:shift/domain/core/string_constant.dart';
import 'package:shift/domain/main/i_main_facade.dart';
import 'package:shift/domain/main/main_failure.dart';
import 'package:shift/infrastructure/core/network/common_response.dart';
import 'package:shift/infrastructure/core/skill_list_model/skill_dto.dart';
import 'package:shift/infrastructure/main/date_time_dto/date_time_dto.dart';
import 'package:shift/infrastructure/main/healthcare_post/healthcare_post_dto.dart';
import 'package:shift/infrastructure/main/multi_shift_dto/multi_shift_dto.dart';
import 'package:shift/infrastructure/main/post_shift_dto/post_shift_dto.dart';
import 'package:shift/infrastructure/main/shift_date_detail_dto/shift_date_detail_dto.dart';
import 'package:shift/infrastructure/main/team_dto/team_dto.dart';
import 'package:shift/presentation/common/utils/date_time_format.dart';
import 'package:shift/presentation/common/utils/flushbar_creator.dart';
import 'package:shift/presentation/common/utils/get_cookie.dart';
import 'package:shift/presentation/core/app_router.gr.dart';
import 'package:shift/presentation/core/common_lisitng/common_listing.dart';
import 'package:shift/presentation/core/logger/logger.dart';

import '../../infrastructure/main/shift_detail_dto/shift_detail_dto.dart';

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

  /// Use this for select shift from tommorrow
  /* static bool timeIsPast(
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
  } */

  /// Use this for select shift from today
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

    print("isSameDateee---> ${isSameDate}");

    if (selectedHour.isValid() && selectedMin.isValid()) {
      final selectedTime = CustomDateTimeFormat.parseTime(
          selectedHour.getValue()!, selectedMin.getValue()!);
      if (isSameDate) {
        // final isBefore = selectedTime.isBefore(currentDate);
        // return isBefore;

        /// Used when shift is today and time is after 2 hours from current time
        final twoHoursLater = currentDate.add(Duration(hours: 2));
        final isBefore = selectedTime.isBefore(twoHoursLater);

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
            // isPast = selectedTime.isBefore(DateTime.now());

            /// Used when shift is today and time is after 2 hours from current time
            final twoHoursLater = today.add(Duration(hours: 2));
            isPast = selectedTime.isBefore(twoHoursLater);
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
        assitantOnSiteCheck: (e) {
          emit(
            state.copyWith(
              isAssistantOnSite: e.isCheck,
              recurringErrorMessage: false,
              recurringFailureOrSuccessOption: none(),
            ),
          );
        },
        technicianOnSiteCheck: (e) {
          emit(
            state.copyWith(
              isTechnicianOnSite: e.isCheck,
              recurringErrorMessage: false,
              recurringFailureOrSuccessOption: none(),
            ),
          );
        },
        scriptVolumeChanged: (e) {
          emit(
            state.copyWith(
              scriptVolume: InputEmptyOrNot(e.scriptVolume),
            ),
          );
        },

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

            add(PostShiftEvent.getBreakAllownceListApi(
              e.updateShift,
              fromSaveTemplate: e.fromSaveTemplate,
              fromReview: e.fromReview,
            ));

            emit(
              state.copyWith(
                shiftType: selectedSkillDTO.id ?? -1,
                postId: e.postId,
                // isLoading: false,
                singleShiftFailureOrSuccessOption: none(),
              ),
            );
          }

          emit(state.copyWith(
            fromSaveTemplate: e.fromSaveTemplate ?? false,
          ));
        },

        /// Single Shift
        getBreakAllownceListApi: (e) async {
          await getUnpaidBreakListApi(emit);
          await getaAccomdationHoursListApi(emit);
          if (e.updateShift != null) {
            setShiftDataToUpdate(
              emit: emit,
              updatedShift: e.updateShift!,
              isFromSaveTemplate: e.fromSaveTemplate,
              isFromReview: e.fromReview,
            );
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

          final isMoreThanTwoHours =
              CustomDateTimeFormat.parseTotalPayableHours(
                  state.totalPaybleHours);
          final isScriptVolumeValid = state.scriptVolume.isValid();
          // final isBeforeEndTime =
          //     timeIsPast(state, state.endHour, state.endMinute);

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
              (getCurrentIndustry() != 2 ||
                  (getCurrentIndustry() == 2 && isScriptVolumeValid))) {
            if (isMoreThanTwoHours < Duration(hours: 2)) {
              showError(
                      message:
                          StringConstant.theTotalPayableHourMustBeAtLeastTwo)
                  .show(e.context);
              print("Hours is minimum 2 hour");
            } else {
              print("All details are valid!");
              /*failureOrSuccess = await _mainFacade.createPostShiftApi(
                shift: passShiftData(state));*/
              final post = continueWithPostDetail(
                state,
                passShiftData(state),
                e.fromSaveTemplate,
              );

              print("All details are valid!---> ${post}");
              e.context.router.push(PageRouteInfo(
                PostShiftRecurring.name,
                args: PostShiftRecurringArgs(
                  shiftType: state.shiftType,
                  updateShift: state.updateShift,
                  post: post,
                  fromSaveTemplate: e.fromSaveTemplate,
                  fromReview: e.fromReview,
                  isCreate: e.isCreate,
                ),
              ));
            }
          } else {
            showError(
                    message: StringConstant
                        .someDetailsAreMissingOrInvalidPleaseCheck)
                .show(e.context);
            print("Some details are invalid! ${isBeforeStartTime}");
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
            setShiftDataToUpdate(
              emit: emit,
              updatedShift: e.updateShift!,
            );
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
              /* update_status: (state.updateShift.id != null &&
                      state.updateShift.id != -1 &&
                      e.fromReview)
                  ? 1
                  : (state.updateShift.id != null && state.updateShift.id != -1)
                      ? 0
                      : null, */
              update_status:
                  (state.updateShift.id != null && state.updateShift.id != -1)
                      ? 1
                      : null,
              recurrence_id: (state.post.shift_type == 1)
                  ? state.updateShift.shift_detail?.recurrence_id
                  : null,
              id: (state.updateShift.id != null && state.updateShift.id != -1)
                  ? state.updateShift.id
                  : null,
              // post_shift_id: e.postShiftId,
              recurring_status: (state.isToBeRecurring) ? "1" : "0",
              recurring_start_date: (state.isToBeRecurring &&
                      state.recurringStartDate.getValue() != null &&
                      state.recurringStartDate.getValue()!.isNotEmpty)
                  ? (CustomDateTimeFormat.mergeDateAndTime(
                            // state.post.start_time ?? "",
                            DateTime.fromMillisecondsSinceEpoch(
                                    ((double.tryParse(state.post.start_time ??
                                                    "0") ??
                                                0) *
                                            1000)
                                        .toInt())
                                .toIso8601String(),
                            "",
                            dateTime: DateTime.parse(
                                state.recurringStartDate.getValue()!),
                          ).toUtc().millisecondsSinceEpoch /
                          1000)
                      .toString()
                  : "",
              recurring_end_date: (state.isToBeRecurring &&
                      state.recurringEndDate.getValue() != null &&
                      state.recurringEndDate.getValue()!.isNotEmpty)
                  ? (CustomDateTimeFormat.mergeDateAndTime(
                            // state.post.start_time ?? "",
                            DateTime.fromMillisecondsSinceEpoch(
                                    ((double.tryParse(state.post.start_time ??
                                                    "0") ??
                                                0) *
                                            1000)
                                        .toInt())
                                .toIso8601String(),
                            "",
                            dateTime: DateTime.parse(
                                state.recurringEndDate.getValue()!),
                          ).toUtc().millisecondsSinceEpoch /
                          1000)
                      .toString()
                  : "",
              /*  recurring_start_date: (state.isToBeRecurring &&
                      state.recurringStartDate.getValue() != null &&
                      state.recurringStartDate.getValue()!.isNotEmpty)
                  ? (DateTime.parse(state.recurringStartDate.getValue()!)
                              .toUtc()
                              .millisecondsSinceEpoch /
                          1000)
                      .toString()
                  : "",
               recurring_end_date: (state.isToBeRecurring &&
                      state.recurringEndDate.getValue() != null &&
                      state.recurringEndDate.getValue()!.isNotEmpty)
                  ? (DateTime.parse(state.recurringEndDate.getValue()!)
                              .toUtc()
                              .millisecondsSinceEpoch /
                          1000)
                      .toString()
                  : "", */
              recurrence_mode:
                  (state.recurrenceMode.getValue() == "Weekly") ? 2 : 1,
              days: (state.isToBeRecurring &&
                      state.recurrenceMode.getValue() == "Weekly")
                  ? getSelectedRecurringDayIds(
                      state.recurrenceWeekList.getValue())
                  : "",
              disclaimer: state.disclaimerNote,
              share_team_status: (state.isShareWithTeams) ? "1" : "0",
              team_id: (state.isShareWithTeams)
                  ? getSelectedRecurringDayIds(
                      state.selectedTeamList.getValue())
                  : "",
              save_template_status:
                  (state.isSaveAsTemplate && !e.fromSaveTemplate) ? "1" : "0",
              dateUpdate: (state.post.shift_type == 2 &&
                      state.updateShift.id != null &&
                      !e.fromSaveTemplate &&
                      (e.fromReview || !e.isCreate))
                  ? 1
                  : 0,
            );

            if ((state.updateShift.id != null && state.updateShift.id != -1) &&
                // e.fromSaveTemplate == false

                ((e.fromSaveTemplate && e.fromReview) || !e.fromSaveTemplate)) {
              final res = await _mainFacade.updatePostApi(
                postShiftDetail: postObj,
              );
              res.fold(
                (l) {
                  failureOrSuccess = left(l);
                },
                (r) {
                  final data = HealthcarePostDTO.fromJson(r.data);
                  failureOrSuccess = right(data);
                },
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
          print("initMultiDifferentDateEvent->${e.list}");
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
              fromSaveTemplate: e.fromSaveTemplate ?? false,
              multiDateTimeList: updatedList,
              updateShift: e.updateShift ?? HealthcarePostDTO(),
              singleShiftFailureOrSuccessOption: none(),
            ),
          );
          await getUnpaidBreakListApi(emit);
          final isAllExist = areAllDatesPresent(
              updatedList, e.updateShift?.shift_detail?.detail ?? []);

          if (e.updateShift != null &&
              e.fromSaveTemplate != true &&
              e.fromReview != true) {
            List<DateTimeDTO>? uniqueDetails;
            if (e.fromSaveTemplate ?? false) {
              final detailList = e.updateShift?.shift_detail?.detail ?? [];
              //     );
              print("llll>${detailList}");
              // detailList.removeWhere((element) => updatedList.any((e) => element.datee.date));
              final parsedDetailList = getDifferentMultiDate(detailList);

              final updatedDates = parsedDetailList
                  .map((e) => DateTime.parse(e.date ?? ""))
                  .toList();

              uniqueDetails = updatedList.where((o) {
                final parsedDate = DateTime.tryParse(o.date ?? "");
                return parsedDate != null && !updatedDates.contains(parsedDate);
              }).toList();
            }

            setShiftDataToUpdate(
              emit: emit,
              updatedShift: e.updateShift!,
              dateTime: uniqueDetails,
              isFromReview: e.fromReview,
              isFromSaveTemplate: e.fromSaveTemplate,
            );
            // await Future.delayed(Duration(seconds: 2));
          } else if (e.updateShift != null &&
              e.fromSaveTemplate == true &&
              e.fromReview == false &&
              isAllExist) {
            List<DateTimeDTO>? uniqueDetails;
            if (e.fromSaveTemplate ?? false) {
              final detailList = e.updateShift?.shift_detail?.detail ?? [];
              //     );
              print("llll11111>${detailList}");
              // detailList.removeWhere((element) => updatedList.any((e) => element.datee.date));
              final parsedDetailList = getDifferentMultiDate(detailList);

              final updatedDates = parsedDetailList
                  .map((e) => DateTime.parse(e.date ?? ""))
                  .toList();

              uniqueDetails = updatedList.where((o) {
                final parsedDate = DateTime.tryParse(o.date ?? "");
                return parsedDate != null && !updatedDates.contains(parsedDate);
              }).toList();
            }

            setShiftDataToUpdate(
              emit: emit,
              updatedShift: e.updateShift!,
              dateTime: uniqueDetails,
              isFromReview: e.fromReview,
              isFromSaveTemplate: e.fromSaveTemplate,
            );
            // await Future.delayed(Duration(seconds: 2));
          } else if (e.updateShift != null &&
              e.fromSaveTemplate == true &&
              e.fromReview == false &&
              !isAllExist) {
            ShiftDetailDTO? r = e.updateShift!.shift_detail;
            if (r != null) {
              Log.success("updatedList =>11111 ${isAllExist}");

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
                      ? getAccomdationHourName(
                          r.commute_allowance_type_details ?? 0.0)
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
                  accomdationHour: InputEmptyOrNot(
                      (r.accommodation_allowance_type == 2)
                          ? getAccomdationHourName(
                              r.accommodation_allowance_type_details ?? 0.0)
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
                  startHour: InputEmptyOrNot(CustomDateTimeFormat.getHour(
                      timestamp: r.start_time ?? 0)),
                  startMinute: InputEmptyOrNot(CustomDateTimeFormat.getMinute(
                      timestamp: r.start_time ?? 0)),
                  endHour: InputEmptyOrNot(
                      CustomDateTimeFormat.getHour(timestamp: r.end_time ?? 0)),
                  endMinute: InputEmptyOrNot(CustomDateTimeFormat.getMinute(
                      timestamp: r.end_time ?? 0)),
                  signleShiftDate: InputEmptyOrNot((r.date != null)
                      ? DateTime.fromMillisecondsSinceEpoch(r.date! * 1000)
                          .toString()
                      : ""),

                  /// Different time for each date
                  selectedMultiShiftType: r.same_or_different_time ?? -1,
                  // multiDateTimeList: (r.shift_type == 2 && r.same_or_different_time == 2)
                  //     ? [
                  //         ...getDifferentMultiDate(r.detail ?? []),
                  //         if (dateTime != null) ...dateTime,
                  //       ]
                  //     : [],

                  /// Set for recurring Screening data
                  isToBeRecurring: (r.recurring_status == 1) ? true : false,
                  isShareWithTeams: (r.share_team_status == 1) ? true : false,
                  isSaveAsTemplate:
                      (r.save_template_status == 1) ? true : false,
                  disclaimerNote: r.disclaimer ?? "",
                  selectedTeamList: setTeamList(r.teams ?? []),
                  recurringStartDate: InputEmptyOrNot(
                      (r.recurring_start_date != null)
                          ? DateTime.fromMillisecondsSinceEpoch(
                                  r.recurring_start_date! * 1000)
                              .toString()
                          : ""),
                  recurringEndDate: InputEmptyOrNot(
                      (r.recurring_end_date != null)
                          ? DateTime.fromMillisecondsSinceEpoch(
                                  r.recurring_end_date! * 1000)
                              .toString()
                          : ""),
                  recurrenceMode: InputEmptyOrNot(
                      (r.recurrence_mode == '2') ? 'Weekly' : 'Daily'),
                  isRangeMoreThanWeek: setRecurringRange(
                      endDate: r.recurring_end_date,
                      startDate: r.recurring_start_date),
                  recurrenceWeekList: setWeekList(r.days ?? ""),
                  scriptVolume:
                      InputEmptyOrNot(getScriptVolume(r.script_volume) ?? ""),
                  isAssistantOnSite: (r.assistant_on_site == 1) ? true : false,
                  isTechnicianOnSite:
                      (r.technician_on_site == 1) ? true : false,
                ),
              );
            }
          } else if (e.updateShift != null &&
              e.fromSaveTemplate == false &&
              e.fromReview == true &&
              isAllExist) {
            List<DateTimeDTO>? uniqueDetails;
            if (e.fromSaveTemplate ?? false) {
              final detailList = e.updateShift?.shift_detail?.detail ?? [];
              //     );
              print("llll11111>${detailList}");
              // detailList.removeWhere((element) => updatedList.any((e) => element.datee.date));
              final parsedDetailList = getDifferentMultiDate(detailList);

              final updatedDates = parsedDetailList
                  .map((e) => DateTime.parse(e.date ?? ""))
                  .toList();

              uniqueDetails = updatedList.where((o) {
                final parsedDate = DateTime.tryParse(o.date ?? "");
                return parsedDate != null && !updatedDates.contains(parsedDate);
              }).toList();
            }

            setShiftDataToUpdate(
              emit: emit,
              updatedShift: e.updateShift!,
              dateTime: uniqueDetails,
              isFromReview: e.fromReview,
              isFromSaveTemplate: e.fromSaveTemplate,
            );
            // await Future.delayed(Duration(seconds: 2));
          } else if (e.updateShift != null &&
              e.fromSaveTemplate == false &&
              e.fromReview == true &&
              !isAllExist) {
            ShiftDetailDTO? r = e.updateShift!.shift_detail;
            if (r != null) {
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
                      ? getAccomdationHourName(
                          r.commute_allowance_type_details ?? 0.0)
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
                  accomdationHour: InputEmptyOrNot(
                      (r.accommodation_allowance_type == 2)
                          ? getAccomdationHourName(
                              r.accommodation_allowance_type_details ?? 0.0)
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
                  startHour: InputEmptyOrNot(CustomDateTimeFormat.getHour(
                      timestamp: r.start_time ?? 0)),
                  startMinute: InputEmptyOrNot(CustomDateTimeFormat.getMinute(
                      timestamp: r.start_time ?? 0)),
                  endHour: InputEmptyOrNot(
                      CustomDateTimeFormat.getHour(timestamp: r.end_time ?? 0)),
                  endMinute: InputEmptyOrNot(CustomDateTimeFormat.getMinute(
                      timestamp: r.end_time ?? 0)),
                  signleShiftDate: InputEmptyOrNot((r.date != null)
                      ? DateTime.fromMillisecondsSinceEpoch(r.date! * 1000)
                          .toString()
                      : ""),

                  /// Different time for each date
                  selectedMultiShiftType: r.same_or_different_time ?? -1,
                  // multiDateTimeList: (r.shift_type == 2 && r.same_or_different_time == 2)
                  //     ? [
                  //         ...getDifferentMultiDate(r.detail ?? []),
                  //         if (dateTime != null) ...dateTime,
                  //       ]
                  //     : [],

                  /// Set for recurring Screening data
                  isToBeRecurring: (r.recurring_status == 1) ? true : false,
                  isShareWithTeams: (r.share_team_status == 1) ? true : false,
                  isSaveAsTemplate:
                      (r.save_template_status == 1) ? true : false,
                  disclaimerNote: r.disclaimer ?? "",
                  selectedTeamList: setTeamList(r.teams ?? []),
                  recurringStartDate: InputEmptyOrNot(
                      (r.recurring_start_date != null)
                          ? DateTime.fromMillisecondsSinceEpoch(
                                  r.recurring_start_date! * 1000)
                              .toString()
                          : ""),
                  recurringEndDate: InputEmptyOrNot(
                      (r.recurring_end_date != null)
                          ? DateTime.fromMillisecondsSinceEpoch(
                                  r.recurring_end_date! * 1000)
                              .toString()
                          : ""),
                  recurrenceMode: InputEmptyOrNot(
                      (r.recurrence_mode == '2') ? 'Weekly' : 'Daily'),
                  isRangeMoreThanWeek: setRecurringRange(
                      endDate: r.recurring_end_date,
                      startDate: r.recurring_start_date),
                  recurrenceWeekList: setWeekList(r.days ?? ""),
                  scriptVolume:
                      InputEmptyOrNot(getScriptVolume(r.script_volume) ?? ""),
                  isAssistantOnSite: (r.assistant_on_site == 1) ? true : false,
                  isTechnicianOnSite:
                      (r.technician_on_site == 1) ? true : false,
                ),
              );
            }
          } else if (e.updateShift != null &&
              e.fromSaveTemplate == true &&
              e.fromReview == true &&
              isAllExist) {
            List<DateTimeDTO>? uniqueDetails;
            if (e.fromSaveTemplate ?? false) {
              final detailList = e.updateShift?.shift_detail?.detail ?? [];
              //     );
              // detailList.removeWhere((element) => updatedList.any((e) => element.datee.date));
              final parsedDetailList = getDifferentMultiDate(detailList);

              final updatedDates = parsedDetailList
                  .map((e) => DateTime.parse(e.date ?? ""))
                  .toList();

              uniqueDetails = updatedList.where((o) {
                final parsedDate = DateTime.tryParse(o.date ?? "");
                return parsedDate != null && !updatedDates.contains(parsedDate);
              }).toList();
            }

            setShiftDataToUpdate(
              emit: emit,
              updatedShift: e.updateShift!,
              dateTime: uniqueDetails,
              isFromReview: e.fromReview,
              isFromSaveTemplate: e.fromSaveTemplate,
            );
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

          final isScriptVolumeValid = state.scriptVolume.isValid();
          if (isMultiDateValid &&
              isCommuteAllownceValid &&
              isAccomdationAllownceValid &&
              isVacancyValid &&
              (getCurrentIndustry() != 2 ||
                  (getCurrentIndustry() == 2 && isScriptVolumeValid))) {
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
            final isLessThanTwoHours = state.multiDateTimeList.any((dto) {
              final totalPayableDuration =
                  CustomDateTimeFormat.parseTotalPayableHours(
                      dto.totalPaybleHours!);
              return totalPayableDuration < Duration(hours: 2);
            });

            /*failureOrSuccess = await _mainFacade.createPostShiftApi(
                shift: passShiftData(
              state,
              shiftDetail: e.shiftDetail,
            ));*/

            if (isLessThanTwoHours) {
              showError(
                      message:
                          StringConstant.theTotalPayableHourMustBeAtLeastTwo)
                  .show(e.context);
            } else {
              final post = continueWithPostDetail(
                state,
                passShiftData(state, shiftDetail: e.shiftDetail),
                e.fromSaveTemplate,
                fromReview: e.fromReview,
              );
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
                  fromSaveTemplate: e.fromSaveTemplate,
                  fromReview: e.fromReview,
                  isCreate: e.isCreate,
                ),
              ));
            }
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
          // final isBeforeEndTime =
          //     timeIsPast(state, state.endHour, state.endMinute, shiftType: 1);
          final isMoreThanTwoHours =
              CustomDateTimeFormat.parseTotalPayableHours(
                  state.totalPaybleHours);

          if (isMultiDateValid &&
                  isCommuteAllownceValid &&
                  isAccomdationAllownceValid &&
                  isStartHourValid &&
                  isStartMinuteValid &&
                  isEndHourValid &&
                  isEndMinuteValid &&
                  isUnpaidBreakValid &&
                  isVacancyValid &&
                  !isBeforeStartTime
              //  &&!isBeforeEndTime
              ) {
            if (isMoreThanTwoHours < Duration(hours: 2)) {
              showError(
                      message:
                          StringConstant.theTotalPayableHourMustBeAtLeastTwo)
                  .show(e.context);
            } else {
              print("All details are valid!");
              /*failureOrSuccess = await _mainFacade.createPostShiftApi(
                shift: passShiftData(state));*/

              final post = continueWithPostDetail(
                state,
                passShiftData(state),
                e.fromSaveTemplate,
                fromReview: e.fromReview,
              );

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
                  fromSaveTemplate: e.fromSaveTemplate,
                  fromReview: e.fromReview,
                  isCreate: e.isCreate,
                ),
              ));
            }
          } else {
            showError(
                    message: StringConstant
                        .someDetailsAreMissingOrInvalidPleaseCheck)
                .show(e.context);
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
              updatePostFailureOrSuccessOption: none(),
              postShiftFailureOrSuccessOption: none(),
            ),
          );
          print("All details are valid! ");
          if (e.updatedPost != null && !e.fromSaveTemp) {
            Either<MainFailure, CommonResponse>? updateFailureOrSuccess;
            PostShiftDTO postObj = e.updatedPost!.copyWith(
              update_status: 1,
            );
            print("=====postObj.id>${jsonEncode(postObj)}");
            updateFailureOrSuccess = await _mainFacade.updatePostApi(
              postShiftDetail: postObj,
            );

            emit(
              state.copyWith(
                isLoading: false,
                singleShiftErrorMessages: true,
                postShiftFailureOrSuccessOption: none(),
                // recurringFailureOrSuccessOption:
                //     optionOf(updateFailureOrSuccess),
                updatePostFailureOrSuccessOption:
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
                updatePostFailureOrSuccessOption: none(),
                postShiftFailureOrSuccessOption: optionOf(failureOrSuccess),
              ),
            );
          }
        },
      );
    });
  }

  setShiftDataToUpdate({
    required Emitter<PostShiftState> emit,
    required HealthcarePostDTO updatedShift,
    bool? isFromSaveTemplate,
    bool? isFromReview,
    List<DateTimeDTO>? dateTime,
  }
      // Emitter<PostShiftState> emit, HealthcarePostDTO updatedShift,{ bool? isFromSaveTemplate},
      // [List<DateTimeDTO>? dateTime,]

      ) async {
    final r = updatedShift.shift_detail;

    if (r != null) {
      emit(
        state.copyWith(
          isLoading: true,
          shiftType: r.shift_type ?? 1,
          selectedMultiShiftType: r.same_or_different_time ?? -1,
          unpaidBreak: InputEmptyOrNot(r.unpaid_break?.name ?? ""),
          // totalPaybleHours: r.total_payable_hour ?? "",
          /// When edit from review screen and shift is Multi same time shift
          totalPaybleHours: (r.shift_type == 2 && r.same_or_different_time == 1)
              ? divideHours(
                  totalPayableHours: r.total_payable_hour,
                  totalShifts: r.detail?.length)
              : r.total_payable_hour ?? "",
          selectedCommuteAllownce:
              InputEmptyOrNot((r.commute_allowance_type == 1)
                  ? "Flat Rate"
                  : (r.commute_allowance_type == 2)
                      ? "Hours"
                      : "None"),
          commuteHour: InputEmptyOrNot((r.commute_allowance_type == 2)
              ? getAccomdationHourName(r.commute_allowance_type_details ?? 0.0)
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
                  r.accommodation_allowance_type_details ?? 0.0)
              : ""),
          accomdationRate: Rate((r.accommodation_allowance_type == 1)
              ? "${r.accommodation_allowance_type_details ?? 0}"
              : ""),
          singleShiftNote: r.shift_note ?? "",
          isMoreVacancy: (r.vacancie_type == 1) ? true : false,
          selectedVacancy: Vacancy("${r.number_of_vacancie ?? 0}"),

          /// Set for Same time for all date data
          isIndividualPost: (r.individual_shift == 1) ? true : false,
          selectedMultiDates: (r.shift_type == 1 ||
                  (isFromSaveTemplate == true && isFromReview == false))
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

          multiDateTimeList:
              (isFromSaveTemplate == true && isFromReview == false)
                  ? []
                  : (r.shift_type == 2 && r.same_or_different_time == 2)
                      ? [
                          ...getDifferentMultiDate(r.detail ?? []),
                          if (dateTime != null) ...dateTime,
                        ]
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
          scriptVolume: InputEmptyOrNot(getScriptVolume(r.script_volume) ?? ""),
          isAssistantOnSite: (r.assistant_on_site == 1) ? true : false,
          isTechnicianOnSite: (r.technician_on_site == 1) ? true : false,
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

  String? getScriptVolume(int? id) {
    final volumeId = state.scriptVolumeList.firstWhere((volume) {
      return volume.id == id;
    }, orElse: () => SkillDTO());
    print("Script Volume ID --> $volumeId");
    return volumeId.name;
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
      PostShiftState state, MultiShiftDTO shift, bool fromSaveTemplate,
      {bool fromReview = false}) {
    String mapMultiDateToApiFormat() {
      if (shift.multi_date != null && shift.multi_date!.isNotEmpty) {
        final list = shift.multi_date!.map((multiDate) {
          final formattedDate = (shift.same_or_different_time == 1)
              ? CustomDateTimeFormat.mergeDateAndTime(
                  shift.start_time ?? "",
                  shift.end_time ?? "",
                  dateTime: DateTime.parse(multiDate.date ?? ""),
                )
              : CustomDateTimeFormat.mergeDateAndTime(
                  multiDate.start_time ?? "",
                  multiDate.end_time ?? "",
                  dateTime: DateTime.parse(multiDate.date ?? ""),
                );

          final map = {
            /*    if (state.updateShift.id == null ||
                fromSaveTemplate == true ||
                fromReview == true) ...{ */
            'date': formattedDate.toUtc().millisecondsSinceEpoch / 1000,
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
            'payable_hour': (shift.same_or_different_time == 1)
                ? state.totalPaybleHours
                : multiDate.totalPaybleHours,
            'unpaid_break_id':
                getSelectedUnPaidBreakId(breakTime: multiDate.unpaidBreak),
            /*   } else ...{
              'id': multiDate.id,
              'unpaid_break_id':
                  getSelectedUnPaidBreakId(breakTime: multiDate.unpaidBreak),
            } */
          };
          return map;
        }).toList();
        return jsonEncode(list);
      } else {
        return "";
      }
    }

    // print("Formatttedddtdt datetetete--> ${shift.shift_type}");
    print("ShiftTypeOnChange---->12121 ${state.shiftType}");

    PostShiftDTO mapData = state.post.copyWith(
      shift_type: shift.shift_type,
      unpaid_break_id: shift.unpaid_break_id,
      total_payable_hour:
          (shift.shift_type == 2 && shift.same_or_different_time == 1)
              ? multiplyHours(
                  totalHours: shift.total_payable_hour,
                  totalShifts: shift.multi_date?.length)
              : shift.total_payable_hour,
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
      script_volume: shift.script_volume,
      assistant_on_site: shift.assistant_on_site,
      technician_on_site: shift.technician_on_site,
    );
    return mapData;
  }

  String multiplyHours(
      {required String? totalHours, required int? totalShifts}) {
    // Parse the time string into hours and minutes

    if (totalHours != null && totalShifts != null) {
      final regex = RegExp(r'(\d+)h (\d+)min');
      final match = regex.firstMatch(totalHours);

      if (match != null) {
        final hours = int.parse(match.group(1)!);
        final minutes = int.parse(match.group(2)!);

        // Convert to Duration
        final totalDuration = Duration(hours: hours, minutes: minutes);

        // Multiply by the total number of shifts
        final multipliedDuration = totalDuration * totalShifts;

        // Format back to "hh mm" format
        final totalHours = multipliedDuration.inHours;
        final totalMinutes = multipliedDuration.inMinutes % 60;

        final formattedHours = totalHours.toString().padLeft(2, '0');
        final formattedMinutes = totalMinutes.toString().padLeft(2, '0');

        return "${formattedHours}h ${formattedMinutes}min";
      } else {
        throw FormatException("Invalid time format: $totalHours");
      }
    }
    return "";
  }

  String divideHours(
      {required String? totalPayableHours, required int? totalShifts}) {
    // Parse the time string into hours and minutes

    if (totalPayableHours != null && totalShifts != null) {
      final regex = RegExp(r'(\d+)h (\d+)min');
      final match = regex.firstMatch(totalPayableHours);

      if (match != null) {
        final hours = int.parse(match.group(1)!);
        final minutes = int.parse(match.group(2)!);

        // Convert to Duration
        /*  final totalDuration = Duration(hours: hours, minutes: minutes);

        // Multiply by the total number of shifts
        final multipliedDuration = totalDuration * totalShifts; */
        // Convert to total minutes
        final totalMinutes = (hours * 60) + minutes;

        // Divide by totalShifts
        final dividedMinutes = totalMinutes ~/ totalShifts;

        // Format back to "hh mm" format
        final totalHours = (dividedMinutes ~/ 60).toString().padLeft(2, '0');
        final totalRemainingMinutes =
            (dividedMinutes % 60).toString().padLeft(2, '0');

        /*  final formattedHours = totalHours.toString().padLeft(2, '0');
        final formattedMinutes =
            totalRemainingMinutes.toString().padLeft(2, '0'); */

        return "${totalHours}h ${totalRemainingMinutes}min";
      } else {
        throw FormatException("Invalid time format: $totalPayableHours");
      }
    }
    return "";
  }

  bool areAllDatesPresent(
      List<DateTimeDTO> list1, List<ShiftDateDetailDTO> list2) {
    // Helper function to convert ISO 8601 date string to Unix timestamp
    int dateStringToTimestamp(String dateString) {
      final format = DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS");
      DateTime dateTime = format.parse(dateString);
      return dateTime.millisecondsSinceEpoch ~/
          1000; // Convert milliseconds to seconds
    }

    // Convert List1 dates to timestamps
    List<int> list1Timestamps = list1.map((item) {
      String dateString = item.date ?? "";
      return dateStringToTimestamp(dateString);
    }).toList();

    // Extract the timestamps from List2
    List<int> list2Timestamps = list2.map((item) {
      return item.date as int;
    }).toList();

    // Check if all timestamps in List1 are in List2
    final isInList1 = list2Timestamps
        .every((timestamp) => list1Timestamps.contains(timestamp));
    final isInList2 = list1Timestamps
        .every((timestamp) => list2Timestamps.contains(timestamp));
    Log.success("isInList1 => ${list1}");
    Log.success("isInList1 =>11111 ${isInList2}");

    return (isInList1 && isInList2);
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
        return emit(state.copyWith(
          accomdationHoursList: r,
        ));
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
    print("List from dateTime ${state.multiDateTimeList}");

    final list = List<DateTimeDTO>.from(state.multiDateTimeList);
    print("list from dateTime1111 ${list}");

    // Check if the item with the given date exists
    final existingIndex = list.indexWhere((item) {
      print("date---->itemm ${item.date}");
      print("date----> ${date}");
      return item.date == date;
    });

    print("existingIndex---> ${existingIndex}");

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
          updatedDTO.startHour!, updatedDTO.startMinute!,
          dateTime: (updatedDTO.date != null && updatedDTO.date!.isNotEmpty)
              ? DateTime.parse(updatedDTO.date!)
              : null);
      updatedDTO = updatedDTO.copyWith(start_time: startTime.toString());
    }

    // Update end_time if endHour and endMinute are set
    if (updatedDTO.endHour != null && updatedDTO.endMinute != null) {
      final endTime = CustomDateTimeFormat.parseTime(
          updatedDTO.endHour!, updatedDTO.endMinute!,
          dateTime: (updatedDTO.date != null && updatedDTO.date!.isNotEmpty)
              ? DateTime.parse(updatedDTO.date!)
              : null);
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

  int getSelectedScriptVolumeId({String? scriptVolume}) {
    final volumeId = state.scriptVolumeList.firstWhere((volume) {
      if (scriptVolume != null) {
        return volume.name == scriptVolume;
      } else {
        return volume.name == state.scriptVolume.getValue();
      }
    }, orElse: () => SkillDTO());
    print("Script Volume ID --> $volumeId");
    return volumeId.id ?? -1;
  }

  String getAccomdationHourId(String selectedHour) {
    final hourId = state.accomdationHoursList.firstWhere(
        (hour) => hour.name == selectedHour,
        orElse: () => SkillDTO());
    print("Hour ID --> $hourId");
    return "${hourId.id ?? -1}";
  }

  String getAccomdationHourName(double id) {
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

    if (state.shiftType == 1) {
      startTime = CustomDateTimeFormat.parseTime(
        state.startHour.getValue() ?? "",
        state.startMinute.getValue() ?? "",
        dateTime: (state.signleShiftDate.isValid())
            ? DateTime.parse(state.signleShiftDate.getValue()!)
            : null,
      ).toString();
      endTime = CustomDateTimeFormat.parseTime(
        state.endHour.getValue() ?? "",
        state.endMinute.getValue() ?? "",
        dateTime: (state.signleShiftDate.isValid())
            ? DateTime.parse(state.signleShiftDate.getValue()!)
            : null,
      ).toString();
    } else if (state.shiftType == 2 && state.selectedMultiShiftType == 1) {
      startTime = CustomDateTimeFormat.parseTime(
        state.startHour.getValue() ?? "",
        state.startMinute.getValue() ?? "",
        dateTime: (state.selectedMultiDates.isValid())
            ? state.selectedMultiDates.getValue()[0]
            : null,
      ).toString();
      endTime = CustomDateTimeFormat.parseTime(
        state.endHour.getValue() ?? "",
        state.endMinute.getValue() ?? "",
        dateTime: (state.selectedMultiDates.isValid())
            ? state.selectedMultiDates.getValue()[0]
            : null,
      ).toString();
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
      print("ShiftTypeOnChange----> ${state.shiftType}");
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
        // date: state.signleShiftDate.getValue(),
        date: CustomDateTimeFormat.parseTime(
          state.startHour.getValue() ?? "",
          state.startMinute.getValue() ?? "",
          dateTime: (state.signleShiftDate.getValue() != null &&
                  state.signleShiftDate.getValue()!.isNotEmpty)
              ? DateTime.parse(state.signleShiftDate.getValue()!)
              : null,
        ).toString(),
        start_time: startTime,
        end_time: endTime,
        unpaid_break_id: getSelectedUnPaidBreakId(),
        total_payable_hour: state.totalPaybleHours,
        script_volume: getSelectedScriptVolumeId(),
        assistant_on_site: (state.isAssistantOnSite) ? 1 : 0,
        technician_on_site: (state.isTechnicianOnSite) ? 1 : 0,
      );
    }
  }

  List<DateTimeDTO> mapMultiDateToApiFormat(PostShiftState state) {
    return state.selectedMultiDates.getValue().map((multiDate) {
      final sameMultiDate = DateTimeDTO(
        // date: multiDate.toString(),
        date: CustomDateTimeFormat.parseTime(
          state.startHour.getValue() ?? "",
          state.startMinute.getValue() ?? "",
          dateTime: multiDate,
        ).toString(),
      );

      print("SameMultiDate----> ${sameMultiDate}");
      return sameMultiDate;
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
              ? DateTime.fromMillisecondsSinceEpoch(timestamp * 1000)
                  .toIso8601String()
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

  @override
  void onEvent(PostShiftEvent event) {
    super.onEvent(event);
    print("====Cureent Event ${event}");
  }
}
