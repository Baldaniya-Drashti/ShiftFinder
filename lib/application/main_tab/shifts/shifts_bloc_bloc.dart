import 'package:auto_route/auto_route.dart';
import 'package:dartz/dartz.dart';
import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:shift/domain/account/account.dart';
import 'package:shift/domain/account/account_failure.dart';
import 'package:shift/domain/account/i_account_repository.dart';
import 'package:shift/domain/auth/auth_value_objects.dart';
import 'package:shift/domain/core/string_constant.dart';
import 'package:shift/domain/main/i_main_facade.dart';
import 'package:shift/domain/main/main_failure.dart';
import 'package:shift/infrastructure/core/employer_shift/employer_shift_dto.dart';
import 'package:shift/infrastructure/core/location_dto/location_dto.dart';
import 'package:shift/infrastructure/core/location_dto/search_location_dto/place_detail_dto.dart';
import 'package:shift/infrastructure/core/location_dto/search_location_dto/search_location_dto.dart';
import 'package:shift/infrastructure/core/network/common_response.dart';
import 'package:shift/infrastructure/core/skill_list_model/skill_dto.dart';
import 'package:shift/presentation/common/utils/flushbar_creator.dart';
import 'package:shift/presentation/common/utils/get_cookie.dart';

part 'shifts_bloc_event.dart';

part 'shifts_bloc_state.dart';

part 'shifts_bloc_bloc.freezed.dart';

@injectable
class ShiftsBloc extends Bloc<ShiftsBlocEvent, ShiftsBlocState> {
  static TextEditingController locationCtrl = TextEditingController();
  int currentPage = 1;
  int lastPage = 1;

  int currentApprovePage = 1;
  int lastApprovePage = 1;

  int currentCancelPage = 1;
  int lastCancelPage = 1;

  final IAccountRepository iAccountRepository;
  final IMainFacade mainFacade;
  List<dynamic> placeList = [];

  final RefreshController filledRefreshController = RefreshController();
  final RefreshController approveRefreshController = RefreshController();
  final RefreshController cancelledRefreshController = RefreshController();

