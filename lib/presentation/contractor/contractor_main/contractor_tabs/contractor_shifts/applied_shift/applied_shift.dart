import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shift/application/contractor/contractor_main_tab_bloc/contractor_shift_bloc/contractor_shift_bloc.dart';
import 'package:shift/domain/core/math_utils.dart';
import 'package:shift/domain/core/string_constant.dart';
import 'package:shift/presentation/common/widgets/base_text.dart';
import 'package:shift/presentation/core/style/app_colors.dart';

class AppliedShift extends StatelessWidget {
  const AppliedShift({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: BaseText(
        text: StringConstant.underDevelopment,
      ),
    );
    /*return BlocBuilder<ContractorShiftBloc, ContractorShiftState>(
      builder: (context, state) {
        return DefaultTabController(
          length: 2,
          initialIndex: state.selectedAppliedTab,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: getSize(20)),
            child: Column(
              children: [
                tabbar(context),
                (state.selectedTab == 0) ? AppliedTab() : CounterProposalTab()
              ],
            ),
          ),
        );
      },
    );*/
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
          Tab(text: StringConstant.applied),
          Tab(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(StringConstant.counterProposal),
                Padding(
                  padding: EdgeInsets.all(getSize(5)),
                  child: Badge(
                    backgroundColor: AppColors.redAccent,
                    largeSize: getSize(20),
                    // isLabelVisible: true,
                    label: BaseText(
                      text: '03',
                      fontSize: 6,
                      textColor: AppColors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
