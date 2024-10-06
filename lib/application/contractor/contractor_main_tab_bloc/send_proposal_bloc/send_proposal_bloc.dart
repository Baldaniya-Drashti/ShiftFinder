import 'dart:convert';

import 'package:auto_route/auto_route.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:shift/domain/auth/auth_value_objects.dart';
import 'package:shift/domain/main/i_main_facade.dart';
import 'package:shift/domain/main/main_failure.dart';
import 'package:shift/infrastructure/core/skill_list_model/skill_dto.dart';
import 'package:shift/infrastructure/main/date_time_dto/date_time_dto.dart';
import 'package:shift/infrastructure/main/healthcare_post/healthcare_post_dto.dart';
import 'package:shift/infrastructure/main/multi_shift_dto/multi_shift_dto.dart';
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

            failureOrSuccess = await _mainFacade.getPostApi(
              postId: e.postID,
            );

            failureOrSuccess.fold(
                  (l) => emit(state.copyWith(
                isLoading: false,
                showErrorMessages: true,
                failureOrSuccessOption: optionOf(failureOrSuccess),
              )),
                  (r) {
                print("post--> $r");
                setShiftDataToUpdate(emit, r);
                emit(state.copyWith(
                  isLoading: false,
                  showErrorMessages: false,
                  shift: r,
                  failureOrSuccessOption: optionOf(failureOrSuccess),
                ));
              },
            );
          },
          tabChangeEvent: (value) async {
            emit(state.copyWith(selectedTab: value.tabIndex));
          },
          setMultiDate: (e) {
            emit(state.copyWith(multiDates: e.updatedDates));
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
                ),
              );
            } else {
              emit(
                state.copyWith(
                  shift: e.post,
                  multiDates: (e.post.shift_detail?.shift_type == 2 &&
                      e.post.shift_detail?.same_or_different_time == 2)
                      ? getDifferentMultiDate(e.post.shift_detail?.detail ?? [])
                      : [],
                ),
              );
            }
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
              // totalPaybleHours: allTimesFilled(list),
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
              // totalPaybleHours: allTimesFilled(list),
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
              // totalPaybleHours: allTimesFilled(list),
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
              // totalPaybleHours: allTimesFilled(list),
              failureOrSuccessOption: none(),
            ));
          },
          setDateUnavailableEvent: (e) {
            List<DateTimeDTO> updatedDateTimeDTOList =
            List.from(state.multiDates);

            Set<DateTime> set2 = e.selectedDateList.toSet();

            List<DateTimeDTO> result = updatedDateTimeDTOList
                .where((item) => !set2.contains(DateTime.parse(item.date!)))
                .toList();

            final index = updatedDateTimeDTOList
                .indexWhere((item) => item.date == result[0].date);

            updatedDateTimeDTOList[index] =
                updatedDateTimeDTOList[index].copyWith(isUnAvailable: true);

            print(
                "updatedDateTimeDTOList---> ${jsonEncode(updatedDateTimeDTOList)}");
            emit(
              state.copyWith(
                multiDates: updatedDateTimeDTOList,
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

            if (isRateValid &&
                isCommuteAllownceValid &&
                isAccomdationAllownceValid &&
                isStartHourValid &&
                isStartMinuteValid &&
                isEndHourValid &&
                isEndMinuteValid) {
              Either<MainFailure, String>? failureOrSuccess;

              final isAllDatesValid = state.multiDates.every((dto) =>
              dto.totalPaybleHours != null &&
                  dto.totalPaybleHours!.isNotEmpty);

              if (isAllDatesValid) {
                failureOrSuccess =
                await _mainFacade.contractorApplyOrSendProposal(
                  mapData: singleShiftData(state),
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
                    showSuccess(message: r).show(e.context).then((value) {
                      e.context.router.maybePop(true);
                    });
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
          submitMultiShiftProposalEvent: (e) async {
            Either<MainFailure, String>? failureOrSuccess;

            final isAllDatesValid = state.multiDates.every((dto) =>
            dto.totalPaybleHours != null &&
                dto.totalPaybleHours!.isNotEmpty);

            if (isAllDatesValid) {
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
  Map<String, dynamic> singleShiftData(SendProposalState state) {
    String startTime = CustomDateTimeFormat.parseTime(
        state.startHour.getValue() ?? "",
        state.startMinute.getValue() ?? "")
        .toString();
    String endTime = CustomDateTimeFormat.parseTime(
        state.endHour.getValue() ?? "", state.endMinute.getValue() ?? "")
        .toString();

    return {
      'post_id': state.shift.id,
      'shift_type': 2,
      'rate_hour': state.rateHour.getValue(),
      'date': state.shift.shift_detail?.date,
      'start_time':
      DateTime.parse(startTime).toUtc().millisecondsSinceEpoch / 1000,
      'end_time': DateTime.parse(endTime).toUtc().millisecondsSinceEpoch / 1000,
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
    };
  }

  Map<String, dynamic> continueWithPostDetail(SendProposalState state) {
    final shiftDetail = state.shift.shift_detail ?? ShiftDetailDTO();
    String startTime = "";
    String endTime = "";

    if (shiftDetail.shift_type == 1 ||
        (shiftDetail.shift_type == 2 &&
            shiftDetail.same_or_different_time == 1)) {
      startTime = CustomDateTimeFormat.parseTime(
          state.startHour.getValue() ?? "",
          state.startMinute.getValue() ?? "")
          .toString();
      endTime = CustomDateTimeFormat.parseTime(
          state.endHour.getValue() ?? "", state.endMinute.getValue() ?? "")
          .toString();
    }

    String mapMultiDateToApiFormat() {
      if (state.multiDates.isNotEmpty) {
        final list = state.multiDates.map((multiDate) {
          final map = {
            'date': DateTime.parse(multiDate.date ?? "")
                .toUtc()
                .millisecondsSinceEpoch /
                1000,
            'start_time': DateTime.parse(
                (shiftDetail.same_or_different_time == 1)
                    ? startTime
                    : multiDate.start_time ?? "")
                .toUtc()
                .millisecondsSinceEpoch /
                1000,
            'end_time': DateTime.parse((shiftDetail.same_or_different_time == 1)
                ? endTime
                : multiDate.end_time ?? "")
                .toUtc()
                .millisecondsSinceEpoch /
                1000,
            'payable_hour': multiDate.totalPaybleHours,
            // 'unpaid_break_id':getSelectedUnPaidBreakId(breakTime: multiDate.unpaidBreak),
          };
          return map;
        }).toList();
        return jsonEncode(list);
      } else {
        return "";
      }
    }

    Map<String, dynamic> mapData = {
      'post_id': state.shift.id,
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
      'unavailability_date': "",
      // shift_type: shift.shift_type,
      // unpaid_break_id: shift.unpaid_break_id,
      // total_payable_hour: shift.total_payable_hour,
      // commute_allowance_type: shift.commute_allowance_type,
      // accommodation_allowance_type: shift.accommodation_allowance_type,
      // vacancie_type: shift.vacancie_type.toString(),
      // date: (shift.date != null && shift.date!.isNotEmpty)
      //     ? (DateTime.parse(shift.date ?? "").toUtc().millisecondsSinceEpoch /
      //             1000)
      //         .toString()
      //     : null,
      // start_time: (shift.start_time != null && shift.start_time!.isNotEmpty)
      //     ? (DateTime.parse(shift.start_time ?? "")
      //                 .toUtc()
      //                 .millisecondsSinceEpoch /
      //             1000)
      //         .toString()
      //     : null,
      // end_time: (shift.end_time != null && shift.end_time!.isNotEmpty)
      //     ? (DateTime.parse(shift.end_time ?? "")
      //                 .toUtc()
      //                 .millisecondsSinceEpoch /
      //             1000)
      //         .toString()
      //     : null,
      // same_or_different_time: shift.same_or_different_time,
      // multi_date: mapMultiDateToApiFormat(),
      // individual_shift: shift.individual_shift,
      // commute_allowance: shift.commute_allowance,
      // accommodation_allowance: shift.accommodation_allowance,
      // shift_note: shift.shift_note,
      // number_of_vacancie: shift.number_of_vacancie,
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

      print("total hours---> $timeDiffBetweenEndStartTime");
      print("total hours---> timeDifference $timeDifference");
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

  bool isTimeFilled(DateTimeDTO dto) {
    return (dto.start_time != null &&
        dto.start_time!.isNotEmpty &&
        dto.end_time != null &&
        dto.end_time!.isNotEmpty);
  }

  setShiftDataToUpdate(
      Emitter<SendProposalState> emit, HealthcarePostDTO updatedShift) async {
    final r = updatedShift.shift_detail;
    if (r != null) {
      print("Update r---> ${jsonEncode(r.recurrence_mode)}");
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
          rateHour: Rate((updatedShift.rate_hour != null)
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
              r.accommodation_allowance_type_details ?? 0)
              : ""),
          accomdationRate: Rate((r.accommodation_allowance_type == 1)
              ? "${r.accommodation_allowance_type_details ?? 0}"
              : ""),
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
        startHour:
        CustomDateTimeFormat.getHour(timestamp: multiDate.start_time ?? 0),
        startMinute: CustomDateTimeFormat.getMinute(
            timestamp: multiDate.start_time ?? 0),
        endHour:
        CustomDateTimeFormat.getHour(timestamp: multiDate.end_time ?? 0),
        endMinute:
        CustomDateTimeFormat.getMinute(timestamp: multiDate.end_time ?? 0),
        totalPaybleHours: multiDate.payable_hour ?? "",
        start_time: (multiDate.start_time != null)
            ? DateTime.fromMillisecondsSinceEpoch(multiDate.start_time! * 1000)
            .toString()
            : DateTime.now().toString(),
        end_time: (multiDate.end_time != null)
            ? DateTime.fromMillisecondsSinceEpoch(multiDate.end_time! * 1000)
            .toString()
            : DateTime.now().toString(),
        unpaidBreak: multiDate.unpaid_break?.name ?? "",
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
