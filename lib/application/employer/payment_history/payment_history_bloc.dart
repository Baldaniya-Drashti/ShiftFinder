import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:shift/domain/main/i_main_facade.dart';
import 'package:shift/infrastructure/core/payment_history_dto/payment_history_dto.dart';

part 'payment_history_event.dart';
part 'payment_history_state.dart';
part 'payment_history_bloc.freezed.dart';

@injectable
class PaymentHistoryBloc
    extends Bloc<PaymentHistoryEvent, PaymentHistoryState> {
  final IMainFacade mainFacade;

  int currentPage = 1;
  int lastPage = 1;

  final RefreshController refreshController = RefreshController();
  PaymentHistoryBloc(this.mainFacade) : super(PaymentHistoryState.initial()) {
    on<PaymentHistoryEvent>((event, emit) async {
      await event.map(
        getPaymentHistoryEvent: (e) async {
          if (e.isRefresh) {
            currentPage = 1;
            emit(state.copyWith(
              historyList: [],
              isLoading: e.isRefresh,
            ));
            refreshController.resetNoData();
          } else {
            if (currentPage > lastPage) {
              refreshController.loadNoData();
              return;
            }
          }
          var res = await mainFacade.getPaymentHistoryAPI(
            page: currentPage,
          );
          currentPage++;
          res.fold(
            (l) => emit(
              state.copyWith(
                isErrorInApi: true,
                isLoading: false,
                historyList: [],
              ),
            ),
            (r) {
              lastPage = r.meta?.lastPage ?? 1;
              if (e.isRefresh) {
                List.from(state.historyList).clear();
              }

              emit(
                state.copyWith(
                  isLoading: false,
                  isErrorInApi: false,
                  noDataFound: (r.data as List<dynamic>)
                      .map((e) => PaymentHistoryDTO.fromJson(e))
                      .toList()
                      .isEmpty,
                  historyList: List.from(state.historyList)
                    ..addAll((r.data as List<dynamic>)
                        .map((e) => PaymentHistoryDTO.fromJson(e))
                        .toList()),
                ),
              );
            },
          );
        },
      );
    });
  }
}
