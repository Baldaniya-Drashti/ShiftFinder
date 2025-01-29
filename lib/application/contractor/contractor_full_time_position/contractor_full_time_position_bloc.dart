import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:shift/domain/main/i_main_facade.dart';
import 'package:shift/infrastructure/core/employer_long_full_term_dashboard/employer_long_full_term_dashboard_dto.dart';

part 'contractor_full_time_position_event.dart';

part 'contractor_full_time_position_state.dart';

part 'contractor_full_time_position_bloc.freezed.dart';

@injectable
class ContractorFullTimePositionBloc extends Bloc<ContractorFullTimePositionEvent, ContractorFullTimePositionState> {
  final IMainFacade _mainFacade;

  int currentPage = 1;
  int lastPage = 1;
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
                  isNoDataFound: (r.data as List<dynamic>).map((e) => EmployerLongFullTermDashboardDto.fromJson(e)).toList().isEmpty,
                  //  getProductList: []
                  openPositionList: List.from(state.openPositionList)
                    ..addAll(
                      (r.data as List<dynamic>).map((e) => EmployerLongFullTermDashboardDto.fromJson(e)).toList(),
                    ),
                ),
              );
            },
          );
        },
        fetchAppliedPositionList: (value) async {

          if (value.refresh) {
            currentPage = 1;
            emit(state.copyWith(appliedPositionList: [], isLoading: value.refresh));
            appliedRefreshController.resetNoData();
          } else {
            if (currentPage > lastPage) {
              appliedRefreshController.loadNoData();
              return;
            }
          }
          var res = await _mainFacade.contractorDashboardFullPost(
            page: currentPage,
            positionsType: 3,
          );
          currentPage++;
          res.fold(
                (l) => emit(
              state.copyWith(
                isErrorInAPI: true,
                isLoading: false,
                appliedPositionList: [],
              ),
            ),
                (r) {
              lastPage = r.meta?.lastPage ?? 1;
              if (value.refresh) {
                List.from(state.appliedPositionList).clear();
              }
              return emit(
                state.copyWith(
                  isLoading: false,
                  isErrorInAPI: false,
                  isNoDataFound: (r.data as List<dynamic>).map((e) => EmployerLongFullTermDashboardDto.fromJson(e)).toList().isEmpty,
                  //  getProductList: []
                  appliedPositionList: List.from(state.appliedPositionList)
                    ..addAll(
                      (r.data as List<dynamic>).map((e) => EmployerLongFullTermDashboardDto.fromJson(e)).toList(),
                    ),
                ),
              );
            },
          );
        },
      );
    });
  }
}
