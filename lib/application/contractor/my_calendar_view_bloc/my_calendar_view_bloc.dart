import 'package:dartz/dartz.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:shift/domain/main/i_main_facade.dart';
import 'package:shift/domain/main/main_failure.dart';
import 'package:shift/infrastructure/contractor_main/profile/my_calendar_dto/my_calendar_dto.dart';
import 'package:shift/presentation/common/utils/date_time_format.dart';
import 'package:shift/presentation/common/utils/flushbar_creator.dart';
part 'my_calendar_view_event.dart';
part 'my_calendar_view_state.dart';
part 'my_calendar_view_bloc.freezed.dart';

@injectable
class MyCalendarViewBloc
    extends Bloc<MyCalendarViewEvent, MyCalendarViewState> {
  final IMainFacade _mainFacade;

  MyCalendarViewBloc(this._mainFacade) : super(MyCalendarViewState.initial()) {
    on<MyCalendarViewEvent>((event, emit) async {
      await event.map(
        getMyCalendarList: (e) async {
          Either<MainFailure, List<MyCalendarDTO>>? failureOrSuccess;
          emit(state.copyWith(
            isLoading: true,
            failureOrSuccessOption: none(),
          ));

          failureOrSuccess = await _mainFacade.getMyCalendarListApi();

          failureOrSuccess.fold(
            (l) => emit(state.copyWith(
              isLoading: false,
              showErrorMessages: true,
              failureOrSuccessOption: optionOf(failureOrSuccess),
            )),
            (r) {
              print("post--> $r");
              List<MyCalendarDTO> sortedMultiDates = List.from(r)
                ..sort((a, b) {
                  if (a.date != null && b.date != null) {
                    return a.date!.compareTo(b.date!);
                  } else {
                    return -1;
                  }
                });

              emit(state.copyWith(
                isLoading: false,
                showErrorMessages: false,
                multiDates: sortedMultiDates,
                calendarDates: sortedMultiDates,
                failureOrSuccessOption: optionOf(failureOrSuccess),
              ));
              List<DateTime> dateTimeList = state.multiDates.isNotEmpty
                  ? state.multiDates
                      .map((item) => CustomDateTimeFormat.timeStampToDateTime(
                            item.date ?? -1,
                          ))
                      .skip(1)
                      .toList()
                  : [];
              if (dateTimeList.isNotEmpty) {
                add(MyCalendarViewEvent.selectDateEvent(
                  e.context,
                  dateTimeList,
                ));
              }
            },
          );
        },
        selectDateEvent: (e) async {
          String? currentDateId;
          int? currentDate;

          Either<MainFailure, ContractorMyCalendarDTO>? failureOrSuccess;
          // if (e.selectedDateList.isNotEmpty) {
          if (e.selectedMonthFirstDate == null) {
            List<MyCalendarDTO> updatedDateTimeDTOList =
                List.from(state.multiDates);

            Set<DateTime> set2 = e.selectedDateList.toSet();

            List<MyCalendarDTO> result = updatedDateTimeDTOList.map((item) {
              bool isSelected = set2.contains(
                  CustomDateTimeFormat.timeStampToDateTime(item.date ?? -1));

              if (!isSelected) {
                currentDateId = item.employer_post_id;
                currentDate = item.date;

                return item.copyWith(
                  isUnAvailable: !item.isUnAvailable,
                  colorText: (!item.isUnAvailable == true)
                      ? "0xFFE1E8ED"
                      : "0xFF0FB62A",
                );
              } else {
                return item.copyWith(
                  isUnAvailable: false,
                  colorText: "0xFF0FB62A",
                );
              }
            }).toList();

            List<MyCalendarDTO> unAvailableDates =
                result.where((item) => item.isUnAvailable == true).toList();

            emit(
              state.copyWith(
                multiDates: result,
                unAvailableDates: unAvailableDates,
                isGetting: true,
              ),
            );

            print("mycalendar result---> $result");

            failureOrSuccess =
                await _mainFacade.getContractorMyCalendarDetailApi(
              (currentDateId != null)
                  ? currentDateId!
                  : (result.isNotEmpty)
                      ? "${result[0].employer_post_id ?? -1}"
                      : "-1",
              currentDate,
            );

            failureOrSuccess.fold(
              (l) {
                emit(state.copyWith(isGetting: false));
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
                emit(state.copyWith(
                  isGetting: false,
                  contractorDetail: r,
                ));
              },
            );
          } else {
            emit(state.copyWith(
              isGetting: false,
              contractorDetail: null,
            ));
          }
        },
        removeChatCount: (e) async {
          Either<MainFailure, ContractorMyCalendarDTO>? failureOrSuccess;
          failureOrSuccess = await _mainFacade.getContractorMyCalendarDetailApi(
            e.selectedId,
            e.selectedDate,
          );

          failureOrSuccess.fold(
            (l) {
              emit(state.copyWith(isGetting: false));
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
              emit(state.copyWith(
                isGetting: false,
                contractorDetail: r,
              ));
            },
          );
        },
      );
    });
  }
}
