// ignore_for_file: prefer_const_constructors, avoid_print, prefer_const_literals_to_create_immutables, unnecessary_string_interpolations
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shift/application/contractor/contractor_main_tab_bloc/contractor_home_bloc/contractor_home_bloc.dart';
import 'package:shift/application/contractor/contractor_main_tab_bloc/contractor_main_bloc.dart';
import 'package:shift/application/profile/account/account_cubit.dart';
import 'package:shift/domain/core/string_constant.dart';
import 'package:shift/injection.dart';
import 'package:shift/presentation/common/utils/app_focus.dart';
import 'package:shift/presentation/contractor/contractor_main/contractor_tabs/contractor_home/contracator_home.dart';
import 'package:shift/presentation/contractor/contractor_main/contractor_tabs/contractor_profile/contractor_profile.dart';
import 'package:shift/presentation/contractor/contractor_main/contractor_tabs/contractor_shifts/contractor_shifts.dart';
import 'package:shift/presentation/core/app_router.gr.dart' as autoroute;
import 'package:shift/presentation/core/style/app_colors.dart';
import 'package:shift/presentation/main/tabs/notification_view.dart';
import 'package:shift/presentation/main/widgets/custom_bottom_navigation.dart';
import 'package:shift/presentation/main/widgets/home_app_bar.dart';

@RoutePage(name: 'ContractorMainTabView')
class ContractorMainTabView extends StatelessWidget {
  const ContractorMainTabView({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => getIt<ContractorMainTabBloc>()
            // ..add(ContractorMainTabEvent.initDynamicLink(context))
            ..add(ContractorMainTabEvent.tabChange(0)),
        ),
        BlocProvider(
          create: (context) => getIt<ContractorHomeBloc>(),
        ),
        BlocProvider<AccountCubit>(
          create: (context) => getIt<AccountCubit>()..getAccount(),
        ),
      ],
      child: BlocBuilder<ContractorMainTabBloc, ContractorMainTabState>(
        builder: (context, state) {
          return DefaultTabController(
            length: context.read<ContractorMainTabBloc>().pageList.length,
            child: Scaffold(
              backgroundColor: AppColors.scaffoldColor,
              appBar: getAppbar(state, context),
              body: GestureDetector(
                  onTap: () {
                    AppFocus.unfocus(context);
                  },
                  // child: state.currentPage,
                  child: IndexedStack(
                    index: state.pageIndex,
                    children: List<Widget>.generate(
                      context.read<ContractorMainTabBloc>().pageList.length,
                      (int index) {
                        return Navigator(
                          onGenerateRoute: (RouteSettings settings) {
                            print(
                                "PAGE IS ${context.read<ContractorMainTabBloc>().pageList[index]}");
                            return onGenerateRoute(
                              settings,
                              context
                                  .read<ContractorMainTabBloc>()
                                  .pageList[index],
                            );
                          },
                          key: ValueKey(state.pageIndex),
                        );
                      },
                    ),
                  )
                  /*   IndexedStack(
                  index: state.pageIndex,
                  children: List<Widget>.generate(
                    context.read<ContractorMainTabBloc>().pageList.length,
                    (int index) {
                      return Navigator(
                        onGenerateRoute: (RouteSettings settings) {
                          print("PAGE IS ${context.read<ContractorMainTabBloc>().pageList[index]}");
                          return onGenerateRoute(
                            settings,
                            context.read<ContractorMainTabBloc>().pageList[index],
                          );
                        },
                      );
                    },
                  ),
                ),
               */
                  ),
              bottomNavigationBar: ContractorBottomNavigationWidget(),
            ),
          );
        },
      ),
    );
  }
}

getAppbar(ContractorMainTabState state, BuildContext context) {
  switch (state.selectedTab) {
    case 0:
      return ContractorHomeAppBar(
        showAppBar: false,
        titleText: null,
      );
    case 1:
      return ContractorHomeAppBar(
        titleText: StringConstant.shifts,
      );
    case 2:
      return ContractorHomeAppBar(
        titleText: StringConstant.notification,
      );
    case 3:
      return ContractorHomeAppBar(
        titleText: StringConstant.profile,
      );
    default:
  }
}

Route? onGenerateRoute(RouteSettings settings, String tabItem) {
  print("TAB ITEM----->  $tabItem");
  return MaterialPageRoute(
    settings: settings,
    builder: (context) {
      if (tabItem == autoroute.ContractorHomeView.name) {
        return ContractorHomeView();
      } else if (tabItem == autoroute.ContractorShiftView.name) {
        return ContractorShiftView();
      } else if (tabItem == autoroute.NotificationView.name) {
        return NotificationView();
      } else if (tabItem == autoroute.ProfileView.name) {
        return ContractorProfileView();
      }
      return Container();
    },
  );
}
