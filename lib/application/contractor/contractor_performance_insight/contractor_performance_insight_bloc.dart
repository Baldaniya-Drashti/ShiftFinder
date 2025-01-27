import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:shift/domain/main/i_main_facade.dart';
import 'package:shift/domain/main/main_failure.dart';
import 'package:shift/infrastructure/contractor_main/profile/performance_insight_dto/performance_insight_dto.dart';
import 'package:shift/infrastructure/core/network/common_response.dart';
import 'package:shift/presentation/common/utils/flushbar_creator.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

part 'contractor_performance_insight_event.dart';

part 'contractor_performance_insight_state.dart';

part 'contractor_performance_insight_bloc.freezed.dart';

@injectable
class ContractorPerformanceInsightBloc extends Bloc<
    ContractorPerformanceInsightEvent, ContractorPerformanceInsightState> {
  final IMainFacade _mainFacade;
  ContractorPerformanceInsightBloc(this._mainFacade)
      : super(ContractorPerformanceInsightState.initial()) {
    on<ContractorPerformanceInsightEvent>((event, emit) async {
      await event.map(
        onPointSelect: (e) {
          emit(
            state.copyWith(
              selectedEarningPoint: e.selectedPoint,
            ),
          );
        },
        onDateSelected: (e) async {
          if (e.selectedDate != null && e.selectedDate != state.selectedMonth) {
            Either<MainFailure, PerformanceInsightDTO>? failureOrSuccess;

            emit(state.copyWith(
              isLoading: true,
              failureOrSuccessOption: none(),
            ));

            failureOrSuccess = await _mainFacade.getPerformanceInsightListAPI(
              date: (e.selectedDate!.toUtc().millisecondsSinceEpoch / 1000),
            );
            failureOrSuccess.fold(
              (l) {
                showError(
                  message: l.maybeMap(
                    showAPIResponseMessage: (value) => value.message,
                    networkError: (value) =>
                        'Please check your internet connectivity',
                    orElse: () => "Server Error. Try again later.",
                  ),
                ).show(e.context);
                emit(state.copyWith(
                  isLoading: false,
                  showErrorMessages: true,
                  failureOrSuccessOption: none(),
                ));
              },
              (r) {
                print("Performance insight data --> $r");

                emit(state.copyWith(
                  isLoading: false,
                  showErrorMessages: false,
                  failureOrSuccessOption: optionOf(failureOrSuccess),
                  insightDetail: r,
                ));
              },
            );

            emit(state.copyWith(
              // selectedDateTime: e.dates,
              selectedMonth: e.selectedDate,
            ));
          }
        },
      );
    });
  }
}
