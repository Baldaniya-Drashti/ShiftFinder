import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:shift/domain/main/i_main_facade.dart';
import 'package:shift/infrastructure/core/contractor_previus_shift_dto/contractor_previus_shift_dto.dart';
import 'package:shift/infrastructure/core/skill_list_model/skill_dto.dart';
part 'contractor_previous_shift_event.dart';
part 'contractor_previous_shift_state.dart';
part 'contractor_previous_shift_bloc.freezed.dart';

@injectable
class ContractorPreviousShiftBloc
    extends Bloc<ContractorPreviousShiftEvent, ContractorPreviousShiftState> {
  final IMainFacade mainFacade;

  int currentCompletedPage = 1;
  int lastCompletedPage = 1;

  int currentCancelledPage = 1;
  int lastCancelledPage = 1;

  final RefreshController completedShiftController = RefreshController();
  final RefreshController cancelledShiftController = RefreshController();

  ContractorPreviousShiftBloc(this.mainFacade)
      : super(ContractorPreviousShiftState.initial()) {
    on<ContractorPreviousShiftEvent>((event, emit) async {
      await event.map(
        onCancelTypeSorting: (value) {
          if (state.currentCancelFilter != value.currentSorting) {
            add(ContractorPreviousShiftEvent.getCancelledShift(
                isRefresh: true, sortBy: value.currentSorting.id ?? 1));
          }
          emit(state.copyWith(currentCancelFilter: value.currentSorting));
        },
        tabChange: (value) {
          emit(state.copyWith(currentIndex: value.index));
        },
        getCompletedList: (GetCompletedList e) async {
          if (e.isRefresh) {
            currentCompletedPage = 1;
            emit(state.copyWith(
              completedDataList: [],
              completedDataListLoading: e.isRefresh,
            ));
            completedShiftController.resetNoData();
          } else {
            if (currentCompletedPage > lastCompletedPage) {
              completedShiftController.loadNoData();
              return;
            }
          }
          var res = await mainFacade.getContractorPreviousShift(
            page: currentCompletedPage,
            type: 1,
            sortBy: null,
          );
          currentCompletedPage++;
          res.fold(
            (l) => emit(
              state.copyWith(
                completedDataListIsErrorApi: true,
                completedDataListLoading: false,
                completedDataList: [],
              ),
            ),
            (r) {
              lastCompletedPage = r.meta?.lastPage ?? 1;
              if (e.isRefresh) {
                List.from(state.completedDataList).clear();
              }

              emit(
                state.copyWith(
                  completedDataListLoading: false,
                  completedDataListIsErrorApi: false,
                  completedDataNoDataFound: (r.data as List<dynamic>)
                      .map((e) => ContractorPreviousShiftDTO.fromJson(e))
                      .toList()
                      .isEmpty,
                  completedDataList: List.from(state.completedDataList)
                    ..addAll((r.data as List<dynamic>)
                        .map((e) => ContractorPreviousShiftDTO.fromJson(e))
                        .toList()),
                ),
              );
            },
          );
        },
        getCancelledShift: (GetCancelledShift e) async {
          if (e.isRefresh) {
            currentCancelledPage = 1;
            emit(state.copyWith(
              cancelledDataList: [],
              cancelledDataListLoading: e.isRefresh,
            ));
            cancelledShiftController.resetNoData();
          } else {
            if (currentCancelledPage > lastCancelledPage) {
              cancelledShiftController.loadNoData();
              return;
            }
          }
          var res = await mainFacade.getContractorPreviousShift(
            page: currentCancelledPage,
            type: 2,
            sortBy: e.sortBy,
          );
          currentCancelledPage++;
          res.fold(
            (l) => emit(
              state.copyWith(
                cancelledDataIsErrorApi: true,
                cancelledDataListLoading: false,
                cancelledDataList: [],
              ),
            ),
            (r) {
              lastCancelledPage = r.meta?.lastPage ?? 1;
              if (e.isRefresh) {
                List.from(state.cancelledDataList).clear();
              }

              emit(
                state.copyWith(
                  cancelledDataListLoading: false,
                  cancelledDataIsErrorApi: false,
                  cancelledDataNoDataFound: (r.data as List<dynamic>)
                      .map((e) => ContractorPreviousShiftDTO.fromJson(e))
                      .toList()
                      .isEmpty,
                  cancelledDataList: List.from(state.cancelledDataList)
                    ..addAll((r.data as List<dynamic>)
                        .map((e) => ContractorPreviousShiftDTO.fromJson(e))
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
