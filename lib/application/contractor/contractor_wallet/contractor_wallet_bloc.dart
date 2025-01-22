import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:shift/domain/main/i_main_facade.dart';
import 'package:shift/domain/main/main_failure.dart';
import 'package:shift/infrastructure/contractor_main/earning/contractor_wallet_dto/contractor_wallet_dto.dart';
import 'package:shift/infrastructure/contractor_main/earning/get_balance_dto/get_balance_dto.dart';
import 'package:shift/presentation/contractor_earning/contractor_wallet_view.dart';
import 'package:shift/presentation/core/common_lisitng/common_listing.dart';

part 'contractor_wallet_event.dart';

part 'contractor_wallet_state.dart';

part 'contractor_wallet_bloc.freezed.dart';

// @injectable
// class ContractorWalletBloc
//     extends Bloc<ContractorWalletEvent, ContractorWalletState> {
//   ContractorWalletBloc() : super(const ContractorWalletState()) {
//     on<OnFilterChanged>(_onFilterChanged);
//   }
// }

@injectable
class ContractorWalletBloc
    extends Bloc<ContractorWalletEvent, ContractorWalletState> {
  final IMainFacade mainFacade;

  int currentPage = 1;
  int lastPage = 1;

  final RefreshController refreshController = RefreshController();
  ContractorWalletBloc(this.mainFacade)
      : super(ContractorWalletState.initial()) {
    on<ContractorWalletEvent>((event, emit) async {
      await event.map(
        getWalletList: (e) async {
          String? startDate;
          String? endDate;
          DateTime now = DateTime.now();
          if (state.selectedDateTime.isNotEmpty) {
            startDate =
                (state.selectedDateTime.first.toUtc().millisecondsSinceEpoch /
                        1000)
                    .toString();
            endDate =
                (state.selectedDateTime.last.toUtc().millisecondsSinceEpoch /
                        1000)
                    .toString();
          } else {
            startDate = (DateTime(now.year, now.month, 1)
                        .toUtc()
                        .millisecondsSinceEpoch /
                    1000)
                .toString();
            endDate = (now.toUtc().millisecondsSinceEpoch / 1000).toString();
          }

          if (e.isRefresh) {
            currentPage = 1;
            emit(state.copyWith(
              walletList: [],
              isLoading: e.isRefresh,
            ));
            refreshController.resetNoData();
          } else {
            if (currentPage > lastPage) {
              refreshController.loadNoData();
              return;
            }
          }

          var res = await mainFacade.getWalletListAPI(
            page: currentPage,
            filterType: state.initialWalletFilter.id,
            startDate: startDate.toString(),
            endDate: endDate.toString(),
          );
          currentPage++;
          res.fold(
            (l) => emit(
              state.copyWith(
                isErrorInApi: true,
                isLoading: false,
                walletList: [],
              ),
            ),
            (r) {
              lastPage = r.meta?.lastPage ?? 1;
              if (e.isRefresh) {
                List.from(state.walletList).clear();
              }

              emit(
                state.copyWith(
                  isLoading: false,
                  isErrorInApi: false,
                  noDataFound: (r.data as List<dynamic>)
                      .map((e) => ContractorWalletDTO.fromJson(e))
                      .toList()
                      .isEmpty,
                  walletList: List.from(state.walletList)
                    ..addAll((r.data as List<dynamic>)
                        .map((e) => ContractorWalletDTO.fromJson(e))
                        .toList()),
                ),
              );
            },
          );
        },
        getAvailableBalance: (e) async {
          Either<MainFailure, GetBalanceDTO>? failureOrSuccess;

          emit(state.copyWith(isLoading: true));

          failureOrSuccess = await mainFacade.getAvailableBalanceApi();

          failureOrSuccess.fold(
            (l) {
              emit(state.copyWith(isLoading: false));
            },
            (r) {
              emit(state.copyWith(
                isLoading: false,
                currentBalance: r,
                // selectedInvoice: r,
              ));
            },
          );
        },
        onFilterChanged: (e) {
          emit(state.copyWith(initialWalletFilter: e.value));
          add(ContractorWalletEvent.getWalletList(true, e.context));
        },
        onDateSelected: (value) {
          emit(state.copyWith(selectedDateTime: value.dates));
          if (value.dates.isNotEmpty) {
            // DateTime startDate = value.dates.first;
            // DateTime endDate = value.dates.last;
            add(ContractorWalletEvent.getWalletList(true, value.context));
          }
        },
      );
    });
  }
}
