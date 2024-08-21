import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:shift/application/employer/add_full_position/add_full_position_bloc.dart';
import 'package:shift/domain/main/i_main_facade.dart';
import 'package:shift/domain/main/main_failure.dart';
import 'package:shift/infrastructure/core/employer_saved_template/employer_saved_template_dto.dart';
import 'package:shift/infrastructure/core/network/common_response.dart';
import 'package:shift/presentation/common/utils/flushbar_creator.dart';
part 'save_template_event.dart';
part 'save_template_state.dart';
part 'save_template_bloc.freezed.dart';

@injectable
class SaveTemplateBloc extends Bloc<SaveTemplateEvent, SaveTemplateState> {
  int currentPage = 1;
  int lastPage = 1;
  final RefreshController refreshController = RefreshController();
  final IMainFacade _mainFacade;

  SaveTemplateBloc(this._mainFacade) : super(const SaveTemplateState()) {
    on<SaveTemplateEvent>((event, emit) async {
      await event.map(
        onFilterChanged: (value) {
          emit(state.copyWith(selectedFilterType: value.value));
          add(SaveTemplateEvent.getSavedTemplateList(value.context,
              refresh: true));
        },
        getSavedTemplateList: (GetSavedTemplateList value) async {
          print("loaddiinn---> ${value.refresh}");
          if (value.refresh) {
            currentPage = 1;
            emit(state.copyWith(
              savedTemplateList: [],
              loading: value.refresh,
              noDataFound: false,
            ));
            refreshController.resetNoData();
          } else {
            if (currentPage > lastPage) {
              refreshController.loadNoData();
              return;
            }
          }
          var res = await _mainFacade.employerSavedTemplate(
              page: currentPage,
              shiftType: state.selectedFilterType?.id ?? 1,
              sameOrDifferentTime: state.selectedFilterType?.id == 2
                  ? state.selectedMultiShift
                  : null,
              search: state.searchQuery);
          currentPage++;
          res.fold(
            (l) {
              showError(
                message: l.maybeMap(
                  showAPIResponseMessage: (value) => value.message,
                  networkError: (value) =>
                      'Please check your internet connectivity',
                  orElse: () => "Something went wrong!",
                ),
              ).show(value.context);
              emit(
                state.copyWith(
                  error: true,
                  loading: false,
                  savedTemplateList: [],
                ),
              );
            },
            (r) {
              lastPage = r.meta?.lastPage ?? 1;
              if (value.refresh) {
                List.from(state.savedTemplateList).clear();
              }
              return emit(
                state.copyWith(
                  loading: false,
                  error: false,
                  noDataFound: (r.data as List<dynamic>)
                      .map((e) => EmployerSavedTemplateDto.fromJson(e))
                      .toList()
                      .isEmpty,
                  //  getProductList: []
                  savedTemplateList: List.from(state.savedTemplateList)
                    ..addAll(
                      (r.data as List<dynamic>)
                          .map((e) => EmployerSavedTemplateDto.fromJson(e))
                          .toList(),
                    ),
                ),
              );
            },
          );
        },
        onSelectMultiShift: (OnSelectMultiShift value) {
          emit(state.copyWith(selectedMultiShift: value.type));
          add(SaveTemplateEvent.getSavedTemplateList(value.context,
              refresh: true));
        },
        onSearchJobRole: (OnSearchJobRole value) {
          emit(state.copyWith(searchQuery: value.query));
          add(SaveTemplateEvent.getSavedTemplateList(value.context,
              refresh: true, search: value.query));
        },
        onDeleteCodeSavedTemplate: (OnDeleteCodeSavedTemplate value) async {
          Either<MainFailure, CommonResponse>? failureOrSuccess;
          emit(state.copyWith(postDataLoading: true));
          failureOrSuccess = await _mainFacade.deleteEmployerSavedTemplate(
            id: value.id,
            shiftType: value.shiftType,
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
              add(SaveTemplateEvent.getSavedTemplateList(value.context,
                  refresh: true));
              showSuccess(message: r.dioMessage ?? "").show(value.context);
            },
          );
        },
      );
    });
  }
}
