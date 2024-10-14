// ignore_for_file: unnecessary_brace_in_string_interps

import 'package:auto_route/auto_route.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:shift/domain/auth/auth_value_objects.dart';
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
class ViewSingleApplicantsBloc extends Bloc<ViewSingleApplicantsEvent, ViewSingleApplicantsState> {
  final IMainFacade _mainFacade;
  final RefreshController refreshController = RefreshController();
  int page = 1;
  int lastPage = 1;
  bool isFetching = false;

  ViewSingleApplicantsBloc(this._mainFacade) : super(ViewSingleApplicantsState.initial()) {
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
              failureOrSuccess = await _mainFacade.getContractorShiftDetail(
                postId: e.postId,
              );
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
            if (isCardHolderNameValid && isCardNumberValid && isCardDateValid && isCvvValid) {
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
              emit(state.copyWith(employerApplicantList: [], isLoading: value.isRefresh, postId: value.id));
              refreshController.resetNoData();
            } else {
              if (page > lastPage) {
                refreshController.loadNoData();
                return;
              }
            }
            var res = await _mainFacade.getApplicantList(postId: value.id, page: page);

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

                Log.success("response=> ${r.additional_data?.isCardAdded}");
                return emit(
                  state.copyWith(
                    isLoading: false,
                    isErrorInAPI: false,
                    isCardAdded: r.additional_data?.isCardAdded ?? false,
                    isNoDataFound: (r.data as List<dynamic>).map((e) => EmployerApplicantsDto.fromJson(e)).toList().isEmpty,
                    //  getProductList: []
                    employerApplicantList: List.from(state.employerApplicantList)
                      ..addAll((r.data as List<dynamic>).map((e) => EmployerApplicantsDto.fromJson(e)).toList()),
                  ),
                );
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
                    networkError: (value) => 'Please check your internet connectivity',
                    orElse: () => "Server Error. Try again later.",
                  ),
                ).show(value.context);
              },
              (r) {
                value.context.router.maybePop();
                CommonCardDialog(
                  title: 'Awaiting Confirmation',
                  description: 'Application accepted, Contractor notified for Confirmation.',
                  buttonText: 'Ok',
                  onPressed: () {
                    value.context.router.maybePop();
                    add(ViewSingleApplicantsEvent.getApplicantsList(state.postId, true));
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
                    networkError: (value) => 'Please check your internet connectivity',
                    orElse: () => "Server Error. Try again later.",
                  ),
                ).show(value.context);
              },
              (r) {
                value.context.router.maybePop();
                showSuccess(message: "Applicant Removed Successfully").show(value.context).then((value) {
                  add(ViewSingleApplicantsEvent.getApplicantsList(state.postId, true));
                });
              },
            );
          },
          onRevoke: (OnRevoke value) async {
            Either<MainFailure, CommonResponse>? failureOrSuccess;
            failureOrSuccess = await _mainFacade.revokeApplicant(postId: value.postId, userId: value.userId);
            failureOrSuccess.fold(
              (l) {
                value.context.router.maybePop();
                showError(
                  message: l.maybeMap(
                    showAPIResponseMessage: (value) => value.message,
                    networkError: (value) => 'Please check your internet connectivity',
                    orElse: () => "Server Error. Try again later.",
                  ),
                ).show(value.context);
              },
              (r) {
                value.context.router.maybePop();
                showSuccess(message: r.dioMessage ?? "").show(value.context).then((value) {
                  add(ViewSingleApplicantsEvent.getApplicantsList(state.postId, true));
                });
              },
            );
          },
        );
      },
    );
  }
}
