import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:shift/domain/main/i_main_facade.dart';
import 'package:shift/domain/main/main_failure.dart';
import 'package:shift/infrastructure/core/employer_invoice_dto/employer_invoice_dto.dart';
import 'package:shift/infrastructure/core/payment_history_dto/payment_history_dto.dart';

part 'employer_invoice_event.dart';
part 'employer_invoice_state.dart';
part 'employer_invoice_bloc.freezed.dart';

@injectable
class EmployerInvoiceBloc
    extends Bloc<EmployerInvoiceEvent, EmployerInvoiceState> {
  final IMainFacade mainFacade;

  int currentPage = 1;
  int lastPage = 1;

  final RefreshController refreshController = RefreshController();
  EmployerInvoiceBloc(this.mainFacade) : super(EmployerInvoiceState.initial()) {
    on<EmployerInvoiceEvent>((event, emit) async {
      await event.map(
        getEmployerInvoiceEvent: (e) async {
          if (e.isRefresh) {
            currentPage = 1;
            emit(state.copyWith(
              invoiceList: [],
              isLoading: e.isRefresh,
            ));
            refreshController.resetNoData();
          } else {
            if (currentPage > lastPage) {
              refreshController.loadNoData();
              return;
            }
          }
          var res = await mainFacade.getEmployerInvoiceAPI(
            page: currentPage,
          );
          currentPage++;
          res.fold(
            (l) => emit(
              state.copyWith(
                isErrorInApi: true,
                isLoading: false,
                invoiceList: [],
              ),
            ),
            (r) {
              lastPage = r.meta?.lastPage ?? 1;
              if (e.isRefresh) {
                List.from(state.invoiceList).clear();
              }

              emit(
                state.copyWith(
                  isLoading: false,
                  isErrorInApi: false,
                  noDataFound: (r.data as List<dynamic>)
                      .map((e) => PaymentHistoryDTO.fromJson(e))
                      .toList()
                      .isEmpty,
                  invoiceList: List.from(state.invoiceList)
                    ..addAll((r.data as List<dynamic>)
                        .map((e) => PaymentHistoryDTO.fromJson(e))
                        .toList()),
                ),
              );
            },
          );
        },
        getInvoiceDetailEvent: (e) async {
          Either<MainFailure, EmployerInvoiceDTO>? failureOrSuccess;

          emit(state.copyWith(isLoading: true));

          failureOrSuccess = await mainFacade.getInvoiceDetailAPI(id: e.id);

          failureOrSuccess.fold(
            (l) {
              emit(state.copyWith(isLoading: false));
            },
            (r) {
              emit(state.copyWith(
                isLoading: false,
                selectedInvoice: r,
              ));
            },
          );
        },
      );
    });
  }
}
