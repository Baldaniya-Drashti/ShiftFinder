// ignore_for_file: deprecated_member_use

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:shift/application/contractor/contractor_previous_shift/contractor_previous_shift_bloc.dart';
import 'package:shift/domain/core/math_utils.dart';
import 'package:shift/domain/core/png_image_constants.dart';
import 'package:shift/domain/core/string_constant.dart';
import 'package:shift/domain/core/svg_image_constants.dart';
import 'package:shift/infrastructure/core/contractor_previus_shift_dto/contractor_previus_shift_dto.dart';
import 'package:shift/presentation/common/widgets/base_text.dart';
import 'package:shift/presentation/common/widgets/center_loading_indicator.dart';
import 'package:shift/presentation/common/widgets/paginated_list_view.dart';
import 'package:shift/presentation/core/app_router.gr.dart';
import 'package:shift/presentation/core/common_lisitng/common_listing.dart';
import 'package:shift/presentation/core/helper/location_helper.dart';
import 'package:shift/presentation/core/style/app_colors.dart';
import 'package:shift/presentation/core/widgets/buttons/common_button.dart';

class ContractorCompletedShiftView extends StatelessWidget {
  const ContractorCompletedShiftView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ContractorPreviousShiftBloc,
        ContractorPreviousShiftState>(
      builder: (context, state) {
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: getSize(5)),
          child: state.completedDataListLoading
              ? CenterLoadingIndicator(isOnlyLoader: true)
              : state.completedDataListIsErrorApi
                  ? Center(
                      child: BaseText(text: StringConstant.somethindWentWrong))
                  : PaginatedListView(
                      onRefresh: () => context
                          .read<ContractorPreviousShiftBloc>()
                          .add(ContractorPreviousShiftEvent.getCompletedList(
                              isRefresh: true)),
                      onLoading: () => context
                          .read<ContractorPreviousShiftBloc>()
                          .add(ContractorPreviousShiftEvent.getCompletedList(
                              isRefresh: false)),
                      refreshController: context
                          .read<ContractorPreviousShiftBloc>()
                          .completedShiftController,
                      isNoDataFound: state.completedDataNoDataFound,
                      child: ListView.separated(
                        padding: EdgeInsets.symmetric(
                            horizontal: getSize(10), vertical: getSize(20)),
                        separatorBuilder: (context, index) => Gap(15),
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: state.completedDataList.length,
                        itemBuilder: (context, index) {
                          return Container(
                            padding: EdgeInsets.all(getSize(12)),
                            decoration: BoxDecoration(
                              color: AppColors.white,
                              borderRadius: BorderRadius.circular(getSize(20)),
                              boxShadow: [
                                BoxShadow(
                                  color: AppColors.black.withValues(alpha: 0.2),
                                  blurRadius: 10,
                                ),
                              ],
                            ),
                            child: Column(
                              children: [
                                userDetail(
                                    context, state.completedDataList[index]),
                                dateAndTime(context, state,
                                    state.completedDataList[index]),
                                CommonButton(
                                  onPressed: () {
                                    // showUnderDevelopment(context);
                                    context.router.push(PageRouteInfo(
                                        InvoiceDetailView.name,
                                        args: InvoiceDetailViewArgs(
                                            id: state.completedDataList[index]
                                                    .id ??
                                                -1)));
                                  },
                                  buttonText: StringConstant.viewReceipt,
                                  backgroundColor:
                                      AppColors.green.withValues(alpha: 0.1),
                                  buttonFontSize: 12,
                                  height: 43,
                                  buttonTextColor: AppColors.black,
                                  buttonFontWeight: FontWeight.w600,
                                  borderRadius: 7,
                                ),
                                Padding(
                                  padding: EdgeInsets.only(top: getSize(10)),
                                  child: BaseText(
                                    text: (state.completedDataList[index]
                                                .is_payment ==
                                            1)
                                        ? StringConstant.paymentCompleted
                                        : StringConstant.paymentUnderProcessing,
                                    textColor: (state.completedDataList[index]
                                                .is_payment ==
                                            1)
                                        ? AppColors.primaryColor
                                        : AppColors.redAccent,
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                  ),
                                )
                              ],
                            ),
                          );
                        },
                      ),
                    ),
        );
      },
    );
  }

  Widget userDetail(
    BuildContext context,
    ContractorPreviousShiftDTO user,
  ) {
    final industry = CommonList.industryList
        .firstWhere((element) => element.id == user.industry);
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(getSize(10)),
        color: AppColors.scaffoldColor,
      ),
      padding: EdgeInsets.symmetric(horizontal: getSize(12)),
      child: Column(
        children: [
          ListTile(
            dense: true,
            leading: Image.asset(
              PngImageConstants.leafWithBG,
              height: getSize(45),
              width: getSize(45),
            ),
            isThreeLine: true,
            title: BaseText(
              text: user.roles_list_name ?? "",
              textColor: AppColors.black,
              fontSize: 16,
              maxLines: 1,
              fontWeight: FontWeight.w600,
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                BaseText(
                  text: user.company_name ?? "",
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  textColor: AppColors.black.withValues(alpha: 0.80),
                ),
                BaseText(
                  text: "(${industry.title} - ${user.listing_id ?? ""})",
                  fontSize: 10,
                  fontWeight: FontWeight.w500,
                  textColor: AppColors.black.withValues(alpha: 0.80),
                ),
                BaseText(
                  text: user.location?.facility_type?.name ?? "",
                  fontSize: 10,
                  fontWeight: FontWeight.w500,
                ),
              ],
            ),
            contentPadding: EdgeInsets.zero,
            visualDensity: VisualDensity.compact,
          ),
          Divider(
            color: AppColors.black.withValues(alpha: 0.2),
            thickness: getSize(0.5),
          ),
          GestureDetector(
            onTap: () {
              final location = user.location;
              final latitude = location?.latitude;
              final longitude = location?.longitude;
              if (latitude != null && longitude != null) {
                LocationHelper.openDirections(context,
                    endLat: latitude, endLng: longitude);
              }
            },
            child: Row(
              children: [
                SvgPicture.asset(
                  SvgImageConstant.location,
                  height: getSize(25),
                  width: getSize(25),
                  color: AppColors.black,
                ),
                SizedBox(width: getSize(10)),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      BaseText(
                        text: user.location?.location ?? "",
                        fontSize: 12,
                        maxLines: 1,
                        fontWeight: FontWeight.w500,
                        textColor: AppColors.black,
                      ),
                      BaseText(
                        text: user.distance ?? "",
                        fontSize: 10,
                        maxLines: 1,
                        fontWeight: FontWeight.w600,
                        textColor: AppColors.primaryColor,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: getSize(12),
          ),
        ],
      ),
    );
  }

  Widget dateAndTime(BuildContext context, ContractorPreviousShiftState state,
      ContractorPreviousShiftDTO shift) {
    return Padding(
      padding:
          EdgeInsets.symmetric(horizontal: getSize(10), vertical: getSize(10)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
            flex: 10,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                (shift.shift_type == 1)
                    ? displayDateBreak(
                        context,
                        boldValue:
                            convertTimeStampToDate(shift.start_date ?? -1),
                        timidValue: convertTimeStampToDate(
                            shift.start_date ?? -1,
                            isYear: true),
                        title: StringConstant.shiftDate,
                        svgPrefixIcon: SvgImageConstant.calendar,
                      )
                    : displayDateBreak(
                        context,
                        boldValue:
                            "${shift.shift_date?.length ?? 0} ${((shift.shift_date?.length ?? 0) > 1) ? "Shifts" : "Shift"}",
                        timidValue: "",
                        title: StringConstant.totalShifts,
                        svgPrefixIcon: SvgImageConstant.calendar,
                      ),
              ],
            ),
          ),
          Flexible(
            flex: 13,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                displayDateBreak(
                  context,
                  boldValue: "",
                  timidValue: "",
                  title: "",
                  svgPrefixIcon: "",
                  showBtn: true,
                  onBtnPressed: () {
                    context.router.push(
                      PageRouteInfo(
                        ViewContractorShift.name,
                        args: ViewContractorShiftArgs(
                          postId: shift.applicants_id ?? -1,
                          isTotalApplicants: true,
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget displayTime({
    required String title,
    required String startDate,
    required String endDate,
    required String svgPrefixIcon,
  }) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: getSize(10)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          SvgPicture.asset(
            svgPrefixIcon,
            color: AppColors.black,
            height: getSize(20),
            width: getSize(16),
          ),
          SizedBox(width: getSize(10)),
          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              BaseText(
                text: StringConstant.time,
                fontSize: 10,
                fontWeight: FontWeight.w400,
                textColor: AppColors.black.withValues(alpha: 0.7),
              ),
              Row(
                children: [
                  BaseText(
                    text: startDate,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    textColor: AppColors.black,
                  ),
                  BaseText(
                    text: ' to ',
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    textColor: AppColors.black,
                  ),
                  BaseText(
                    text: endDate,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    textColor: AppColors.black,
                  ),
                ],
              ),
            ],
          )
        ],
      ),
    );
  }

  String convertTimeStampToDate(int timestamp,
      {bool isYear = false, bool isTime = false}) {
    DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);

    if (isTime) {
      return DateFormat('hh:mm a').format(dateTime);
    } else {
      if (isYear) {
        return DateFormat('yyyy').format(dateTime);
      } else {
        return DateFormat('d MMM, ').format(dateTime);
      }
    }
  }

  Widget displayDateBreak(BuildContext context,
      {required String title,
      required String boldValue,
      required String timidValue,
      required String svgPrefixIcon,
      bool showBtn = false,
      void Function()? onBtnPressed}) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: getSize(10)),
      child: (showBtn)
          ? CommonButton(
              onPressed: onBtnPressed ?? () {},
              // width: 160,
              height: 34,
              borderRadius: 5,
              buttonFontSize: 12,
              buttonFontWeight: FontWeight.w600,
              buttonText: StringConstant.viewShiftDetails,
              buttonTextColor: AppColors.black,
              backgroundColor: AppColors.scaffoldColor,
            )
          : Row(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                SvgPicture.asset(
                  svgPrefixIcon,
                  color: AppColors.black,
                  height: getSize(20),
                  width: getSize(16),
                ),
                SizedBox(width: getSize(10)),
                Flexible(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      BaseText(
                        text: title,
                        fontSize: 10,
                        fontWeight: FontWeight.w400,
                        textColor: AppColors.black.withValues(alpha: 0.7),
                      ),
                      highLightText(
                          boldValue: boldValue, timidValue: timidValue),
                    ],
                  ),
                ),
              ],
            ),
    );
  }

  Widget highLightText(
      {required String boldValue,
      required String timidValue,
      String? thirdValue}) {
    return RichText(
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        text: TextSpan(
          text: boldValue,
          style: TextStyle(
            fontSize: getFontSize(13),
            fontWeight: FontWeight.w500,
            color: AppColors.black,
          ),
          children: [
            TextSpan(
              text: timidValue,
              style: TextStyle(
                fontSize: getFontSize(13),
                fontWeight: FontWeight.w500,
                color: AppColors.black.withValues(alpha: 0.5),
              ),
            ),
            TextSpan(
              text: thirdValue ?? "",
            ),
          ],
        ));
  }
}
