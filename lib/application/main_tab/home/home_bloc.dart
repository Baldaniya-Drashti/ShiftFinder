import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:shift/domain/main/i_main_facade.dart';
import 'package:shift/domain/main/main_failure.dart';
import 'package:shift/infrastructure/core/employer_home/employer_dashboard_dto.dart';

part 'home_state.dart';
part 'home_event.dart';
part 'home_bloc.freezed.dart';

@injectable
class HomeBloc extends Bloc<HomeEvent, HomeState> {
  int page = 1;
  int lastPage = 1;
  Timer? searchOnStoppedTyping;
  bool isFetching = false;
  final RefreshController refreshController = RefreshController();
  final IMainFacade mainFacade;
  HomeBloc(this.mainFacade) : super(HomeState.initial()) {
    on<HomeEvent>((event, emit) async {
      await event.map(
        initialEvent: (e) async {
          // emit(const HomeState.loadInProgress());
        },
        getEmployerDashboardList: (e) async {
          if (e.isRefresh) {
            page = 1;
            emit(state
                .copyWith(employerDashboardList: [], isLoading: e.isRefresh));
            refreshController.resetNoData();
          } else {
            if (page > lastPage) {
              refreshController.loadNoData();
              return;
            }
          }

          var res = await mainFacade.getEmployerDashboardListAPI(page: page);

          page++;

          res.fold(
            (l) => emit(
              state.copyWith(
                isErrorInAPI: true,
                isLoading: false,
                employerDashboardList: [],
              ),
            ),
            (r) {
              lastPage = r.meta?.lastPage ?? 1;
              if (e.isRefresh) {
                List.from(state.employerDashboardList).clear();
              }
              return emit(
                state.copyWith(
                  isLoading: false,
                  isErrorInAPI: false,
                  isNoDataFound: (r.data as List<dynamic>)
                      .map((e) => EmployerDashboardDTO.fromJson(e))
                      .toList()
                      .isEmpty,
                  //  getProductList: []
                  employerDashboardList: List.from(state.employerDashboardList)
                    ..addAll((r.data as List<dynamic>)
                        .map((e) => EmployerDashboardDTO.fromJson(e))
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
