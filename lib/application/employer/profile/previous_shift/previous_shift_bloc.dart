import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:shift/domain/main/i_main_facade.dart';

part 'previous_shift_event.dart';

part 'previous_shift_state.dart';

part 'previous_shift_bloc.freezed.dart';

@injectable
class PreviousShiftBloc extends Bloc<PreviousShiftEvent, PreviousShiftState> {
  final IMainFacade _mainFacade;

  int allPostPage = 1;
  int allPostLastPage = 1;
  int favoritePostPage = 1;
  int favoritePostLastPage = 1;
  int blockedPostPage = 1;
  int blockedPostLastPage = 1;
  int remarkedPostPage = 1;
  int remarkedPostLastPage = 1;

  final RefreshController allPost = RefreshController();
  final RefreshController favorite = RefreshController();
  final RefreshController blocked = RefreshController();
  final RefreshController remarked = RefreshController();

  PreviousShiftBloc(this._mainFacade) : super(PreviousShiftState()) {
    on<PreviousShiftEvent>(
      (event, emit) async {
        event.map(
          tabChangeEvent: (value) => emit(state.copyWith(currentTabIndex: value.tabIndex)),
          ratingChangeEvent: (value) {
            emit(state.copyWith(selectedRating: value.rating));
          },
          fetchAllPreviousPost: (value) async {
            if (value.refresh) {
              allPostPage = 1;
              emit(state.copyWith(allPostList: [], allListLoading: value.refresh));
              allPost.resetNoData();
            } else {
              if (allPostPage > allPostLastPage) {
                allPost.loadNoData();
                return;
              }
            }
            var res = await _mainFacade.getPreviousPost(page: allPostPage, type: 0);
            allPostPage++;
            res.fold(
              (l) => emit(
                state.copyWith(
                  allListIsErrorApi: true,
                  allListLoading: false,
                  allPostList: [],
                ),
              ),
              (r) {
                allPostLastPage = r.meta?.lastPage ?? 1;
                if (value.refresh) {
                  List.from(state.allPostList).clear();
                }

                return emit(
                  state.copyWith(
                    allListLoading: false,
                    allListIsErrorApi: false,

                    allListNoDataFound: (r.data as List<dynamic>).map((e) => e).toList().isEmpty,

                    // upcomingShiftList: List.from(state.upcomingShiftList)
                    //   ..addAll((r.data as List<dynamic>).map((e) => UpComingShiftDTO.fromJson(e)).toList()),

                    allPostList: List.from(state.allPostList)
                      ..addAll((r.data as List<dynamic>).map((e) => e).toList()),
                  ),
                );
              },
            );
          },
          fetchFavoriteList: (value) {},
          fetchBlockedList: (value) {},
          fetchRemarkedList: (value) {},
          deleteRemarkedPost: (value) {},
          blockUnblockPost: (value) {},
          leaveRating: (value) {},
        );
      },
    );
  }
}
