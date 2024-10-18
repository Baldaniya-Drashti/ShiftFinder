import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:shift/domain/main/i_main_facade.dart';
import 'package:shift/domain/main/main_failure.dart';
import 'package:shift/infrastructure/core/additional_data_dto/additional_data_dto.dart';
import 'package:shift/infrastructure/core/employer_proposal_dto/employer_proposal_dto.dart';
import 'package:shift/infrastructure/core/network/common_response.dart';
import 'package:shift/presentation/common/utils/flushbar_creator.dart';
import 'package:shift/presentation/core/logger/logger.dart';

part 'total_proposal_event.dart';

part 'total_proposal_state.dart';

part 'total_proposal_bloc.freezed.dart';

@injectable
class TotalProposalBloc extends Bloc<TotalProposalEvent, TotalProposalState> {
  final IMainFacade _mainFacade;
  final RefreshController refreshController = RefreshController();
  int page = 1;
  int lastPage = 1;
  Timer? _timer;

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
                emit(state.copyWith(isErrorInAPI: true, isLoading: false));
              },
              (r) {
                Log.success("=> ${r.data}");
                Log.debug("==> ${r.pending_users}");
                final totalProposedDataList = r.data;

                emit(
                  state.copyWith(
                    additionalData: EmployerProposalDto.fromJson(r.data),
                    totalProposedDataList: r.pending_users ?? [],
                  ),
                );
                // for (var i in totalProposedDataList) {
                //   if (i.revoke_status == 1) {
                //     add(
                //       TotalProposalEvent.startRevokingTimer(
                //         duration: Duration(hours: 2),
                //         postId: i.id ?? -1,
                //         revokeTime: i.revoke_start ?? -1,
                //       ),
                //     );
                //   }
                // }
              },
            );

            // _mainFacade.getEmployerTotalProposal(postId: value, page: page)
          },
          startRevokingTimer: (StartRevokingTimer value) {
            DateTime timerStartTime = DateTime.fromMillisecondsSinceEpoch(value.revokeTime * 1000);

            Duration totalDuration = Duration(hours: 2);

            state.totalProposedDataList.map((shift) {
              if (shift.id == value.postId) {
                // if (shift.revoke_status == 1) {
                Duration remainingTime = calculateRemainingTime(timerStartTime, totalDuration);

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

  Duration calculateRemainingTime(DateTime timerStartTime, Duration totalDuration) {
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
      totalProposedDataList: state.totalProposedDataList.map((s) {
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
}
