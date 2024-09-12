import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:shift/domain/main/i_main_facade.dart';
import 'package:shift/domain/main/main_failure.dart';
import 'package:shift/infrastructure/core/employer_home/employer_dashboard_dto.dart';

part 'contractor_home_state.dart';
part 'contractor_home_event.dart';
part 'contractor_home_bloc.freezed.dart';

@injectable
class ContractorHomeBloc
    extends Bloc<ContractorHomeEvent, ContractorHomeState> {
  int page = 1;
  int lastPage = 1;
  Timer? searchOnStoppedTyping;
  bool isFetching = false;
  final RefreshController refreshController = RefreshController();
  final IMainFacade mainFacade;
  ContractorHomeBloc(this.mainFacade) : super(ContractorHomeState.initial()) {
    on<ContractorHomeEvent>((event, emit) async {
      await event.map(
        deletePost: (e) async {
          final res = await mainFacade.deletePostApi(postId: e.postId);
          res.fold(
            (l) => emit(
              state.copyWith(
                isErrorInAPI: true,
                isLoading: false,
              ),
            ),
            (r) {
              emit(
                state.copyWith(
                  isLoading: false,
                  isErrorInAPI: false,
                ),
              );
              add(ContractorHomeEvent.getContractorDashboardList(true));
            },
          );
        },
        initialEvent: (e) async {},
        getContractorDashboardList: (e) async {
          print("Api called after delete--->");
          if (e.isRefresh) {
            page = 1;
            emit(state
                .copyWith(contractorDashboardList: [], isLoading: e.isRefresh));
            refreshController.resetNoData();
          } else {
            if (page > lastPage) {
              refreshController.loadNoData();
              return;
            }
          }

          var res = await mainFacade.getContractorDashboardListAPI(page: page);

          page++;

          res.fold(
            (l) => emit(
              state.copyWith(
                isErrorInAPI: true,
                isLoading: false,
                contractorDashboardList: [],
              ),
            ),
            (r) {
              lastPage = r.meta?.lastPage ?? 1;
              if (e.isRefresh) {
                List.from(state.contractorDashboardList).clear();
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
                  contractorDashboardList:
                      List.from(state.contractorDashboardList)
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
