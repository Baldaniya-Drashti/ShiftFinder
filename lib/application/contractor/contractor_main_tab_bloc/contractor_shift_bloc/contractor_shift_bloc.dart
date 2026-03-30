// ignore_for_file: unused_local_variable, invalid_use_of_visible_for_testing_member

import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:shift/domain/auth/auth_value_objects.dart';
import 'package:shift/domain/core/string_constant.dart';
import 'package:shift/domain/main/i_main_facade.dart';
import 'package:shift/domain/main/main_failure.dart';
import 'package:shift/infrastructure/contractor_main/shift/applied_shift_dto/applied_shift_dto.dart';
import 'package:shift/infrastructure/contractor_main/shift/current_shift_dto/current_shift_dto.dart';
import 'package:shift/infrastructure/contractor_main/shift/upcoming_shift_dto/upcoming_shift_dto.dart';
import 'package:shift/infrastructure/core/network/common_response.dart';
import 'package:shift/infrastructure/main/healthcare_post/healthcare_post_dto.dart';
import 'package:shift/presentation/common/utils/date_time_format.dart';
import 'package:shift/presentation/common/utils/flushbar_creator.dart';
import 'package:shift/presentation/common/utils/get_cookie.dart';
import 'package:shift/presentation/core/widgets/dialogs/app_dialog.dart';

part 'contractor_shift_event.dart';

part 'contractor_shift_state.dart';

part 'contractor_shift_bloc.freezed.dart';

