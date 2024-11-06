import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:shift/application/contractor/contractor_previous_shift/contractor_previous_shift_bloc.dart';
import 'package:shift/domain/core/math_utils.dart';
import 'package:shift/injection.dart';

import 'package:shift/presentation/contractor/contractor_previous_shift/contractor_cancelled_shift_view.dart';
import 'package:shift/presentation/contractor/contractor_previous_shift/contractor_completed_shift_view.dart';

import 'package:shift/presentation/core/style/app_colors.dart';

import 'package:shift/presentation/main/widgets/home_app_bar.dart';

@RoutePage(name: "ContractorPreviousShiftView")
class ContractorPreviousShiftView extends StatelessWidget {
  const ContractorPreviousShiftView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<ContractorPreviousShiftBloc>(),
      child: Scaffold(
        appBar: CommonAppBar(
          onBackPressed: () => context.router.maybePop(),
          title: "Previous Shifts",
        ),
        body: DefaultTabController(
          length: 2,
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: getSize(25)),
                child: buildTabBar(context),
              ),
              Gap(18),
              Expanded(
                child: TabBarView(
                  children: [
                    ContractorCompletedShiftView(),
                    ContractorCancelledShiftView(),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget buildTabBar(BuildContext context) {
    return Container(
      height: getSize(50),
      padding: EdgeInsets.symmetric(vertical: getSize(5)),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: AppColors.white,
      ),
      child: TabBar(
        onTap: (value) {},
        padding: EdgeInsets.zero,
        labelStyle: TextStyle(
          fontSize: getFontSize(14),
          color: AppColors.white,
          fontWeight: FontWeight.w500,
        ),
        unselectedLabelStyle: TextStyle(
          fontSize: getFontSize(14),
          color: Colors.black.withOpacity(0.5),
          fontWeight: FontWeight.w500,
        ),
        indicatorSize: TabBarIndicatorSize.tab,
        dividerColor: AppColors.white,
        indicator: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: AppColors.primaryColor,
        ),
        tabs: [
          Tab(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Completed"),
              ],
            ),
          ),
          Tab(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Cancelled"),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
