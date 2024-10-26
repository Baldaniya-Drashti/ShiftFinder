import 'package:auto_route/auto_route.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:shift/domain/account/account_failure.dart';
import 'package:shift/domain/main/i_main_facade.dart';
import 'package:shift/domain/main/main_failure.dart';
import 'package:shift/infrastructure/core/network/common_response.dart';
import 'package:shift/infrastructure/main/hired_contractor_list_dto/hired_contractor_list_dto.dart';
import 'package:shift/presentation/common/utils/flushbar_creator.dart';

part 'hired_contractor_event.dart';
part 'hired_contractor_state.dart';
part 'hired_contractor_bloc.freezed.dart';

@injectable
class HiredContractorBloc
    extends Bloc<HiredContractorEvent, HiredContractorState> {
  int currentPage = 1;
  int lastPage = 1;

  final RefreshController hiredContractorListController = RefreshController();

  final IMainFacade mainFacade;

  int convertToTimestamp(TimeOfDay timeOfDay) {
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

  HiredContractorBloc(this.mainFacade) : super(HiredContractorState.initial()) {
    on<HiredContractorEvent>((event, emit) async {
      await event.map(
        changeClockInClockOutTime: (value) async {
          if (value.isClockIn) {
            final clockInTimeStamp = convertToTimestamp(value.time);
            print("Selected clock in time---> ${value.time} ");

            emit(state.copyWith(
              clockIn: clockInTimeStamp,
            ));
          } else {
            final clockOutTimeStamp = convertToTimestamp(value.time);
            emit(
              state.copyWith(
                clockOut: clockOutTimeStamp,
              ),
            );
          }
        },
        submitClockInOutTime: (e) async {
          Either<MainFailure, CommonResponse>? failureOrSuccess;

          final isClockInValid = state.clockIn != null;
          final isClockOutValid = state.clockOut != null;

          if (isClockInValid && isClockOutValid) {
            failureOrSuccess = await mainFacade.submitEmployerClockInClockOut(
              shiftId: e.postId,
              userId: e.userId,
              clockInTime: state.clockIn,
              clockOutTime: state.clockOut,
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
                // e.context.router.maybePop();
                showSuccess(message: r.dioMessage ?? "")
                    .show(e.context)
                    .then((value) {
                  e.context.router.maybePop(true);
                });
              },
            );
          } else {
            emit(
              state.copyWith(
                showClockTimeError: true,
              ),
            );
          }
        },
        getHiredFilledContractorList: (e) async {
          if (e.refresh) {
            currentPage = 1;
            emit(state.copyWith(
              hiredFilledContractorList: [],
              isLoading: e.refresh,
            ));
            hiredContractorListController.resetNoData();
          } else {
            if (currentPage > lastPage) {
              hiredContractorListController.loadNoData();
              return;
            }
          }
          var res = await mainFacade.hiredContractorList(
            postId: e.postId,
            page: currentPage,
            shortType: 0,
          );
          currentPage++;
          res.fold(
            (l) => emit(
              state.copyWith(
                errorApi: true,
                isLoading: false,
                hiredFilledContractorList: [],
              ),
            ),
            (r) {
              lastPage = r.meta?.lastPage ?? 1;
              if (e.refresh) {
                List.from(state.hiredFilledContractorList).clear();
              }
              return emit(
                state.copyWith(
                  isLoading: false,
                  errorApi: false,
                  noDataFound: (r.data as List<dynamic>)
                      .map((e) => HiredContractorListDTO.fromJson(e))
                      .toList()
                      .isEmpty,
                  //  getProductList: []
                  hiredFilledContractorList:
                      List.from(state.hiredFilledContractorList)
                        ..addAll(
                          (r.data as List<dynamic>)
                              .map((e) => HiredContractorListDTO.fromJson(e))
                              .toList(),
                        ),
                ),
              );
            },
          );
        },
        getHiredApproveContractorList: (e) async {
          if (e.refresh) {
            currentPage = 1;
            emit(state.copyWith(
              hiredApproveContractorList: [],
              isLoading: e.refresh,
            ));
            hiredContractorListController.resetNoData();
          } else {
            if (currentPage > lastPage) {
              hiredContractorListController.loadNoData();
              return;
            }
          }
          var res = await mainFacade.hiredContractorList(
            postId: e.postId,
            page: currentPage,
            shortType: 0,
          );
          currentPage++;
          res.fold(
            (l) => emit(
              state.copyWith(
                errorApi: true,
                isLoading: false,
                hiredApproveContractorList: [],
              ),
            ),
            (r) {
              lastPage = r.meta?.lastPage ?? 1;
              if (e.refresh) {
                List.from(state.hiredApproveContractorList).clear();
              }
              return emit(
                state.copyWith(
                  isLoading: false,
                  errorApi: false,
                  noDataFound: (r.data as List<dynamic>)
                      .map((e) => HiredContractorListDTO.fromJson(e))
                      .toList()
                      .isEmpty,
                  //  getProductList: []
                  hiredApproveContractorList:
                      List.from(state.hiredApproveContractorList)
                        ..addAll(
                          (r.data as List<dynamic>)
                              .map((e) => HiredContractorListDTO.fromJson(e))
                              .toList(),
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
