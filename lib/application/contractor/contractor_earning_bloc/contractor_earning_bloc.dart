import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:shift/domain/main/i_main_facade.dart';
import 'package:shift/domain/main/main_failure.dart';
import 'package:shift/infrastructure/contractor_main/earning/earning_statement_dto/earning_statement_dto.dart';
import 'package:shift/infrastructure/core/monthly_statement_dto/monthly_statement_dto.dart';
import 'package:shift/infrastructure/core/network/common_response.dart';

part 'contractor_earning_event.dart';
part 'contractor_earning_state.dart';
part 'contractor_earning_bloc.freezed.dart';

@injectable
class ContractorEarningBloc
    extends Bloc<ContractorEarningEvent, ContractorEarningState> {
  final IMainFacade mainFacade;

  ContractorEarningBloc(this.mainFacade)
      : super(ContractorEarningState.initial()) {
    on<ContractorEarningEvent>((event, emit) async {
      await event.map(
        onDateSelected: (value) {
          emit(state.copyWith(selectedDateTime: value.dates));
          if (value.dates.isNotEmpty) {
            DateTime startDate = value.dates.first;
            DateTime endDate = value.dates.last;
            add(ContractorEarningEvent.getTotalEarningStatement(
                startDate: startDate, endDate: endDate));
          }
        },
        downloadContractorEarningEvent: (e) async {
          /* 
          final pdfData = await InvoiceGenerator().generateMonthlyStatement(
              e.statement,
              selectedDates: state.selectedDateTime);

          String? pdfPath =
              await SaveFileToStorage.savePdfToShiftFinderDirectory(pdfData,
                  fileName: 'Monthly_Statement.pdf');

          if (pdfPath != null) {
            print('PDF saved to: $pdfPath');
            showSuccess(message: "Monthly_Statement Downloaded..!")
                .show(e.context);
            /*  Navigator.push(
              e.context,
              MaterialPageRoute(
                builder: (context) => PdfViewerScreen(pdfPath: pdfPath),
              ),
            ); */
          } else {
            showError(message: "Failed to download PDF!").show(e.context);
          } */
        },
        getTotalEarningStatement: (e) async {
          Either<MainFailure, EarningStatementDTO>? failureOrSuccess;

          emit(state.copyWith(isLoading: true));

          failureOrSuccess = await mainFacade.totalEarningStatementAPI(
            startDate: (e.startDate != null)
                ? (e.startDate!.toUtc().millisecondsSinceEpoch / 1000)
                    .toString()
                : "",
            endDate: (e.endDate != null)
                ? (e.endDate!.toUtc().millisecondsSinceEpoch / 1000).toString()
                : "",
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
        },
      );
    });
  }
}
