import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:shift/domain/main/i_main_facade.dart';
import 'package:shift/domain/main/main_failure.dart';
import 'package:shift/infrastructure/contractor_main/shift/current_shift_dto/current_shift_dto.dart';
import 'package:shift/infrastructure/contractor_main/shift/upcoming_shift_dto/upcoming_shift_dto.dart';
import 'package:shift/infrastructure/main/healthcare_post/healthcare_post_dto.dart';
part 'contractor_shift_event.dart';
part 'contractor_shift_state.dart';
part 'contractor_shift_bloc.freezed.dart';

@injectable
class ContractorShiftBloc
    extends Bloc<ContractorShiftEvent, ContractorShiftState> {
  final IMainFacade mainFacade;
  int page = 1;
  int lastPage = 1;

  final RefreshController refreshController = RefreshController();

  ContractorShiftBloc(this.mainFacade) : super(ContractorShiftState.initial()) {
    on<ContractorShiftEvent>(
      (event, emit) async {
        await event.map(
          changeShiftTab: (e) async {
            print("Current Tab index---> ${e.tabIndex}");
            emit(state.copyWith(selectedTab: e.tabIndex));
          },
          getCurrentShiftDetailAPI: (e) async {
            if (e.isRefresh) {
              page = 1;
              emit(state.copyWith(
                currentShiftList: [],
                isLoading: e.isRefresh,
              ));
              refreshController.resetNoData();
            } else {
              if (page > lastPage) {
                refreshController.loadNoData();
                return;
              }
            }
            var res = await mainFacade.getContractorShifts(
                page: page, filterType: state.selectedTab);
            page++;
            res.fold(
              (l) => emit(
                state.copyWith(
                  isErrorInAPI: true,
                  isLoading: false,
                  currentShiftList: [],
                ),
              ),
              (r) {
                lastPage = r.meta?.lastPage ?? 1;
                if (e.isRefresh) {
                  List.from(state.currentShiftList).clear();
                }

                /*final dummyList = [
                  CurrentShiftDTO(
                    selectedClockInTime: "10:10 AM",
                    selectedClockOutTime: "10",
                  ),
                  CurrentShiftDTO(
                    selectedClockInTime: "1",
                    selectedClockOutTime: "10",
                  ),
                ];*/
                return emit(
                  state.copyWith(
                    isLoading: false,
                    isErrorInAPI: false,
                    isNoDataFound: (r.data as List<dynamic>)
                        .map((e) => CurrentShiftDTO.fromJson(e))
                        .toList()
                        .isEmpty,
                    currentShiftList: List.from(state.currentShiftList)
                      ..addAll((r.data as List<dynamic>)
                          .map((e) => CurrentShiftDTO.fromJson(e))
                          .toList()),
                    // currentShiftList: dummyList,
                  ),
                );
              },
            );
          },
          getUpcomingShiftAPI: (e) async {
            if (e.isRefresh) {
              page = 1;
              emit(state.copyWith(
                upcomingShiftList: [],
                isLoading: e.isRefresh,
              ));
              refreshController.resetNoData();
            } else {
              if (page > lastPage) {
                refreshController.loadNoData();
                return;
              }
            }
            print("SELECTED TAB---> ${state.selectedTab}");
            var res = await mainFacade.getContractorShifts(
                page: page, filterType: state.selectedTab);

            page++;
            res.fold(
              (l) => emit(
                state.copyWith(
                  isErrorInAPI: true,
                  isLoading: false,
                  upcomingShiftList: [],
                ),
              ),
              (r) {
                lastPage = r.meta?.lastPage ?? 1;
                if (e.isRefresh) {
                  List.from(state.upcomingShiftList).clear();
                }

                return emit(
                  state.copyWith(
                    isLoading: false,
                    isErrorInAPI: false,
                    isNoDataFound: (r.data as List<dynamic>)
                        .map((e) => UpComingShiftDTO.fromJson(e))
                        .toList()
                        .isEmpty,
                    upcomingShiftList: List.from(state.upcomingShiftList)
                      ..addAll((r.data as List<dynamic>)
                          .map((e) => UpComingShiftDTO.fromJson(e))
                          .toList()),
                  ),
                );
              },
            );
          },
          setClockIn: (e) {
            final List<CurrentShiftDTO> shiftList =
                List.from(state.currentShiftList);
            final updatedShift = shiftList[e.index].copyWith(
              selectedClockInTime: e.clockInTime,
            );
            shiftList[e.index] = updatedShift;

            emit(state.copyWith(currentShiftList: List.from(shiftList)));
          },
          submitClockInOut: (e) {},
        );
      },
    );
  }
}
