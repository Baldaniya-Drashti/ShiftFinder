import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:shift/domain/account/i_account_repository.dart';
import 'package:shift/domain/core/svg_image_constants.dart';
import 'package:shift/domain/main/i_main_facade.dart';
import 'package:shift/domain/main/main_failure.dart';
import 'package:shift/infrastructure/core/employer_previous_shift/employer_previous_shift_dto.dart';
import 'package:shift/infrastructure/core/location_dto/location_dto.dart';
import 'package:shift/infrastructure/core/network/common_response.dart';
import 'package:shift/presentation/common/utils/flushbar_creator.dart';
import 'package:shift/presentation/core/logger/logger.dart';
import 'package:shift/presentation/employer/profile/previous_shift_view/previous_shift_all_view.dart';

part 'employer_completed_shift_event.dart';
part 'employer_completed_shift_state.dart';
part 'employer_completed_shift_bloc.freezed.dart';

@injectable
class EmployerCompletedShiftBloc
    extends Bloc<EmployerCompletedShiftEvent, EmployerCompletedShiftState> {
  final IMainFacade _mainFacade;
  final IAccountRepository iAccountRepository;

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

  EmployerCompletedShiftBloc(this._mainFacade, this.iAccountRepository)
      : super(EmployerCompletedShiftState()) {
    on<EmployerCompletedShiftEvent>(
      (event, emit) async {
        await event.map(
          getLocationListAPI: (e) async {
            emit(state.copyWith(postDataLoading: true));
            final locationList = await iAccountRepository.getLocationListApi();
            // print("Location List ---> ${locationList}");
            locationList.fold(
              (l) => emit(
                state.copyWith(
                  postDataLoading: false,
                  locationList: [],
                ),
              ),
              (r) {
                emit(
                  state.copyWith(
                    postDataLoading: false,
                    currentFilledFilter: (r.isNotEmpty) ? r[0] : LocationDTO(),
                    locationList: r,
                  ),
                );
              },
            );
            add(EmployerCompletedShiftEvent.fetchAllCompletedPost(
                refresh: true, sortBy: state.currentFilledFilter.id ?? -1));
          },
          onFilledSorting: (e) {
            if (state.currentFilledFilter != e.currentSorting) {
              add(EmployerCompletedShiftEvent.fetchAllCompletedPost(
                  refresh: true, sortBy: e.currentSorting.id ?? -1));
            }
            emit(state.copyWith(currentFilledFilter: e.currentSorting));
          },
          tabChangeEvent: (value) {
            emit(state.copyWith(
              currentTabIndex: value.tabIndex,
            ));
          },
          ratingChangeEvent: (value) {
            emit(state.copyWith(selectedRating: value.rating));
            add(EmployerCompletedShiftEvent.fetchAllCompletedPost(
                refresh: true, sortBy: value.rating.value));
          },
          fetchAllCompletedPost: (value) async {
            print("Api called after delete--->  ${value.sortBy}");

            Log.debug("value.refresh ${value.refresh}");
            if (value.refresh) {
              currentPage = 1;
              emit(state.copyWith(
                  employerPreviousList: [],
                  allDataListLoading: value.refresh,
                  allDataListNoDataFound: false));
              allPost.resetNoData();
            } else {
              if (currentPage > lastPage) {
                allPost.loadNoData();
                return;
              }
            }
            var res = await _mainFacade.getEmployerCompletedPost(
              page: currentPage,
              type: 0,
              sortBy: value.sortBy,
            );
            currentPage++;
            res.fold(
              (l) => emit(
                state.copyWith(
                  allDataListIsErrorApi: true,
                  allDataListLoading: false,
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
                    allDataListLoading: false,
                    allDataListIsErrorApi: false,
                    allDataListNoDataFound: (r.data as List<dynamic>)
                        .map((e) => EmployerPreviousShiftDto.fromJson(e))
                        .toList()
                        .isEmpty,
                    //  getProductList: []
                    employerPreviousList: List.from(state.employerPreviousList)
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
          fetchFavoriteList: (value) async {
            if (value.refresh) {
              currentPage = 1;
              emit(state.copyWith(
                  favoritesList: [], favoriteListLoading: value.refresh));
              allPost.resetNoData();
            } else {
              if (currentPage > lastPage) {
                allPost.loadNoData();
                return;
              }
            }
            var res = await _mainFacade.getEmployerCompletedPost(
              page: currentPage,
              type: 1,
              sortBy: 0,
            );
            currentPage++;
            res.fold(
              (l) => emit(
                state.copyWith(
                  favoriteListIsErrorApi: true,
                  favoriteListLoading: false,
                  favoritesList: [],
                ),
              ),
              (r) {
                lastPage = r.meta?.lastPage ?? 1;
                if (value.refresh) {
                  List.from(state.favoritesList).clear();
                }
                return emit(
                  state.copyWith(
                    favoriteListLoading: false,
                    favoriteListIsErrorApi: false,
                    favoriteListNoDataFound: (r.data as List<dynamic>)
                        .map((e) => EmployerPreviousShiftDto.fromJson(e))
                        .toList()
                        .isEmpty,
                    //  getProductList: []
                    favoritesList: List.from(state.favoritesList)
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
          fetchBlockedList: (value) async {
            if (value.refresh) {
              currentPage = 1;
              emit(state.copyWith(
                  blockedList: [], blockedListLoading: value.refresh));
              allPost.resetNoData();
            } else {
              if (currentPage > lastPage) {
                allPost.loadNoData();
                return;
              }
            }
            var res = await _mainFacade.getEmployerCompletedPost(
              page: currentPage,
              type: 2,
              sortBy: 0,
            );
            currentPage++;
            res.fold(
              (l) => emit(
                state.copyWith(
                  blockedListIsErrorApi: true,
                  blockedListLoading: false,
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
                    blockedListLoading: false,
                    blockedListIsErrorApi: false,
                    blockedListNoDataFound: (r.data as List<dynamic>)
                        .map((e) => EmployerPreviousShiftDto.fromJson(e))
                        .toList()
                        .isEmpty,
                    //  getProductList: []
                    blockedList: List.from(state.blockedList)
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
          fetchRemarkedList: (value) async {
            if (value.refresh) {
              currentPage = 1;
              emit(state.copyWith(
                  remarkedList: [], remarkedListLoading: value.refresh));
              allPost.resetNoData();
            } else {
              if (currentPage > lastPage) {
                allPost.loadNoData();
                return;
              }
            }
            var res = await _mainFacade.getEmployerCompletedPost(
              page: currentPage,
              type: 3,
              sortBy: 0,
            );
            currentPage++;
            res.fold(
              (l) => emit(
                state.copyWith(
                  remarkedListIsErrorApi: true,
                  remarkedListLoading: false,
                  remarkedList: [],
                ),
              ),
              (r) {
                lastPage = r.meta?.lastPage ?? 1;
                if (value.refresh) {
                  List.from(state.remarkedList).clear();
                }
                return emit(
                  state.copyWith(
                    remarkedListLoading: false,
                    remarkedListIsErrorApi: false,
                    remarkedListNoDataFound: (r.data as List<dynamic>)
                        .map((e) => EmployerPreviousShiftDto.fromJson(e))
                        .toList()
                        .isEmpty,
                    remarkedList: List.from(state.remarkedList)
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
                    networkError: (value) =>
                        'Please check your internet connectivity',
                    orElse: () => "Server Error. Try again later.",
                  ),
                ).show(value.context);
              },
              (r) {
                add(EmployerCompletedShiftEvent.fetchAllCompletedPost(
                    refresh: true, sortBy: state.currentFilledFilter.id ?? -1));
                add(EmployerCompletedShiftEvent.fetchBlockedList(
                    refresh: true));
                // final tempList = [...state.employerPreviousList];
                // final index = tempList.indexWhere((element) => element.post_id == value.postId);
                //
                // tempList[index] = tempList[index].copyWith(
                //   isBlock: !(tempList[index].isBlock ?? false),
                // );
                // emit(state.copyWith(employerPreviousList: tempList));
                showSuccess(message: r.dioMessage ?? "").show(value.context);
              },
            );
          },
          leaveRating: (value) async {
            Either<MainFailure, CommonResponse>? failureOrSuccess;
            emit(state.copyWith(postDataLoading: true));
            failureOrSuccess = await _mainFacade.addEmployerRating(
              postId: value.postId,
              userId: value.userId,
              rating: value.rating,
            );
            emit(state.copyWith(postDataLoading: false));
            failureOrSuccess.fold(
              (l) {
                showError(
                  message: l.maybeMap(
                    showAPIResponseMessage: (value) => value.message,
                    networkError: (value) =>
                        'Please check your internet connectivity',
                    orElse: () => "Server Error. Try again later.",
                  ),
                ).show(value.context);
              },
              (r) {
                add(EmployerCompletedShiftEvent.fetchAllCompletedPost(
                    refresh: true, sortBy: state.currentFilledFilter.id ?? -1));
                showSuccess(message: r.dioMessage ?? "").show(value.context);
              },
            );
          },
          addFavorite: (AddFavorite value) async {
            Either<MainFailure, CommonResponse>? failureOrSuccess;
            emit(state.copyWith(postDataLoading: true));
            failureOrSuccess = await _mainFacade.addFavorite(
                postId: value.postId, userId: value.userId);
            emit(state.copyWith(postDataLoading: false));

            failureOrSuccess.fold(
              (l) {
                showError(
                  message: l.maybeMap(
                    showAPIResponseMessage: (value) => value.message,
                    networkError: (value) =>
                        'Please check your internet connectivity',
                    orElse: () => "Server Error. Try again later.",
                  ),
                ).show(value.context);
              },
              (r) {
                // final tempList = [...state.employerPreviousList];
                // final index = tempList.indexWhere((element) => element.post_id == value.postId);
                // tempList[index] = tempList[index].copyWith(isFavourite: true);
                // emit(state.copyWith(employerPreviousList: tempList));
                add(EmployerCompletedShiftEvent.fetchAllCompletedPost(
                    refresh: true, sortBy: state.currentFilledFilter.id ?? -1));
                add(EmployerCompletedShiftEvent.fetchFavoriteList(
                    refresh: true));

                showSuccess(message: r.dioMessage ?? "").show(value.context);
              },
            );
          },
          addUnFavorite: (AddUnFavorite value) async {
            Either<MainFailure, CommonResponse>? failureOrSuccess;
            emit(state.copyWith(postDataLoading: true));
            failureOrSuccess = await _mainFacade.addUnFavorite(
                postId: value.postId, userId: value.userId);
            emit(state.copyWith(postDataLoading: false));
            failureOrSuccess.fold(
              (l) {
                showError(
                  message: l.maybeMap(
                    showAPIResponseMessage: (value) => value.message,
                    networkError: (value) =>
                        'Please check your internet connectivity',
                    orElse: () => "Server Error. Try again later.",
                  ),
                ).show(value.context);
              },
              (r) {
                // final tempList = [...state.favoritesList];
                // final index = tempList.indexWhere((element) => element.post_id == value.postId);
                // tempList[index] = tempList[index].copyWith(isFavourite: false);
                // emit(state.copyWith(employerPreviousList: tempList));
                //
                // emit(state.copyWith(favoritesList: tempList, favoriteListNoDataFound: tempList.isEmpty));
                add(EmployerCompletedShiftEvent.fetchAllCompletedPost(
                    refresh: true, sortBy: state.currentFilledFilter.id ?? -1));
                add(EmployerCompletedShiftEvent.fetchFavoriteList(
                    refresh: true));
                showSuccess(message: r.dioMessage ?? "").show(value.context);
              },
            );
          },
          addRemark: (AddRemark value) async {
            Either<MainFailure, CommonResponse>? failureOrSuccess;
            emit(state.copyWith(postDataLoading: true));
            failureOrSuccess = await _mainFacade.employerAddRemark(
              postId: value.postId,
              userId: value.userId,
              remark: value.remark,
            );
            emit(state.copyWith(postDataLoading: false));
            failureOrSuccess.fold(
              (l) {
                showError(
                  message: l.maybeMap(
                    showAPIResponseMessage: (value) => value.message,
                    networkError: (value) =>
                        'Please check your internet connectivity',
                    orElse: () => "Server Error. Try again later.",
                  ),
                ).show(value.context);
              },
              (r) {
                add(EmployerCompletedShiftEvent.fetchAllCompletedPost(
                    refresh: true, sortBy: state.currentFilledFilter.id ?? -1));
                add(EmployerCompletedShiftEvent.fetchRemarkedList(
                  refresh: true,
                ));
                showSuccess(message: r.dioMessage ?? "").show(value.context);
              },
            );
          },
          deleteRemark: (DeleteRemark value) async {
            Either<MainFailure, CommonResponse>? failureOrSuccess;
            emit(state.copyWith(postDataLoading: true));
            failureOrSuccess = await _mainFacade.deleteRemark(id: value.id);
            emit(state.copyWith(postDataLoading: false));
            failureOrSuccess.fold(
              (l) {
                showError(
                  message: l.maybeMap(
                    showAPIResponseMessage: (value) => value.message,
                    networkError: (value) =>
                        'Please check your internet connectivity',
                    orElse: () => "Server Error. Try again later.",
                  ),
                ).show(value.context);
              },
              (r) {
                add(EmployerCompletedShiftEvent.fetchAllCompletedPost(
                    refresh: true, sortBy: state.currentFilledFilter.id ?? -1));
                add(EmployerCompletedShiftEvent.fetchRemarkedList(
                    refresh: true));
                showSuccess(message: r.dioMessage ?? "").show(value.context);
              },
            );
          },
        );
      },
    );
  }
}
