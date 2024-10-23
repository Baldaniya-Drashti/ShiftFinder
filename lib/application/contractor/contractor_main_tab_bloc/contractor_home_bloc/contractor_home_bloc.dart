import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:shift/domain/core/string_constant.dart';
import 'package:shift/domain/main/i_main_facade.dart';
import 'package:shift/domain/main/main_failure.dart';
import 'package:shift/infrastructure/core/contractor_home/contractor_dashboard_dto.dart';
import 'package:shift/infrastructure/main/healthcare_post/healthcare_post_dto.dart';
import 'package:shift/presentation/common/utils/flushbar_creator.dart';

part 'contractor_home_state.dart';
part 'contractor_home_event.dart';
part 'contractor_home_bloc.freezed.dart';

@injectable
class ContractorHomeBloc
    extends Bloc<ContractorHomeEvent, ContractorHomeState> {
  int page = 1;
  int lastPage = 1;
  Timer? searchOnStoppedTyping;
  bool isFetching = false;
  final RefreshController refreshController = RefreshController();
  final IMainFacade mainFacade;
  ContractorHomeBloc(this.mainFacade) : super(ContractorHomeState.initial()) {
    on<ContractorHomeEvent>((event, emit) async {
      await event.map(
        getShiftDetailEvent: (e) async {
          Either<MainFailure, HealthcarePostDTO>? failureOrSuccess;
          emit(
            state.copyWith(isLoading: true),
          );
          failureOrSuccess = await mainFacade.getPostApi(
            postId: e.postId,
          );

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
          );
        },
        deletePost: (e) async {
          final res = await mainFacade.deletePostApi(postId: e.postId);
          res.fold(
            (l) => emit(
              state.copyWith(
                isErrorInAPI: true,
                isLoading: false,
              ),
            ),
            (r) {
              emit(
                state.copyWith(
                  isLoading: false,
                  isErrorInAPI: false,
                ),
              );
              add(ContractorHomeEvent.getContractorDashboardList(true));
            },
          );
        },
        initialEvent: (e) async {},
        getContractorDashboardList: (e) async {
          if (e.isRefresh) {
            page = 1;
            emit(state
                .copyWith(contractorDashboardList: [], isLoading: e.isRefresh));
            refreshController.resetNoData();
          } else {
            if (page > lastPage) {
              refreshController.loadNoData();
              return;
            }
          }

          var res = await mainFacade.getContractorDashboardListAPI(
              page: page, filterType: state.filterType);

          page++;

          res.fold(
            (l) => emit(
              state.copyWith(
                isErrorInAPI: true,
                isLoading: false,
                contractorDashboardList: [],
              ),
            ),
            (r) {
              lastPage = r.meta?.lastPage ?? 1;
              if (e.isRefresh) {
                List.from(state.contractorDashboardList).clear();
              }
              return emit(
                state.copyWith(
                  isLoading: false,
                  isErrorInAPI: false,
                  isNoDataFound: (r.data as List<dynamic>)
                      .map((e) => ContactorDashboardDTO.fromJson(e))
                      .toList()
                      .isEmpty,
                  //  getProductList: []
                  contractorDashboardList:
                      List.from(state.contractorDashboardList)
                        ..addAll((r.data as List<dynamic>)
                            .map((e) => ContactorDashboardDTO.fromJson(e))
                            .toList()),
                ),
              );
            },
          );
        },
        filterShiftEvent: (e) async {
          final type = (e.filterType == StringConstant.singleShifts)
              ? 1
              : (e.filterType == StringConstant.multiShifts)
                  ? 2
                  : 0;

          if (type != state.filterType) {
            emit(
              state.copyWith(filterType: type),
            );
            add(ContractorHomeEvent.getContractorDashboardList(true));
            /* emit(
              state.copyWith(
                isLoading: true,
              ),
            );
            await Future.delayed(Duration(seconds: 3));
            emit(
              state.copyWith(
                isLoading: false,
                filterType: type,
              ),
            );*/
          }
        },
        applyShiftSubmittedEvent: (e) async {
          Either<MainFailure, String>? failureOrSuccess;

          failureOrSuccess = await mainFacade.contractorApplyOrSendProposal(
            mapData: {
              'post_id': e.postId ?? -1,
              'shift_type': 1,
            },
          );

          failureOrSuccess.fold(
            (l) {
              e.context.router.maybePop();
              showError(
                message: l.maybeMap(
                  showAPIResponseMessage: (value) => value.message,
                  networkError: (value) =>
                      'Please check your internet connectivity',
                  orElse: () => "Server Error. Try again later.",
                ),
              ).show(e.context);
            },
            (r) {
              e.context.router.maybePop();
              showSuccess(message: r).show(e.context).then((value) {
                add(ContractorHomeEvent.getContractorDashboardList(true));
              });
            },
          );
        },
      );
    });
  }
}
