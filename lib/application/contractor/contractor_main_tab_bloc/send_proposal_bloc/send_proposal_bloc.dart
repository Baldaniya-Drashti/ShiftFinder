import 'dart:convert';

import 'package:auto_route/auto_route.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:shift/domain/auth/auth_value_objects.dart';
import 'package:shift/domain/core/string_constant.dart';
import 'package:shift/domain/main/i_main_facade.dart';
import 'package:shift/domain/main/main_failure.dart';
import 'package:shift/infrastructure/core/skill_list_model/skill_dto.dart';
import 'package:shift/infrastructure/main/date_time_dto/date_time_dto.dart';
import 'package:shift/infrastructure/main/healthcare_post/healthcare_post_dto.dart';
import 'package:shift/infrastructure/main/shift_date_detail_dto/shift_date_detail_dto.dart';
import 'package:shift/infrastructure/main/shift_detail_dto/shift_detail_dto.dart';
import 'package:shift/presentation/common/utils/date_time_format.dart';
import 'package:shift/presentation/common/utils/flushbar_creator.dart';

part 'send_proposal_event.dart';

part 'send_proposal_state.dart';

part 'send_proposal_bloc.freezed.dart';

@injectable
class SendProposalBloc extends Bloc<SendProposalEvent, SendProposalState> {
  final IMainFacade _mainFacade;

  static bool isAllownceValid(
      {required int selectedValue,
      required InputEmptyOrNot hourValue,
      required Rate rateValue}) {
    final parsedRate = double.tryParse(rateValue.getValue());
    final rateValid = parsedRate != null && parsedRate > 0;

    if (selectedValue == 1 && rateValue.isValid() && rateValid) {
      return true;
    } else if (selectedValue == 2 && hourValue.isValid()) {
      return true;
    } else if (selectedValue == 0) {
      return true;
    } else if (selectedValue == 1 && rateValue.isValid()) {
      return true;
    }
    return false;
  }

