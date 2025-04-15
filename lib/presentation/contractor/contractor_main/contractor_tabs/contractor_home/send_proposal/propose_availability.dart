// ignore_for_file: deprecated_member_use, use_key_in_widget_constructors, must_be_immutable

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shift/application/contractor/contractor_main_tab_bloc/send_proposal_bloc/send_proposal_bloc.dart';
import 'package:shift/domain/core/math_utils.dart';
import 'package:shift/domain/core/string_constant.dart';
import 'package:shift/domain/core/svg_image_constants.dart';
import 'package:shift/infrastructure/main/date_time_dto/date_time_dto.dart';
import 'package:shift/infrastructure/main/healthcare_post/healthcare_post_dto.dart';
import 'package:shift/infrastructure/main/shift_detail_dto/shift_detail_dto.dart';
import 'package:shift/injection.dart';
import 'package:shift/presentation/common/utils/date_time_format.dart';
import 'package:shift/presentation/common/utils/flushbar_creator.dart';
import 'package:shift/presentation/common/widgets/base_text.dart';
import 'package:shift/presentation/contractor/contractor_main/contractor_tabs/contractor_home/send_proposal/edit_proposal_time.dart';
import 'package:shift/presentation/contractor/contractor_main/contractor_tabs/contractor_home/send_proposal/mark_availability.dart';
import 'package:shift/presentation/core/style/app_colors.dart';
import 'package:shift/presentation/core/widgets/buttons/common_button.dart';
import 'package:shift/presentation/core/widgets/inputs/custom_text_field.dart';
import 'package:shift/presentation/main/widgets/home_app_bar.dart';

@RoutePage(name: 'ProposeAvailability')
class ProposeAvailability extends StatelessWidget {
  HealthcarePostDTO post;
  String? totalPayableHours;
  List<DateTimeDTO>? updatedDates;

  ProposeAvailability(
      {required this.post, this.updatedDates, this.totalPayableHours});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<SendProposalBloc>()
        ..add(SendProposalEvent.getMultiDateEvent(
            post, updatedDates, totalPayableHours)),
      child: BlocConsumer<SendProposalBloc, SendProposalState>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
            appBar: CommonAppBar(
              onBackPressed: () {
                context.router.maybePop();
              },
              title: StringConstant.proposeAvailability,
            ),
            body: DefaultTabController(
              length: 2,
              initialIndex: state.selectedTab,
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: getSize(20)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      BaseText(
                        text: StringConstant.proposalDesc,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        textColor: AppColors.black.withOpacity(0.6),
                      ),
                      paddingBetweenFields(),
                      if (post.shift_detail?.same_or_different_time == 2)
                        tabbar(context),
                      paddingBetweenFields(),
                      numberOfShift(
                        svgPrefixIcon: SvgImageConstant.clockWithOuterLine,
                        title:
                            "${StringConstant.totalNumberOfShifts} - ${(post.shift_detail?.detail != null && post.shift_detail!.detail!.isNotEmpty) ? "${(post.shift_detail?.detail?.length.toString().length == 2) ? post.shift_detail?.detail?.length : "0${post.shift_detail?.detail?.length}"}" : "00"}",
                      ),
                      paddingBetweenFields(),
                      (state.selectedTab == 0)
                          ? EditProposalTime(
                              shift: post.shift_detail ?? ShiftDetailDTO())
                          : MarkUnavailability(),
                      totalPaybleHours(state),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: getSize(30)),
                        child: CommonButton(
                          onPressed: () {
                            if (state.shift.shift_detail
                                    ?.same_or_different_time !=
                                1) {
                              final bool isBeforeTime =
                                  state.multiDates.any((dto) {
                                if (dto.start_time == null) return false;
                                final twoHoursLater =
                                    DateTime.now().add(Duration(hours: 2));
                                DateTime startTime =
                                    DateTime.parse(dto.start_time!);
                                return startTime.isBefore(twoHoursLater);
                              });

                              if (isBeforeTime) {
                                showError(
                                        message: StringConstant
                                            .shiftStartTimeMustBeAFutureTimeAndAtLeastTwoHoursAfterTheCurrentTime)
                                    .show(context);
                                return;
                              }
                              final isLessThanTwoHours =
                                  state.multiDates.any((dto) {
                                final totalPayableDuration =
                                    CustomDateTimeFormat.parseTotalPayableHours(
                                        dto.totalPaybleHours!);
                                return totalPayableDuration <
                                    Duration(hours: 2);
                              });

                              if (isLessThanTwoHours) {
                                showError(
                                        message: StringConstant
                                            .theTotalPayableHourMustBeAtLeastTwo)
                                    .show(context);
                              } else {
                                Navigator.pop(context,
                                    [state.multiDates, state.totalPaybleHours]);
                              }
                            } else {
                              Navigator.pop(context,
                                  [state.multiDates, state.totalPaybleHours]);
                            }
                          },
                          buttonText: StringConstant.done,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget totalPaybleHours(SendProposalState state) {
    return CustomTextField(
      labelText: StringConstant.totalPayableHours,
      hintText: state.totalPaybleHours,
      hintAsValue: true,
      readOnly: true,
      fillColor: AppColors.grey04,
    );
  }

  Widget paddingBetweenFields({double? height}) {
    return SizedBox(
      height: getSize(height ?? 15),
    );
  }

  Widget tabbar(BuildContext context) {
    return Container(
      height: getSize(50),
      padding: EdgeInsets.symmetric(vertical: getSize(5)),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
          10,
        ),
        color: AppColors.white,
      ),
      child: TabBar(
        onTap: (value) {
          context
              .read<SendProposalBloc>()
              .add(SendProposalEvent.tabChangeEvent(value));
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
          borderRadius: BorderRadius.circular(
            10,
          ),
          color: AppColors.primaryColor,
        ),
        tabs: const [
          Tab(text: StringConstant.editTime),
          Tab(text: StringConstant.markUnavailability),
        ],
      ),
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
