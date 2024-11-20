import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:shift/domain/main/i_main_facade.dart';

part 'contractor_rating_event.dart';

part 'contractor_rating_state.dart';

part 'contractor_rating_bloc.freezed.dart';

@injectable
class ContractorRatingBloc extends Bloc<ContractorRatingEvent, ContractorRatingState> {
  final RefreshController refreshController = RefreshController();
  int currentPage = 1;
  int lastPage = 1;
  final IMainFacade _mainFacade;

  ContractorRatingBloc(this._mainFacade) : super(const ContractorRatingState()) {
    on<ContractorRatingEvent>((event, emit) async {
      await event.map(
        getRatingList: (value) async {
          if (value.refresh) {
            currentPage = 1;
            emit(state.copyWith(ratingList: [], loading: value.refresh));
            refreshController.resetNoData();
          } else {
            if (currentPage > lastPage) {
              refreshController.loadNoData();
              return;
            }
          }
          var res = await _mainFacade.getContractorRatings(
            page: currentPage,
          );
          currentPage++;
          res.fold(
            (l) => emit(
              state.copyWith(
                error: true,
                loading: false,
                ratingList: [],
              ),
            ),
            (r) {
              lastPage = r.meta?.lastPage ?? 1;
              if (value.refresh) {
                List.from(state.ratingList).clear();
              }
              return emit(
                state.copyWith(
                  loading: false,
                  error: false,
                  noDataFound: true,//(r.data as List<dynamic>).map((e) => EmployerPreviousShiftDto.fromJson(e)).toList().isEmpty,
                  ratingList: List.from(state.ratingList)
                    // ..addAll(
                    //   (r.data as List<dynamic>).map((e) => EmployerPreviousShiftDto.fromJson(e)).toList(),
                    // ),
                ),
              );
            },
          );
        },
      );
    });
  }
}
