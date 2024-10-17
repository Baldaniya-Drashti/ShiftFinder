import 'package:auto_route/auto_route.dart';
import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:shift/application/auth/contractor_auth/card_bloc/card_bloc.dart';
import 'package:shift/domain/auth/auth_value_objects.dart';
import 'package:shift/domain/main/i_main_facade.dart';
import 'package:shift/domain/main/main_failure.dart';
import 'package:shift/infrastructure/core/applicant_dto/applicant_dto.dart';
import 'package:shift/infrastructure/core/network/common_response.dart';
import 'package:shift/infrastructure/core/proposal_detail_dto/proposal_detail_dto.dart';
import 'package:shift/infrastructure/core/skill_list_model/skill_dto.dart';
import 'package:shift/presentation/common/utils/flushbar_creator.dart';
import 'package:shift/presentation/core/app_router.gr.dart';
import 'package:shift/presentation/core/logger/logger.dart';
import 'package:shift/presentation/main/tabs/home/praposals/widgets/person_praposal_view.dart';
import 'package:shift/presentation/main/tabs/home/view_single_applicants/widgets/accept_reject_dialog.dart';

part 'counter_proposal_detail_event.dart';

part 'counter_proposal_detail_state.dart';

part 'counter_proposal_detail_bloc.freezed.dart';

@injectable
class CounterProposalDetailBloc extends Bloc<CounterProposalDetailEvent, CounterProposalDetailState> {
  final IMainFacade _mainFacade;

  static bool isAllownceValid({required int selectedValue, required InputEmptyOrNot hourValue, required Rate rateValue}) {
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

  CounterProposalDetailBloc(this._mainFacade) : super(CounterProposalDetailState.initial()) {
    on<CounterProposalDetailEvent>((event, emit) async {
      await event.map(
        sendCounterProposal: (value) async {
          Log.debug("commute_allowance_type${state.data.commute_allowance_type}");

          final isCommuteAllownceValid = isAllownceValid(
              selectedValue: state.data.commute_allowance_type ?? -1, hourValue: state.commuteHour, rateValue: state.commuteRate);
          final isAccomdationAllownceValid = isAllownceValid(
              selectedValue: state.data.accommodation_allowance_type ?? -1,
              hourValue: state.accomdationHour,
              rateValue: state.accomdationRate);
          final isRateValid = state.rateHour.isValid();

          Log.success("=isCommuteAllownceValid ${isCommuteAllownceValid}");
          Log.success("=isAccomdationAllownceValid ${isAccomdationAllownceValid}");
          Log.success("=isRateValid ${isRateValid}");
          Log.debug(isCommuteAllownceValid && isAccomdationAllownceValid && isRateValid);

          if (isCommuteAllownceValid && isAccomdationAllownceValid && isRateValid) {
            AcceptRejectDialog(
              title: 'Counter Propose',
              description: 'Are you sure you want to send a counter proposal?',
              onPressedAccept: () {
                value.context.router.maybePop().then(
                  (_) async {
                    emit(state.copyWith(postDataLoading: true));
                    Either<MainFailure, CommonResponse> failureOrSuccess;

                    failureOrSuccess = await _mainFacade.sendEmployerApplicantsCounterPropose(
                      id: state.data.id ?? -1,
                      counterRateHour: num.parse(state.rateHour.getValue()),
                      commuteAllowanceType: state.data.commute_allowance_type ?? -1,
                      accommodationAllowanceType: state.data.accommodation_allowance_type ?? -1,
                      counterCommuteAllowance: (state.data.commute_allowance_type == 1)
                          ? num.parse(state.commuteRate.getValue())
                          : (state.data.commute_allowance_type == 2)
                              ? getAccomdationHourId(state, state.commuteHour.getValue() ?? "")
                              : 0,
                      counterAccommodationAllowance: (state.data.accommodation_allowance_type == 1)
                          ? num.parse(state.accomdationRate.getValue())
                          : (state.data.accommodation_allowance_type == 2)
                              ? getAccomdationHourId(state, state.accomdationHour.getValue() ?? "")
                              : 0,
                    );
                    emit(state.copyWith(postDataLoading: false));

                    failureOrSuccess.fold(
                      (l) {
                        showError(
                          message: l.maybeMap(
                            showAPIResponseMessage: (value) => value.message,
                            networkError: (value) => 'Please check your internet connectivity',
                            orElse: () => "Server Error. Try again later.",
                          ),
                        ).show(value.context);
                      },
                      (r) {
                        showSuccess(message: r.dioMessage ?? "").show(value.context).then((_) {
                          value.context.router.maybePop(true);
                        });
                      },
                    );
                  },
                );
              },
              onPressedReject: () {
                value.context.router.maybePop();
              },
              acceptButtonText: 'Send',
            ).acceptRejectDialog(value.context);
          } else {
            emit(state.copyWith(showErrorMessages: true));
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
          final hoursList = await _mainFacade.getAccomdationHoursListApi();
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

  int getAccomdationHourId(CounterProposalDetailState state, String selectedHour) {
    final hourId = state.accomdationHoursList.firstWhere((hour) => hour.name == selectedHour, orElse: () => SkillDTO());
    print("Hour ID --> $hourId");
    return hourId.id ?? -1;
  }
}
