import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:shift/domain/core/string_constant.dart';
import 'package:shift/infrastructure/core/skill_list_model/skill_dto.dart';

part 'contractor_previous_shift_event.dart';

part 'contractor_previous_shift_state.dart';

part 'contractor_previous_shift_bloc.freezed.dart';

@injectable
class ContractorPreviousShiftBloc extends Bloc<ContractorPreviousShiftEvent, ContractorPreviousShiftState> {
  int currentPage = 1;
  int lastPage = 1;

  final RefreshController previousShiftController = RefreshController();
  final RefreshController cancelledShiftController = RefreshController();

  ContractorPreviousShiftBloc() : super(const ContractorPreviousShiftState()) {
    on<ContractorPreviousShiftEvent>((event, emit) {
      event.map(
        onCancelTypeSorting: (value) {
          emit(state.copyWith(currentCancelFilter: value.currentSorting));
        },
        tabChange: (value) {
          emit(state.copyWith(currentIndex: value.index));
        },
        getCompletedList: (GetCompletedList value) {

        },
        getCancelledShift: (GetCancelledShift value) {},
      );
    });
  }
}
