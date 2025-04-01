import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shift/application/contractor/contractor_main_tab_bloc/contractor_shift_bloc/contractor_shift_bloc.dart';
import 'package:shift/domain/core/math_utils.dart';
import 'package:shift/domain/core/string_constant.dart';
import 'package:shift/presentation/contractor/contractor_main/contractor_tabs/contractor_shifts/applied_shift/applied_tab.dart';
import 'package:shift/presentation/contractor/contractor_main/contractor_tabs/contractor_shifts/applied_shift/counter_proposal_tab.dart';
import 'package:shift/presentation/core/style/app_colors.dart';

class AppliedShift extends StatelessWidget {
  const AppliedShift({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ContractorShiftBloc, ContractorShiftState>(
      builder: (context, state) {
        return DefaultTabController(
          length: 2,
          initialIndex: state.selectedAppliedTab,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: getSize(25)),
                child: tabbar(context),
              ),
              Expanded(
                child: (state.selectedAppliedTab == 0)
                    ? AppliedTab()
                    : CounterProposalTab(),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget tabbar(BuildContext context) {
    return Container(
      height: getSize(50),
      padding: EdgeInsets.symmetric(vertical: getSize(5)),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: AppColors.white,
      ),
      child: TabBar(
        onTap: (value) {
          context
              .read<ContractorShiftBloc>()
              .add(ContractorShiftEvent.appliedShiftChangeTab(value));
        },
        padding: EdgeInsets.zero,
        labelStyle: TextStyle(
          fontSize: getFontSize(14),
          color: AppColors.white,
          fontWeight: FontWeight.w500,
        ),
        unselectedLabelStyle: TextStyle(
          fontSize: getFontSize(14),
          color: Colors.black.withValues(alpha: 0.5),
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
                Text(StringConstant.applied),
                /*Padding(
                  padding: EdgeInsets.only(left: getSize(5)),
                  child: Badge(
                    backgroundColor: AppColors.redAccent,
                    largeSize: getSize(15),
                    padding: EdgeInsets.symmetric(horizontal: getSize(3)),
                    // smallSize: getSize(10),
                    // isLabelVisible: true,
                    label: BaseText(
                      text: '03',
                      fontSize: 6,
                      textColor: AppColors.white,
                    ),
                  ),
                ),*/
              ],
            ),
          ),
          Tab(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(StringConstant.counterProposal),
                /*Padding(
                  padding: EdgeInsets.only(left: getSize(5)),
                  child: Badge(
                    backgroundColor: AppColors.redAccent,
                    largeSize: getSize(15),
                    padding: EdgeInsets.symmetric(horizontal: getSize(3)),
                    // smallSize: getSize(10),
                    // isLabelVisible: true,
                    label: BaseText(
                      text: '03',
                      fontSize: 6,
                      textColor: AppColors.white,
                    ),
                  ),
                ),*/
              ],
            ),
          ),
        ],
      ),
    );
  }
}
