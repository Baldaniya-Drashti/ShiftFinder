import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:shift/domain/main/i_main_facade.dart';
import 'package:shift/infrastructure/core/employer_previous_shift/employer_previous_shift_dto.dart';

part 'hired_contractor_event.dart';

part 'hired_contractor_state.dart';

part 'hired_contractor_bloc.freezed.dart';

@injectable
class HiredContractorBloc
    extends Bloc<HiredContractorEvent, HiredContractorState> {
  final IMainFacade _mainFacade;
  final RefreshController refreshController = RefreshController();
  int page = 1;
  int lastPage = 1;

  HiredContractorBloc(this._mainFacade)
      : super(HiredContractorState.initial()) {
    on<HiredContractorEvent>((event, emit) async {
      event.map(
        getHiredContractorList: (value) async {
          if (value.refresh) {
            page = 1;
            emit(state
                .copyWith(hiredContractorList: [], loading: value.refresh));
            refreshController.resetNoData();
          } else {
            if (page > lastPage) {
              refreshController.loadNoData();
              return;
            }
          }
          var res = await _mainFacade.getHiredContractorList(
              page: page, postId: value.postId);
          page++;
          res.fold(
            (l) => emit(
              state.copyWith(
                  apiError: true, loading: false, hiredContractorList: []),
            ),
            (r) {
              lastPage = r.meta?.lastPage ?? 1;
              if (value.refresh) {
                List.from(state.hiredContractorList).clear();
              }
              return emit(
                state.copyWith(
                  loading: false,
                  apiError: false,
                  noDataFound: (r.data as List<dynamic>)
                      .map((e) => EmployerPreviousShiftDto.fromJson(e))
                      .toList()
                      .isEmpty,
                  hiredContractorList: List.from(state.hiredContractorList)
                    ..addAll(
                      (r.data as List<dynamic>)
                          .map((e) => EmployerPreviousShiftDto.fromJson(e))
                          .toList(),
                    ),
                ),
              );
            },
          );
        },
      );
    });
  }
}
