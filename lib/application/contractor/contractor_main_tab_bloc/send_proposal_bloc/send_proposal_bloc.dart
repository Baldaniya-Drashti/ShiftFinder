import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:shift/infrastructure/main/date_time_dto/date_time_dto.dart';

part 'send_proposal_event.dart';
part 'send_proposal_state.dart';
part 'send_proposal_bloc.freezed.dart';

@injectable
class SendProposalBloc extends Bloc<SendProposalEvent, SendProposalState> {
  SendProposalBloc() : super(SendProposalState.initial()) {
    on<SendProposalEvent>(
      (event, emit) async {
        await event.map(
          tabChangeEvent: (value) async {
            emit(state.copyWith(selectedTab: value.tabIndex));
          },
          getMultiDateEvent: (e) {
            List<DateTimeDTO> selectedDateList = [
              DateTimeDTO(date: DateTime.now().toString(), isUnAvailable: true),
              DateTimeDTO(
                  date: DateTime.now().add(Duration(days: 1)).toString(),
                  isUnAvailable: false),
              DateTimeDTO(
                  date: DateTime.now().add(Duration(days: 3)).toString(),
                  isUnAvailable: false),
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
        );
      },
    );
  }
}
