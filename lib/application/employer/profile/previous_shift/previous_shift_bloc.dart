import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:shift/domain/main/i_main_facade.dart';
import 'package:shift/domain/main/main_failure.dart';
import 'package:shift/infrastructure/core/employer_previous_shift/employer_previous_shift_dto.dart';
import 'package:shift/infrastructure/core/network/common_response.dart';
import 'package:shift/presentation/common/utils/flushbar_creator.dart';
import 'package:shift/presentation/core/logger/logger.dart';

part 'previous_shift_event.dart';

part 'previous_shift_state.dart';

part 'previous_shift_bloc.freezed.dart';

@injectable
class PreviousShiftBloc extends Bloc<PreviousShiftEvent, PreviousShiftState> {
  final IMainFacade _mainFacade;

  int currentPage = 1;
  int lastPage = 1;
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
        await event.map(
          tabChangeEvent: (value) {
            final index = value.tabIndex;
            print("index $index");
            if (index == 1) {
              add(PreviousShiftEvent.fetchAllPreviousPost(refresh: true));
            } else if (index == 2) {
              add(PreviousShiftEvent.fetchFavoriteList(refresh: true));
            } else if (index == 3) {
              add(PreviousShiftEvent.fetchBlockedList(refresh: true));
            } else if (index == 4) {
              add(PreviousShiftEvent.fetchRemarkedList(refresh: true));
            }

            emit(state.copyWith(
              currentTabIndex: value.tabIndex,
            ));
          },
          ratingChangeEvent: (value) {
            emit(state.copyWith(selectedRating: value.rating));
          },
          fetchAllPreviousPost: (value) async {
            print("Api called after delete--->");

            Log.debug("value.refresh ${value.refresh}");
            if (value.refresh) {
              currentPage = 1;
              emit(state.copyWith(employerPreviousList: [], getDataLoading: value.refresh));
              allPost.resetNoData();
            } else {
              if (currentPage > lastPage) {
                allPost.loadNoData();
                return;
              }
            }
            var res = await _mainFacade.getPreviousPost(
              page: currentPage,
              type: 0,
              sortBy: 0,
            );
            currentPage++;
            res.fold(
              (l) => emit(
                state.copyWith(
                  errorApi: true,
                  getDataLoading: false,
                  employerPreviousList: [],
                ),
              ),
              (r) {
                lastPage = r.meta?.lastPage ?? 1;
                if (value.refresh) {
                  List.from(state.employerPreviousList).clear();
                }
                return emit(
                  state.copyWith(
                    getDataLoading: false,
                    errorApi: false,
                    noDataFound: (r.data as List<dynamic>).map((e) => EmployerPreviousShiftDto.fromJson(e)).toList().isEmpty,
                    //  getProductList: []
                    employerPreviousList: List.from(state.employerPreviousList)
                      ..addAll(
                        (r.data as List<dynamic>).map((e) => EmployerPreviousShiftDto.fromJson(e)).toList(),
                      ),
                  ),
                );
              },
            );
          },
          fetchFavoriteList: (value) async {
            if (value.refresh) {
              currentPage = 1;
              emit(state.copyWith(employerPreviousList: [], getDataLoading: value.refresh));
              allPost.resetNoData();
            } else {
              if (currentPage > lastPage) {
                allPost.loadNoData();
                return;
              }
            }
            var res = await _mainFacade.getPreviousPost(
              page: currentPage,
              type: 1,
              sortBy: 0,
            );
            currentPage++;
            res.fold(
              (l) => emit(
                state.copyWith(
                  errorApi: true,
                  getDataLoading: false,
                  employerPreviousList: [],
                ),
              ),
              (r) {
                lastPage = r.meta?.lastPage ?? 1;
                if (value.refresh) {
                  List.from(state.employerPreviousList).clear();
                }
                return emit(
                  state.copyWith(
                    getDataLoading: false,
                    errorApi: false,
                    noDataFound: (r.data as List<dynamic>).map((e) => EmployerPreviousShiftDto.fromJson(e)).toList().isEmpty,
                    //  getProductList: []
                    favoritesList: List.from(state.employerPreviousList)
                      ..addAll(
                        (r.data as List<dynamic>).map((e) => EmployerPreviousShiftDto.fromJson(e)).toList(),
                      ),
                  ),
                );
              },
            );
          },
          fetchBlockedList: (value) async {
            if (value.refresh) {
              currentPage = 1;
              emit(state.copyWith(blockedList: [], getDataLoading: value.refresh));
              allPost.resetNoData();
            } else {
              if (currentPage > lastPage) {
                allPost.loadNoData();
                return;
              }
            }
            var res = await _mainFacade.getPreviousPost(
              page: currentPage,
              type: 2,
              sortBy: 0,
            );
            currentPage++;
            res.fold(
              (l) => emit(
                state.copyWith(
                  errorApi: true,
                  getDataLoading: false,
                  blockedList: [],
                ),
              ),
              (r) {
                lastPage = r.meta?.lastPage ?? 1;
                if (value.refresh) {
                  List.from(state.blockedList).clear();
                }
                return emit(
                  state.copyWith(
                    getDataLoading: false,
                    errorApi: false,
                    noDataFound: (r.data as List<dynamic>).map((e) => EmployerPreviousShiftDto.fromJson(e)).toList().isEmpty,
                    //  getProductList: []
                    blockedList: List.from(state.blockedList)
                      ..addAll(
                        (r.data as List<dynamic>).map((e) => EmployerPreviousShiftDto.fromJson(e)).toList(),
                      ),
                  ),
                );
              },
            );
          },
          fetchRemarkedList: (value) async {
            if (value.refresh) {
              currentPage = 1;
              emit(state.copyWith(remarkedList: [], getDataLoading: value.refresh));
              allPost.resetNoData();
            } else {
              if (currentPage > lastPage) {
                allPost.loadNoData();
                return;
              }
            }
            var res = await _mainFacade.getPreviousPost(
              page: currentPage,
              type: 3,
              sortBy: 0,
            );
            currentPage++;
            res.fold(
                  (l) => emit(
                state.copyWith(
                  errorApi: true,
                  getDataLoading: false,
                  remarkedList: [],
                ),
              ),
                  (r) {
                lastPage = r.meta?.lastPage ?? 1;
                if (value.refresh) {
                  List.from(state.employerPreviousList).clear();
                }
                return emit(
                  state.copyWith(
                    getDataLoading: false,
                    errorApi: false,
                    noDataFound: (r.data as List<dynamic>).map((e) => EmployerPreviousShiftDto.fromJson(e)).toList().isEmpty,
                    //  getProductList: []
                    remarkedList: List.from(state.employerPreviousList)
                      ..addAll(
                        (r.data as List<dynamic>).map((e) => EmployerPreviousShiftDto.fromJson(e)).toList(),
                      ),
                  ),
                );
              },
            );
          },
          deleteRemarkedPost: (value) {},
          blockUnblockPost: (BlockPost value) async {
            Either<MainFailure, CommonResponse>? failureOrSuccess;
            emit(state.copyWith(postDataLoading: true));
            failureOrSuccess = await _mainFacade.employerBlockUnblock(
              postId: value.postId,
              userId: value.userId,
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
                final tempList = [...state.employerPreviousList];
                final index = tempList.indexWhere((element) => element.post_id == value.postId);

                tempList[index] = tempList[index].copyWith(
                  isBlock: !(tempList[index].isBlock ?? false),
                );
                emit(state.copyWith(employerPreviousList: tempList));
                showSuccess(message: r.dioMessage ?? "").show(value.context);
              },
            );
          },
          leaveRating: (value) {},
          addFavorite: (AddFavorite value) async {
            Either<MainFailure, CommonResponse>? failureOrSuccess;
            emit(state.copyWith(postDataLoading: true));
            failureOrSuccess = await _mainFacade.addFavorite(postId: value.postId, userId: value.userId);
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
                final tempList = [...state.employerPreviousList];
                final index = tempList.indexWhere((element) => element.post_id == value.postId);
                tempList[index] = tempList[index].copyWith(isFavourite: true);
                emit(state.copyWith(employerPreviousList: tempList));
                showSuccess(message: r.dioMessage ?? "").show(value.context);
              },
            );
          },
          addUnFavorite: (AddUnFavorite value) async {
            Either<MainFailure, CommonResponse>? failureOrSuccess;
            emit(state.copyWith(postDataLoading: true));
            failureOrSuccess = await _mainFacade.addUnFavorite(postId: value.postId, userId: value.userId);
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
                final tempList = [...state.favoritesList];
                tempList.removeWhere((element) => element.post_id == value.postId);
                emit(state.copyWith(favoritesList: tempList, noDataFound: tempList.isEmpty));
                showSuccess(message: r.dioMessage ?? "").show(value.context);
              },
            );
          },
        );
      },
    );
  }
}
