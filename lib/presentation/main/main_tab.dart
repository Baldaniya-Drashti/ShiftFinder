// ignore_for_file: prefer_const_constructors, avoid_print
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shift/application/main_tab/main_tab_bloc.dart';
import 'package:shift/domain/core/math_utils.dart';
import 'package:shift/domain/core/png_image_constants.dart';
import 'package:shift/injection.dart';
import 'package:shift/presentation/common/utils/app_focus.dart';
import 'package:shift/presentation/core/app_router.gr.dart' as autoroute;
import 'package:shift/presentation/core/style/app_colors.dart';
import 'package:shift/presentation/main/tabs/history_view.dart';
import 'package:shift/presentation/main/tabs/home_view.dart';
import 'package:shift/presentation/main/tabs/notification_view.dart';
import 'package:shift/presentation/main/tabs/profile_view.dart';
import 'package:shift/presentation/main/widgets/custom_bottom_navigation.dart';
import 'package:shift/presentation/main/widgets/home_app_bar.dart';

@RoutePage(name: 'MainTabView')
class MainTabView extends StatelessWidget {
  const MainTabView({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => getIt<MainTabBloc>()..add(TabChange(0)),
        ),
        // BlocProvider<AccountCubit>(
        //   create: (context) => getIt<AccountCubit>()..getAccount(),
        // ),
        // BlocProvider(
        //   create: (context) =>
        //       getIt<HomeBloc>()..add(HomeEvent.getProductList(true)),
        // ),
        // BlocProvider(
        //   create: (context) => getIt<NotificationsBloc>()
        //     ..add(NotificationsEvent.getNotificationList(true))
        //     ..add(
        //       NotificationsEvent.getMessageList(true),
        //     ),
        // ),
      ],
      child: BlocBuilder<MainTabBloc, MainTabState>(
        builder: (context, state) {
          return DefaultTabController(
            length: 2,
            child: Scaffold(
              // backgroundColor: AppColors.scaffoldColor,
              appBar: HomeAppbar(),
              body: GestureDetector(
                onTap: () {
                  AppFocus.unfocus(context);
                },
                child: IndexedStack(
                  index: state.pageIndex,
                  children: List<Widget>.generate(
                    context.read<MainTabBloc>().pageList.length,
                    (int index) {
                      return Navigator(
                        onGenerateRoute: (RouteSettings settings) {
                          print(
                              "PAGE IS ${context.read<MainTabBloc>().pageList[index]}");
                          return onGenerateRoute(
                            settings,
                            context.read<MainTabBloc>().pageList[index],
                          );
                        },
                      );
                    },
                  ),
                ),
              ),
              floatingActionButton: FloatingActionButton(
                onPressed: () {},
                backgroundColor: AppColors.darkGreen,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(80),
                ),
                child: Container(
                  height: getSize(55),
                  width: getSize(55),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      image: AssetImage(PngImageConstants.floating_background),
                    ),
                  ),
                  child: Icon(
                    Icons.add,
                    color: AppColors.white,
                    size: getSize(30),
                  ),
                ),
                //params
              ),
              floatingActionButtonLocation:
                  FloatingActionButtonLocation.centerDocked,
              bottomNavigationBar: CustomBottomNavigationWidget(),
            ),
          );
        },
      ),
    );
  }
}

Route? onGenerateRoute(RouteSettings settings, String tabItem) {
  print("TAB ITEM----->  $tabItem");
  return MaterialPageRoute(
    settings: settings,
    builder: (context) {
      if (tabItem == autoroute.HomeView.name) {
        return HomeView();
      } else if (tabItem == autoroute.HistoryView.name) {
        return HistoryView();
      } else if (tabItem == autoroute.NotificationView.name) {
        return NotificationView();
      } else if (tabItem == autoroute.ProfileView.name) {
        return ProfileView();
      }
      return Container();
    },
  );
}
