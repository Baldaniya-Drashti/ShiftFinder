import 'package:auto_route/auto_route.dart';
import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:shift/application/auth/contractor_auth/card_bloc/card_bloc.dart';
import 'package:shift/domain/core/svg_image_constants.dart';
import 'package:shift/domain/main/i_main_facade.dart';
import 'package:shift/domain/main/main_failure.dart';
import 'package:shift/infrastructure/core/network/common_response.dart';
import 'package:shift/infrastructure/core/proposal_detail_dto/proposal_detail_dto.dart';
import 'package:shift/presentation/common/utils/flushbar_creator.dart';
import 'package:shift/presentation/core/app_router.gr.dart';
import 'package:shift/presentation/main/tabs/home/view_single_applicants/widgets/common_card_dialog.dart';

part 'proposal_detail_event.dart';

part 'proposal_detail_state.dart';

part 'proposal_detail_bloc.freezed.dart';

@injectable
class ProposalDetailBloc extends Bloc<ProposalDetailEvent, ProposalDetailState> {
  final IMainFacade _mainFacade;

  ProposalDetailBloc(this._mainFacade) : super(ProposalDetailState.initial()) {
    on<ProposalDetailEvent>((event, emit) async {
      await event.map(
        getProposalDetail: (value) async {
          Either<MainFailure, CommonResponse> failureOrSuccess;
          emit(state.copyWith(isLoading: true));
          failureOrSuccess = await _mainFacade.getProposalDetail(userId: value.userId, postId: value.postId);
          emit(state.copyWith(isLoading: false));

          failureOrSuccess.fold(
            (l) {
              showError(
                message: l.maybeMap(
                  showAPIResponseMessage: (value) => value.message,
                  networkError: (value) => 'Please check your internet connectivity',
                  orElse: () => "Server Error. Try again later.",
                ),
              ).show(value.context);
              emit(state.copyWith(isErrorInAPI: true, isLoading: false));
            },
            (r) {
              final data = ProposalDetailDto.fromJson(r.data);
              emit(
                state.copyWith(proposalDetailDto: data),
              );
            },
          );
        },
        proposalAcceptReject: (ProposalAcceptReject value) async {
          Either<MainFailure, CommonResponse> failureOrSuccess;
          emit(state.copyWith(postDataLoading: true));
          failureOrSuccess = await _mainFacade.proposalAcceptReject(id: value.id, request: value.request);
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
              emit(state.copyWith(isErrorInAPI: true, isLoading: false));
            },
            (r) {
              showSuccess(message: r.dioMessage ?? "").show(value.context);
              if (value.request == 2) {
                value.context.maybePop(true);
                return;
              }
              CommonCardDialog(
                title: 'Awaiting Confirmation',
                description: 'Application accepted, Contractor\nnotified for Confirmation.',
                buttonText: 'Ok',
                onPressed: () {
                  //value.context.router.replace(PageRouteInfo(ViewPersonPraposalView.name));
                  value.context.maybePop(true);
                },
                image: SvgImageConstant.awaitingConfirmation,
              ).addCardDialog(value.context);
            },
          );
        }, addConfirmDialogFlag: (AddConfirmDialogFlag value) {
          emit(state.copyWith(confirmDialog: value.flag));
      },
      );
    });
  }
}