  ShiftsBloc(this.iAccountRepository, this.mainFacade)
      : super(ShiftsBlocState.initial()) {
    on<ShiftsBlocEvent>(
      (event, emit) async {
        await event.map(
          started: (value) async {},
          changeNotificationTab: (e) async {
            final currentTab = getNotificationTab();

            if (currentTab != null) {
              emit(state.copyWith(isLoading: true));
              emit(state.copyWith(selectedTab: currentTab));
              await Future.delayed(Duration(seconds: 1));
              emit(state.copyWith(isLoading: false));
            }
          },
          onFilledSorting: (e) {
            if (state.currentFilledFilter != e.currentSorting) {
              add(ShiftsBlocEvent.fetchFilledShiftList(refresh: true));
            }
            emit(state.copyWith(currentFilledFilter: e.currentSorting));
          },
          onApproveSorting: (e) {
            if (state.currentApproveFilter != e.currentSorting) {
              add(ShiftsBlocEvent.fetchApprovedShiftList(refresh: true));
            }
            emit(state.copyWith(currentApproveFilter: e.currentSorting));
          },
          onCancelTypeSorting: (e) {
            if (state.currentCancelFilter != e.currentSorting) {
              add(ShiftsBlocEvent.fetchCancelledShiftList(refresh: true));
            }
            emit(state.copyWith(currentCancelFilter: e.currentSorting));
          },
          onCancelLocationSorting: (e) {
            if (state.currentCancelLocationFilter != e.currentSorting) {
              add(ShiftsBlocEvent.fetchCancelledShiftList(refresh: true));
            }
            emit(state.copyWith(currentCancelLocationFilter: e.currentSorting));
          },
          tabChange: (value) async {
            final currentTab = getNotificationTab();

            if (currentTab != null) {
              emit(state.copyWith(isLoading: true));
              emit(state.copyWith(selectedTab: currentTab));
              await Future.delayed(Duration(seconds: 1));
            } else {
              emit(state.copyWith(selectedTab: value.tabIndex));
            }

            emit(state.copyWith(isLoading: false));
            if (value.tabIndex == 0) {
              add(ShiftsBlocEvent.fetchFilledShiftList(refresh: true));
            } else if (value.tabIndex == 1) {
              add(ShiftsBlocEvent.fetchApprovedShiftList(refresh: true));
            } else if (value.tabIndex == 2) {
              add(ShiftsBlocEvent.fetchCancelledShiftList(refresh: true));
            }
          },
          getLocationListAPI: (GetLocationListAPI value) async {
            emit(state.copyWith(getDataLoading: true));
            final locationList = await iAccountRepository.getLocationListApi();
            // print("Location List ---> ${locationList}");
            locationList.fold(
              (l) => emit(
                state.copyWith(
                  getDataLoading: false,
                  locationList: [],
                ),
              ),
              (r) {
                emit(
                  state.copyWith(
                    getDataLoading: false,
                    currentFilledFilter: (r.isNotEmpty) ? r[0] : LocationDTO(),
                    currentApproveFilter: (r.isNotEmpty) ? r[0] : LocationDTO(),
                    currentCancelLocationFilter:
                        (r.isNotEmpty) ? r[0] : LocationDTO(),
                    // locationList: List.from(state.locationList)
                    //   ..addAll(dropdownList),
                    locationList: r,
                  ),
                );
              },
            );
            add(ShiftsBlocEvent.tabChange(0));
            // add(ShiftsBlocEvent.fetchFilledShiftList(refresh: true));
            // add(ShiftsBlocEvent.fetchApprovedShiftList(refresh: true));
            // add(ShiftsBlocEvent.fetchCancelledShiftList(refresh: true));
          },
          deleteReasonChange: (DeleteReasonChange e) async {
            return emit(
              state.copyWith(
                deleteReason: InputEmptyOrNot(e.value),
              ),
            );
          },
          withdrawShift: (e) async {
            Either<MainFailure, CommonResponse>? failureOrSuccess;
            if (state.deleteReason.isValid()) {
              failureOrSuccess = await mainFacade.deleteEmployerFilledShift(
                id: e.postId,
                isCad: e.isCad,
                reason: state.deleteReason.getValue() ?? "",
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
                    e.context.router.maybePop(true);
                  });
                },
              );
            } else {
              emit(state.copyWith(showErrorMessages: true));
            }
          },
          changeClockInClockOutTime: (CangeClockInClockOutTime value) async {
            if (value.isClockIn) {
              emit(
                state.copyWith(clockIn: value.time),
              );
            } else {
              emit(
                state.copyWith(
                  clockOut: value.time,
                ),
              );
            }
          },
          onChangeSortBy: (OnChangeSortBy value) {
            emit(
              state.copyWith(
                cancelledShiftSortByController: SingleValueDropDownController(
                    data: value.controller.dropDownValue),
              ),
            );
          },
          fetchFilledShiftList: (FetchAllPreviousPost value) async {
            if (value.refresh) {
              currentPage = 1;
              emit(state.copyWith(
                filledShiftList: [],
                getDataLoading: value.refresh,
              ));
              filledRefreshController.resetNoData();
            } else {
              if (currentPage > lastPage) {
                filledRefreshController.loadNoData();
                return;
              }
            }
            var res = await mainFacade.getEmployerShift(
              page: currentPage,
              type: 1,
              locationId: state.currentFilledFilter.id ?? -1,
              shortType: 0,
            );
            currentPage++;
            res.fold(
              (l) => emit(
                state.copyWith(
                  errorApi: true,
                  getDataLoading: false,
                  filledShiftList: [],
                ),
              ),
              (r) {
                lastPage = r.meta?.lastPage ?? 1;
                if (value.refresh) {
                  List.from(state.filledShiftList).clear();
                }
                return emit(
                  state.copyWith(
                    getDataLoading: false,
                    errorApi: false,
                    noDataFound: (r.data as List<dynamic>)
                        .map((e) => EmployerShiftDto.fromJson(e))
                        .toList()
                        .isEmpty,
                    //  getProductList: []
                    filledShiftList: List.from(state.filledShiftList)
                      ..addAll(
                        (r.data as List<dynamic>)
                            .map((e) => EmployerShiftDto.fromJson(e))
                            .toList(),
                      ),
                  ),
                );
              },
            );
          },
          fetchApprovedShiftList: (FetchApprovedShiftList value) async {
            if (value.refresh) {
              currentApprovePage = 1;
              emit(state.copyWith(
                approveShiftList: [],
                approveLoading: value.refresh,
              ));
              approveRefreshController.resetNoData();
            } else {
              if (currentApprovePage > lastApprovePage) {
                approveRefreshController.loadNoData();
                return;
              }
            }
            var res = await mainFacade.getEmployerShift(
              page: currentApprovePage,
              type: 2,
              locationId: state.currentApproveFilter.id ?? -1,
              shortType: 0,
            );
            currentApprovePage++;
            res.fold(
              (l) => emit(
                state.copyWith(
                  approveErrorApi: true,
                  approveLoading: false,
                  approveShiftList: [],
                ),
              ),
              (r) {
                lastApprovePage = r.meta?.lastPage ?? 1;
                if (value.refresh) {
                  List.from(state.approveShiftList).clear();
                }
                return emit(
                  state.copyWith(
                    approveLoading: false,
                    approveErrorApi: false,
                    noApproveDataFound: (r.data as List<dynamic>)
                        .map((e) => EmployerShiftDto.fromJson(e))
                        .toList()
                        .isEmpty,
                    approveShiftList: List.from(state.approveShiftList)
                      ..addAll(
                        (r.data as List<dynamic>)
                            .map((e) => EmployerShiftDto.fromJson(e))
                            .toList(),
                      ),
                  ),
                );
              },
            );
          },
          fetchCancelledShiftList: (FetchCancelledShiftList value) async {
            if (value.refresh) {
              currentCancelPage = 1;
              emit(state.copyWith(
                  cancelledShiftList: [], cancelLoading: value.refresh));
              cancelledRefreshController.resetNoData();
            } else {
              if (currentCancelPage > lastCancelPage) {
                cancelledRefreshController.loadNoData();
                return;
              }
            }
            var res = await mainFacade.getEmployerShift(
              page: currentCancelPage,
              type: 3,
              locationId: state.currentCancelLocationFilter.id ?? -1,
              shortType: state.currentCancelFilter.id ?? -1,
            );
            currentCancelPage++;
            res.fold(
              (l) => emit(
                state.copyWith(
                  cancelErrorApi: true,
                  cancelLoading: false,
                  cancelledShiftList: [],
                ),
              ),
              (r) {
                lastCancelPage = r.meta?.lastPage ?? 1;
                if (value.refresh) {
                  List.from(state.cancelledShiftList).clear();
                }
                return emit(
                  state.copyWith(
                    cancelLoading: false,
                    cancelErrorApi: false,
                    noCancelDataFound: (r.data as List<dynamic>)
                        .map((e) => EmployerShiftDto.fromJson(e))
                        .toList()
                        .isEmpty,
                    //  getProductList: []
                    cancelledShiftList: List.from(state.cancelledShiftList)
                      ..addAll(
                        (r.data as List<dynamic>)
                            .map((e) => EmployerShiftDto.fromJson(e))
                            .toList(),
                      ),
                  ),
                );
              },
            );
          },
        );
      },
    );
  }
}
