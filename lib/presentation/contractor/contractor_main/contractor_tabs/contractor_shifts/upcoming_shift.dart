// ignore_for_file: deprecated_member_use

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:shift/application/contractor/contractor_main_tab_bloc/contractor_shift_bloc/contractor_shift_bloc.dart';
import 'package:shift/domain/core/math_utils.dart';
import 'package:shift/domain/core/png_image_constants.dart';
import 'package:shift/domain/core/string_constant.dart';
import 'package:shift/domain/core/svg_image_constants.dart';
import 'package:shift/infrastructure/contractor_main/shift/upcoming_shift_dto/upcoming_shift_dto.dart';
import 'package:shift/infrastructure/onboarding_model/onboarding_dto.dart';
import 'package:shift/presentation/common/widgets/base_text.dart';
import 'package:shift/presentation/common/widgets/center_loading_indicator.dart';
import 'package:shift/presentation/common/widgets/paginated_list_view.dart';
import 'package:shift/presentation/core/app_router.gr.dart';
import 'package:shift/presentation/core/common_lisitng/common_listing.dart';
import 'package:shift/presentation/core/style/app_colors.dart';
import 'package:shift/presentation/core/widgets/buttons/common_button.dart';
import 'package:shift/presentation/core/widgets/dialogs/dialogs.dart';
import 'package:shift/presentation/core/widgets/inputs/custom_text_field.dart';
import 'package:shift/presentation/core/widgets/texts/common_texts.dart';

