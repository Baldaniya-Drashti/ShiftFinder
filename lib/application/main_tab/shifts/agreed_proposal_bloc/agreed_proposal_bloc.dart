import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:shift/domain/main/i_main_facade.dart';
import 'package:shift/domain/main/main_failure.dart';
import 'package:shift/infrastructure/core/employer_proposal_dto/employer_proposal_dto.dart';
import 'package:shift/infrastructure/core/network/common_response.dart';
import 'package:shift/presentation/common/utils/flushbar_creator.dart';
part 'agreed_proposal_event.dart';
part 'agreed_proposal_state.dart';
part 'agreed_proposal_bloc.freezed.dart';
// failureOrSuccess = await _mainFacade.getProposalDetail(userId: value.userId, postId: value.postId);

@injectable
class AgreedProposalBloc
    extends Bloc<AgreedProposalEvent, AgreedProposalState> {
  final IMainFacade mainFacade;

  AgreedProposalBloc(this.mainFacade) : super(AgreedProposalState.initial()) {
    on<AgreedProposalEvent>((event, emit) async {
      await event.map(
        getProposalDataEvent: (e) async {
          Either<MainFailure, CommonResponse> failureOrSuccess;
          emit(state.copyWith(isLoading: true));
          failureOrSuccess = await mainFacade.getProposalDetail(
              userId: e.userId, postId: e.postId);
          emit(state.copyWith(isLoading: false));

          failureOrSuccess.fold(
            (l) {
              showError(
                message: l.maybeMap(
                  showAPIResponseMessage: (value) => value.message,
                  networkError: (value) =>
                      'Please check your internet connectivity',
                  orElse: () => "Server Error. Try again later.",
                ),
              ).show(e.context);
              emit(state.copyWith(errorApi: true, isLoading: false));
            },
            (r) {
              final data = EmployerProposalDto.fromJson(r.data);
              emit(
                state.copyWith(contractorDetail: data),
              );
            },
          );
        },
      );
    });
  }
}