  static bool timeIsPast(SendProposalState state, InputEmptyOrNot selectedHour,
      InputEmptyOrNot selectedMin,
      {int shiftType = 0}) {
    DateTime currentDate = DateTime.now();
    DateTime selectedDate = (state.shift.shift_detail?.detail?[0].date != null)
        ? CustomDateTimeFormat.timeStampToDateTime(
            state.shift.shift_detail?.detail?[0].date ?? -1)
        : DateTime.now();

    print(
        "selected Date Time ---> ${state.shift.shift_detail?.detail?[0].date}");
    bool isSameDate = (shiftType == 1)
        ? isCurrentDateInList(state.multiDates)
        : (selectedDate.year == currentDate.year &&
            selectedDate.month == currentDate.month &&
            selectedDate.day == currentDate.day);

    print("isSameDateee---> $isSameDate");

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

  static bool isCurrentDateInList(List<DateTimeDTO> selectedMultiDates) {
    DateTime today = DateTime.now();

    final bool isBeforeTime = selectedMultiDates.any((dto) {
      if (dto.date == null) return false;
      final selectedDate = DateTime.parse(dto.date ?? "");
      print("selected Date Time same ---> ${dto.date}");
      print("selected Date Time same --->111  $selectedDate");
      return (selectedDate.year == today.year &&
          selectedDate.month == today.month &&
          selectedDate.day == today.day);
    });
    return isBeforeTime;
  }

  SendProposalBloc(this._mainFacade) : super(SendProposalState.initial()) {
    on<SendProposalEvent>(
      (event, emit) async {
        await event.map(
          accomdationHourChanged: (e) {
            emit(state.copyWith(
              accomdationHour: InputEmptyOrNot(e.rate),
              failureOrSuccessOption: none(),
            ));
          },
          accomdationRateChanged: (e) {
            emit(state.copyWith(
              accomdationRate: Rate(e.hour),
              failureOrSuccessOption: none(),
            ));
          },
          commuteHourChanged: (e) {
            emit(state.copyWith(
              commuteHour: InputEmptyOrNot(e.hour),
              failureOrSuccessOption: none(),
            ));
          },
          commuteRateChanged: (e) {
            emit(state.copyWith(
              commuteRate: Rate(e.rate),
              failureOrSuccessOption: none(),
            ));
          },
          rateHourChanged: (e) {
            emit(state.copyWith(
              rateHour: Rate(e.rate),
              failureOrSuccessOption: none(),
            ));
          },
          startHourChanged: (e) {
            emit(state.copyWith(
              startHour: InputEmptyOrNot(e.hour),
              failureOrSuccessOption: none(),
            ));
            add(SendProposalEvent.totalPayableHoursChanged());
          },
          startMinuteChanged: (e) {
            emit(state.copyWith(
              startMinute: InputEmptyOrNot(e.minute),
              failureOrSuccessOption: none(),
            ));
            add(SendProposalEvent.totalPayableHoursChanged());
          },
          endHourChanged: (e) {
            emit(state.copyWith(
              endHour: InputEmptyOrNot(e.hour),
              failureOrSuccessOption: none(),
            ));
            add(SendProposalEvent.totalPayableHoursChanged());
          },
          endMinuteChanged: (e) {
            emit(state.copyWith(
              endMinute: InputEmptyOrNot(e.minute),
              failureOrSuccessOption: none(),
            ));
            add(SendProposalEvent.totalPayableHoursChanged());
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
          getContractorShiftDetail: (e) async {
            Either<MainFailure, HealthcarePostDTO>? failureOrSuccess;
            emit(state.copyWith(isLoading: true));

            await getaAccomdationHoursListApi(emit);
            // if (e.isFromCounterPropose) {
            //   failureOrSuccess =
            //       await _mainFacade.getContractorShiftDetail(postId: e.postID);
            // } else {
            //   failureOrSuccess = await _mainFacade.getPostApi(postId: e.postID);
            // }
            // failureOrSuccess =await _mainFacade.getPostApi(postId: e.postID);
            failureOrSuccess = await _mainFacade.getSendProposalDetailApi(
                id: e.id, postId: e.postID);

            failureOrSuccess.fold(
              (l) => emit(state.copyWith(
                isLoading: false,
                showErrorMessages: true,
                failureOrSuccessOption: optionOf(failureOrSuccess),
              )),
              (r) {
                setShiftDataToUpdate(emit, r);
                emit(state.copyWith(
                  isLoading: false,
                  showErrorMessages: false,
                  shift: r,
                  multiDates:
                      getDifferentMultiDate(r.shift_detail?.detail ?? []),
                  failureOrSuccessOption: optionOf(failureOrSuccess),
                ));
              },
            );
          },
          tabChangeEvent: (value) async {
            emit(state.copyWith(selectedTab: value.tabIndex));
          },
          setMultiDate: (e) {
            emit(
              state.copyWith(
                  multiDates: e.updatedDates,
                  totalPaybleHours: e.totalPayableHours,
                  unAvailableDates: e.updatedDates
                      .where((item) => item.isUnAvailable == true)
                      .toList()),
            );
          },
          getMultiDateEvent: (e) {
            // List<DateTimeDTO> selectedDateList = [
            //   DateTimeDTO(
            //       date: DateTime.now().toString(), isUnAvailable: false),
            //   DateTimeDTO(
            //       date: DateTime.now().add(Duration(days: 1)).toString(),
            //       isUnAvailable: false),
            //   DateTimeDTO(
            //       date: DateTime.now().add(Duration(days: 3)).toString(),
            //       isUnAvailable: true),
            //   DateTimeDTO(
            //       date: DateTime.now().add(Duration(days: 5)).toString(),
            //       isUnAvailable: false),
            // ];
            if (e.updatedDates != null && e.updatedDates!.isNotEmpty) {
              emit(
                state.copyWith(
                    shift: e.post,
                    multiDates: e.updatedDates!,
                    totalPaybleHours: e.totalPayableHours ?? "",
                    unAvailableDates: e.updatedDates!
                        .where((item) => item.isUnAvailable == true)
                        .toList()),
              );
            } else {
              emit(
                state.copyWith(
                    shift: e.post,
                    totalPaybleHours:
                        e.post.shift_detail?.total_payable_hour ?? "",
                    multiDates: getDifferentMultiDate(
                        e.post.shift_detail?.detail ?? [])),
              );
            }
            emit(
              state.copyWith(
                selectedTab:
                    (e.post.shift_detail?.same_or_different_time == 1) ? 1 : 0,
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
              multiDates: list,
              totalPaybleHours: allTimesFilled(list),
              failureOrSuccessOption: none(),
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
              multiDates: list,
              totalPaybleHours: allTimesFilled(list),
              failureOrSuccessOption: none(),
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
              multiDates: list,
              totalPaybleHours: allTimesFilled(list),
              failureOrSuccessOption: none(),
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
              multiDates: list,
              totalPaybleHours: allTimesFilled(list),
              failureOrSuccessOption: none(),
            ));
          },
          setDateUnavailableEvent: (e) {
            List<DateTimeDTO> updatedDateTimeDTOList =
                List.from(state.multiDates);
            print(
                "updatedDateTimeDTOList----> ${jsonEncode(updatedDateTimeDTOList)}");

            Set<DateTime> set2 = e.selectedDateList.toSet();

            List<DateTimeDTO> result = updatedDateTimeDTOList
                .where((item) => !set2.contains(DateTime.parse(item.date!)))
                .toList();

            final index = updatedDateTimeDTOList
                .indexWhere((item) => item.date == result[0].date);

            updatedDateTimeDTOList[index] =
                updatedDateTimeDTOList[index].copyWith(
              isUnAvailable: !updatedDateTimeDTOList[index].isUnAvailable,
              colorText:
                  (!(updatedDateTimeDTOList[index].isUnAvailable) == true)
                      ? "0xffEB0000"
                      : "0xFF0FB62A",
            );

            print(
                "updatedDateTimeDTOList AFTER CHANGE COLOR----> $updatedDateTimeDTOList");
            List<DateTimeDTO> unAvailableDates = updatedDateTimeDTOList
                .where((item) => item.isUnAvailable == true)
                .toList();

            print("Total payable hours---> ${state.totalPaybleHours}");
            emit(
              state.copyWith(
                multiDates: updatedDateTimeDTOList,
                totalPaybleHours: allTimesFilled(updatedDateTimeDTOList),
                unAvailableDates: unAvailableDates,
              ),
            );
          },
          submitSingleShiftProposalEvent: (e) async {
            final isCommuteAllownceValid = isAllownceValid(
                selectedValue:
                    state.shift.shift_detail?.commute_allowance_type ?? -1,
                hourValue: state.commuteHour,
                rateValue: state.commuteRate);
            final isAccomdationAllownceValid = isAllownceValid(
                selectedValue:
                    state.shift.shift_detail?.accommodation_allowance_type ??
                        -1,
                hourValue: state.accomdationHour,
                rateValue: state.accomdationRate);
            final isStartHourValid = state.startHour.isValid();
            final isStartMinuteValid = state.startMinute.isValid();
            final isEndHourValid = state.endHour.isValid();
            final isEndMinuteValid = state.endMinute.isValid();
            final isRateValid = state.rateHour.isValid();
            final isMoreThanTwoHours =
                CustomDateTimeFormat.parseTotalPayableHours(
                    state.totalPaybleHours);

            if (isRateValid &&
                isCommuteAllownceValid &&
                isAccomdationAllownceValid &&
                isStartHourValid &&
                isStartMinuteValid &&
                isEndHourValid &&
                isEndMinuteValid) {
              final isTimePast =
                  timeIsPast(state, state.startHour, state.startMinute);

              if (isTimePast) {
                showError(
                        message: StringConstant
                            .shiftStartTtimeMustBeAtLeastHoursFromTheCurrentTime)
                    .show(e.context);
              } else if (isMoreThanTwoHours < Duration(hours: 2)) {
                print("show errorrrr on submit");
                showError(
                        message:
                            StringConstant.theTotalPayableHourMustBeAtLeastTwo)
                    .show(e.context);
              } else {
                emit(state.copyWith(
                  isLoading: true,
                  failureOrSuccessOption: none(),
                ));

                print("show success on submit ${state.multiDates}");

                Either<MainFailure, String>? failureOrSuccess;

                // final isAllDatesValid = state.multiDates.every((dto) =>
                //     dto.totalPaybleHours != null &&
                //     dto.totalPaybleHours!.isNotEmpty);

                // if (isAllDatesValid) {
                failureOrSuccess =
                    await _mainFacade.contractorApplyOrSendProposal(
                  mapData: singleShiftData(state),
                );

                failureOrSuccess.fold(
                  (l) {
                    emit(state.copyWith(isLoading: false));

                    e.context.router.maybePop();
                    showError(
                      message: l.maybeMap(
                        showAPIResponseMessage: (value) => value.message,
                        networkError: (value) =>
                            'Please check your internet connectivity',
                        orElse: () => "Server Error. Try again later.",
                      ),
                    ).show(e.context);
                  },
                  (r) {
                    showSuccess(message: r).show(e.context).then((value) {
                      e.context.router.maybePop(true);
                    });
                    emit(state.copyWith(isLoading: false));
                  },
                );
              }
              // }
            } else {
              print("Some details are invalid!");
              emit(
                state.copyWith(
                  isLoading: false,
                  showErrorMessages: true,
                  failureOrSuccessOption: none(),
                ),
              );
            }
          },
          submitSameMultiShiftProposalEvent: (e) async {
            Either<MainFailure, String>? failureOrSuccess;

            final isCommuteAllownceValid = isAllownceValid(
                selectedValue:
                    state.shift.shift_detail?.commute_allowance_type ?? -1,
                hourValue: state.commuteHour,
                rateValue: state.commuteRate);
            final isAccomdationAllownceValid = isAllownceValid(
                selectedValue:
                    state.shift.shift_detail?.accommodation_allowance_type ??
                        -1,
                hourValue: state.accomdationHour,
                rateValue: state.accomdationRate);
            final isStartHourValid = state.startHour.isValid();
            final isStartMinuteValid = state.startMinute.isValid();
            final isEndHourValid = state.endHour.isValid();
            final isEndMinuteValid = state.endMinute.isValid();
            final isRateValid = state.rateHour.isValid();
            final isMoreThanTwoHours =
                CustomDateTimeFormat.parseTotalPayableHours(
                    state.totalPaybleHours);

            if (isRateValid &&
                isCommuteAllownceValid &&
                isAccomdationAllownceValid &&
                isStartHourValid &&
                isStartMinuteValid &&
                isEndHourValid &&
                isEndMinuteValid) {
              final isTimePast = timeIsPast(
                state,
                state.startHour,
                state.startMinute,
                shiftType: 1,
              );

              if (isTimePast) {
                showError(
                        message: StringConstant
                            .shiftStartTtimeMustBeAtLeastHoursFromTheCurrentTime)
                    .show(e.context);
              } else if (isMoreThanTwoHours < Duration(hours: 2)) {
                showError(
                        message:
                            StringConstant.theTotalPayableHourMustBeAtLeastTwo)
                    .show(e.context);
              } else {
                emit(state.copyWith(
                  isLoading: true,
                  failureOrSuccessOption: none(),
                ));
                final post = continueWithPostDetail(state);

                failureOrSuccess = await _mainFacade
                    .contractorApplyOrSendProposal(mapData: post);

                failureOrSuccess.fold(
                  (l) {
                    emit(state.copyWith(
                      isLoading: false,
                    ));
                    e.context.router.maybePop();
                    showError(
                      message: l.maybeMap(
                        showAPIResponseMessage: (value) => value.message,
                        networkError: (value) =>
                            'Please check your internet connectivity',
                        orElse: () => "Server Error. Try again later.",
                      ),
                    ).show(e.context);
                  },
                  (r) {
                    e.context.router.maybePop();
                    showSuccess(message: r).show(e.context).then((value) {
                      e.context.router.maybePop(true);
                    });
                    emit(state.copyWith(
                      isLoading: true,
                      failureOrSuccessOption: none(),
                    ));
                  },
                );
              }
            } else {
              print("Some details are invalid!");
              emit(
                state.copyWith(
                  showErrorMessages: true,
                  failureOrSuccessOption: none(),
                ),
              );
            }
          },
          submitDifferentMultiShiftProposalEvent: (e) async {
            Either<MainFailure, String>? failureOrSuccess;
            final isCommuteAllownceValid = isAllownceValid(
                selectedValue:
                    state.shift.shift_detail?.commute_allowance_type ?? -1,
                hourValue: state.commuteHour,
                rateValue: state.commuteRate);
            final isAccomdationAllownceValid = isAllownceValid(
                selectedValue:
                    state.shift.shift_detail?.accommodation_allowance_type ??
                        -1,
                hourValue: state.accomdationHour,
                rateValue: state.accomdationRate);
            final isRateValid = state.rateHour.isValid();
            final isAllDatesValid = state.multiDates.every((dto) =>
                dto.totalPaybleHours != null &&
                dto.totalPaybleHours!.isNotEmpty);

            if (isAllDatesValid &&
                isRateValid &&
                isCommuteAllownceValid &&
                isAccomdationAllownceValid) {
              final post = continueWithPostDetail(state);

              failureOrSuccess =
                  await _mainFacade.contractorApplyOrSendProposal(
                mapData: post,
              );

              failureOrSuccess.fold(
                (l) {
                  e.context.router.maybePop();
                  showError(
                    message: l.maybeMap(
                      showAPIResponseMessage: (value) => value.message,
                      networkError: (value) =>
                          'Please check your internet connectivity',
                      orElse: () => "Server Error. Try again later.",
                    ),
                  ).show(e.context);
                },
                (r) {
                  e.context.router.maybePop();
                  showSuccess(message: r).show(e.context).then((value) {
                    e.context.router.maybePop(true);
                  });
                },
              );
            }
            emit(
              state.copyWith(
                showErrorMessages: true,
                failureOrSuccessOption: none(),
              ),
            );
          },
        );
      },
    );
  }

  String allTimesFilled(List<DateTimeDTO> multiDateTimeList) {
    List<DateTimeDTO> filteredList = multiDateTimeList.where((dto) {
      return dto.start_time != null &&
          dto.start_time!.isNotEmpty &&
          dto.end_time != null &&
          dto.end_time!.isNotEmpty &&
          dto.isUnAvailable == false;
    }).toList();
    bool areAllTimesFilled = filteredList.every((dto) =>
        dto.totalPaybleHours != null && dto.totalPaybleHours!.isNotEmpty);

    print("filteredList---> ${jsonEncode(filteredList)}");

    if (areAllTimesFilled) {
      // Substract unpaid break list
      List<DateTimeDTO> updatedList = filteredList.map((dto) {
        if (isTimeFilled(dto)) {
          final unpaidBreak =
              CustomDateTimeFormat.extractUnpaidBreak(dto.unpaidBreak ?? "0");
          var timeDiffBetweenEndStartTime = DateTime.parse(dto.end_time!)
              .difference(DateTime.parse(dto.start_time!));

          final timeDifference =
              timeDiffBetweenEndStartTime - Duration(minutes: unpaidBreak);
          // print("timeDifference---> timeDifference ${timeDifference}");
          print("timeDifference---> timeDifference $unpaidBreak");
          return dto.copyWith(totalPaybleHours: timeDifference.toString());
        } else {
          return dto;
        }
      }).toList();

      final totalHour = CustomDateTimeFormat.formatDuration(
          sumTotalPayableHours(updatedList));
      print("totalHour--> $totalHour");
      return totalHour;
    } else {
      return "00h 00min";
    }
  }

  Duration sumTotalPayableHours(List<DateTimeDTO> multiDateTimeList) {
    print("payable hours: $multiDateTimeList");
    final totalDuration = multiDateTimeList.fold(Duration.zero, (total, dto) {
      return total + parseDuration(dto.totalPaybleHours ?? "");
    });
    return totalDuration;
  }

  Duration parseDuration(String duration) {
    final parts = duration.split(':');
    final hours = int.parse(parts[0]);
    final minutes = int.parse(parts[1]);
    final seconds = double.parse(parts[2]).round();
    final duration1 =
        Duration(hours: hours, minutes: minutes, seconds: seconds);
    return duration1;
  }

  Map<String, dynamic> singleShiftData(SendProposalState state) {
    String startTime = CustomDateTimeFormat.parseTime(
      state.startHour.getValue() ?? "",
      state.startMinute.getValue() ?? "",
      dateTime: (state.shift.shift_detail?.date != null)
          ? CustomDateTimeFormat.timeStampToDateTime(
              (state.shift.shift_detail?.date ?? -1))
          : null,
    ).toString();
    String endTime = CustomDateTimeFormat.parseTime(
      state.endHour.getValue() ?? "",
      state.endMinute.getValue() ?? "",
      dateTime: (state.shift.shift_detail?.date != null)
          ? CustomDateTimeFormat.timeStampToDateTime(
              (state.shift.shift_detail?.date ?? -1))
          : null,
    ).toString();

    String shiftDate =
        CustomDateTimeFormat.dateTimeToUtcTimestamp(DateTime.parse(startTime))
            .toString();

    return {
      'post_id': state.shift.post_id,

      /// shift_type means Applied => 1 SendProposal => 2
      'shift_type': 2,
      'rate_hour': state.rateHour.getValue(),
      'date': shiftDate,
      'start_time': CustomDateTimeFormat.dateTimeToUtcTimestamp(
          DateTime.parse(startTime)),
      'end_time': CustomDateTimeFormat.dateTimeToUtcTimestamp(
        DateTime.parse(endTime),
        startTime: DateTime.parse(startTime),
      ),
      'commute_allowance': (state.shift.shift_detail?.commute_allowance_type ==
              1)
          ? state.commuteRate.getValue()
          : (state.shift.shift_detail?.commute_allowance_type == 2)
              ? getAccomdationHourId(state, state.commuteHour.getValue() ?? "")
              : "",
      'accommodation_allowance':
          (state.shift.shift_detail?.accommodation_allowance_type == 1)
              ? state.accomdationRate.getValue()
              : (state.shift.shift_detail?.accommodation_allowance_type == 2)
                  ? getAccomdationHourId(
                      state, state.accomdationHour.getValue() ?? "")
                  : "",
      'total_payable_hour': state.totalPaybleHours,
      'unpaid_break_id': state.shift.shift_detail?.unpaid_break?.id ?? -1,
    };
  }

  Map<String, dynamic> continueWithPostDetail(SendProposalState state) {
    final shiftDetail = state.shift.shift_detail ?? ShiftDetailDTO();
    /* String startTime = "";
    String endTime = "";

    if (shiftDetail.shift_type == 1 ||
        (shiftDetail.shift_type == 2 &&
            shiftDetail.same_or_different_time == 1)) {
      startTime = CustomDateTimeFormat.parseTime(
        state.startHour.getValue() ?? "",
        state.startMinute.getValue() ?? "",
      ).toString();
      endTime = CustomDateTimeFormat.parseTime(
              state.endHour.getValue() ?? "", state.endMinute.getValue() ?? "")
          .toString();
    } */

    String mapMultiDateToApiFormat() {
      if (state.multiDates.isNotEmpty) {
        final list = state.multiDates
            .where((element) => element.isUnAvailable == false)
            .map((multiDate) {
          final formattedStartTime = CustomDateTimeFormat.parseTime(
            state.startHour.getValue() ?? "",
            state.startMinute.getValue() ?? "",
            dateTime: DateTime.parse(multiDate.date ?? ""),
          ).toString();
          final formattedEndTime = CustomDateTimeFormat.parseTime(
            state.endHour.getValue() ?? "",
            state.endMinute.getValue() ?? "",
            dateTime: DateTime.parse(multiDate.date ?? ""),
          ).toString();

          final formattedDate = (shiftDetail.same_or_different_time == 1)
              ? CustomDateTimeFormat.mergeDateAndTime(
                  formattedStartTime,
                  formattedEndTime,
                  dateTime: DateTime.parse(multiDate.date ?? ""),
                )
              : CustomDateTimeFormat.mergeDateAndTime(
                  multiDate.start_time ?? "",
                  multiDate.end_time ?? "",
                  dateTime: DateTime.parse(multiDate.date ?? ""),
                );

          final map = {
            'date': CustomDateTimeFormat.dateTimeToUtcTimestamp(formattedDate),
            'start_time': CustomDateTimeFormat.dateTimeToUtcTimestamp(
              DateTime.parse((shiftDetail.same_or_different_time == 1)
                  ? formattedStartTime
                  : multiDate.start_time ?? ""),
              isInt: true,
            ),
            'end_time': CustomDateTimeFormat.dateTimeToUtcTimestamp(
              DateTime.parse((shiftDetail.same_or_different_time == 1)
                  ? formattedEndTime
                  : multiDate.end_time ?? ""),
              startTime: DateTime.parse(
                  (shiftDetail.same_or_different_time == 1)
                      ? formattedStartTime
                      : multiDate.start_time ?? ""),
              isInt: true,
            ),
            'payable_hour': multiDate.totalPaybleHours,
            'unpaid_break_id': (shiftDetail.same_or_different_time == 1)
                ? state.shift.shift_detail?.unpaid_break?.id ?? -1
                : multiDate.unpaidBreakId,
          };
          return map;
        }).toList();
        return jsonEncode(list);
      } else {
        return "";
      }
    }

    String unAvailableDateFormat() {
      if (state.multiDates.isNotEmpty) {
        final list = state.multiDates
            .where((element) => element.isUnAvailable == true)
            .map((multiDate) {
          return CustomDateTimeFormat.dateTimeToUtcTimestamp(
              DateTime.parse(multiDate.date ?? ""));
        }).toList();

        return list.join(",");
      } else {
        return "";
      }
    }

    Map<String, dynamic> mapData = {
      'post_id': state.shift.post_id,
      'shift_type': 2,
      'rate_hour': state.rateHour.getValue(),
      'commute_allowance': (shiftDetail.commute_allowance_type == 1)
          ? state.commuteRate.getValue()
          : (shiftDetail.commute_allowance_type == 2)
              ? getAccomdationHourId(state, state.commuteHour.getValue() ?? "")
              : "",
      'accommodation_allowance': (shiftDetail.accommodation_allowance_type == 1)
          ? state.accomdationRate.getValue()
          : (shiftDetail.accommodation_allowance_type == 2)
              ? getAccomdationHourId(
                  state, state.accomdationHour.getValue() ?? "")
              : "",
      'multi_date': mapMultiDateToApiFormat(),
      'total_payable_hour': state.totalPaybleHours,
      'unavailability_date': unAvailableDateFormat(),
    };
    return mapData;
  }

  List<DateTimeDTO> createOrUpdateDateTimeDTO(
    SendProposalState state, {
    required String date,
    required int condition,
    required String value,
    required int? index,
  }) {
    final list = List<DateTimeDTO>.from(state.multiDates);

    final existingIndex = list.indexWhere((item) => item.date == date);

    DateTimeDTO updatedDTO = existingIndex != -1
        ? list[existingIndex]
        : DateTimeDTO(
            date: date,
            objId: index,
          );

    updatedDTO = updatedDTO.copyWith(
      startHour: condition == 1 ? value : updatedDTO.startHour,
      startMinute: condition == 2 ? value : updatedDTO.startMinute,
      endHour: condition == 3 ? value : updatedDTO.endHour,
      endMinute: condition == 4 ? value : updatedDTO.endMinute,
      unpaidBreak: condition == 5 ? value : updatedDTO.unpaidBreak,
    );

    if (updatedDTO.startHour != null && updatedDTO.startMinute != null) {
      // final startTime = CustomDateTimeFormat.parseTime(
      //     updatedDTO.startHour!, updatedDTO.startMinute!);

      final startTime = CustomDateTimeFormat.parseTime(
          updatedDTO.startHour!, updatedDTO.startMinute!,
          dateTime: (updatedDTO.date != null && updatedDTO.date!.isNotEmpty)
              ? DateTime.parse(updatedDTO.date!)
              : null);
      updatedDTO = updatedDTO.copyWith(start_time: startTime.toString());
    }

    if (updatedDTO.endHour != null && updatedDTO.endMinute != null) {
      // final endTime = CustomDateTimeFormat.parseTime(
      //     updatedDTO.endHour!, updatedDTO.endMinute!);
      final endTime = CustomDateTimeFormat.parseTime(
          updatedDTO.endHour!, updatedDTO.endMinute!,
          dateTime: (updatedDTO.date != null && updatedDTO.date!.isNotEmpty)
              ? DateTime.parse(updatedDTO.date!)
              : null);
      updatedDTO = updatedDTO.copyWith(end_time: endTime.toString());
    }

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

      print("total hours---> $timeDiffBetweenEndStartTime");
      print("total hours---> timeDifference $timeDifference");
      updatedDTO = updatedDTO.copyWith(
          totalPaybleHours: (timeDifference != null)
              ? CustomDateTimeFormat.formatDuration(timeDifference)
              : "");
    }

    if (existingIndex != -1) {
      list[existingIndex] = updatedDTO;
    } else {
      list.add(updatedDTO);
      list.sort((a, b) => a.date!.compareTo(b.date!));
    }

    return list;
  }

  bool isTimeFilled(DateTimeDTO dto) {
    return (dto.start_time != null &&
        dto.start_time!.isNotEmpty &&
        dto.end_time != null &&
        dto.end_time!.isNotEmpty);
  }

  setShiftDataToUpdate(
      Emitter<SendProposalState> emit, HealthcarePostDTO updatedShift) async {
    final r = updatedShift.shift_detail;
    final proposal = r?.proposal_received;
    if (r != null) {
      emit(
        state.copyWith(
          isLoading: true,
          startHour: InputEmptyOrNot(
              CustomDateTimeFormat.getHour(timestamp: r.start_time ?? 0)),
          startMinute: InputEmptyOrNot(
              CustomDateTimeFormat.getMinute(timestamp: r.start_time ?? 0)),
          endHour: InputEmptyOrNot(
              CustomDateTimeFormat.getHour(timestamp: r.end_time ?? 0)),
          endMinute: InputEmptyOrNot(
              CustomDateTimeFormat.getMinute(timestamp: r.end_time ?? 0)),
          unpaidBreak: InputEmptyOrNot(r.unpaid_break?.name ?? ""),
          totalPaybleHours: r.total_payable_hour ?? "",
          /* rateHour: Rate((updatedShift.rate_hour != null)
              ? "${updatedShift.rate_hour ?? ""}"
              : ""),
          commuteHour: InputEmptyOrNot((r.commute_allowance_type == 2)
              ? getAccomdationHourName(r.commute_allowance_type_details ?? 0)
              : ""),
          commuteRate: Rate((r.commute_allowance_type == 1)
              ? "${r.commute_allowance_type_details ?? 0}"
              : ""),
          accomdationHour: InputEmptyOrNot((r.accommodation_allowance_type == 2)
              ? getAccomdationHourName(
                  r.accommodation_allowance_type_details ?? 0.0)
              : ""),
          accomdationRate: Rate((r.accommodation_allowance_type == 1)
              ? "${r.accommodation_allowance_type_details ?? 0}"
              : ""), */
          rateHour: Rate((proposal?.proposed_hourly_rate != null)
              ? "${proposal?.proposed_hourly_rate ?? ""}"
              : ""),
          commuteHour: InputEmptyOrNot((proposal?.commute_allowance_type == 2)
              ? getAccomdationHourName(
                  proposal?.proposed_commute_allowance_hour_id ?? 0)
              : ""),
          commuteRate: Rate((proposal?.commute_allowance_type == 1)
              ? "${proposal?.proposed_commute_allowance_rate ?? ""}"
              : ""),
          accomdationHour: InputEmptyOrNot(
              (proposal?.accommodation_allowance_type == 2)
                  ? getAccomdationHourName(
                      proposal?.proposed_accommodation_allowance_hour_id ?? 0)
                  : ""),
          accomdationRate: Rate((proposal?.accommodation_allowance_type == 1)
              ? "${proposal?.proposed_accommodation_allowance_rate ?? ""}"
              : ""),
          /* rateHour: Rate((updatedShift
                      .proposal_received?.proposed_hourly_rate !=
                  null)
              ? "${updatedShift.proposal_received?.proposed_hourly_rate ?? ""}"
              : ""),
          commuteHour: InputEmptyOrNot((proposal?.commute_allowance_type == 2)
              ? getAccomdationHourName(
                  proposal?.proposed_commute_allowance ?? 0)
              : ""),
          commuteRate: Rate((proposal?.commute_allowance_type == 1)
              ? "${proposal?.proposed_commute_allowance ?? 0}"
              : ""),
          accomdationHour: InputEmptyOrNot(
              (proposal?.accommodation_allowance_type == 2)
                  ? getAccomdationHourName(
                      proposal?.proposed_accommodation_allowance ?? 0.0)
                  : ""),
          accomdationRate: Rate((proposal?.accommodation_allowance_type == 1)
              ? "${proposal?.proposed_accommodation_allowance ?? 0}"
              : ""), */
        ),
      );
    }
  }

  String getAccomdationHourId(SendProposalState state, String selectedHour) {
    final hourId = state.accomdationHoursList.firstWhere(
        (hour) => hour.name == selectedHour,
        orElse: () => SkillDTO());
    print("Hour ID --> $hourId");
    return "${hourId.id ?? -1}";
  }

  getaAccomdationHoursListApi(Emitter<SendProposalState> emit) async {
    final hoursList = await _mainFacade.getAccomdationHoursListApi();
    hoursList.fold(
      (l) => emit(
        state.copyWith(
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

  List<DateTimeDTO> getDifferentMultiDate(List<ShiftDateDetailDTO> detail) {
    print("detail is empty--> $detail");
    final list = detail.map((multiDate) {
      final timestamp = multiDate.date;

      return DateTimeDTO(
        id: multiDate.id,
        date: (timestamp != null)
            ? CustomDateTimeFormat.timeStampToDateTime(timestamp).toString()
            : DateTime.now().toString(),
        startHour:
            CustomDateTimeFormat.getHour(timestamp: multiDate.start_time ?? 0),
        startMinute: CustomDateTimeFormat.getMinute(
            timestamp: multiDate.start_time ?? 0),
        endHour:
            CustomDateTimeFormat.getHour(timestamp: multiDate.end_time ?? 0),
        endMinute:
            CustomDateTimeFormat.getMinute(timestamp: multiDate.end_time ?? 0),
        start_time: (multiDate.start_time != null)
            ? CustomDateTimeFormat.timeStampToDateTime(multiDate.start_time!)
                .toString()
            : DateTime.now().toString(),
        end_time: (multiDate.end_time != null)
            ? CustomDateTimeFormat.timeStampToDateTime(multiDate.end_time!)
                .toString()
            : DateTime.now().toString(),
        totalPaybleHours: multiDate.payable_hour ?? "",
        unpaidBreak: multiDate.unpaid_break?.name ?? "",
        unpaidBreakId: multiDate.unpaid_break?.id ?? -1,
      );
    }).toList();
    print("get selected date list--> $list");
    return list;
  }

  String getAccomdationHourName(int id) {
    print("id of hour--> ${state.accomdationHoursList}");
    final hour = state.accomdationHoursList
        .firstWhere((hour) => hour.id == id, orElse: () => SkillDTO());
    print("Hour --> $hour");
    return hour.name ?? "";
  }
}
