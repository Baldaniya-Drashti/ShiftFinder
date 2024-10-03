import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:shift/domain/auth/auth_value_objects.dart';
import 'package:shift/domain/main/i_main_facade.dart';
import 'package:shift/domain/main/main_failure.dart';
import 'package:shift/infrastructure/core/skill_list_model/skill_dto.dart';
import 'package:shift/infrastructure/main/date_time_dto/date_time_dto.dart';
import 'package:shift/infrastructure/main/healthcare_post/healthcare_post_dto.dart';
import 'package:shift/presentation/common/utils/date_time_format.dart';

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
              showErrorMessages: false,
              failureOrSuccessOption: none(),
            ));
          },
          accomdationRateChanged: (e) {
            emit(state.copyWith(
              accomdationRate: Rate(e.hour),
              showErrorMessages: false,
              failureOrSuccessOption: none(),
            ));
          },
          commuteHourChanged: (e) {
            emit(state.copyWith(
              commuteHour: InputEmptyOrNot(e.hour),
              showErrorMessages: false,
              failureOrSuccessOption: none(),
            ));
          },
          commuteRateChanged: (e) {
            emit(state.copyWith(
              commuteRate: Rate(e.rate),
              showErrorMessages: false,
              failureOrSuccessOption: none(),
            ));
          },
          rateHourChanged: (e) {
            emit(state.copyWith(
              rateHour: Rate(e.rate),
              showErrorMessages: false,
              failureOrSuccessOption: none(),
            ));
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
          getMultiDateEvent: (e) {
            List<DateTimeDTO> selectedDateList = [
              DateTimeDTO(
                  date: DateTime.now().toString(), isUnAvailable: false),
              DateTimeDTO(
                  date: DateTime.now().add(Duration(days: 1)).toString(),
                  isUnAvailable: false),
              DateTimeDTO(
                  date: DateTime.now().add(Duration(days: 3)).toString(),
                  isUnAvailable: true),
              DateTimeDTO(
                  date: DateTime.now().add(Duration(days: 5)).toString(),
                  isUnAvailable: false),
            ];
            emit(state.copyWith(multiDates: selectedDateList));
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
          submitProposalEvent: (e) {
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
              print("All details are valid!");
            } else {
              print("Some details are invalid!");

              emit(
                state.copyWith(
                  showErrorMessages: true,
                ),
              );
            }
          },
        );
      },
    );
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

  String getAccomdationHourName(int id) {
    print("id of hour--> ${state.accomdationHoursList}");
    final hour = state.accomdationHoursList
        .firstWhere((hour) => hour.id == id, orElse: () => SkillDTO());
    print("Hour --> $hour");
    return hour.name ?? "";
  }
}
