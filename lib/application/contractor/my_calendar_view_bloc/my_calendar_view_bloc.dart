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
              emit(state.copyWith(
                isLoading: false,
                showErrorMessages: false,
                multiDates: r,
                failureOrSuccessOption: optionOf(failureOrSuccess),
              ));
              List<DateTime> dateTimeList = state.multiDates
                  .map((item) => DateTime.fromMillisecondsSinceEpoch(
                      (item.date ?? -1) * 1000))
                  .skip(1)
                  .toList();
              add(MyCalendarViewEvent.selectDateEvent(
                e.context,
                dateTimeList,
              ));
            },
          );
        },
        /*selectDateEvent: (e) {
          List<MyCalendarDTO> updatedDateTimeDTOList =
              List.from(state.multiDates);
          print("updatedDateTimeDTOList----> $updatedDateTimeDTOList");

          Set<DateTime> set2 = e.selectedDateList.toSet();

          List<MyCalendarDTO> result = updatedDateTimeDTOList.where((item) {
            return !set2.contains(
                DateTime.fromMillisecondsSinceEpoch((item.date ?? -1) * 1000));
          }).toList();

          final index = updatedDateTimeDTOList
              .indexWhere((item) => item.date == result[0].date);

          updatedDateTimeDTOList[index] =
              updatedDateTimeDTOList[index].copyWith(
            isUnAvailable: !updatedDateTimeDTOList[index].isUnAvailable,
            colorText: (!(updatedDateTimeDTOList[index].isUnAvailable) == true)
                ? "0xFFE1E8ED"
                : "0xFF0FB62A",
          );

          List<MyCalendarDTO> unAvailableDates = updatedDateTimeDTOList
              .where((item) => item.isUnAvailable == true)
              .toList();

          emit(
            state.copyWith(
              multiDates: updatedDateTimeDTOList,
              unAvailableDates: unAvailableDates,
            ),
          );
        },*/

        selectDateEvent: (e) async {
          int? currentDateId;
          Either<MainFailure, ContractorMyCalendarDTO>? failureOrSuccess;

          List<MyCalendarDTO> updatedDateTimeDTOList =
              List.from(state.multiDates);

          Set<DateTime> set2 = e.selectedDateList.toSet();

          List<MyCalendarDTO> result = updatedDateTimeDTOList.map((item) {
            bool isSelected = set2.contains(
                DateTime.fromMillisecondsSinceEpoch((item.date ?? -1) * 1000));

            if (!isSelected) {
              currentDateId = item.employer_post_id;
              return item.copyWith(
                isUnAvailable: !item.isUnAvailable,
                colorText:
                    (!item.isUnAvailable == true) ? "0xFFE1E8ED" : "0xFF0FB62A",
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

          failureOrSuccess = await _mainFacade.getContractorMyCalendarDetailApi(
              currentDateId ?? result[0].employer_post_id ?? -1);

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
        },
      );
    });
  }
}
