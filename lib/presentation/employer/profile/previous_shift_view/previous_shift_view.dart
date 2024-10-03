import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shift/application/employer/profile/previous_shift_bloc.dart';
import 'package:shift/domain/core/math_utils.dart';
import 'package:shift/domain/core/string_constant.dart';
import 'package:shift/injection.dart';
import 'package:shift/presentation/core/style/app_colors.dart';
import 'package:shift/presentation/employer/profile/previous_shift_view/previous_shift_all_view.dart';
import 'package:shift/presentation/employer/profile/previous_shift_view/previous_shift_blocked_view.dart';
import 'package:shift/presentation/employer/profile/previous_shift_view/previous_shift_fav_view.dart';
import 'package:shift/presentation/employer/profile/previous_shift_view/previous_shift_remarked_view.dart';
import 'package:shift/presentation/main/widgets/home_app_bar.dart';

@RoutePage(name: 'PreviousShiftView')
class PreviousShiftView extends StatelessWidget {
  const PreviousShiftView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBar(
        onBackPressed: () {
          Navigator.pop(context);
        },
        title: "All ShiftPros",
      ),
      body: BlocProvider(
        create: (context) => getIt<PreviousShiftBloc>(),
        child: BlocBuilder<PreviousShiftBloc, PreviousShiftState>(
          builder: (context, state) {
            return DefaultTabController(
              length: 4,
              child: Column(
                children: [
                  tabbar(context),
                  Expanded(
                    child: TabBarView(
                      children: [
                        PreviousShiftAllView(),
                        PreviousShiftFavView(),
                        PreviousShiftBlockedView(),
                        PreviousShiftRemarkedView(),
                      ],
                    ),
                  )
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget tabbar(BuildContext context) {
    return TabBar(
      onTap: (value) {
        context.read<PreviousShiftBloc>().add(PreviousShiftEvent.tabChange(value + 1));
      },
      padding: EdgeInsets.zero,
      labelStyle: TextStyle(
        fontSize: getFontSize(14),
        color: AppColors.primaryColor,
        fontWeight: FontWeight.w500,
      ),
      overlayColor: WidgetStateProperty.all(AppColors.primaryColor.withOpacity(0.01)),
      unselectedLabelStyle: TextStyle(
        fontSize: getFontSize(14),
        color: Colors.black.withOpacity(0.5),
        fontWeight: FontWeight.w500,
      ),
      dividerHeight: getSize(3),
      indicatorSize: TabBarIndicatorSize.tab,
      dividerColor: AppColors.black.withOpacity(0.2),
      indicatorColor: AppColors.primaryColor,
      labelPadding: EdgeInsets.zero,
      unselectedLabelColor: AppColors.black.withOpacity(0.2),
      tabs: [
        Tab(text: "All"),
        Tab(text: "Favorites"),
        Tab(text: "Blocked"),
        Tab(text: "Remarked"),
      ],
    );
  }
}

