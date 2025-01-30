import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:shift/domain/main/i_main_facade.dart';
import 'package:shift/infrastructure/core/contractor_long_term_dashboard/contractor_long_term_dashboard_dto.dart';
import 'package:shift/presentation/common/utils/flushbar_creator.dart';

part 'contractor_long_term_event.dart';

part 'contractor_long_term_state.dart';

part 'contractor_long_term_bloc.freezed.dart';

@injectable
class ContractorLongTermBloc extends Bloc<ContractorLongTermEvent, ContractorLongTermState> {
  final IMainFacade _mainFacade;

  int currentPage = 1;
  int lastPage = 1;

  int upcomingCurrentPage = 1;
  int upcomingLastPage = 1;

  int appliedCurrentPage = 1;
  int appliedLastPage = 1;

  final RefreshController openRefreshController = RefreshController();
  final RefreshController upcomingRefreshController = RefreshController();
  final RefreshController appliedRefreshController = RefreshController();

  ContractorLongTermBloc(this._mainFacade) : super(ContractorLongTermState.initial()) {
    on<ContractorLongTermEvent>((event, emit) async {
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
          var res = await _mainFacade.contractorDashboardLongPost(
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
                  isNoDataFound:
                      (r.data as List<dynamic>).map((e) => ContractorLongTermDashboardDto.fromJson(e)).toList().isEmpty,
                  openPositionList: List.from(state.openPositionList)
                    ..addAll(
                      (r.data as List<dynamic>).map((e) => ContractorLongTermDashboardDto.fromJson(e)).toList(),
                    ),
                ),
              );
            },
          );
        },
        fetchUpcomingPositionList: (value) async {
          if (value.refresh) {
            upcomingCurrentPage = 1;
            emit(state.copyWith(upComingPositionList: [], upcomingLoading: value.refresh));
            upcomingRefreshController.resetNoData();
          } else {
            if (upcomingCurrentPage > upcomingLastPage) {
              upcomingRefreshController.loadNoData();
              return;
            }
          }
          var res = await _mainFacade.contractorDashboardLongPost(
            page: currentPage,
            positionsType: 2,
          );
          currentPage++;
          res.fold(
            (l) => emit(
              state.copyWith(
                upcomingIsErrorInAPI: true,
                upcomingLoading: false,
                upComingPositionList: [],
              ),
            ),
            (r) {
              upcomingLastPage = r.meta?.lastPage ?? 1;
              if (value.refresh) {
                List.from(state.upComingPositionList).clear();
              }
              return emit(
                state.copyWith(
                  upcomingLoading: false,
                  upcomingIsErrorInAPI: false,
                  upcomingNoDataFound:
                      (r.data as List<dynamic>).map((e) => ContractorLongTermDashboardDto.fromJson(e)).toList().isEmpty,
                  //  getProductList: []
                  upComingPositionList: List.from(state.upComingPositionList)
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
          var res = await _mainFacade.contractorDashboardLongPost(
            page: currentPage,
            positionsType: 3,
          );
          currentPage++;
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
                  appliedNoDataFound:
                      (r.data as List<dynamic>).map((e) => ContractorLongTermDashboardDto.fromJson(e)).toList().isEmpty,
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
        applyOpenPosition: (ApplyOpenPosition value) async {
          emit(state.copyWith(postDataLoading: true));
          final res = await _mainFacade.contractorApplyLongFullPost(id: value.id);
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
              add(ContractorLongTermEvent.fetchOpenPositionList(refresh: true));
            },
          );
        },
      );
    });
  }
}
