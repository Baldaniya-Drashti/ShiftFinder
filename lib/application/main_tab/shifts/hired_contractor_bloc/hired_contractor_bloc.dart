import 'package:auto_route/auto_route.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:shift/domain/account/account_failure.dart';
import 'package:shift/domain/core/math_utils.dart';
import 'package:shift/domain/core/string_constant.dart';
import 'package:shift/domain/core/svg_image_constants.dart';
import 'package:shift/domain/main/i_main_facade.dart';
import 'package:shift/domain/main/main_failure.dart';
import 'package:shift/infrastructure/core/network/common_response.dart';
import 'package:shift/infrastructure/main/hired_contractor_list_dto/hired_contractor_list_dto.dart';
import 'package:shift/presentation/common/utils/date_time_format.dart';
import 'package:shift/presentation/common/utils/flushbar_creator.dart';
import 'package:shift/presentation/common/widgets/base_text.dart';
import 'package:shift/presentation/core/app_router.gr.dart';
import 'package:shift/presentation/core/style/app_colors.dart';
import 'package:shift/presentation/core/widgets/buttons/common_button.dart';
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
    return CustomDateTimeFormat.dateTimeToUtcTimestamp(dateTime, isInt: true);
  }

  HiredContractorBloc(this.mainFacade) : super(HiredContractorState.initial()) {
    on<HiredContractorEvent>((event, emit) async {
      await event.map(
        getEditClockInTime: (e) {
          emit(
            state.copyWith(
              clockIn: e.clockIn,
              clockOut: e.clockOut,
            ),
          );
        },
        changeClockInClockOutTime: (value) async {
          if (value.isClockIn) {
            final clockInTimeStamp = convertToTimestamp(value.time);

            emit(state.copyWith(
              clockIn: clockInTimeStamp,
              clockOut: null,
            ));
          } else {
            final clockOutTimeStamp = convertToTimestamp(value.time);

            if (state.clockIn != null && clockOutTimeStamp < state.clockIn!) {
              showError(message: StringConstant.pleaseSelectAValidTime)
                  .show(value.context);
            } else {
              emit(
                state.copyWith(
                  clockOut: clockOutTimeStamp,
                ),
              );
            }
          }
        },
        submitClockInOutTime: (e) async {
          Either<MainFailure, CommonResponse>? failureOrSuccess;
          final formatedClockIn = state.clockIn ?? e.clockIn;
          final formatedClockOut = state.clockOut ?? e.clockOut;

          final isClockInValid = formatedClockIn != null;
          final isClockOutValid = formatedClockOut != null;

          if (isClockInValid && isClockOutValid) {
            emit(state.copyWith(
              isSubmitting: true,
              hiredApproveContractorList:
                  state.hiredApproveContractorList.map((contractor) {
                return (contractor.user_id == e.userId)
                    ? contractor.copyWith(isLoading: true)
                    : contractor;
              }).toList(),
            ));

            failureOrSuccess = await mainFacade.submitEmployerClockInClockOut(
              shiftId: e.postId,
              userId: e.userId,
              clockInTime: formatedClockIn,
              clockOutTime: formatedClockOut,
            );

            failureOrSuccess.fold(
              (l) {
                emit(state.copyWith(
                  isSubmitting: false,
                  hiredApproveContractorList:
                      state.hiredApproveContractorList.map((contractor) {
                    return (contractor.user_id == e.userId)
                        ? contractor.copyWith(isLoading: false)
                        : contractor;
                  }).toList(),
                ));

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
              (r) async {
                emit(state.copyWith(
                  isSubmitting: false,
                  hiredApproveContractorList:
                      state.hiredApproveContractorList.map((contractor) {
                    return (contractor.user_id == e.userId)
                        ? contractor.copyWith(isLoading: false)
                        : contractor;
                  }).toList(),
                ));
                await showDialog<bool?>(
                  barrierDismissible: false,
                  context: e.context,
                  builder: (context) {
                    return AlertDialog(
                      contentPadding:
                          EdgeInsets.all(getSize(24)).copyWith(top: 0),
                      clipBehavior: Clip.none,
                      insetPadding:
                          EdgeInsets.symmetric(horizontal: getSize(20)),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(getSize(15)),
                      ),
                      titlePadding: EdgeInsets.zero,
                      title: Column(
                        children: [
                          SvgPicture.asset(
                            SvgImageConstant.approvedWithCurved,
                            fit: BoxFit.fill,
                          ),
                          SizedBox(height: getSize(20)),
                          BaseText(
                            text: "${StringConstant.approved}!",
                            fontSize: 22,
                            fontFamily: 'Aclonica',
                          ),
                        ],
                      ),
                      content: Padding(
                        padding: EdgeInsets.symmetric(horizontal: getSize(20))
                            .copyWith(top: getSize(10)),
                        child: BaseText(
                          text: StringConstant.approvedDesc,
                          fontSize: 14,
                          textAlign: TextAlign.center,
                          textColor: AppColors.black.withValues(alpha: 0.7),
                        ),
                      ),
                      actionsAlignment: MainAxisAlignment.center,
                      actions: [
                        CommonButton(
                          height: 46,
                          width: 200,
                          onPressed: () {
                            context.router.maybePop(true);
                          },
                          buttonText: StringConstant.ok,
                        ),
                      ],
                    );
                  },
                ).then((value) {
                  if (value == true) {
                    e.context.router
                        .push(
                      PageRouteInfo(ShiftActionsView.name,
                          args: ShiftActionsViewArgs(
                              postId: e.postId, userId: e.userId)),
                    )
                        .then((value) {
                      if (value == true) {
                        (e.isEdit)
                            ? e.context.router.maybePop(true)
                            : e.context.read<HiredContractorBloc>().add(
                                HiredContractorEvent
                                    .getHiredApproveContractorList(
                                        refresh: true, postId: e.postId));
                      }
                    });
                  }
                });
              },
            );
          } else {
            emit(state.copyWith(showClockTimeError: true));
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
                    hiredFilledContractorList:
                        List.from(state.hiredFilledContractorList)
                          ..addAll((r.data as List<dynamic>)
                              .map((e) => HiredContractorListDTO.fromJson(e))
                              .toList())),
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
                    hiredApproveContractorList:
                        List.from(state.hiredApproveContractorList)
                          ..addAll((r.data as List<dynamic>)
                              .map((e) => HiredContractorListDTO.fromJson(e))
                              .toList())),
              );
            },
          );
        },
        getHiredCancelledContractorList: (e) async {
          if (e.refresh) {
            currentPage = 1;
            emit(state.copyWith(
              hiredCancelledContractorList: [],
              isLoading: e.refresh,
            ));
            hiredContractorListController.resetNoData();
          } else {
            if (currentPage > lastPage) {
              hiredContractorListController.loadNoData();
              return;
            }
          }
          var res = await mainFacade.hiredCancelledContractorList(
            postId: e.postId,
            page: currentPage,
            shortType: e.shortType,
          );
          currentPage++;
          res.fold(
            (l) => emit(
              state.copyWith(
                errorApi: true,
                isLoading: false,
                hiredCancelledContractorList: [],
              ),
            ),
            (r) {
              lastPage = r.meta?.lastPage ?? 1;
              if (e.refresh) {
                List.from(state.hiredCancelledContractorList).clear();
              }
              return emit(
                state.copyWith(
                    isLoading: false,
                    errorApi: false,
                    noDataFound: (r.data as List<dynamic>)
                        .map((e) => HiredContractorListDTO.fromJson(e))
                        .toList()
                        .isEmpty,
                    hiredCancelledContractorList:
                        List.from(state.hiredCancelledContractorList)
                          ..addAll((r.data as List<dynamic>)
                              .map((e) => HiredContractorListDTO.fromJson(e))
                              .toList())),
              );
            },
          );
        },
      );
    });
  }
}
