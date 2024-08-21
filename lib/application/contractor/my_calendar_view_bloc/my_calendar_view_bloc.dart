import 'package:dartz/dartz.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:shift/domain/main/i_main_facade.dart';
import 'package:shift/domain/main/main_failure.dart';
import 'package:shift/infrastructure/contractor_main/profile/my_calendar_dto/my_calendar_dto.dart';
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
                      .map((item) => DateTime.fromMillisecondsSinceEpoch(
                          (item.date ?? -1) * 1000))
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

        /// Formatted code
        /* getMyCalendarList: (e) async {
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

              print("sorted Multidatess--> $sortedMultiDates");

              emit(state.copyWith(
                isLoading: false,
                showErrorMessages: false,
                multiDates: sortedMultiDates,
                failureOrSuccessOption: optionOf(failureOrSuccess),
              ));
              List<DateTime> dateTimeList = state.multiDates.isNotEmpty
                  ? (state.multiDates.length > 1)
                      ? state.multiDates
                          .map((item) => DateTime.fromMillisecondsSinceEpoch(
                              (item.date ?? -1) * 1000))
                          .skip(1)
                          .toList()
                      : state.multiDates
                          .map((item) => DateTime.fromMillisecondsSinceEpoch(
                              (item.date ?? -1) * 1000))
                          .toList()
                  : [];

              print("DateTime Listttt--> ${dateTimeList}");
              if (dateTimeList.isNotEmpty) {
                add(MyCalendarViewEvent.selectDateEvent(
                  e.context,
                  dateTimeList,
                ));
              }
            },
          );
        },
         */

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
                  DateTime.fromMillisecondsSinceEpoch(
                      (item.date ?? -1) * 1000));

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
        /* selectDateEvent: (e) async {
          String? currentDateId;
          int? currentDate;

          Either<MainFailure, ContractorMyCalendarDTO>? failureOrSuccess;

          DateTime? selectedMonthFirstDate =
              e.selectedMonthFirstDate ?? DateTime.now();

          // Ensure `selectedMonthFirstDate` is not null
          // if (selectedMonthFirstDate != null) {
          int selectedMonth = selectedMonthFirstDate.month;
          int selectedYear = selectedMonthFirstDate.year;

          // Get the updated list of dates
          List<MyCalendarDTO> updatedDateTimeDTOList =
              List.from(state.calendarDates);

          // Filter dates that match the selected month and year
          List<MyCalendarDTO> datesInMonth = updatedDateTimeDTOList;
          // if (e.selectedMonthFirstDate != null) {
          datesInMonth = updatedDateTimeDTOList.where((item) {
            DateTime date =
                DateTime.fromMillisecondsSinceEpoch((item.date ?? -1) * 1000);
            return date.month == selectedMonth && date.year == selectedYear;
          }).toList();
          // }

          print("selectedMonth----> $selectedMonth");
          print("selectedYear----> $selectedYear");

          if (datesInMonth.isNotEmpty) {
            // Sort dates in ascending order
            datesInMonth.sort((a, b) {
              DateTime dateA =
                  DateTime.fromMillisecondsSinceEpoch((a.date ?? -1) * 1000);
              DateTime dateB =
                  DateTime.fromMillisecondsSinceEpoch((b.date ?? -1) * 1000);
              return dateA.compareTo(dateB);
            });

            // Select the first date
            // currentDateId = updatedDateTimeDTOList.first.employer_post_id;
            // currentDate = updatedDateTimeDTOList.first.date;

            // Update the availability of dates in the result
            Set<DateTime> set2 = e.selectedDateList.toSet();

            List<MyCalendarDTO> result = datesInMonth.map((item) {
              bool isSelected = set2.contains(
                  DateTime.fromMillisecondsSinceEpoch(
                      (item.date ?? -1) * 1000));

              if (!isSelected) {
                if (e.selectedMonthFirstDate != null) {
                  currentDateId = updatedDateTimeDTOList.first.employer_post_id;
                  currentDate = updatedDateTimeDTOList.first.date;

                  if (updatedDateTimeDTOList.isNotEmpty &&
                      updatedDateTimeDTOList.indexOf(item) == 0) {
                    MyCalendarDTO firstItem = item.copyWith(
                      isUnAvailable: true,
                      colorText: "0xFFE1E8ED",
                    );
                    return firstItem;
                  } else {
                    return item.copyWith(
                      isUnAvailable: false,
                      colorText: "0xFF0FB62A",
                    );
                  }
                } else {
                  currentDateId = item.employer_post_id;
                  currentDate = item.date;
                  return item.copyWith(
                    isUnAvailable: !item.isUnAvailable,
                    colorText:
                        (!item.isUnAvailable) ? "0xFFE1E8ED" : "0xFF0FB62A",
                  );
                }
              } else {
                return item.copyWith(
                  isUnAvailable: false,
                  colorText: "0xFF0FB62A",
                );
              }
            }).toList();

            // Filter unavailable dates
            List<MyCalendarDTO> unAvailableDates =
                result.where((item) => item.isUnAvailable == true).toList();

            print("Result---> $result");
            emit(
              state.copyWith(
                multiDates: result,
                unAvailableDates: unAvailableDates,
                isGetting: true,
              ),
            );

            print("mycalendar result ---> $result");

            // Call the API
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
                print("post ---> $r");
                emit(state.copyWith(
                  isGetting: false,
                  contractorDetail: r,
                ));
              },
            );
          } else {
            // No dates exist in the selected month
            currentDateId = null;
            currentDate = null;

            print("No dates found for the selected month.");

            emit(state.copyWith(
              isGetting: false,
              contractorDetail: null,
            ));
          }
          // } else {
          //   // If `selectedMonthFirstDate` is null
          //   emit(state.copyWith(
          //     isGetting: false,
          //     contractorDetail: null,
          //   ));
          // }
        },
 */
        /// Formatted code
        /* selectDateEvent: (e) async {
          String? currentDateId;
          int? currentDate;

          Either<MainFailure, ContractorMyCalendarDTO>? failureOrSuccess;
          List<MyCalendarDTO> updatedDateTimeDTOList =
              List.from(state.multiDates);

          DateTime? firstDateInSelectedMonth = e.selectedMonthFirstDate;
          // Extract the month and year of the selected month
          int? selectedMonth = firstDateInSelectedMonth?.month;
          int? selectedYear = firstDateInSelectedMonth?.year;

          List<MyCalendarDTO> datesInMonth =
              updatedDateTimeDTOList.where((item) {
            DateTime date =
                DateTime.fromMillisecondsSinceEpoch((item.date ?? -1) * 1000);
            if (selectedMonth != null && selectedYear != null) {
              return date.month == selectedMonth && date.year == selectedYear;
            }
            return true;
          }).toList();
          datesInMonth.sort((a, b) {
            DateTime dateA =
                DateTime.fromMillisecondsSinceEpoch((a.date ?? -1) * 1000);
            DateTime dateB =
                DateTime.fromMillisecondsSinceEpoch((b.date ?? -1) * 1000);
            return dateA.compareTo(dateB);
          });
          bool hasDateInMonth = datesInMonth.isNotEmpty;

          // Check if any date exists in the same month
          /*  bool? hasDateInMonth = datesInMonth.any((item) {
            DateTime date =
                DateTime.fromMillisecondsSinceEpoch((item.date ?? -1) * 1000);
            if (selectedMonth != null && selectedYear != null) {
              return date.month == selectedMonth && date.year == selectedYear;
            }
            return true;
          }); */
          print("hasDateInMonth-----> $hasDateInMonth");

          // if (e.selectedDateList.isNotEmpty) {
          if (hasDateInMonth) {
            Set<DateTime> set2 = e.selectedDateList.toSet();

            List<MyCalendarDTO> result = updatedDateTimeDTOList.map((item) {
              bool isSelected = set2.contains(
                  DateTime.fromMillisecondsSinceEpoch(
                      (item.date ?? -1) * 1000));

              print("isSelected-----> $isSelected");

              if (updatedDateTimeDTOList.length == 1 || !isSelected) {
                currentDateId = item.employer_post_id;
                currentDate = item.date;
                print("currentDateId---> $currentDateId");
                print("currentDate---> $currentDate");

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

            print("mycalendar result---> $currentDateId");

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
                print("post--> $r");
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
        }, */
      );
    });
  }
}
