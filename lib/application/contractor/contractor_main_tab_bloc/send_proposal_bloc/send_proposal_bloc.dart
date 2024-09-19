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
              DateTimeDTO(date: DateTime.now().toString()),
              DateTimeDTO(
                  date: DateTime.now().add(Duration(days: 1)).toString()),
              DateTimeDTO(
                  date: DateTime.now().add(Duration(days: 3)).toString()),
              DateTimeDTO(
                  date: DateTime.now().add(Duration(days: 5)).toString()),
              DateTimeDTO(
                  date: DateTime.now().add(Duration(days: 7)).toString()),
              DateTimeDTO(
                  date: DateTime.now().add(Duration(days: 8)).toString()),
            ];
            emit(state.copyWith(multiDates: selectedDateList));
          },
          setDateUnavailableEvent: (e) {
            List<DateTimeDTO> updatedDateTimeDTOList =
                List.from(state.multiDates);

            /*for (int i = 0; i < updatedDateTimeDTOList.length; i++) {
              final currentDate =
                  DateTime.parse(updatedDateTimeDTOList[i].date!);

              if (e.selectedDateList.any((selectedDate) =>
                  selectedDate.year == currentDate.year &&
                  selectedDate.month == currentDate.month &&
                  selectedDate.day == currentDate.day)) {
                updatedDateTimeDTOList[i] =
                    updatedDateTimeDTOList[i].copyWith(isUnAvailable: false);
                print("Current date ---> $currentDate");
              } else {
                updatedDateTimeDTOList[i] =
                    updatedDateTimeDTOList[i].copyWith(isUnAvailable: true);
                print("Else Current date ---> $currentDate");
              }
            }*/

            /*for (int i = 0; i < updatedDateTimeDTOList.length; i++) {
              for (var currentDate in e.selectedDateList) {
                if (DateTime.parse(updatedDateTimeDTOList[i].date!) !=
                    currentDate) {
                  updatedDateTimeDTOList[i] =
                      updatedDateTimeDTOList[i].copyWith(isUnAvailable: true);
                  print("Updated DTO---> $i");
                  print("Updated DTO E date---> $currentDate");
                  print(
                      "Updated DTO Date---> ${updatedDateTimeDTOList[i].date}");
                }
              }
            }*/

            /*for (int i = 0; i < updatedDateTimeDTOList.length; i++) {
              for (var currentDate in e.selectedDateList) {
                final dtoDate = DateTime.parse(updatedDateTimeDTOList[i].date!);

                if (dtoDate.year == currentDate.year &&
                    dtoDate.month == currentDate.month &&
                    dtoDate.day == currentDate.day) {
                  updatedDateTimeDTOList[i] =
                      updatedDateTimeDTOList[i].copyWith(isUnAvailable: false);

                  print(
                      "Updated DTO at index $i ---> ${updatedDateTimeDTOList[i]}");
                  print("Matched currentDate ---> $currentDate");
                } else {
                  updatedDateTimeDTOList[i] =
                      updatedDateTimeDTOList[i].copyWith(isUnAvailable: true);
                  print("Else part is called ---> $currentDate");
                }
              }
            }*/

            /*for (DateTime selectedDate in e.selectedDateList) {
              DateTimeDTO? dto = updatedDateTimeDTOList.firstWhere(
                (dto) =>
                    dto.date != null &&
                    DateTime.parse(dto.date!) == selectedDate,
                orElse: () => DateTimeDTO(),
              );

              if (dto.date != null) {
                int index = updatedDateTimeDTOList.indexOf(dto);
                updatedDateTimeDTOList[index] =
                    dto.copyWith(isUnAvailable: true);
              }
            }*/
            print(
                "updatedDateTimeDTOList---> ${jsonEncode(updatedDateTimeDTOList)}");
            emit(state.copyWith(multiDates: updatedDateTimeDTOList));
          },
        );
      },
    );
  }
}
