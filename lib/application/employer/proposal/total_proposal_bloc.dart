import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:shift/domain/main/i_main_facade.dart';
import 'package:shift/domain/main/main_failure.dart';
import 'package:shift/infrastructure/core/additional_data_dto/additional_data_dto.dart';
import 'package:shift/infrastructure/core/network/common_response.dart';
import 'package:shift/infrastructure/core/total_proposal_dto/total_proposal_dto.dart';
import 'package:shift/presentation/common/utils/flushbar_creator.dart';

part 'total_proposal_event.dart';

part 'total_proposal_state.dart';

part 'total_proposal_bloc.freezed.dart';

@injectable
class TotalProposalBloc extends Bloc<TotalProposalEvent, TotalProposalState> {
  final IMainFacade _mainFacade;
  final RefreshController refreshController = RefreshController();
  int page = 1;
  int lastPage = 1;

  TotalProposalBloc(this._mainFacade) : super(TotalProposalState.initial()) {
    on<TotalProposalEvent>(
      (event, emit) async {
        await event.map(
          getTotalProposalList: (value) async {
            Either<MainFailure, CommonResponse> failureOrSuccess;

            emit(state.copyWith(isLoading: true));
            failureOrSuccess = await _mainFacade.getEmployerTotalProposal(postId: value.id, page: page);
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
                emit(state.copyWith(isErrorInAPI: true,isLoading: false));
              },
              (r) {
                emit(
                  state.copyWith(
                    additionalData: r.additional_data ?? AdditionalDataDto(),
                    totalProposedDataList: List.from(state.totalProposedDataList)
                      ..addAll(
                        (r.data as List<dynamic>).map((e) => TotalProposalDto.fromJson(e)).toList(),
                      ),
                  ),
                );
              },
            );

            // _mainFacade.getEmployerTotalProposal(postId: value, page: page)
          },
        );
      },
    );
  }
}
