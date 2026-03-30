import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:shift/domain/main/i_main_facade.dart';
import 'package:shift/infrastructure/core/employer_long_full_term_dashboard/employer_long_full_term_dashboard_dto.dart';
import 'package:shift/presentation/common/utils/flushbar_creator.dart';
import 'package:shift/presentation/common/utils/get_cookie.dart';
part 'employer_long_term_event.dart';
part 'employer_long_term_state.dart';
part 'employer_long_term_bloc.freezed.dart';

@injectable
class EmployerLongTermBloc
    extends Bloc<EmployerLongTermEvent, EmployerLongTermState> {
  final IMainFacade _iMainFacade;

  int currentPage = 1;
  int lastPage = 1;

  int fillPositionCurrentPage = 1;
  int fillPositionLastPage = 1;

  final RefreshController openPositionController = RefreshController();
  final RefreshController filledPositionController = RefreshController();

  EmployerLongTermBloc(this._iMainFacade)
      : super(EmployerLongTermState.initial()) {
    on<EmployerLongTermEvent>((event, emit) async {
      await event.map(
        changeTab: (e) async {
          final currentTab = getNotificationTab();
          print("selected TAB---> $currentTab");
          if (currentTab != null) {
            emit(state.copyWith(isLoading: true, selectedTab: currentTab));
            await Future.delayed(Duration(seconds: 1));
            if (currentTab == 0) {
              add(EmployerLongTermEvent.getEmployerLongTermOpenPosition(
                  context: e.context, refresh: true));
            } else {
              add(EmployerLongTermEvent.getEmployerFilledPosition(
                  context: e.context, refresh: true));
            }
            emit(state.copyWith(isLoading: false));
          } else {
            if (e.tabIndex == 0) {
              add(EmployerLongTermEvent.getEmployerLongTermOpenPosition(
                  context: e.context, refresh: true));
            } else {
              add(EmployerLongTermEvent.getEmployerFilledPosition(
                  context: e.context, refresh: true));
            }
            emit(state.copyWith(selectedTab: e.tabIndex));
          }
        },
        getEmployerFilledPosition: (value) async {
          if (value.refresh) {
            fillPositionCurrentPage = 1;
            emit(state.copyWith(
                filledPositionList: [], fillPositionLoading: value.refresh));
            filledPositionController.resetNoData();
          } else {
            if (fillPositionCurrentPage > fillPositionLastPage) {
              filledPositionController.loadNoData();
              return;
            }
          }
          final response = await _iMainFacade.employerLongTermDashboard(
            positionsType: 2,
            page: fillPositionCurrentPage,
          );
          fillPositionCurrentPage++;

          response.fold(
            (l) => emit(
              state.copyWith(
                  fillPositionErrorInAPI: true,
                  fillPositionLoading: false,
                  filledPositionList: []),
            ),
            (r) {
              lastPage = r.meta?.lastPage ?? 1;
              if (value.refresh) {
                List.from(state.filledPositionList).clear();
              }
              return emit(
                state.copyWith(
                  fillPositionLoading: false,
                  fillPositionErrorInAPI: false,
                  fillPositionNoDataFound: (r.data as List<dynamic>)
                      .map((e) => EmployerLongFullTermDashboardDto.fromJson(e))
                      .toList()
                      .isEmpty,
                  filledPositionList: List.from(state.filledPositionList)
                    ..addAll(
                      (r.data as List<dynamic>)
                          .map((e) =>
                              EmployerLongFullTermDashboardDto.fromJson(e))
                          .toList(),
                    ),
                ),
              );
            },
          );
        },
        getEmployerLongTermOpenPosition: (value) async {
          if (value.refresh) {
            currentPage = 1;
            emit(state.copyWith(
                openPositionList: [], openPostionLoading: value.refresh));
            openPositionController.resetNoData();
          } else {
            if (currentPage > lastPage) {
              openPositionController.loadNoData();
              return;
            }
          }
          final response = await _iMainFacade.employerLongTermDashboard(
              positionsType: 1, page: currentPage);
          currentPage++;

          response.fold(
            (l) => emit(
              state.copyWith(
                  isErrorInAPI: true,
                  openPostionLoading: false,
                  openPositionList: []),
            ),
            (r) {
              lastPage = r.meta?.lastPage ?? 1;
              if (value.refresh) {
                List.from(state.openPositionList).clear();
              }
              return emit(
                state.copyWith(
                  openPostionLoading: false,
                  isErrorInAPI: false,
                  isNoDataFound: (r.data as List<dynamic>)
                      .map((e) => EmployerLongFullTermDashboardDto.fromJson(e))
                      .toList()
                      .isEmpty,
                  openPositionList: List.from(state.openPositionList)
                    ..addAll(
                      (r.data as List<dynamic>)
                          .map((e) =>
                              EmployerLongFullTermDashboardDto.fromJson(e))
                          .toList(),
                    ),
                ),
              );
            },
          );
        },
        deletePost: (value) async {
          emit(state.copyWith(postDataLoading: true));
          final response = await _iMainFacade.deleteLongTermPost(
            id: value.id,
          );
          emit(state.copyWith(postDataLoading: false));

          response.fold(
            (l) {
              showError(
                message: l.maybeMap(
                  showAPIResponseMessage: (value) => value.message,
                  networkError: (value) =>
                      'Please check your internet connectivity',
                  orElse: () => "Server Error. Try again later.",
                ),
              ).show(value.context);
            },
            (r) {
              showSuccess(message: r.dioMessage ?? "").show(value.context);
              add(EmployerLongTermEvent.getEmployerLongTermOpenPosition(
                  context: value.context, refresh: true));
            },
          );
        },
      );
    });
  }
}
