import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:shift/domain/account/account.dart';
import 'package:shift/domain/account/account_failure.dart';
import 'package:shift/domain/account/i_account_repository.dart';
import 'package:shift/domain/main/i_main_facade.dart';
import 'package:shift/infrastructure/core/contractor_previus_shift_dto/contractor_previus_shift_dto.dart';
import 'package:shift/infrastructure/core/contractor_refer_collegue_dto/contractor_refer_collegue_dto.dart';

part 'refer_colleague_event.dart';
part 'refer_colleague_state.dart';
part 'refer_colleague_bloc.freezed.dart';

@injectable
class ReferColleagueBloc
    extends Bloc<ReferColleagueEvent, ReferColleagueState> {
  final IMainFacade mainFacade;
  final IAccountRepository accontRepository;

  int currentPage = 1;
  int lastPage = 1;

  final RefreshController refreshController = RefreshController();
  ReferColleagueBloc(this.mainFacade, this.accontRepository)
      : super(ReferColleagueState.initial()) {
    on<ReferColleagueEvent>((event, emit) async {
      await event.map(
        getReferredColleagueData: (GetCompletedList e) async {
          if (e.isRefresh) {
            currentPage = 1;
            emit(state.copyWith(
              collegueList: [],
              isLoading: e.isRefresh,
            ));
            refreshController.resetNoData();
          } else {
            if (currentPage > lastPage) {
              refreshController.loadNoData();
              return;
            }
          }
          var res = await mainFacade.getReferCollegueAPI(
            page: currentPage,
          );
          currentPage++;
          res.fold(
            (l) => emit(
              state.copyWith(
                isErrorInApi: true,
                isLoading: false,
                collegueList: [],
              ),
            ),
            (r) {
              lastPage = r.meta?.lastPage ?? 1;
              if (e.isRefresh) {
                List.from(state.collegueList).clear();
              }

              emit(
                state.copyWith(
                  isLoading: false,
                  isErrorInApi: false,
                  noDataFound: (r.data as List<dynamic>)
                      .map((e) => ReferColleagueDTO.fromJson(e))
                      .toList()
                      .isEmpty,
                  collegueList: List.from(state.collegueList)
                    ..addAll((r.data as List<dynamic>)
                        .map((e) => ReferColleagueDTO.fromJson(e))
                        .toList()),
                ),
              );
            },
          );
        },
        getCollegueProfile: (e) async {
          /* Either<AccountFailure, Account>? failureOrSuccess;
          emit(
            state.copyWith(isLoading: true)
          );
          failureOrSuccess = await accontRepository.getCurrentUserApi();

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
          ); */
        },
      );
    });
  }
}
