import 'dart:async';
import 'package:auto_route/auto_route.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:shift/domain/core/math_utils.dart';
import 'package:shift/domain/core/string_constant.dart';
import 'package:shift/domain/main/i_main_facade.dart';
import 'package:shift/domain/main/main_failure.dart';
import 'package:shift/infrastructure/core/employer_home/employer_dashboard_dto.dart';
import 'package:shift/infrastructure/main/team_dto/team_dto.dart';
import 'package:shift/presentation/common/utils/flushbar_creator.dart';
import 'package:shift/presentation/common/utils/get_cookie.dart';
import 'package:shift/presentation/common/widgets/base_text.dart';
import 'package:shift/presentation/core/app_router.gr.dart';
import 'package:shift/presentation/core/logger/logger.dart';
import 'package:shift/presentation/core/style/app_colors.dart';
import 'package:shift/presentation/core/widgets/dialogs/app_dialog.dart';

part 'home_state.dart';

part 'home_event.dart';

part 'home_bloc.freezed.dart';

@injectable
class HomeBloc extends Bloc<HomeEvent, HomeState> {
  int page = 1;
  int lastPage = 1;
  Timer? searchOnStoppedTyping;
  bool isFetching = false;
  final RefreshController refreshController = RefreshController();
  final IMainFacade mainFacade;

  HomeBloc(this.mainFacade) : super(HomeState.initial()) {
    on<HomeEvent>((event, emit) async {
      await event.map(
        deletePost: (e) async {
          final res = await mainFacade.deletePostApi(postId: e.postId);
          res.fold(
            (l) => emit(
              state.copyWith(
                isErrorInAPI: true,
                isLoading: false,
                teamStatusFailureOrSuccessOption: none(),
              ),
            ),
            (r) {
              emit(
                state.copyWith(
                  isLoading: false,
                  isErrorInAPI: false,
                  teamStatusFailureOrSuccessOption: none(),
                ),
              );
              add(HomeEvent.getEmployerDashboardList(true));
            },
          );
        },
        initialEvent: (e) async {
          // emit(const HomeState.loadInProgress());
        },
        getEmployerDashboardList: (e) async {
          print("Api called after delete--->");
          if (e.isRefresh) {
            page = 1;
            emit(state
                .copyWith(employerDashboardList: [], isLoading: e.isRefresh));
            refreshController.resetNoData();
          } else {
            if (page > lastPage) {
              refreshController.loadNoData();
              return;
            }
          }
          var res = await mainFacade.getEmployerDashboardListAPI(page: page);
          page++;
          res.fold(
            (l) => emit(
              state.copyWith(
                isErrorInAPI: true,
                isLoading: false,
                employerDashboardList: [],
              ),
            ),
            (r) {
              lastPage = r.meta?.lastPage ?? 1;
              if (e.isRefresh) {
                List.from(state.employerDashboardList).clear();
              }
              return emit(
                state.copyWith(
                  isLoading: false,
                  isErrorInAPI: false,
                  isNoDataFound: (r.data as List<dynamic>)
                      .map((e) => EmployerDashboardDTO.fromJson(e))
                      .toList()
                      .isEmpty,
                  //  getProductList: []
                  employerDashboardList: List.from(state.employerDashboardList)
                    ..addAll((r.data as List<dynamic>)
                        .map((e) => EmployerDashboardDTO.fromJson(e))
                        .toList()),
                ),
              );
            },
          );
        },
        dontShowAgain: (e) {
          emit(state.copyWith(
            showTeamDialog: e.isCheck,
            teamStatusErrorMessage: false,
            teamStatusFailureOrSuccessOption: none(),
          ));
        },
        checkTeamAvailableEvent: (e) async {
          emit(
            state.copyWith(
              teamStatusErrorMessage: true,
              teamStatusFailureOrSuccessOption: none(),
            ),
          );
          final res = await mainFacade.employerTeamCheck();
          emit(
            state.copyWith(
              teamStatusErrorMessage: false,
              teamStatusFailureOrSuccessOption: optionOf(res),
            ),
          );
          res.fold(
            (l) {
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
              emit(
                state.copyWith(
                  teamStatusErrorMessage: false,
                  teamStatusFailureOrSuccessOption: optionOf(res),
                ),
              );

              // if (r.isTeamAvailable == 1 || getShowTeamDialog() == true) {

              print(
                  "getCurrentUser().isDialogBox---> ${getCurrentUser().isDialogBox}");

              if (r.isTeamAvailable == 1 || getCurrentUser().isDialogBox == 1) {
                e.context.router
                    .push(PageRouteInfo(HealthCarePostForm.name))
                    .then((value) {
                  print("value------> ${e.context}");
                  add(HomeEvent.getEmployerDashboardList(true));
                });
              } else {
                teamCheckDialog(e.context);
              }
            },
          );
        },
      );
    });
  }

  teamCheckDialog(BuildContext context) {
    AppDialog.showDelete(
      context,
      title: StringConstant.createYourTeamToGetStarted,
      infoMessage: StringConstant.checkTeamStatusDesc,
      barrierDismissible: true,
      deleteBtnText: StringConstant.yes,
      cancelText: StringConstant.no,
      otherContent: dontShowAgain(context),
      onCancelClick: () async {
        if (state.showTeamDialog) {
          // await setShowTeamDialog(false);
          await mainFacade.dontShowEmployerTeamDialog();
        }
        context.router.maybePop();
        context.router
            .push(PageRouteInfo(HealthCarePostForm.name))
            .then((value) {
          add(HomeEvent.getEmployerDashboardList(true));
        });
      },
      onDeleteClick: () async {
        if (state.showTeamDialog) {
          // await setShowTeamDialog(false);
          await mainFacade.dontShowEmployerTeamDialog();
        }
        context.router.maybePop();
        context.router.push(PageRouteInfo(TeamsView.name)).then((value) {
          add(HomeEvent.checkTeamAvailableEvent(context));
        });
      },
    );
  }

  Widget dontShowAgain(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      bloc: this,
      builder: (__, _) {
        return Padding(
          padding: EdgeInsets.symmetric(
              horizontal: getSize(20), vertical: getSize(20)),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              SizedBox(
                height: getSize(20),
                width: getSize(16.67),
                // color: Colors.green,
                child: Checkbox(
                  value: state.showTeamDialog,
                  activeColor: AppColors.primaryColor,
                  side: BorderSide(
                    width: getSize(1.5),
                    color: AppColors.black.withOpacity(0.5),
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                  onChanged: (value) async {
                    if (value != null) {
                      add(HomeEvent.dontShowAgain(context, isCheck: value));
                      // await setShowTeamDialog(value);
                    }
                  },
                ),
              ),
              SizedBox(width: getSize(20)),
              Flexible(
                child: BaseText(
                  text: StringConstant.dontShowThisAgain,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  textAlign: TextAlign.center,
                  textColor: AppColors.black.withOpacity(0.7),
                  maxLines: 20,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