@injectable
class ContractorShiftBloc
    extends Bloc<ContractorShiftEvent, ContractorShiftState> {
  final IMainFacade mainFacade;

  Timer? _timer;

  int currentShiftPage = 1;
  int currentShiftLastPage = 1;
  int upcomingShiftPage = 1;
  int upcomingShiftLastPage = 1;

  int appliedTypePage = 1;
  int appliedTypeLastPage = 1;
  int counterTypePage = 1;
  int counterTypeLastPage = 1;

  final RefreshController currentShiftRefreshCtrl = RefreshController();
  final RefreshController counterShiftRefreshCtrl = RefreshController();
  final RefreshController appliedTypeRefreshCtrl = RefreshController();
  final RefreshController upcomingShiftRefreshCtrl = RefreshController();

  ContractorShiftBloc(this.mainFacade) : super(ContractorShiftState.initial()) {
    on<ContractorShiftEvent>(
      (event, emit) async {
        await event.map(
          changeNotificationTab: (e) async {
            final currentTab = getNotificationTab();
            final currentAppliedTab = getNotificationSubTab();

            if (currentTab != null) {
              emit(state.copyWith(isLoading: true));
              emit(state.copyWith(
                selectedTab: currentTab,
                selectedAppliedTab: currentAppliedTab ?? 0,
              ));
              await Future.delayed(Duration(seconds: 1));
              emit(state.copyWith(isLoading: false));
            }
          },
          changeShiftTab: (e) async {
            /* emit(state.copyWith(isLoading: true));
            if (e.notificationTabIndex != null) {
              emit(state.copyWith(selectedTab: e.notificationTabIndex!));
            } else {
              emit(state.copyWith(selectedTab: e.tabIndex));
            }
            await Future.delayed(Duration(seconds: 1));
            emit(state.copyWith(isLoading: false)); */

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
                  if (e.isClockOut == true) {
                    AppDialog.showInfo(
                        e.context, StringConstant.currentCompleteShiftDesc,
                        onPressed: () {
                      e.context.router.maybePop().then((value) {
                        add(ContractorShiftEvent.getCurrentShiftDetailAPI(
                            true));
                      });
                    });
                  } else {
                    add(ContractorShiftEvent.getCurrentShiftDetailAPI(true));
                  }
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
                id: e.postId,
                isCad: e.isCad,
                reason: state.deletePostReason.getValue() ?? "",
              );

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
          getAppliedTypeList: (e) async {
            if (e.isRefresh) {
              appliedTypePage = 1;
              emit(state.copyWith(
                appliedList: [],
                isAppliedLoading: e.isRefresh,
              ));
              appliedTypeRefreshCtrl.resetNoData();
            } else {
              if (appliedTypePage > appliedTypeLastPage) {
                appliedTypeRefreshCtrl.loadNoData();
                return;
              }
            }
            var res = await mainFacade.getContractorShifts(
                page: appliedTypePage, filterType: 3, appliedType: 1);
            appliedTypePage++;
            res.fold(
                (l) => emit(
                      state.copyWith(
                        isAppliedErrorInAPI: true,
                        isAppliedLoading: false,
                        appliedList: [],
                      ),
                    ), (r) {
              appliedTypeLastPage = r.meta?.lastPage ?? 1;
              if (e.isRefresh) {
                List.from(state.appliedList).clear();
              }
              final newShifts = (r.data as List<dynamic>)
                  .map((e) => AppliedShiftDTO.fromJson(e))
                  .toList();
              emit(
                state.copyWith(
                  isAppliedLoading: false,
                  isAppliedErrorInAPI: false,
                  isAppliedNoDataFound: (r.data as List<dynamic>)
                      .map((e) => AppliedShiftDTO.fromJson(e))
                      .toList()
                      .isEmpty,
                  appliedList: List.from(state.appliedList)
                    ..addAll((r.data as List<dynamic>)
                        .map((e) => AppliedShiftDTO.fromJson(e))
                        .toList()),
                ),
              );

              /// to start revoking timer
              for (var shift in newShifts) {
                print("shift.revoke_start-----> ${shift.revoke_start}");
                if (shift.revoke_status == 2) {
                  add(
                    ContractorShiftEvent.startAppliedRevokingTimer(
                      Duration(hours: 2), shift.id ?? -1,
                      // revokeTime: (shift.id == 115) ? 1728877581 : 1728877581,
                      revokeTime: shift.revoke_start ?? -1,
                    ),
                  );
                }
              }
            });
          },
          getCounterProposalList: (e) async {
            if (e.isRefresh) {
              counterTypePage = 1;
              emit(state.copyWith(
                counterList: [],
                isCounterLoading: e.isRefresh,
              ));
              counterShiftRefreshCtrl.resetNoData();
            } else {
              if (counterTypePage > counterTypeLastPage) {
                counterShiftRefreshCtrl.loadNoData();
                return;
              }
            }
            var res = await mainFacade.getContractorShifts(
                page: counterTypePage, filterType: 3, appliedType: 2);
            counterTypePage++;
            res.fold(
              (l) => emit(
                state.copyWith(
                  isCounterErrorInAPI: true,
                  isCounterLoading: false,
                  counterList: [],
                ),
              ),
              (r) {
                counterTypeLastPage = r.meta?.lastPage ?? 1;
                if (e.isRefresh) {
                  List.from(state.counterList).clear();
                }
                final newShifts = (r.data as List<dynamic>)
                    .map((e) => AppliedShiftDTO.fromJson(e))
                    .toList();

                emit(
                  state.copyWith(
                    isCounterLoading: false,
                    isCounterErrorInAPI: false,
                    isCounterNoDataFound: (r.data as List<dynamic>)
                        .map((e) => AppliedShiftDTO.fromJson(e))
                        .toList()
                        .isEmpty,
                    counterList: List.from(state.counterList)
                      ..addAll((r.data as List<dynamic>)
                          .map((e) => AppliedShiftDTO.fromJson(e))
                          .toList()),
                  ),
                );

                for (var shift in newShifts) {
                  if (shift.revoke_status == 2) {
                    add(
                      ContractorShiftEvent.startCounterProposalRevokingTimer(
                        Duration(hours: 2), shift.id ?? -1,
                        // revokeTime: (shift.id == 115) ? 1728877581 : 1729668587,
                        revokeTime: shift.revoke_start ?? -1,
                      ),
                    );
                  }
                }
              },
            );
          },
          urgentActionEvent: (e) async {
            print("urgent action called!!! ${e.postId}");

            Either<MainFailure, String>? failureOrSuccess;

            failureOrSuccess = await mainFacade.contractorShiftUrgentActionApi(
                postId: e.postId, urgentAction: e.urgentAction);

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
                showSuccess(message: r).show(e.context).then((value) {
                  add(ContractorShiftEvent.getAppliedTypeList(true));
                });
              },
            );
          },
          proposalAcceptRejectEvent: (e) async {
            print("proposal action called!!! ${e.postId}");
            Either<MainFailure, String>? failureOrSuccess;

            failureOrSuccess = await mainFacade.contractorShiftUrgentActionApi(
                postId: e.postId, urgentAction: e.urgentAction);

            failureOrSuccess.fold(
              (l) {
                // e.context.router.maybePop();
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
                // e.context.router.maybePop();
                showSuccess(message: r).show(e.context).then((value) {
                  // e.context.router.maybePop(true);
                  Navigator.pop(e.context, true);
                  // add(ContractorShiftEvent.getCounterProposalList(true));
                });
              },
            );
          },

          /*startRevokingTimer: (e) async {
            Duration remainingTime = e.duration;

            print("remainingTime Of starting----> $remainingTime");

            if (_timer != null) {
              _timer?.cancel();
            }

            _timer = Timer.periodic(const Duration(seconds: 1), (timer) async {
              print("Timer is started");

              // Check if time has run out
              if (remainingTime.inSeconds <= 0) {
                timer.cancel();
                remainingTime = Duration.zero;
                _updateRemainingTime(remainingTime);
              } else {
                // Reduce remaining time by one second
                remainingTime -= Duration(seconds: 1);
                _updateRemainingTime(remainingTime);
              }
            });
          },*/
          startAppliedRevokingTimer: (e) {
            // print("revoke start time---> ${e.revokeTime}");
            DateTime timerStartTime =
                CustomDateTimeFormat.timeStampToDateTime(e.revokeTime);

            Duration totalDuration = Duration(hours: 2);

            final updatedList = state.appliedList.map((shift) {
              if (shift.id == e.id) {
                // if (shift.revoke_status == 1) {
                Duration remainingTime =
                    calculateRemainingTime(timerStartTime, totalDuration);

                _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
                  if (remainingTime.inSeconds <= 0) {
                    timer.cancel();
                    remainingTime = Duration.zero;
                  } else {
                    remainingTime -= const Duration(seconds: 1);
                  }
                  updateRemainingTime(remainingTime, shift.id ?? -1);
                });
              }
              return shift;
            }).toList();
          },
          startCounterProposalRevokingTimer: (e) {
            DateTime timerStartTime =
                CustomDateTimeFormat.timeStampToDateTime(e.revokeTime);

            Duration totalDuration = Duration(hours: 2);

            final updatedList = state.counterList.map((shift) {
              if (shift.id == e.id) {
                // if (shift.revoke_status == 1) {
                Duration remainingTime =
                    calculateRemainingTime(timerStartTime, totalDuration);

                _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
                  if (remainingTime.inSeconds <= 0) {
                    timer.cancel();
                    remainingTime = Duration.zero;
                  } else {
                    remainingTime -= const Duration(seconds: 1);
                  }
                  updateCounterRemainingTime(remainingTime, shift.id ?? -1);
                });
              }
              return shift;
            }).toList();
          },
        );
      },
    );
  }

  Duration calculateRemainingTime(
      DateTime timerStartTime, Duration totalDuration) {
    DateTime currentTime = DateTime.now();
    Duration elapsedTime = currentTime.difference(timerStartTime);
    Duration remainingTime = totalDuration - elapsedTime;
    if (remainingTime.isNegative) {
      return Duration.zero;
    } else {
      return remainingTime;
    }
  }

  void updateRemainingTime(Duration remainingTime, int id) {
    emit(state.copyWith(
      appliedList: state.appliedList.map((s) {
        if (s.id == id) {
          return s.copyWith(remainingRevokeTime: remainingTime);
        }
        return s;
      }).toList(),
    ));
  }

  void updateCounterRemainingTime(Duration remainingTime, int id) {
    emit(state.copyWith(
      counterList: state.counterList.map((s) {
        if (s.id == id) {
          return s.copyWith(remainingRevokeTime: remainingTime);
        }
        return s;
      }).toList(),
    ));
  }

  @override
  Future<void> close() {
    _timer?.cancel();
    return super.close();
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

    return CustomDateTimeFormat.dateTimeToUtcTimestamp(dateTime, isInt: true);
  }
}
