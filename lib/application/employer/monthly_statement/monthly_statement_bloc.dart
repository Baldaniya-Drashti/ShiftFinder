import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:shift/domain/main/i_main_facade.dart';
import 'package:shift/domain/main/main_failure.dart';
import 'package:shift/infrastructure/core/monthly_statement_dto/monthly_statement_dto.dart';
import 'package:shift/infrastructure/core/payment_history_dto/payment_history_dto.dart';
import 'package:shift/presentation/billing/invoice_viewer.dart';
import 'package:shift/presentation/common/utils/flushbar_creator.dart';
import 'package:shift/presentation/common/utils/save_file_to_storage.dart';
part 'monthly_statement_event.dart';
part 'monthly_statement_state.dart';
part 'monthly_statement_bloc.freezed.dart';

@injectable
class MonthlyStatementBloc
    extends Bloc<MonthlyStatementEvent, MonthlyStatementState> {
  final IMainFacade mainFacade;

  MonthlyStatementBloc(this.mainFacade)
      : super(MonthlyStatementState.initial()) {
    on<MonthlyStatementEvent>((event, emit) async {
      await event.map(
        onDateSelected: (value) {
          emit(state.copyWith(selectedDateTime: value.dates));
          if (value.dates.isNotEmpty) {
            DateTime startDate = value.dates.first;
            DateTime endDate = value.dates.last;
            add(MonthlyStatementEvent.getMonthlyStatementListEvent(true,
                startDate: startDate, endDate: endDate));
          }
        },
        downloadMonthlyStatementEvent: (e) async {
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
            Navigator.push(
              e.context,
              MaterialPageRoute(
                builder: (context) => PdfViewerScreen(pdfPath: pdfPath),
              ),
            );
          } else {
            showError(message: "Failed to download PDF!").show(e.context);
          }
        },
        getMonthlyStatementListEvent: (e) async {
          Either<MainFailure, MonthlyStatementDTO>? failureOrSuccess;

          emit(state.copyWith(isLoading: true));

          failureOrSuccess = await mainFacade.getEmployerMonthlyStatementAPI(
            startDate: (e.startDate != null)
                ? e.startDate!.toUtc().millisecondsSinceEpoch / 1000
                : null,
            endDate: (e.endDate != null)
                ? e.endDate!.toUtc().millisecondsSinceEpoch / 1000
                : null,
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
