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
import 'package:shift/infrastructure/main/team_dto/team_dto.dart';
import 'package:shift/presentation/common/utils/date_time_format.dart';
import 'package:shift/presentation/core/app_router.gr.dart';
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
              post: (e.post != null) ? e.post! : state.post,
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
              postId: e.postId,
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
              isVacancyValid) {
            print("All details are valid!");
            /*failureOrSuccess = await _mainFacade.createPostShiftApi(
                shift: passShiftData(state));*/

            PostShiftDTO post = state.post.copyWith(
              shiftDetail: passShiftData(state),
            );

            e.context.router.push(PageRouteInfo(
              PostShiftRecurring.name,
              args: PostShiftRecurringArgs(
                shiftType: state.shiftType,
                healthcarePost: HealthcarePostDTO(),
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
          emit(
            state.copyWith(
              recurringEndDate: InputEmptyOrNot(e.selectedDate),
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
              isLoading: true,
              recurringFailureOrSuccessOption: none(),
            ),
          );
          await getTeamsListApi(emit);
        },
        recurringButtonEvent: (e) async {
          Either<MainFailure, HealthcarePostDTO>? failureOrSuccess;
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

            final postObj = state.post.copyWith(
              post_shift_id: e.postShiftId,
              recurring_status: (state.isToBeRecurring) ? 1 : 0,
              start_date: state.recurringStartDate.getValue() ?? "",
              recurrence_mode:
                  (state.recurrenceMode.getValue() == "Weekly") ? 2 : 1,
              days: getSelectedRecurringDayIds(
                  state.recurrenceWeekList.getValue()),
              end_date: state.recurringEndDate.getValue() ?? "",
              disclaimer: state.disclaimerNote,
              share_team_status: (state.isShareWithTeams) ? 1 : 0,
              team_id:
                  getSelectedRecurringDayIds(state.selectedTeamList.getValue()),
              save_template_status: (state.isSaveAsTemplate) ? 1 : 0,
            );
            print("All details are valid!--->  ${jsonEncode(postObj)}");
          } else {
            print("Some details are invalid!");
          }

          emit(
            state.copyWith(
              recurringErrorMessage: true,
              recurringFailureOrSuccessOption: optionOf(failureOrSuccess),
            ),
          );
        },

        /// Multi Shift
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

          final isUnPaidBreakValid = state.unpaidBreak.isValid();
          final isAllDatesValid = state.multiDateTimeList.every((dto) =>
              dto.totalPaybleHours != null && dto.totalPaybleHours!.isNotEmpty);
          if (isAllDatesValid && isUnPaidBreakValid) {
            /*failureOrSuccess = await _mainFacade.createPostShiftApi(
                shift: passShiftData(
              state,
              shiftDetail: e.shiftDetail,
            ));*/
            PostShiftDTO post = state.post.copyWith(
              shiftDetail: passShiftData(state, shiftDetail: e.shiftDetail),
            );

            print("Post from push222:--> ${jsonEncode(post)}");

            e.context.router.push(PageRouteInfo(
              PostShiftRecurring.name,
              args: PostShiftRecurringArgs(
                shiftType: state.shiftType,
                healthcarePost: HealthcarePostDTO(),
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

          if (isMultiDateValid &&
              isCommuteAllownceValid &&
              isAccomdationAllownceValid &&
              isStartHourValid &&
              isStartMinuteValid &&
              isEndHourValid &&
              isEndMinuteValid &&
              isUnpaidBreakValid &&
              isVacancyValid) {
            print("All details are valid!");
            /*failureOrSuccess = await _mainFacade.createPostShiftApi(
                shift: passShiftData(state));*/

            PostShiftDTO post = state.post.copyWith(
              shiftDetail: passShiftData(state),
            );
            print("Post from push111:--> ${jsonEncode(post)}");

            e.context.router.push(PageRouteInfo(
              PostShiftRecurring.name,
              args: PostShiftRecurringArgs(
                shiftType: state.shiftType,
                healthcarePost: HealthcarePostDTO(),
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
          Either<MainFailure, String>? failureOrSuccess;
          emit(
            state.copyWith(
              isLoading: true,
              postShiftFailureOrSuccessOption: none(),
            ),
          );
          print("All details are valid! ");
          failureOrSuccess = await _mainFacade.postShiftApi(postId: e.postId);
          emit(
            state.copyWith(
              isLoading: false,
              singleShiftErrorMessages: true,
              postShiftFailureOrSuccessOption: optionOf(failureOrSuccess),
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

  getTeamsListApi(Emitter<PostShiftState> emit) async {
    final teamList = await _mainFacade.getTeamsList();
    print("Team List ---> $teamList");
    teamList.fold(
      (l) => emit(
        state.copyWith(
          isLoading: false,
          teamList: [],
        ),
      ),
      (r) {
        return emit(
          state.copyWith(
            isLoading: false,
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
      var timeDiffBetweenEndStartTime = DateTime.parse(updatedDTO.end_time!)
          .difference(DateTime.parse(updatedDTO.start_time!));
      print("total hours---> ${timeDiffBetweenEndStartTime}");
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

  /// Addition of total_payable_hours
  String allTimesFilled(List<DateTimeDTO> multiDateTimeList) {
    bool areAllTimesFilled = multiDateTimeList.every((dto) =>
        dto.totalPaybleHours != null && dto.totalPaybleHours!.isNotEmpty);
    final unpaidBreak =
        CustomDateTimeFormat.extractUnpaidBreak(state.unpaidBreak.getValue()!);
    if (areAllTimesFilled) {
      // Substract unpaid break list
      List<DateTimeDTO> updatedList = multiDateTimeList.map((dto) {
        if (isTimeFilled(dto)) {
          var timeDiffBetweenEndStartTime = DateTime.parse(dto.end_time!)
              .difference(DateTime.parse(dto.start_time!));

          final timeDifference =
              timeDiffBetweenEndStartTime - Duration(minutes: unpaidBreak);
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

  int getSelectedUnPaidBreakId() {
    final breakId = state.breakList.firstWhere(
        (unpaidBreak) => unpaidBreak.name == state.unpaidBreak.getValue(),
        orElse: () => SkillDTO());
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
            ? int.parse(state.selectedVacancy.getValue() ?? "0")
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

  String getSelectedRecurringDayIds(List<dynamic> list) {
    final dayIds = list
        .map((day) => day.id) // Extract IDs
        .toList();
    String commaSeparated = dayIds.join(',');
    print('Get IDs from list: $commaSeparated');

    return commaSeparated;
  }
}