class UpcomingShift extends StatelessWidget {
  const UpcomingShift({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ContractorShiftBloc, ContractorShiftState>(
      builder: (context, state) {
        return PaginatedListView(
          onRefresh: () {
            context.read<ContractorShiftBloc>().add(ContractorShiftEvent.getUpcomingShiftAPI(true));
          },
          refreshController: context.read<ContractorShiftBloc>().upcomingShiftRefreshCtrl,
          onLoading: () {
            context.read<ContractorShiftBloc>().add(ContractorShiftEvent.getUpcomingShiftAPI(false));
          },
          isNoDataFound: state.isNoDataFound,
          child: state.isLoading
              ? CenterLoadingIndicator(isOnlyLoader: true)
              : state.isErrorInAPI
                  ? Center(
                      child: BaseText(text: StringConstant.somethindWentWrong),
                    )
                  : ListView.builder(
                      itemCount: state.upcomingShiftList.length,
                      shrinkWrap: true,
                      padding: EdgeInsets.symmetric(horizontal: getSize(20)),
                      itemBuilder: (context, index) {
                        return Container(
                          margin: EdgeInsets.symmetric(vertical: getSize(10)),
                          padding: EdgeInsets.all(getSize(10)),
                          width: getSize(355),
                          decoration: BoxDecoration(
                            color: AppColors.white,
                            borderRadius: BorderRadius.circular(getSize(20)),
                            boxShadow: [
                              BoxShadow(
                                color: AppColors.black.withOpacity(0.2),
                                blurRadius: 25,
                              ),
                            ],
                          ),
                          child: Column(
                            children: [
                              userDetail(context, state, state.upcomingShiftList[index]),
                              paddingBetweenFields(),
                              dateAndTime(context, state.upcomingShiftList[index]),
                              paddingBetweenFields(),
                              CommonButton(
                                onPressed: () {
                                  /*context.router.push(
                                    PageRouteInfo(
                                      ViewUpcomingShiftDetails.name,
                                      args: ViewUpcomingShiftDetailsArgs(
                                          postId: 1),
                                    ),
                                  );*/
                                  context.router.push(
                                    PageRouteInfo(
                                      ViewContractorShift.name,
                                      args: ViewContractorShiftArgs(
                                        postId: state.upcomingShiftList[index].id ?? -1,
                                        isTotalApplicants: true,
                                      ),
                                    ),
                                  );
                                },
                                height: 34,
                                borderRadius: 10,
                                buttonText: StringConstant.viewShiftDetails,
                                buttonFontSize: 12,
                                buttonTextColor: AppColors.black,
                                backgroundColor: AppColors.primaryColor.withOpacity(0.2),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
        );
      },
    );
  }

  Widget paddingBetweenFields({double? height}) {
    return SizedBox(
      height: getSize(height ?? 10),
    );
  }

  Widget userDetail(BuildContext context, ContractorShiftState state, UpComingShiftDTO shift) {
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
              height: getSize(40),
              width: getSize(40),
            ),
            isThreeLine: true,
            title: BaseText(
              text: shift.role_lists_name ?? "",
              textColor: AppColors.black,
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                BaseText(
                  text: shift.company_name ?? "",
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  textColor: AppColors.black.withOpacity(0.80),
                ),
                BaseText(
                  text: "(${getIndustry(shift.industry_id ?? 0)}  - ${shift.listing_id ?? ''})",
                  fontSize: 10,
                  fontWeight: FontWeight.w500,
                  textColor: AppColors.black.withOpacity(0.80),
                ),
              ],
            ),
            trailing: (shift.check_delete == true)
                ? GestureDetector(
                    onTap: () {
                      AppDialog.showSuccess(
                        context,
                        image: Container(),
                        title: StringConstant.withdrawShift,
                        infoMessage: StringConstant.withdrawShiftDesc,
                        onOkClick: () {
                          context.router.maybePop().then((value) {
                            showWithdrawDialog(context, shift, context.read<ContractorShiftBloc>());
                          });
                        },
                      );
                    },
                    child: Container(
                      padding: EdgeInsets.all(getSize(5)),
                      decoration: BoxDecoration(
                        color: AppColors.white,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: SvgPicture.asset(
                        SvgImageConstant.delete,
                        color: AppColors.black,
                      ),
                    ),
                  )
                : Text(""),
            contentPadding: EdgeInsets.zero,
            visualDensity: VisualDensity.compact,
            minTileHeight: getSize(43.41),
          ),
          Divider(
            color: AppColors.black.withOpacity(0.2),
            thickness: getSize(0.5),
          ),
          GestureDetector(
            onTap: () {
              /*context.router.push(
                    PageRouteInfo(
                      ShowGoogleMap.name,
                      args: ShowGoogleMapArgs(
                        latitude: 21.191535534205194,
                        longitude: 72.78582206137469,
                      ),
                    ),
                  );*/
            },
            child: Row(
              children: [
                SvgPicture.asset(
                  SvgImageConstant.location,
                  height: getSize(25),
                  width: getSize(25),
                  color: AppColors.black,
                ),
                SizedBox(
                  width: getSize(10),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      BaseText(
                        text: shift.location ?? "",
                        fontSize: 12,
                        maxLines: 1,
                        fontWeight: FontWeight.w500,
                        textColor: AppColors.black,
                      ),
                      BaseText(
                        text: shift.distance ?? "",
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
          SizedBox(height: getSize(12)),
        ],
      ),
    );
  }

  showWithdrawDialog(
    BuildContext context,
    UpComingShiftDTO shift,
    ContractorShiftBloc bloc,
  ) {
    AppDialog.showDelete(
      context,
      title: StringConstant.withdrawShift,
      infoMessage: StringConstant.withdrawCADFeeDesc,
      deleteBtnText: StringConstant.withdraw,
      otherContent: BlocBuilder<ContractorShiftBloc, ContractorShiftState>(
        bloc: bloc..emit(bloc.state.copyWith(showErrorMessages: false)),
        builder: (_, state) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              CustomTextField(
                labelText: StringConstant.reason,
                hintText: StringConstant.typeHere,
                maxLines: 5,
                fillColor: AppColors.grey04,
                onChanged: (value) {
                  context.read<ContractorShiftBloc>().add(ContractorShiftEvent.deletePostReasonChanged(value));
                },
              ),
              if (state.showErrorMessages)
                commonErrorText(
                  "Please add valid reason to delete post",
                  padding: EdgeInsets.symmetric(horizontal: getSize(15), vertical: getSize(10)),
                ),
            ],
          );
        },
      ),
      onCancelClick: () {
        context.router.maybePop();
      },
      onDeleteClick: () {
        context.read<ContractorShiftBloc>().add(ContractorShiftEvent.deleteUpcomingShift(context, postId: shift.post_id ?? -1));
      },
    );
  }

  String getIndustry(int id) {
    OnBoardingDTO industry = CommonList.industryList.firstWhere(
      (item) => item.id == id,
      orElse: () => OnBoardingDTO(),
    );
    return industry.title ?? "";
  }

  Widget dateAndTime(BuildContext context, UpComingShiftDTO shift) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Flexible(
          child: displayDateBreak(
            context,
            boldValue: convertTimeStampToDate(shift.applied_date ?? -1),
            timidValue: convertTimeStampToDate(shift.applied_date ?? -1, isYear: true),
            title: "",
            svgPrefixIcon: SvgImageConstant.calendar,
            titleWidget: Row(
              children: [
                BaseText(
                  text: StringConstant.startDate,
                  fontSize: 10,
                  fontWeight: FontWeight.w400,
                  textColor: AppColors.black.withOpacity(0.7),
                ),
                BaseText(
                  text: " (5 Shifts)",
                  fontSize: 10,
                  fontWeight: FontWeight.w400,
                  textColor: AppColors.primaryColor,
                ),
              ],
            ),
          ),
        ),
        Flexible(
          child: displayTime(
            title: StringConstant.time,
            startDate: "07:15 AM",
            endDate: "18:30 AM",
            svgPrefixIcon: SvgImageConstant.clock,
          ),
        ),
      ],
    );
  }

  String convertTimeStampToDate(int timestamp, {bool isYear = false, bool isTime = false}) {
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

  Widget displayDateBreak(
    BuildContext context, {
    required String title,
    required String boldValue,
    required String timidValue,
    required String svgPrefixIcon,
    bool showBtn = false,
    Widget? titleWidget,
  }) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: getSize(10)),
      child: (showBtn)
          ? CommonButton(
              onPressed: () {
                /*if (post.shift_detail != null) {
                          context.router.push(PageRouteInfo(ViewDates.name,
                              args: ViewDatesArgs(
                                  shiftDetail: post.shift_detail!)));
                        }*/
              },
              width: 160,
              height: 34,
              borderRadius: 5,
              buttonFontSize: 12,
              buttonFontWeight: FontWeight.w600,
              buttonText: StringConstant.viewDetails,
              buttonTextColor: AppColors.black,
              backgroundColor: AppColors.scaffoldColor,
            )
          : Row(
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
                    titleWidget ??
                        BaseText(
                          text: title,
                          fontSize: 10,
                          fontWeight: FontWeight.w400,
                          textColor: AppColors.black.withOpacity(0.7),
                        ),
                    highLightText(boldValue: boldValue, timidValue: timidValue),
                  ],
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
                  text: StringConstant.time,
                  fontSize: 10,
                  fontWeight: FontWeight.w400,
                  textColor: AppColors.black.withOpacity(0.7),
                ),
                highLightText(boldValue: "$startDate to $endDate", timidValue: ""),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget highLightText({required String boldValue, required String timidValue, String? thirdValue}) {
    return RichText(
        maxLines: 1,
        text: TextSpan(
          text: boldValue,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: AppColors.black,
          ),
          children: [
            TextSpan(
              text: timidValue,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: AppColors.black.withOpacity(0.5),
              ),
            ),
            TextSpan(
              text: thirdValue ?? "",
            ),
          ],
        ));
  }

  Widget paybaleTitleRate({required String title, required String value, bool isFirst = false, isLast = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        BaseText(
          text: title,
          fontSize: 12,
          fontWeight: (isLast) ? FontWeight.w600 : FontWeight.w400,
          textColor: AppColors.black.withOpacity(0.7),
        ),
        BaseText(
          text: value,
          fontSize: (isLast) ? 18 : 14,
          fontWeight: (isLast) ? FontWeight.w600 : FontWeight.w400,
          textColor: AppColors.primaryColor,
        ),
      ],
    );
  }
}
