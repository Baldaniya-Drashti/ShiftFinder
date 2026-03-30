// ignore_for_file: prefer_const_constructors, avoid_print, prefer_const_literals_to_create_immutables, unnecessary_string_interpolations
import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shift/application/main_tab/home/home_bloc.dart';
import 'package:shift/application/main_tab/main_tab_bloc.dart';
import 'package:shift/application/profile/account/account_cubit.dart';
import 'package:shift/domain/core/math_utils.dart';
import 'package:shift/domain/core/png_image_constants.dart';
import 'package:shift/domain/core/string_constant.dart';
import 'package:shift/domain/core/svg_image_constants.dart';
import 'package:shift/injection.dart';
import 'package:shift/presentation/common/utils/app_focus.dart';
import 'package:shift/presentation/common/utils/get_cookie.dart';
import 'package:shift/presentation/common/widgets/base_text.dart';
import 'package:shift/presentation/core/app_router.gr.dart' as autoroute;
import 'package:shift/presentation/core/style/app_colors.dart';
import 'package:shift/presentation/main/tabs/employer_shift_view.dart';
import 'package:shift/presentation/main/tabs/home/home_view.dart';
import 'package:shift/presentation/main/tabs/notification_view.dart';
import 'package:shift/presentation/main/tabs/profile/profile_view.dart';
import 'package:shift/presentation/main/widgets/custom_bottom_navigation.dart';
import 'package:shift/presentation/main/widgets/home_app_bar.dart';

@RoutePage(name: 'MainTabView')
class MainTabView extends StatelessWidget {
  const MainTabView({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        /* BlocProvider(
          create: (context) => getIt<MainTabBloc>()
            // ..add(MainTabEvent.initDynamicLink(context))
            ..add(TabChange(0))
            ..add(MainTabEvent.registerForPush()),
        ), */
        BlocProvider(create: (context) => getIt<HomeBloc>()),
        BlocProvider<AccountCubit>(
            create: (context) => getIt<AccountCubit>()..getAccount()),
      ],
      child: Builder(builder: (context) {
        return BlocBuilder<MainTabBloc, MainTabState>(
          builder: (context, state) {
            return DefaultTabController(
              length: context.read<MainTabBloc>().pageList.length,
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
                      context.read<MainTabBloc>().pageList.length,
                      (int index) {
                        return Navigator(
                          onGenerateRoute: (RouteSettings settings) {
                            return onGenerateRoute(
                              settings,
                              context.read<MainTabBloc>().pageList[index],
                            );
                          },
                          key: ValueKey(state.pageIndex),
                        );
                      },
                    ),
                  ),
                ),
                floatingActionButton: BlocConsumer<HomeBloc, HomeState>(
                  listener: (context, state) {},
                  builder: (con, state) {
                    return FloatingActionButton(
                      onPressed: () {
                        /* if (getCurrentUser().isUserEnable == null) {
                          UserEnableDisableDialog.showEnableDisableDialog(
                            context,
                            title: StringConstant.accountDisabled,
                            infoMessage: StringConstant.accountDisabledDesc,
                          );
                        } else { */
                        context
                            .read<MainTabBloc>()
                            .add(MainTabEvent.checkTeamAvailableEvent(context));
                        // }
                      },
                      backgroundColor: AppColors.primaryColor,
                      shape: CircleBorder(
                        side: BorderSide(
                          color: AppColors.darkGreen,
                          width: getSize(3),
                        ),
                      ),
                      child: Container(
                        decoration: BoxDecoration(
                          color: AppColors.primaryColor,
                          shape: BoxShape.circle,
                          image: DecorationImage(
                            image: AssetImage(
                                PngImageConstants.floating_background),
                          ),
                        ),
                        alignment: Alignment.center,
                        child: SvgPicture.asset(
                          SvgImageConstant.plus,
                          height: getSize(30),
                          width: getSize(30),
                        ),
                      ),
                    );
                  },
                ),
                floatingActionButtonLocation:
                    FloatingActionButtonLocation.centerDocked,
                bottomNavigationBar: CustomBottomNavigationWidget(),
              ),
            );
          },
        );
      }),
    );
  }
}

getAppbar(MainTabState state, BuildContext context) {
  switch (state.selectedTab) {
    case 0:
      return HomeAppbar(
        leading: Container(
          height: getSize(50),
          width: getSize(50),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: AppColors.darkGreen, width: getSize(3)),
            image: DecorationImage(
              image: (getCurrentUser().profileImage != null &&
                      getCurrentUser().profileImage!.isNotEmpty)
                  ? CachedNetworkImageProvider(
                      getCurrentUser().profileImage!,
                      // "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQBLrdd7MIMxvrcpH-P3EtMy2jhc5PL0tDNww&s",
                    )
                  : AssetImage(PngImageConstants.profile_employer),
              fit: BoxFit.cover,
            ),
          ),
        ),
        titleWidget: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            BaseText(
              text: StringConstant.welcome,
              fontSize: 12,
              fontWeight: FontWeight.w400,
              fontFamily: "Aclonica",
              lineHeight: getSize(1),
              textColor: AppColors.black.withValues(alpha: 0.7),
            ),
            BaseText(
              text:
                  "${getCurrentUser().firstName ?? ''} ${getCurrentUser().lastName ?? ''}",
              fontSize: 12,
              fontWeight: FontWeight.w400,
              fontFamily: "Aclonica",
              maxLines: 1,
            ),
            BaseText(
              text: "${getCurrentUser().companyName ?? ''}",
              fontSize: 10,
              fontWeight: FontWeight.w600,
              textColor: AppColors.primaryColor,
              maxLines: 1,
            ),
          ],
        ),
        actions: [
          SvgPicture.asset(
            SvgImageConstant.twoPerson,
          ),
        ],
      );
    case 1:
      return HomeAppbar(
        titleText: StringConstant.shifts,
      );
    case 2:
      return HomeAppbar(
        titleText: StringConstant.notification,
      );
    case 3:
      return HomeAppbar(
        titleText: StringConstant.profile,
      );

    default:
  }
}

Route? onGenerateRoute(RouteSettings settings, String tabItem) {
  return MaterialPageRoute(
    settings: settings,
    builder: (context) {
      if (tabItem == autoroute.HomeView.name) {
        return HomeView();
      } else if (tabItem == autoroute.EmployerShiftView.name) {
        return EmployerShiftView();
      } else if (tabItem == autoroute.NotificationView.name) {
        return NotificationView();
      } else if (tabItem == autoroute.ProfileView.name) {
        return ProfileView();
      }
      return Container();
    },
  );
}
