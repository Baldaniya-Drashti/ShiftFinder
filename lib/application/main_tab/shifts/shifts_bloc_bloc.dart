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
import 'package:shift/domain/main/i_main_facade.dart';
import 'package:shift/infrastructure/core/employer_shift/employer_shift_dto.dart';
import 'package:shift/infrastructure/core/location_dto/search_location_dto/place_detail_dto.dart';
import 'package:shift/infrastructure/core/location_dto/search_location_dto/search_location_dto.dart';

part 'shifts_bloc_event.dart';

part 'shifts_bloc_state.dart';

part 'shifts_bloc_bloc.freezed.dart';

@injectable
class ShiftsBloc extends Bloc<ShiftsBlocEvent, ShiftsBlocState> {
  static TextEditingController locationCtrl = TextEditingController();
  int currentPage = 1;
  int lastPage = 1;

  final IAccountRepository iAccountRepository;
  final IMainFacade mainFacade;
  List<dynamic> placeList = [];

  final RefreshController filledRefreshController = RefreshController();
  final RefreshController approveRefreshController = RefreshController();
  final RefreshController cancelledRefreshController = RefreshController();

  ShiftsBloc(this.iAccountRepository, this.mainFacade) : super(ShiftsBlocState.initial()) {
    on<ShiftsBlocEvent>(
      (event, emit) async {
        await event.map(
          started: (value) async {},
          tabChange: (value) async {
            final index = value.tabIndex + 1;
            if (index == 1) {
              add(ShiftsBlocEvent.fetchFilledShiftList(refresh: true));
            } else if (index == 2) {
              add(ShiftsBlocEvent.fetchApprovedShiftList(refresh: true));
            } else if (index == 3) {
              add(ShiftsBlocEvent.fetchCancelledShiftList(refresh: true));
            }
            emit(state.copyWith(selectedTab: value.tabIndex));
          },
          getLocationListAPI: (GetLocationListAPI value) async {
            emit(state.copyWith(isLoading: true));
            final locationList = await iAccountRepository.getLocationListApi();

            // print("Location List ---> ${locationList}");
            locationList.fold(
              (l) => emit(
                state.copyWith(
                  isLoading: false,
                  locationList: [],
                ),
              ),
              (r) {
                var dropdownList = r
                    .map(
                      (e) => DropDownValueModel(name: e.location ?? "", value: e.id),
                    )
                    .toList();
                return emit(
                  state.copyWith(
                    isLoading: false,
                    locationList: List.from(state.locationList)..addAll(dropdownList),
                  ),
                );
              },
            );
          },
          deleteReasonChange: (DeleteReasonChange e) async {
            return emit(
              state.copyWith(
                deleteReason: InputEmptyOrNot(e.value),
              ),
            );
          },
          withdrawShift: (WithdrawShift value) async {
            emit(state.copyWith(showErrorMessages: true));
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
                cancelledShiftSortByController: SingleValueDropDownController(data: value.controller.dropDownValue),
              ),
            );
          },
          fetchFilledShiftList: (FetchAllPreviousPost value) async {
            if (value.refresh) {
              currentPage = 1;
              emit(state.copyWith(filledShiftList: [], getDataLoading: value.refresh));
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
              locationId: 0,
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
                    noDataFound: (r.data as List<dynamic>).map((e) => EmployerShiftDto.fromJson(e)).toList().isEmpty,
                    //  getProductList: []
                    filledShiftList: List.from(state.filledShiftList)
                      ..addAll(
                        (r.data as List<dynamic>).map((e) => EmployerShiftDto.fromJson(e)).toList(),
                      ),
                  ),
                );
              },
            );
          },
          fetchApprovedShiftList: (FetchApprovedShiftList value) async {
            if (value.refresh) {
              currentPage = 1;
              emit(state.copyWith(approveShiftList: [], getDataLoading: value.refresh));
              approveRefreshController.resetNoData();
            } else {
              if (currentPage > lastPage) {
                approveRefreshController.loadNoData();
                return;
              }
            }
            var res = await mainFacade.getEmployerShift(
              page: currentPage,
              type: 2,
              locationId: 0,
              shortType: 0,
            );
            currentPage++;
            res.fold(
              (l) => emit(
                state.copyWith(
                  errorApi: true,
                  getDataLoading: false,
                  approveShiftList: [],
                ),
              ),
              (r) {
                lastPage = r.meta?.lastPage ?? 1;
                if (value.refresh) {
                  List.from(state.approveShiftList).clear();
                }
                return emit(
                  state.copyWith(
                    getDataLoading: false,
                    errorApi: false,
                    noDataFound: (r.data as List<dynamic>).map((e) => EmployerShiftDto.fromJson(e)).toList().isEmpty,
                    //  getProductList: []
                    approveShiftList: List.from(state.approveShiftList)
                      ..addAll(
                        (r.data as List<dynamic>).map((e) => EmployerShiftDto.fromJson(e)).toList(),
                      ),
                  ),
                );
              },
            );
          },
          fetchCancelledShiftList: (FetchCancelledShiftList value) async {
            if (value.refresh) {
              currentPage = 1;
              emit(state.copyWith(cancelledShiftList: [], getDataLoading: value.refresh));
              approveRefreshController.resetNoData();
            } else {
              if (currentPage > lastPage) {
                approveRefreshController.loadNoData();
                return;
              }
            }
            var res = await mainFacade.getEmployerShift(
              page: currentPage,
              type: 3,
              locationId: 0,
              shortType: 0,
            );
            currentPage++;
            res.fold(
              (l) => emit(
                state.copyWith(
                  errorApi: true,
                  getDataLoading: false,
                  cancelledShiftList: [],
                ),
              ),
              (r) {
                lastPage = r.meta?.lastPage ?? 1;
                if (value.refresh) {
                  List.from(state.approveShiftList).clear();
                }
                return emit(
                  state.copyWith(
                    getDataLoading: false,
                    errorApi: false,
                    noDataFound: (r.data as List<dynamic>).map((e) => EmployerShiftDto.fromJson(e)).toList().isEmpty,
                    //  getProductList: []
                    cancelledShiftList: List.from(state.approveShiftList)
                      ..addAll(
                        (r.data as List<dynamic>).map((e) => EmployerShiftDto.fromJson(e)).toList(),
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
