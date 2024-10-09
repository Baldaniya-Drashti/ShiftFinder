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
import 'package:shift/infrastructure/contractor_main/shift/applied_shift_dto/applied_shift_dto.dart';
import 'package:shift/infrastructure/onboarding_model/onboarding_dto.dart';
import 'package:shift/presentation/common/widgets/base_text.dart';
import 'package:shift/presentation/common/widgets/center_loading_indicator.dart';
import 'package:shift/presentation/common/widgets/paginated_list_view.dart';
import 'package:shift/presentation/core/common_lisitng/common_listing.dart';
import 'package:shift/presentation/core/style/app_colors.dart';
import 'package:shift/presentation/core/widgets/buttons/common_button.dart';
import 'package:shift/presentation/core/widgets/dialogs/app_dialog.dart';

class AppliedTab extends StatelessWidget {
  const AppliedTab({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ContractorShiftBloc, ContractorShiftState>(
      builder: (context, state) {
        return PaginatedListView(
            onRefresh: () {
              context
                  .read<ContractorShiftBloc>()
                  .add(ContractorShiftEvent.getAppliedTypeList(true));
            },
            refreshController:
                context.read<ContractorShiftBloc>().appliedTypeRefreshCtrl,
            onLoading: () {
              context
                  .read<ContractorShiftBloc>()
                  .add(ContractorShiftEvent.getAppliedTypeList(false));
            },
            isNoDataFound: state.isAppliedNoDataFound,
            child: state.isAppliedLoading
                ? CenterLoadingIndicator(isOnlyLoader: true)
                : state.isAppliedErrorInAPI
                    ? Center(
                        child:
                            BaseText(text: StringConstant.somethindWentWrong),
                      )
                    : ListView.builder(
                        itemCount: state.appliedList.length,
                        padding: EdgeInsets.symmetric(horizontal: getSize(10)),
                        itemBuilder: (context, index) {
                          final shift = state.appliedList[index];
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
                                  blurRadius: 10,
                                ),
                              ],
                            ),
                            child: Column(
                              children: [
                                userDetail(context, shift),
                                paddingBetweenFields(),
                                dateView(
                                  title: StringConstant.appliedDate,
                                  boldValue: convertTimeStampToDate(
                                      shift.applied_date ?? -1),
                                  timidValue: convertTimeStampToDate(
                                      shift.applied_date ?? -1,
                                      isYear: true),
                                ),
                                paddingBetweenFields(),
                                dateView(
                                  title: StringConstant.proposalDate,
                                  boldValue: convertTimeStampToDate(
                                      shift.applied_date ?? -1),
                                  timidValue: convertTimeStampToDate(
                                      shift.applied_date ?? -1,
                                      isYear: true),
                                ),
                                paddingBetweenFields(),
                                if (shift.revoke_status == 1) ...[
                                  Padding(
                                    padding: EdgeInsets.symmetric(
                                        vertical: getSize(10)),
                                    child: BaseText(
                                      text: StringConstant
                                          .offerRevokedByTheEmployer,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ] else ...[
                                  revokingStatus(),
                                  paddingBetweenFields(),
                                  Row(
                                    children: [
                                      buttonUI(
                                        onPressed: () {
                                          /*context.router.push(
                                  PageRouteInfo(
                                    ViewContractorShift.name,
                                    args: ViewContractorShiftArgs(
                                      postId:
                                          state.upcomingShiftList[index].id ??
                                              -1,
                                      isTotalApplicants: true,
                                    ),
                                  ),
                                );*/
                                        },
                                        buttonText:
                                            StringConstant.viewShiftDetails,
                                        textColor: AppColors.black,
                                        bgColor: AppColors.primaryColor
                                            .withOpacity(0.10),
                                      ),
                                      SizedBox(width: getSize(10)),
                                      (shift.request == 0)
                                          ? urgentActionRequiredBtn(context)
                                          : cancelBtn(context),
                                    ],
                                  ),
                                ],
                              ],
                            ),
                          );
                        },
                      ));
      },
    );
  }

  Widget revokingStatus() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(getSize(10)),
        color: AppColors.scaffoldColor,
      ),
      padding: EdgeInsets.symmetric(horizontal: getSize(12)),
      child: ListTile(
        dense: true,
        contentPadding: EdgeInsets.zero,
        horizontalTitleGap: 10,
        title: Padding(
          padding: EdgeInsets.only(left: getSize(20)),
          child: BaseText(
            text: StringConstant.revoking,
            fontSize: 12,
            fontWeight: FontWeight.w400,
            textColor: AppColors.black.withOpacity(0.7),
          ),
        ),
        trailing: Container(
          width: getSize(108),
          padding: EdgeInsets.symmetric(
              horizontal: getSize(10), vertical: getSize(5)),
          decoration: BoxDecoration(
              color: AppColors.primaryColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(6)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SvgPicture.asset(
                SvgImageConstant.clock,
                height: getSize(15),
                width: getSize(15),
              ),
              BaseText(
                text: "1 h 23 min",
                fontSize: 12,
                fontWeight: FontWeight.w600,
                textColor: AppColors.primaryColor,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget paddingBetweenFields({double? height}) {
    return SizedBox(
      height: getSize(height ?? 10),
    );
  }

  Widget userDetail(BuildContext context, AppliedShiftDTO shift) {
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
              text: shift.role_lists_name ?? " ",
              textColor: AppColors.black,
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                BaseText(
                  text: shift.company_name ?? " ",
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  textColor: AppColors.black.withOpacity(0.80),
                ),
                BaseText(
                  text:
                      "(${getIndustry(shift.industry_id ?? 0)}  - ${shift.listing_id ?? ''})",
                  fontSize: 10,
                  fontWeight: FontWeight.w500,
                  textColor: AppColors.black.withOpacity(0.80),
                ),
              ],
            ),
            trailing: BaseText(
              text: shift.last_ago ?? " ",
              fontSize: 10,
              fontWeight: FontWeight.w600,
            ),
            contentPadding: EdgeInsets.zero,
            visualDensity: VisualDensity.compact,
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
                        text: shift.location ?? " ",
                        fontSize: 12,
                        maxLines: 1,
                        fontWeight: FontWeight.w500,
                        textColor: AppColors.black,
                      ),
                      BaseText(
                        text: shift.distance ?? " ",
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

  String getIndustry(int id) {
    OnBoardingDTO industry = CommonList.industryList.firstWhere(
      (item) => item.id == id,
      orElse: () => OnBoardingDTO(),
    );
    return industry.title ?? "";
  }

  Widget dateView(
      {required String title,
      required String boldValue,
      required String timidValue}) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(getSize(10)),
        color: AppColors.scaffoldColor,
      ),
      padding: EdgeInsets.symmetric(horizontal: getSize(12)),
      child: ListTile(
          dense: true,
          contentPadding: EdgeInsets.zero,
          horizontalTitleGap: 0,
          leading: SvgPicture.asset(
            SvgImageConstant.calendar,
            color: AppColors.black.withOpacity(0.7),
            height: getSize(20),
            width: getSize(20),
          ),
          title: BaseText(
            text: title,
            fontSize: 12,
            fontWeight: FontWeight.w400,
            textColor: AppColors.primaryColor,
          ),
          trailing:
              highLightText(boldValue: boldValue, timidValue: timidValue)),
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

  Widget highLightText(
      {required String boldValue,
      required String timidValue,
      String? thirdValue}) {
    return RichText(
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

  Widget buttonUI({
    required void Function() onPressed,
    required String buttonText,
    Color? bgColor,
    Color? textColor,
  }) {
    return Flexible(
      child: CommonButton(
        onPressed: onPressed,
        height: 34,
        borderRadius: 10,
        buttonText: buttonText,
        buttonFontSize: 12,
        buttonTextColor: textColor,
        backgroundColor: bgColor,
      ),
    );
  }

  Widget urgentActionRequiredBtn(BuildContext context) {
    return buttonUI(
      onPressed: () {
        AppDialog.showUrgentActionDialog(
          context,
          title: StringConstant.urgentActionRequired,
          infoMessage: StringConstant.urgentActionRequiredDesc,
          cancelText: StringConstant.declineShift,
          deleteBtnText: StringConstant.confirmAcceptance,
          onCancelClick: () {
            context.router.maybePop();

            AppDialog.showDelete(
              context,
              title: StringConstant.declineShift,
              infoMessage: StringConstant.declineShiftDesc,
              cancelText: StringConstant.no,
              deleteBtnText: StringConstant.decline,
              onCancelClick: () {
                context.router.maybePop();
              },
              onDeleteClick: () {
                context.router.maybePop();
              },
            );
          },
          onDeleteClick: () {
            context.router.maybePop();
          },
        );
      },
      buttonText: StringConstant.urgentActionRequired,
    );
  }

  Widget cancelBtn(BuildContext context) {
    return buttonUI(
      onPressed: () {
        AppDialog.showDelete(
          context,
          title: StringConstant.cancle,
          infoMessage: StringConstant.areYouSureYouWantToCancelTheApplication,
          cancelText: StringConstant.no,
          deleteBtnText: StringConstant.cancle,
          onCancelClick: () {
            context.router.maybePop();
          },
          onDeleteClick: () {
            context.router.maybePop();
          },
        );
      },
      buttonText: StringConstant.cancelApplication,
      textColor: AppColors.black,
      bgColor: AppColors.redAccent.withOpacity(0.10),
    );
  }
}
