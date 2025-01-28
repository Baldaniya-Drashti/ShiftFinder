import 'package:auto_route/auto_route.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:shift/domain/auth/i_auth_facade.dart';
import 'package:shift/domain/core/math_utils.dart';
import 'package:shift/domain/core/string_constant.dart';
import 'package:shift/domain/main/i_main_facade.dart';
import 'package:shift/domain/main/main_failure.dart';
import 'package:shift/infrastructure/main/team_dto/team_dto.dart';
import 'package:shift/presentation/common/utils/flushbar_creator.dart';
import 'package:shift/presentation/common/utils/get_cookie.dart';
import 'package:shift/presentation/common/widgets/base_text.dart';
import 'package:shift/presentation/core/app_router.gr.dart' as route;
import 'package:shift/presentation/core/helper/push_notification_helper.dart';
import 'package:shift/presentation/core/style/app_colors.dart';
import 'package:shift/presentation/core/widgets/dialogs/app_dialog.dart';
import 'package:shift/presentation/main/tabs/employer_shift_view.dart';
import 'package:shift/presentation/main/tabs/home/home_view.dart';
import 'package:shift/presentation/main/tabs/notification_view.dart';
import 'package:shift/presentation/main/tabs/profile/profile_view.dart';
part 'main_tab_state.dart';
part 'main_tab_event.dart';
part 'main_tab_bloc.freezed.dart';

@injectable
class MainTabBloc extends Bloc<MainTabEvent, MainTabState> {
  final List<String> pageList = [];
  final IAuthFacade authFacade;
  final IMainFacade mainFacade;
  // final IAccountRepository accountRepository;

  MainTabBloc(
    this.authFacade,
    this.mainFacade,
    // this.accountRepository,
  ) : super(MainTabState.initial()) {
    on<MainTabEvent>(
      (event, emit) async {
        await event.map(
          tabChange: (value) async {
            emit(state.copyWith(selectedTab: value.tabIndex));

            switch (value.tabIndex) {
              case 0:
                if (!pageList.contains(state.homePage)) {
                  pageList.add(state.homePage);
                }

                /// when back to home screen after click on floating action button at that time is condition true
                if (state.currentPage is HomeView) {
                  emit(state.copyWith(
                    pageIndex: -1,
                    currentPage: Container(),
                  ));
                  await Future.delayed(Duration(milliseconds: 50));
                }
                emit(state.copyWith(
                  pageIndex: pageList.indexOf(state.homePage),
                  currentPage: HomeView(),
                ));
                /* emit(state.copyWith(
                  pageIndex: pageList.indexOf(state.homePage),
                  currentPage: HomeView(),
                )); */
                break;
              case 1:
                if (!pageList.contains(state.employerShiftPage)) {
                  pageList.add(state.employerShiftPage);
                }
                emit(state.copyWith(
                  pageIndex: pageList.indexOf(state.employerShiftPage),
                  currentPage: EmployerShiftView(),
                ));
                break;
              case 2:
                if (!pageList.contains(state.notificationPage)) {
                  pageList.add(state.notificationPage);
                }
                emit(state.copyWith(
                  pageIndex: pageList.indexOf(state.notificationPage),
                  currentPage: NotificationView(),
                ));
                break;
              case 3:
                if (!pageList.contains(state.profilePage)) {
                  pageList.add(state.profilePage);
                }
                emit(state.copyWith(
                  pageIndex: pageList.indexOf(state.profilePage),
                  currentPage: ProfileView(),
                ));
                break;
              default:
            }
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
                if (r.isTeamAvailable == 1 ||
                    getCurrentUser().isDialogBox == 1) {
                  e.context.router
                      .push(PageRouteInfo(route.HealthCarePostForm.name))
                      .then((value) {
                    print("value------> ${e.context}");
                    add(MainTabEvent.tabChange(0));
                    // add(HomeEvent.getEmployerDashboardList(true));
                  });
                } else {
                  teamCheckDialog(e.context);
                }
              },
            );
          },
          registerForPush: (RegisterForPush value) async {
            print("FCM token----> ${value.fcmToken}");
            await authFacade.registerForPush(fcmToken: value.fcmToken);
          },
          pushNotificationInitialize: (PushNotificationInitialize value) async {
            print("pushNotificationInitialize calledd");
            await PushNotificationService()
                .setupInteractedMessage(value.context);
            PushNotificationService()
                .firebaseMessaging
                .onTokenRefresh
                .listen((event) {
              add(MainTabEvent.registerForPush(event));
            });
            await PushNotificationService()
                .firebaseMessaging
                .getToken()
                .then((value) async {
              add(MainTabEvent.registerForPush(value ?? ""));
            });
          },
          initDynamicLink: (InitDynamicLink value) async {
            print("initDynamicLink called!!!");
            // DynamicLinksService.initDynamicLinks(value.context);
            add(MainTabEvent.pushNotificationInitialize(value.context));
          },
          /* registerForPush: (RegisterForPush value) async {
            await authFacade.registerForPush(fcmToken: value.fcmToken);
          },
          pushNotificationInitialize: (PushNotificationInitialize value) async {
            await PushNotificationService()
                .setupInteractedMessage(value.context);
            PushNotificationService()
                .firebaseMessaging
                .onTokenRefresh
                .listen((event) {
              add(MainTabEvent.registerForPush(event));
            });
            await PushNotificationService()
                .firebaseMessaging
                .getToken()
                .then((value) async {
              add(MainTabEvent.registerForPush(value ?? ""));
            });
          },
          initDynamicLink: (InitDynamicLink value) async {
            DynamicLinksService.initDynamicLinks(value.context);
            add(MainTabEvent.pushNotificationInitialize(value.context));
          }, */
        );
      },
    );
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
            .push(PageRouteInfo(route.HealthCarePostForm.name))
            .then((value) {
          // add(HomeEvent.getEmployerDashboardList(true));
          add(MainTabEvent.tabChange(0));
        });
      },
      onDeleteClick: () async {
        if (state.showTeamDialog) {
          // await setShowTeamDialog(false);
          await mainFacade.dontShowEmployerTeamDialog();
        }
        context.router.maybePop();
        context.router.push(PageRouteInfo(route.TeamsView.name)).then((value) {
          // add(HomeEvent.checkTeamAvailableEvent(context));
          add(MainTabEvent.tabChange(0));
        });
      },
    );
  }

  Widget dontShowAgain(BuildContext context) {
    return BlocBuilder<MainTabBloc, MainTabState>(
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
                      add(MainTabEvent.dontShowAgain(context, isCheck: value));
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
