import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:shift/domain/main/i_main_facade.dart';
import 'package:shift/infrastructure/core/contractor_long_term_dashboard/contractor_long_term_dashboard_dto.dart';
import 'package:shift/infrastructure/core/employer_long_full_term_dashboard/employer_long_full_term_dashboard_dto.dart';
import 'package:shift/presentation/common/utils/flushbar_creator.dart';

part 'contractor_full_time_position_event.dart';

part 'contractor_full_time_position_state.dart';

part 'contractor_full_time_position_bloc.freezed.dart';

@injectable
class ContractorFullTimePositionBloc extends Bloc<ContractorFullTimePositionEvent, ContractorFullTimePositionState> {
  final IMainFacade _mainFacade;

  int currentPage = 1;
  int lastPage = 1;

  int appliedCurrentPage = 1;
  int appliedLastPage = 1;

  final RefreshController openRefreshController = RefreshController();
  final RefreshController appliedRefreshController = RefreshController();

  ContractorFullTimePositionBloc(this._mainFacade) : super(ContractorFullTimePositionState.initial()) {
    on<ContractorFullTimePositionEvent>((event, emit) async {
      await event.map(
        fetchOpenPositionList: (value) async {
          if (value.refresh) {
            currentPage = 1;
            emit(state.copyWith(openPositionList: [], isLoading: value.refresh));
            openRefreshController.resetNoData();
          } else {
            if (currentPage > lastPage) {
              openRefreshController.loadNoData();
              return;
            }
          }
          var res = await _mainFacade.contractorDashboardFullPost(
            page: currentPage,
            positionsType: 1,
          );
          currentPage++;
          print("-========>${res}");
          res.fold(
            (l) => emit(
              state.copyWith(
                isErrorInAPI: true,
                isLoading: false,
                openPositionList: [],
              ),
            ),
            (r) {
              lastPage = r.meta?.lastPage ?? 1;
              if (value.refresh) {
                List.from(state.openPositionList).clear();
              }
              return emit(
                state.copyWith(
                  isLoading: false,
                  isErrorInAPI: false,
                  isNoDataFound: (r.data as List<dynamic>).map((e) => ContractorLongTermDashboardDto.fromJson(e)).toList().isEmpty,
                  //  getProductList: []
                  openPositionList: List.from(state.openPositionList)
                    ..addAll(
                      (r.data as List<dynamic>).map((e) => ContractorLongTermDashboardDto.fromJson(e)).toList(),
                    ),
                ),
              );
            },
          );
        },
        fetchAppliedPositionList: (value) async {
          if (value.refresh) {
            appliedCurrentPage = 1;
            emit(state.copyWith(appliedPositionList: [], appliedLoading: value.refresh));
            appliedRefreshController.resetNoData();
          } else {
            if (appliedCurrentPage > appliedLastPage) {
              appliedRefreshController.loadNoData();
              return;
            }
          }
          var res = await _mainFacade.contractorDashboardFullPost(
            page: appliedCurrentPage,
            positionsType: 3,
          );
          appliedCurrentPage++;
          res.fold(
            (l) => emit(
              state.copyWith(
                appliedIsErrorInAPI: true,
                appliedLoading: false,
                appliedPositionList: [],
              ),
            ),
            (r) {
              appliedLastPage = r.meta?.lastPage ?? 1;
              if (value.refresh) {
                List.from(state.appliedPositionList).clear();
              }
              return emit(
                state.copyWith(
                  appliedLoading: false,
                  appliedIsErrorInAPI: false,
                  appliedNoDataFound: (r.data as List<dynamic>).map((e) => ContractorLongTermDashboardDto.fromJson(e)).toList().isEmpty,
                  //  getProductList: []
                  appliedPositionList: List.from(state.appliedPositionList)
                    ..addAll(
                      (r.data as List<dynamic>).map((e) => ContractorLongTermDashboardDto.fromJson(e)).toList(),
                    ),
                ),
              );
            },
          );
        },
        confirmRejectOffer: (ConfirmRejectOffer value) async {
          emit(state.copyWith(postDataLoading: true));
          final res = await _mainFacade.contractorLongFullConfirmAccpetence(
            id: value.id,
            urgent_action: value.urgent_action,
          );
          emit(state.copyWith(postDataLoading: false));

          res.fold(
            (l) {
              showError(
                message: l.maybeMap(
                  showAPIResponseMessage: (value) => value.message,
                  networkError: (value) => 'Please check your internet connectivity',
                  orElse: () => "Something went wrong!",
                ),
              ).show(value.context);
            },
            (r) {
              showSuccess(message: r.dioMessage ?? "").show(value.context);
              add(ContractorFullTimePositionEvent.fetchAppliedPositionList(refresh: true));
            },
          );
        },
        applyOpenPosition: (ApplyOpenPosition value) async {
          emit(state.copyWith(postDataLoading: true));
          final res = await _mainFacade.contractorApplyLongFullPost(
            id: value.id,
          );
          emit(state.copyWith(postDataLoading: false));

          res.fold(
            (l) {
              showError(
                message: l.maybeMap(
                  showAPIResponseMessage: (value) => value.message,
                  networkError: (value) => 'Please check your internet connectivity',
                  orElse: () => "Something went wrong!",
                ),
              ).show(value.context);
            },
            (r) {
              showSuccess(message: r.dioMessage ?? "").show(value.context);
              add(ContractorFullTimePositionEvent.fetchOpenPositionList(refresh: true));
            },
          );
        },
      );
    });
  }
}
