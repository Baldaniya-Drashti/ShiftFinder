// ignore_for_file: unnecessary_brace_in_string_interps, invalid_use_of_visible_for_testing_member

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
import 'package:shift/domain/core/svg_image_constants.dart';
import 'package:shift/domain/main/i_main_facade.dart';
import 'package:shift/domain/main/main_failure.dart';
import 'package:shift/infrastructure/core/employer_applicant/employer_applicant_dto.dart';
import 'package:shift/infrastructure/core/network/common_response.dart';
import 'package:shift/infrastructure/main/healthcare_post/healthcare_post_dto.dart';
import 'package:shift/presentation/common/utils/flushbar_creator.dart';
import 'package:shift/presentation/core/logger/logger.dart';
import 'package:shift/presentation/main/tabs/home/view_single_applicants/widgets/common_card_dialog.dart';

part 'view_single_applicants_state.dart';

part 'view_single_applicants_event.dart';

part 'view_single_applicants_bloc.freezed.dart';

@injectable
class ViewSingleApplicantsBloc
    extends Bloc<ViewSingleApplicantsEvent, ViewSingleApplicantsState> {
  final IMainFacade _mainFacade;
  final RefreshController refreshController = RefreshController();
  int page = 1;
  int lastPage = 1;
  bool isFetching = false;
  Timer? _timer;

  ViewSingleApplicantsBloc(this._mainFacade)
      : super(ViewSingleApplicantsState.initial()) {
    on<ViewSingleApplicantsEvent>(
      (event, emit) async {
        await event.map(
          getShiftDetailEvent: (e) async {
            Either<MainFailure, HealthcarePostDTO>? failureOrSuccess;
            emit(
              state.copyWith(isLoading: true),
            );

            if (e.fromDashboard) {
              failureOrSuccess = await _mainFacade.getPostApi(
                postId: e.postId,
              );
            } else {
              failureOrSuccess =
                  await _mainFacade.getContractorShiftDetail(postId: e.postId);
            }

            failureOrSuccess.fold(
              (l) => emit(state.copyWith(
                isLoading: false,
                showErrorMessages: true,
                shiftFailureOrSuccessOption: optionOf(failureOrSuccess),
              )),
              (r) {
                print("post--> $r");
                emit(state.copyWith(
                  isLoading: false,
                  showErrorMessages: false,
                  shift: r,
                  shiftFailureOrSuccessOption: optionOf(failureOrSuccess),
                ));
              },
            );
          },
          cardHolderNameChanged: (value) async {
            emit(
              state.copyWith(cardHoldersName: Username(value.cardHolderName)),
            );
          },
          cardNumberChanged: (value) async {
            emit(
              state.copyWith(cardNumber: CardNumber(value.cardNo)),
            );
          },
          validUpToChanged: (value) async {
            emit(state.copyWith(
              cardDate: CardDate(value.date),
            ));
          },
          cvvChanged: (value) async {
            emit(state.copyWith(
              cvv: CVV(value.cvv),
            ));
          },
          saveButtonPressed: (value) async {
            // Either<MainFailure, String>? failureOrSuccess;
            final isCardHolderNameValid = state.cardHoldersName.isValid();
            final isCardNumberValid = state.cardNumber.isValid();
            final isCardDateValid = state.cardDate.isValid();
            final isCvvValid = state.cvv.isValid();
            //request 1= accpeted
            //request 0= notaccpeted
            if (isCardHolderNameValid &&
                isCardNumberValid &&
                isCardDateValid &&
                isCvvValid) {
              emit(
                state.copyWith(
                  isSubmitting: true,
                  showErrorMessages: false,
                  failureOrSuccessOption: none(),
                ),
              );
            }
            emit(
              state.copyWith(
                isSubmitting: false,
                showErrorMessages: true,
                failureOrSuccessOption: none(),
              ),
            );
          },
          getApplicantsList: (GetApplicantsList value) async {
            if (value.isRefresh) {
              page = 1;
              emit(state.copyWith(
                  employerApplicantList: [],
                  isLoading: value.isRefresh,
                  postId: value.id));
              refreshController.resetNoData();
            } else {
              if (page > lastPage) {
                refreshController.loadNoData();
                return;
              }
            }
            var res = await _mainFacade.getApplicantList(
                postId: value.id, page: page);

            page++;
            res.fold(
              (l) => emit(
                state.copyWith(
                  isErrorInAPI: true,
                  isLoading: false,
                  employerApplicantList: [],
                ),
              ),
              (r) {
                lastPage = r.meta?.lastPage ?? 1;
                if (value.isRefresh) {
                  List.from(state.employerApplicantList).clear();
                }

                Log.success("response=> ${r.additional_data?.is_card_added}");
                final employerApplicantList = (r.data as List<dynamic>)
                    .map((e) => EmployerApplicantsDto.fromJson(e))
                    .toList();

                emit(
                  state.copyWith(
                    isLoading: false,
                    isErrorInAPI: false,
                    isCardAdded: r.additional_data?.is_card_added ?? false,
                    totalShift: r.additional_data?.total_shift ?? 0,
                    completeShift: r.additional_data?.complete_shift ?? 0,
                    isNoDataFound: (r.data as List<dynamic>)
                        .map((e) => EmployerApplicantsDto.fromJson(e))
                        .toList()
                        .isEmpty,
                    //  getProductList: []
                    employerApplicantList:
                        List.from(state.employerApplicantList)
                          ..addAll((r.data as List<dynamic>)
                              .map((e) => EmployerApplicantsDto.fromJson(e))
                              .toList()),
                  ),
                );
                for (var i in employerApplicantList) {
                  if (i.revoke_status == 2) {
                    add(
                      ViewSingleApplicantsEvent.startRevokingTimer(
                        duration: Duration(hours: 2),
                        postId: i.id ?? -1,
                        revokeTime: i.revoke_start ?? -1,
                      ),
                    );
                  }
                }
              },
            );

            // _mainFacade.getApplicantList(postId: postId, page: page);
          },
          acceptApplicants: (AcceptApplicants value) async {
            Either<MainFailure, CommonResponse>? failureOrSuccess;

            failureOrSuccess = await _mainFacade.acceptApplicant(id: value.id);

            failureOrSuccess.fold(
              (l) {
                value.context.router.maybePop();
                showError(
                  message: l.maybeMap(
                    showAPIResponseMessage: (value) => value.message,
                    networkError: (value) =>
                        'Please check your internet connectivity',
                    orElse: () => "Server Error. Try again later.",
                  ),
                ).show(value.context);
              },
              (r) {
                value.context.router.maybePop();
                CommonCardDialog(
                  title: StringConstant.awaitingConfirmation,
                  description:
                      'Application accepted, Contractor notified for Confirmation.',
                  buttonText: StringConstant.ok,
                  onPressed: () {
                    value.context.router.maybePop();
                    add(ViewSingleApplicantsEvent.getApplicantsList(
                        state.postId, true));
                  },
                  image: SvgImageConstant.timerShift,
                ).addCardDialog(value.context);

                //value.context.router.maybePop();
                //showSuccess(message: r.dioMessage ?? "").show(value.context).then((value) {});
              },
            );
          },
          rejectApplicants: (RejectApplicants value) async {
            Either<MainFailure, CommonResponse>? failureOrSuccess;

            failureOrSuccess = await _mainFacade.rejectApplicant(id: value.id);

            failureOrSuccess.fold(
              (l) {
                value.context.router.maybePop();
                showError(
                  message: l.maybeMap(
                    showAPIResponseMessage: (value) => value.message,
                    networkError: (value) =>
                        'Please check your internet connectivity',
                    orElse: () => "Server Error. Try again later.",
                  ),
                ).show(value.context);
              },
              (r) {
                value.context.router.maybePop();
                showSuccess(
                        message: StringConstant.applicationRejectedSuccessfully)
                    .show(value.context)
                    .then((value) {
                  add(ViewSingleApplicantsEvent.getApplicantsList(
                      state.postId, true));
                });
              },
            );
          },
          onRevoke: (OnRevoke value) async {
            Either<MainFailure, CommonResponse>? failureOrSuccess;

            emit(state.copyWith(postDataLoading: true));
            failureOrSuccess = await _mainFacade.revokeApplicant(
                postId: value.postId, userId: value.userId);
            emit(state.copyWith(postDataLoading: false));
            failureOrSuccess.fold(
              (l) {
                value.context.router.maybePop();
                showError(
                  message: l.maybeMap(
                    showAPIResponseMessage: (value) => value.message,
                    networkError: (value) =>
                        'Please check your internet connectivity',
                    orElse: () => "Server Error. Try again later.",
                  ),
                ).show(value.context);
              },
              (r) {
                value.context.router.maybePop();
                showSuccess(message: r.dioMessage ?? "")
                    .show(value.context)
                    .then((value) {
                  add(ViewSingleApplicantsEvent.getApplicantsList(
                      state.postId, true));
                });
              },
            );
          },
          startRevokingTimer: (StartRevokingTimer value) {
            DateTime timerStartTime =
                DateTime.fromMillisecondsSinceEpoch(value.revokeTime * 1000);

            Duration totalDuration = Duration(hours: 2);

            state.employerApplicantList.map((shift) {
              if (shift.id == value.postId) {
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
      employerApplicantList: state.employerApplicantList.map((s) {
        if (s.id == id) {
          return s.copyWith(duration: remainingTime);
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

    return dateTime.toUtc().millisecondsSinceEpoch ~/ 1000;
  }
}
