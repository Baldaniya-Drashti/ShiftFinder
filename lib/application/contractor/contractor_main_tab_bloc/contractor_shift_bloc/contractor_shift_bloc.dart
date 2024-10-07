import 'package:auto_route/auto_route.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:shift/domain/auth/auth_value_objects.dart';
import 'package:shift/domain/main/i_main_facade.dart';
import 'package:shift/domain/main/main_failure.dart';
import 'package:shift/infrastructure/contractor_main/shift/current_shift_dto/current_shift_dto.dart';
import 'package:shift/infrastructure/contractor_main/shift/upcoming_shift_dto/upcoming_shift_dto.dart';
import 'package:shift/infrastructure/core/network/common_response.dart';
import 'package:shift/infrastructure/main/healthcare_post/healthcare_post_dto.dart';
import 'package:shift/presentation/common/utils/flushbar_creator.dart';
part 'contractor_shift_event.dart';
part 'contractor_shift_state.dart';
part 'contractor_shift_bloc.freezed.dart';

@injectable
class ContractorShiftBloc
    extends Bloc<ContractorShiftEvent, ContractorShiftState> {
  final IMainFacade mainFacade;

  int currentShiftPage = 1;
  int currentShiftLastPage = 1;
  int upcomingShiftPage = 1;
  int upcomingShiftLastPage = 1;

  final RefreshController currentShiftRefreshCtrl = RefreshController();
  final RefreshController upcomingShiftRefreshCtrl = RefreshController();

  ContractorShiftBloc(this.mainFacade) : super(ContractorShiftState.initial()) {
    on<ContractorShiftEvent>(
      (event, emit) async {
        await event.map(
          changeShiftTab: (e) async {
            print("Current Tab index---> ${e.tabIndex}");
            emit(state.copyWith(selectedTab: e.tabIndex));
          },
          appliedShiftChangeTab: (e) {
            emit(state.copyWith(selectedAppliedTab: e.tabIndex));
          },
          getCurrentShiftDetailAPI: (e) async {
            if (e.isRefresh) {
              currentShiftPage = 1;
              emit(state.copyWith(
                currentShiftList: [],
                isLoading: e.isRefresh,
              ));
              currentShiftRefreshCtrl.resetNoData();
            } else {
              if (currentShiftPage > currentShiftLastPage) {
                currentShiftRefreshCtrl.loadNoData();
                return;
              }
            }
            var res = await mainFacade.getContractorShifts(
                page: currentShiftPage, filterType: 1);
            currentShiftPage++;
            res.fold(
              (l) => emit(
                state.copyWith(
                  isErrorInAPI: true,
                  isLoading: false,
                  currentShiftList: [],
                ),
              ),
              (r) {
                currentShiftLastPage = r.meta?.lastPage ?? 1;
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
                emit(
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
              upcomingShiftPage = 1;
              emit(state.copyWith(
                upcomingShiftList: [],
                isUpcomingLoading: e.isRefresh,
              ));
              upcomingShiftRefreshCtrl.resetNoData();
            } else {
              if (upcomingShiftPage > upcomingShiftLastPage) {
                upcomingShiftRefreshCtrl.loadNoData();
                return;
              }
            }
            print("SELECTED TAB---> ${state.selectedTab}");
            var res = await mainFacade.getContractorShifts(
                page: upcomingShiftPage, filterType: 2);

            upcomingShiftPage++;
            res.fold(
              (l) => emit(
                state.copyWith(
                  isUpcomingErrorInAPI: true,
                  isUpcomingLoading: false,
                  upcomingShiftList: [],
                ),
              ),
              (r) {
                upcomingShiftLastPage = r.meta?.lastPage ?? 1;
                if (e.isRefresh) {
                  List.from(state.upcomingShiftList).clear();
                }

                return emit(
                  state.copyWith(
                    isUpcomingLoading: false,
                    isUpcomingErrorInAPI: false,
                    isUpcomingNoDataFound: (r.data as List<dynamic>)
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

            final clockInTimeStamp = convertToTimestamp(e.clockInTime);

            print("clockInTimeStamp----> $clockInTimeStamp");

            final updatedShift = shiftList[e.index].copyWith(
              selectedClockInTime: clockInTimeStamp,
            );

            shiftList[e.index] = updatedShift;
            emit(state.copyWith(currentShiftList: List.from(shiftList)));
          },
          setClockOut: (e) {
            final List<CurrentShiftDTO> shiftList =
                List.from(state.currentShiftList);

            final clockOutTimeStamp = convertToTimestamp(e.clockOutTime);

            print("clockOutTimeStamp----> $clockOutTimeStamp");

            final updatedShift = shiftList[e.index].copyWith(
              selectedClockOutTime: clockOutTimeStamp,
            );

            shiftList[e.index] = updatedShift;
            emit(state.copyWith(currentShiftList: List.from(shiftList)));
          },
          submitClockInOut: (e) async {
            Either<MainFailure, CommonResponse>? failureOrSuccess;

            failureOrSuccess = await mainFacade.submitContractorClockInClockOut(
                shiftId: e.postId, clockTime: e.clockInOutTime);

            failureOrSuccess.fold(
              (l) {
                e.context.router.maybePop();
                showError(
                  message: l.maybeMap(
                    showAPIResponseMessage: (value) => value.message,
                    networkError: (value) =>
                        'Please check your internet connectivity',
                    orElse: () => "Server Error. Try again later.",
                  ),
                ).show(e.context);
              },
              (r) {
                e.context.router.maybePop();
                showSuccess(message: r.dioMessage ?? "")
                    .show(e.context)
                    .then((value) {
                  add(ContractorShiftEvent.getCurrentShiftDetailAPI(true));
                });
              },
            );
          },
          deletePostReasonChanged: (e) {
            emit(
              state.copyWith(
                deletePostReason: InputEmptyOrNot(e.reason),
                showErrorMessages: false,
              ),
            );
          },
          deleteUpcomingShift: (e) async {
            Either<MainFailure, CommonResponse>? failureOrSuccess;

            if (state.deletePostReason.isValid()) {
              failureOrSuccess = await mainFacade.deleteUpcomingShiftApi(
                  id: e.postId, reason: "");

              failureOrSuccess.fold(
                (l) {
                  e.context.router.maybePop();
                  showError(
                    message: l.maybeMap(
                      showAPIResponseMessage: (value) => value.message,
                      networkError: (value) =>
                          'Please check your internet connectivity',
                      orElse: () => "Server Error. Try again later.",
                    ),
                  ).show(e.context);
                },
                (r) {
                  e.context.router.maybePop();
                  showSuccess(message: r.dioMessage ?? "")
                      .show(e.context)
                      .then((value) {
                    add(ContractorShiftEvent.getUpcomingShiftAPI(true));
                  });
                },
              );
            } else {
              emit(state.copyWith(showErrorMessages: true));
            }
          },
        );
      },
    );
  }

  int convertToTimestamp(TimeOfDay timeOfDay) {
    // Get the current date
    final now = DateTime.now();

    final dateTime = DateTime(
      now.year,
      now.month,
      now.day,
      timeOfDay.hour,
      timeOfDay.minute,
    );

    return dateTime.toUtc().millisecondsSinceEpoch ~/ 1000;
  }
}
