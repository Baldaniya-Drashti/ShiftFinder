// ignore_for_file: deprecated_member_use

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shift/application/contractor/contractor_main_tab_bloc/contractor_shift_bloc/contractor_shift_bloc.dart';
import 'package:shift/domain/core/math_utils.dart';
import 'package:shift/domain/core/string_constant.dart';
import 'package:shift/domain/core/svg_image_constants.dart';
import 'package:shift/injection.dart';
import 'package:shift/presentation/common/widgets/base_text.dart';
import 'package:shift/presentation/contractor/contractor_main/contractor_tabs/contractor_shifts/applied_shift.dart';
import 'package:shift/presentation/contractor/contractor_main/contractor_tabs/contractor_shifts/current_shift.dart';
import 'package:shift/presentation/contractor/contractor_main/contractor_tabs/contractor_shifts/upcoming_shift.dart';
import 'package:shift/presentation/core/style/app_colors.dart';

@RoutePage(name: 'ContractorShiftView')
class ContractorShiftView extends StatelessWidget {
  const ContractorShiftView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<ContractorShiftBloc>()
        ..add(ContractorShiftEvent.getCurrentShiftDetailAPI(true))
        ..add(ContractorShiftEvent.getUpcomingShiftAPI(true)),
      child: BlocConsumer<ContractorShiftBloc, ContractorShiftState>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
            body: DefaultTabController(
              length: 3,
              initialIndex: state.selectedTab - 1,
              child: Column(
                // mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  tabbar(context),
                  paddingBetweenFields(),
                  Expanded(
                    child: (state.selectedTab == 1)
                        ? CurrentShift()
                        : (state.selectedTab == 2)
                            ? UpcomingShift()
                            : AppliedShift(),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget paddingBetweenFields({double? height}) {
    return SizedBox(
      height: getSize(height ?? 15),
    );
  }

  Widget tabbar(BuildContext context) {
    return TabBar(
      onTap: (value) {
        context.read<ContractorShiftBloc>().add(ContractorShiftEvent.changeShiftTab(value + 1));
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
      tabs: const [
        Tab(text: StringConstant.currentShifts),
        Tab(text: StringConstant.upcomingShifts),
        Tab(text: StringConstant.appliedShifts),
      ],
    );
  }

  Widget numberOfShift({
    required String svgPrefixIcon,
    required String title,
  }) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: getSize(12),
        vertical: getSize(10),
      ),
      margin: EdgeInsets.symmetric(vertical: getSize(5)),
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            height: getSize(43),
            width: getSize(35),
            child: SvgPicture.asset(
              svgPrefixIcon,
              color: AppColors.primaryColor,
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: getSize(20)),
            child: SvgPicture.asset(
              SvgImageConstant.verticalLine,
              height: getSize(50),
            ),
          ),
          BaseText(
            text: title,
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ],
      ),
    );
  }
}
