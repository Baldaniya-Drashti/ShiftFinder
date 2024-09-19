import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shift/application/main_tab/shifts/shifts_bloc_bloc.dart';
import 'package:shift/domain/core/math_utils.dart';
import 'package:shift/presentation/common/widgets/base_text.dart';
import 'package:shift/presentation/core/style/app_colors.dart';

class ShiftsAppbar extends StatelessWidget implements PreferredSizeWidget {
  const ShiftsAppbar({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ShiftsBloc, ShiftsBlocState>(
      builder: (context, state) {
        return AppBar(
          systemOverlayStyle: SystemUiOverlayStyle.dark,
          automaticallyImplyLeading: true,
          scrolledUnderElevation: 0,
          backgroundColor: AppColors.white,
          centerTitle: true,
          title: BaseText(
            text: 'Shifts',
            fontSize: 12,
            fontWeight: FontWeight.w400,
            fontFamily: "Aclonica",
          ),
          elevation: 0,
          bottom: TabBar(
            onTap: (value) {
              context.read<ShiftsBloc>().add(ShiftsBlocEvent.tabChange(value));
            },
            automaticIndicatorColorAdjustment: true,
            labelStyle: TextStyle(
              fontSize: getFontSize(14),
              fontWeight: FontWeight.w500,
              color: Color(0xFFC5C5C5),
              fontFamily: 'Roboto Flex',
            ),
            unselectedLabelStyle: TextStyle(
              fontSize: getFontSize(14),
              fontWeight: FontWeight.w500,
              color: Color(0xFFC5C5C5),
              fontFamily: 'Roboto Flex',
            ),
            labelColor: AppColors.black,
            unselectedLabelColor: AppColors.black.withOpacity(0.60),
            splashFactory: NoSplash.splashFactory,
            dividerColor: Color(0xFFC5C5C5),
            indicatorColor: AppColors.primaryColor,
            indicatorSize: TabBarIndicatorSize.tab,
            physics: BouncingScrollPhysics(),
            padding: EdgeInsets.zero,
            indicatorPadding: EdgeInsets.zero,
            labelPadding: EdgeInsets.zero,
            dividerHeight: getSize(2.5),
            indicatorWeight: getSize(2.5),
            tabs: [
              Tab(
                child: getTabTitleMethod(
                  title: 'Filled Shifts',
                  index: 0,
                  notificationsState: state,
                ),
              ),
              Tab(
                child: getTabTitleMethod(
                  title: 'Approve Shifts',
                  index: 1,
                  notificationsState: state,
                ),
              ),
              Tab(
                child: getTabTitleMethod(
                  title: 'Cancelled Shifts',
                  index: 2,
                  notificationsState: state,
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  getTabTitleMethod(
      {required String title,
      required int index,
      required ShiftsBlocState notificationsState}) {
    return BaseText(
      text: title,
      fontSize: 14,
      fontWeight: FontWeight.w500,
      textColor: notificationsState.selectedTab == index
          ? AppColors.primaryColor
          : Color(0xFFC5C5C5),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(getSize(100));
}
