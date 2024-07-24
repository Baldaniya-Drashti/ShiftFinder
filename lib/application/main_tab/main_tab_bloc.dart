import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:shift/domain/auth/i_auth_facade.dart';
import 'package:shift/presentation/core/app_router.gr.dart';
part 'main_tab_state.dart';
part 'main_tab_event.dart';
part 'main_tab_bloc.freezed.dart';

@injectable
class MainTabBloc extends Bloc<MainTabEvent, MainTabState> {
  final List<String> pageList = [];
  final IAuthFacade authFacade;
  // final IAccountRepository accountRepository;

  MainTabBloc(
    this.authFacade,
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
                emit(state.copyWith(
                    pageIndex: pageList.indexOf(state.homePage)));
                break;
              case 1:
                if (!pageList.contains(state.historyPage)) {
                  pageList.add(state.historyPage);
                }
                emit(state.copyWith(
                    pageIndex: pageList.indexOf(state.historyPage)));
                break;
              case 2:
                if (!pageList.contains(state.notificationPage)) {
                  pageList.add(state.notificationPage);
                }
                emit(state.copyWith(
                    pageIndex: pageList.indexOf(state.notificationPage)));
                break;
              case 3:
                if (!pageList.contains(state.profilePage)) {
                  pageList.add(state.profilePage);
                }
                emit(state.copyWith(
                    pageIndex: pageList.indexOf(state.profilePage)));
                break;
              default:
            }
          },
          // registerForPush: (RegisterForPush value) async {
          //   await authFacade.registerForPush(fcmToken: value.fcmToken);
          // },
          // pushNotificationInitialize: (PushNotificationInitialize value) async {
          //   await PushNotificationService()
          //       .setupInteractedMessage(value.context);
          //   PushNotificationService()
          //       .firebaseMessaging
          //       .onTokenRefresh
          //       .listen((event) {
          //     add(MainTabEvent.registerForPush(event));
          //   });
          //   await PushNotificationService()
          //       .firebaseMessaging
          //       .getToken()
          //       .then((value) async {
          //     add(MainTabEvent.registerForPush(value ?? ""));
          //   });
          // },
          // initDynamicLink: (InitDynamicLink value) async {
          //   DynamicLinksService.initDynamicLinks(value.context);
          //   add(MainTabEvent.pushNotificationInitialize(value.context));
          // },
        );
      },
    );
  }
}
