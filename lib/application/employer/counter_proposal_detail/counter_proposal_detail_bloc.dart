import 'package:auto_route/auto_route.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:shift/domain/auth/auth_value_objects.dart';
import 'package:shift/domain/core/math_utils.dart';
import 'package:shift/domain/core/string_constant.dart';
import 'package:shift/domain/main/i_main_facade.dart';
import 'package:shift/domain/main/main_failure.dart';
import 'package:shift/infrastructure/core/employer_proposal_dto/employer_proposal_dto.dart';
import 'package:shift/infrastructure/core/network/common_response.dart';
import 'package:shift/infrastructure/core/skill_list_model/skill_dto.dart';
import 'package:shift/presentation/common/utils/flushbar_creator.dart';
import 'package:shift/presentation/common/widgets/base_text.dart';
import 'package:shift/presentation/core/logger/logger.dart';
import 'package:shift/presentation/core/style/app_colors.dart';
import 'package:shift/presentation/core/widgets/buttons/common_button.dart';
part 'counter_proposal_detail_event.dart';
part 'counter_proposal_detail_state.dart';
part 'counter_proposal_detail_bloc.freezed.dart';

@injectable
class CounterProposalDetailBloc
    extends Bloc<CounterProposalDetailEvent, CounterProposalDetailState> {
  final IMainFacade _mainFacade;

  static bool isAllownceValid(
      {required int selectedValue,
      required InputEmptyOrNot hourValue,
      required Rate rateValue}) {
    final parsedRate = double.tryParse(rateValue.getValue());
    final rateValid = parsedRate != null && parsedRate > 0;

    if (selectedValue == 1 && rateValue.isValid() && rateValid) {
      return true;
    } else if (selectedValue == 2 && hourValue.isValid()) {
      return true;
    } else if (selectedValue == 0) {
      return true;
    } else if (selectedValue == 1 && rateValue.isValid()) {
      return true;
    }
    return false;
  }

  CounterProposalDetailBloc(this._mainFacade)
      : super(CounterProposalDetailState.initial()) {
    on<CounterProposalDetailEvent>((event, emit) async {
      await event.map(
        sendCounterProposal: (value) async {
          final isCommuteAllownceValid = isAllownceValid(
              selectedValue: state.data.commute_allowance_type ?? -1,
              hourValue: state.commuteHour,
              rateValue: state.commuteRate);
          final isAccomdationAllownceValid = isAllownceValid(
              selectedValue: state.data.accommodation_allowance_type ?? -1,
              hourValue: state.accomdationHour,
              rateValue: state.accomdationRate);
          final isRateValid = state.rateHour.isValid();

          if (isCommuteAllownceValid &&
              isAccomdationAllownceValid &&
              isRateValid) {
            final result = await showDialog<bool?>(
              context: value.context,
              builder: (context) {
                return AlertDialog(
                  contentPadding: EdgeInsets.zero,
                  clipBehavior: Clip.none,
                  elevation: 0,
                  backgroundColor: AppColors.white,
                  insetPadding: EdgeInsets.symmetric(horizontal: getSize(17)),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(getSize(15)),
                  ),
                  content: Padding(
                    padding: EdgeInsets.symmetric(horizontal: getSize(25)),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SizedBox(
                          height: getSize(30),
                        ),
                        BaseText(
                          text: "Counter Propose",
                          fontSize: 22,
                          fontFamily: 'Aclonica',
                        ),
                        SizedBox(
                          height: getSize(10),
                        ),
                        BaseText(
                          text: StringConstant.counterProposalConfirmation,
                          fontSize: 14,
                          showFullDescription: true,
                          textAlign: TextAlign.center,
                          fontWeight: FontWeight.w500,
                          textColor: AppColors.black.withOpacity(0.7),
                        ),
                        SizedBox(
                          height: getSize(30),
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: CommonButton(
                                backgroundColor: AppColors.white,
                                borderColor: AppColors.green,
                                buttonTextColor: AppColors.green,
                                onPressed: () => context.router.maybePop(false),
                                buttonText: "Cancel",
                              ),
                            ),
                            SizedBox(
                              width: getSize(25),
                            ),
                            Expanded(
                              child: CommonButton(
                                onPressed: () => context.router.maybePop(true),
                                buttonText: "Send",
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: getSize(25),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );

            if (result ?? false) {
              emit(state.copyWith(postDataLoading: true));
              Either<MainFailure, CommonResponse> failureOrSuccess;

              failureOrSuccess =
                  await _mainFacade.sendEmployerApplicantsCounterPropose(
                id: state.data.id ?? -1,
                counterRateHour: num.parse(state.rateHour.getValue()),
                commuteAllowanceType: state.data.commute_allowance_type ?? -1,
                accommodationAllowanceType:
                    state.data.accommodation_allowance_type ?? -1,
                counterCommuteAllowance:
                    (state.data.commute_allowance_type == 1)
                        ? num.parse(state.commuteRate.getValue())
                        : (state.data.commute_allowance_type == 2)
                            ? getAccomdationHourId(
                                state, state.commuteHour.getValue() ?? "")
                            : 0,
                counterAccommodationAllowance:
                    (state.data.accommodation_allowance_type == 1)
                        ? num.parse(state.accomdationRate.getValue())
                        : (state.data.accommodation_allowance_type == 2)
                            ? getAccomdationHourId(
                                state, state.accomdationHour.getValue() ?? "")
                            : 0,
              );
              emit(state.copyWith(postDataLoading: false));

              failureOrSuccess.fold(
                (l) {
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
                  showSuccess(message: r.dioMessage ?? "")
                      .show(value.context)
                      .then((_) {
                    value.context.router.maybePop(true);
                  });
                },
              );
            }
          } else {
            final result = await showDialog<bool?>(
              context: value.context,
              builder: (context) {
                return AlertDialog(
                  contentPadding: EdgeInsets.zero,
                  clipBehavior: Clip.none,
                  elevation: 0,
                  backgroundColor: AppColors.white,
                  insetPadding: EdgeInsets.symmetric(horizontal: getSize(17)),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(getSize(15)),
                  ),
                  content: Padding(
                    padding: EdgeInsets.symmetric(horizontal: getSize(25)),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SizedBox(
                          height: getSize(30),
                        ),
                        BaseText(
                          text: "Counter Propose",
                          fontSize: 22,
                          fontFamily: 'Aclonica',
                        ),
                        SizedBox(
                          height: getSize(10),
                        ),
                        BaseText(
                          text: StringConstant.counterProposalExistingValueDesc,
                          fontSize: 14,
                          showFullDescription: true,
                          textAlign: TextAlign.center,
                          fontWeight: FontWeight.w500,
                          textColor: AppColors.black.withOpacity(0.7),
                        ),
                        SizedBox(height: getSize(10)),
                        BaseText(
                          text: StringConstant
                              .wouldYouLikeToProceedWithSendingTheCounterProposal,
                          fontSize: 14,
                          showFullDescription: true,
                          textAlign: TextAlign.center,
                          fontWeight: FontWeight.w500,
                          textColor: AppColors.black.withOpacity(0.7),
                        ),
                        SizedBox(height: getSize(30)),
                        Row(
                          children: [
                            Expanded(
                              child: CommonButton(
                                backgroundColor: AppColors.white,
                                borderColor: AppColors.green,
                                buttonTextColor: AppColors.green,
                                onPressed: () {
                                  value.context.router.maybePop();
                                },
                                buttonText: StringConstant.no,
                              ),
                            ),
                            SizedBox(width: getSize(25)),
                            Expanded(
                              child: CommonButton(
                                onPressed: () async {
                                  value.context.router.maybePop(true);
                                },
                                buttonText: StringConstant.yes,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: getSize(25)),
                      ],
                    ),
                  ),
                );
              },
            ).then((newVal) async {
              if (newVal == true) {
                emit(state.copyWith(
                    postDataLoading: true, showErrorMessages: false));
                Either<MainFailure, CommonResponse> failureOrSuccess;

                failureOrSuccess =
                    await _mainFacade.sendEmployerApplicantsCounterPropose(
                  id: state.data.id ?? -1,
                  counterRateHour: (state.data.proposed_hourly_rate ?? 0.0),
                  commuteAllowanceType: state.data.commute_allowance_type ?? -1,
                  accommodationAllowanceType:
                      state.data.accommodation_allowance_type ?? -1,
                  counterCommuteAllowance: (state.data.commute_allowance_type ==
                          1)
                      ? (state.data.proposed_commute_allowance_rate ?? 0.0)
                      : (state.data.commute_allowance_type == 2)
                          ? (state.data.proposed_commute_allowance_hour_id ??
                              -1)
                          : 0,
                  counterAccommodationAllowance: (state
                              .data.accommodation_allowance_type ==
                          1)
                      ? (state.data.proposed_accommodation_allowance_rate ??
                          0.0)
                      : (state.data.accommodation_allowance_type == 2)
                          ? (state.data
                                  .proposed_accommodation_allowance_hour_id ??
                              -1)
                          : 0,
                );
                emit(state.copyWith(postDataLoading: false));

                failureOrSuccess.fold(
                  (l) async {
                    showError(
                      message: l.maybeMap(
                        showAPIResponseMessage: (value) => value.message,
                        networkError: (value) =>
                            'Please check your internet connectivity',
                        orElse: () => "Server Error. Try again later.",
                      ),
                    ).show(value.context);
                  },
                  (r) async {
                    showSuccess(message: r.dioMessage ?? "")
                        .show(value.context)
                        .then((_) {
                      value.context.router.maybePop(true);
                    });
                  },
                );
              } else {
                showError(
                        message: StringConstant
                            .someDetailsAreMissingOrInvalidPleaseCheck)
                    .show(value.context);
                emit(state.copyWith(showErrorMessages: true));
              }
            });

            /* showError(
                    message: StringConstant
                        .someDetailsAreMissingOrInvalidPleaseCheck)
                .show(value.context);

            emit(state.copyWith(showErrorMessages: true)); */
          }

          // emit(state.copyWith(postDataLoading: true));
          // Either<MainFailure, CommonResponse> failureOrSuccess;
          // failureOrSuccess = await _mainFacade.sendEmployerApplicantsCounterPropose(
          //   id: value.id,
          //   counterRateHour: value.counterRateHour,
          //   commuteAllowanceType: value.commuteAllowanceType,
          //   accommodationAllowanceType: value.accommodationAllowanceType,
          //   counterCommuteAllowance: counterCommuteAllowance,
          //   counterAccommodationAllowance: counterAccommodationAllowance,
          // );
          //
          // emit(state.copyWith(postDataLoading: false));
          // failureOrSuccess.fold(
          //   (l) {
          //     showError(
          //       message: l.maybeMap(
          //         showAPIResponseMessage: (value) => value.message,
          //         networkError: (value) => 'Please check your internet connectivity',
          //         orElse: () => "Server Error. Try again later.",
          //       ),
          //     ).show(value.context);
          //   },
          //   (r) {
          //     showSuccess(message: r.dioMessage ?? "").show(value.context);
          //   },
          // );
        },
        commuteRateChanged: (e) {
          emit(state.copyWith(
            commuteRate: Rate(e.selectedValue),
          ));
        },
        accomdationRateChanged: (e) {
          emit(state.copyWith(
            accomdationRate: Rate(e.selectedValue),
          ));
        },
        getHoursList: (GetHoursList value) async {
          emit(state.copyWith(loading: true));
          final hoursList = await _mainFacade.getAccomdationHoursListApi();
          emit(state.copyWith(loading: false));
          hoursList.fold(
            (l) => emit(
              state.copyWith(
                accomdationHoursList: [],
              ),
            ),
            (r) {
              print("Hours List ---> $hoursList");
              return emit(
                state.copyWith(
                  accomdationHoursList: r,
                ),
              );
            },
          );
        },
        addProposalData: (AddProposalData value) {
          emit(state.copyWith(data: value.data));
        },
        accomdationHourChanged: (AccomdationHourChanged value) {
          emit(state.copyWith(
            accomdationHour: InputEmptyOrNot(value.rate),
          ));
        },
        commuteHourChanged: (CommuteHourChanged value) {
          emit(state.copyWith(
            commuteHour: InputEmptyOrNot(value.rate),
          ));
        },
        rateHourChanged: (RateHourChanged value) {
          emit(state.copyWith(
            rateHour: Rate(value.rate),
          ));
        },
      );
    });
  }

  int getAccomdationHourId(
      CounterProposalDetailState state, String selectedHour) {
    final hourId = state.accomdationHoursList.firstWhere(
        (hour) => hour.name == selectedHour,
        orElse: () => SkillDTO());
    print("Hour ID --> $hourId");
    return hourId.id ?? -1;
  }
}
