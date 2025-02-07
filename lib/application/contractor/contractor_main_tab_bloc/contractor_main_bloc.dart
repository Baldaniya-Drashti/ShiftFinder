import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:shift/domain/auth/i_auth_facade.dart';
import 'package:shift/presentation/contractor/contractor_main/contractor_tabs/contractor_home/contracator_home.dart';
import 'package:shift/presentation/contractor/contractor_main/contractor_tabs/contractor_profile/contractor_profile.dart';
import 'package:shift/presentation/contractor/contractor_main/contractor_tabs/contractor_shifts/contractor_shifts.dart';
import 'package:shift/presentation/core/app_router.gr.dart' as route;
import 'package:shift/presentation/main/tabs/notification_view.dart';
part 'contractor_main_state.dart';
part 'contractor_main_event.dart';
part 'contractor_main_bloc.freezed.dart';

@injectable
class ContractorMainTabBloc
    extends Bloc<ContractorMainTabEvent, ContractorMainTabState> {
  final List<String> pageList = [];
  final IAuthFacade authFacade;
  // final IAccountRepository accountRepository;

  ContractorMainTabBloc(
    this.authFacade,
    // this.accountRepository,
  ) : super(ContractorMainTabState.initial()) {
    on<ContractorMainTabEvent>(
      (event, emit) async {
        await event.map(
          tabChange: (value) async {
            emit(state.copyWith(selectedTab: value.tabIndex));
            switch (value.tabIndex) {
              case 0:
                if (!pageList.contains(state.homePage)) {
                  pageList.add(state.homePage);
                }
                emit(state.copyWith(
                  pageIndex: pageList.indexOf(state.homePage),
                  currentPage: ContractorHomeView(),
                ));
                break;
              case 1:
                if (!pageList.contains(state.shiftPage)) {
                  pageList.add(state.shiftPage);
                }
                emit(state.copyWith(
                  pageIndex: pageList.indexOf(state.shiftPage),
                  currentPage: ContractorShiftView(),
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
                  currentPage: ContractorProfileView(),
                ));
                break;
              default:
            }
          },
          /* registerForPush: (RegisterForPush value) async {
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
              add(ContractorMainTabEvent.registerForPush(event));
            });
            await PushNotificationService()
                .firebaseMessaging
                .getToken()
                .then((value) async {
              add(ContractorMainTabEvent.registerForPush(value ?? ""));
            });
          },
          initDynamicLink: (InitDynamicLink value) async {
            print("initDynamicLink called!!!");
            // DynamicLinksService.initDynamicLinks(value.context);
            add(ContractorMainTabEvent.pushNotificationInitialize(
                value.context));
          }, */
        );
      },
    );
  }
}
