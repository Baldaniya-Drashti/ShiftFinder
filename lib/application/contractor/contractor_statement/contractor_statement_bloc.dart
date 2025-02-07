import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:shift/domain/main/i_main_facade.dart';
import 'package:shift/domain/main/main_failure.dart';
import 'package:shift/infrastructure/contractor_main/earning/statement_dto/statement_dto.dart';
import 'package:shift/presentation/contractor_earning/contractor_statement_view.dart';
import 'package:shift/presentation/core/common_lisitng/common_listing.dart';
part 'contractor_statement_event.dart';
part 'contractor_statement_state.dart';
part 'contractor_statement_bloc.freezed.dart';

@injectable
class ContractorStatementBloc
    extends Bloc<ContractorStatementEvent, ContractorStatementState> {
  final IMainFacade mainFacade;
  ContractorStatementBloc(this.mainFacade)
      : super(ContractorStatementState.initial()) {
    on<ContractorStatementEvent>(
      (event, emit) async {
        await event.map(
          getStatement: (e) async {
            String? startDate;
            String? endDate;
            if (state.selectedDates.isNotEmpty) {
              startDate =
                  (state.selectedDates.first.toUtc().millisecondsSinceEpoch /
                          1000)
                      .toString();
              endDate =
                  (state.selectedDates.last.toUtc().millisecondsSinceEpoch /
                          1000)
                      .toString();

              Either<MainFailure, StatementDTO>? failureOrSuccess;

              emit(state.copyWith(isLoading: true));

              failureOrSuccess = await mainFacade.statementAPI(
                statementFilter: state.currentStatementFilter.id,
                startDate: startDate,
                endDate: endDate,
              );

              failureOrSuccess.fold(
                (l) {
                  emit(state.copyWith(
                    isLoading: false,
                  ));
                },
                (r) {
                  emit(state.copyWith(
                    isLoading: false,
                    statement: r,
                  ));
                },
              );
            }
          },
          onFilterChanged: (value) {
            emit(state.copyWith(currentStatementFilter: value.value));
            add(ContractorStatementEvent.getStatement(value.context));
          },
          onSelectDateRange: (value) {
            emit(state.copyWith(selectedDates: value.value));

            if (value.value.isNotEmpty) {
              add(ContractorStatementEvent.getStatement(value.context));
            }
          },
        );
      },
    );
  }
}
