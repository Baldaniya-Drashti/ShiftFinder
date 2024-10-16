import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:shift/domain/auth/auth_value_objects.dart';
import 'package:shift/domain/main/i_main_facade.dart';
import 'package:shift/domain/main/main_failure.dart';
import 'package:shift/infrastructure/core/network/common_response.dart';
import 'package:shift/infrastructure/core/skill_list_model/skill_dto.dart';
import 'package:shift/presentation/common/utils/flushbar_creator.dart';

part 'counter_proposal_detail_event.dart';

part 'counter_proposal_detail_state.dart';

part 'counter_proposal_detail_bloc.freezed.dart';

@injectable
class CounterProposalDetailBloc extends Bloc<CounterProposalDetailEvent, CounterProposalDetailState> {
  final IMainFacade _mainFacade;

  static bool isAllownceValid({
    required InputEmptyOrNot selectedValue,
    required InputEmptyOrNot hourValue,
    required Rate rateValue,
  }) {
    final parsedRate = double.tryParse(rateValue.getValue());
    final rateValid = parsedRate != null && parsedRate > 0;

    if (selectedValue.getValue() == "Flat Rate" && rateValue.isValid() && rateValid) {
      return true;
    } else if (selectedValue.getValue() == "Hours" && hourValue.isValid()) {
      return true;
    } else if (selectedValue.getValue() == "None") {
      return true;
    } else if (selectedValue.getValue() == "Flat Rate" && rateValue.isValid()) {
      return true;
    }
    return false;
  }

  CounterProposalDetailBloc(this._mainFacade) : super(CounterProposalDetailState.initial()) {
    on<CounterProposalDetailEvent>((event, emit) async {
      await event.map(
        sendCounterProposal: (value) async {
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
        commuteAllownceChanged: (e) {
          if (e.selectedValue != state.selectedCommuteAllownce.getValue()) {
            emit(state.copyWith(
              selectedCommuteAllownce: InputEmptyOrNot(e.selectedValue),
              commuteHour: InputEmptyOrNot(""),
              commuteRate: Rate(""),
            ));
          }
        },
        commuteHoursChanged: (e) {
          emit(state.copyWith(
            commuteHour: InputEmptyOrNot(e.selectedValue),
          ));
        },
        commuteRateChanged: (e) {
          emit(state.copyWith(
            commuteRate: Rate(e.selectedValue),
          ));
        },
        accomdationAllownceChanged: (e) {
          if (e.selectedValue != state.selectedAccomdationAllownce.getValue()) {
            emit(state.copyWith(
              selectedAccomdationAllownce: InputEmptyOrNot(e.selectedValue),
              accomdationHour: InputEmptyOrNot(""),
              accomdationRate: Rate(""),
            ));
          }
        },
        accomdationHoursChanged: (e) {
          emit(state.copyWith(
            accomdationHour: InputEmptyOrNot(e.selectedValue),
          ));
        },
        accomdationRateChanged: (e) {
          emit(state.copyWith(
            accomdationRate: Rate(e.selectedValue),
          ));
        },
      );
    });
  }
}
