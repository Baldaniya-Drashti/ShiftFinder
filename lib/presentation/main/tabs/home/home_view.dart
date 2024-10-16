// ignore_for_file: prefer_const_constructors

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:shift/application/main_tab/home/home_bloc.dart';
import 'package:shift/domain/core/math_utils.dart';
import 'package:shift/domain/core/string_constant.dart';
import 'package:shift/domain/core/svg_image_constants.dart';
import 'package:shift/presentation/common/utils/flushbar_creator.dart';
import 'package:shift/presentation/common/widgets/base_text.dart';
import 'package:shift/presentation/common/widgets/center_loading_indicator.dart';
import 'package:shift/presentation/common/widgets/paginated_list_view.dart';
import 'package:shift/presentation/core/app_router.gr.dart';
import 'package:shift/presentation/core/logger/logger.dart';
import 'package:shift/presentation/core/style/app_colors.dart';
import 'package:shift/presentation/core/widgets/buttons/common_button.dart';
import 'package:shift/presentation/core/widgets/dialogs/app_dialog.dart';
import 'package:shift/presentation/main/widgets/stacked_images.dart';

@RoutePage(name: 'HomeView')
class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        return PaginatedListView(
          onRefresh: () {
            context
                .read<HomeBloc>()
                .add(HomeEvent.getEmployerDashboardList(true));
          },
          refreshController: context.read<HomeBloc>().refreshController,
          onLoading: () {
            context
                .read<HomeBloc>()
                .add(HomeEvent.getEmployerDashboardList(false));
          },
          isNoDataFound: state.isNoDataFound,
          noDataWidget: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                SvgPicture.asset(
                  SvgImageConstant.noShiftNurse,
                  height: getSize(112.59),
                  width: getSize(94.09),
                ),
                Padding(
                  padding:
                      EdgeInsets.only(top: getSize(20), bottom: getSize(5)),
                  child: BaseText(
                    text: StringConstant.noShiftPostedYet,
                    textAlign: TextAlign.center,
                    textColor: AppColors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.w400,
                    fontFamily: 'Aclonica',
                  ),
                ),
                SizedBox(
                  width: getSize(280),
                  child: BaseText(
                    textColor: AppColors.black.withOpacity(0.65),
                    text: StringConstant.getStartedwithNewShift,
                    textAlign: TextAlign.center,
                    lineHeight: 1.2,
                  ),
                ),
              ],
            ),
          ),
          child: state.isLoading
              ? CenterLoadingIndicator(isOnlyLoader: true)
              : state.isErrorInAPI
                  ? Center(
                      child: BaseText(text: StringConstant.somethindWentWrong),
                    )
                  :
                  // (state.employerDashboardList.isEmpty)
                  // ? Center(
                  //     child: BaseText(text: StringConstant.somethindWentWrong),
                  //   ):
                  // state.isNoDataFound
                  //     ? Text(state.isNoDataFound):
                  ListView.builder(
                      itemCount: state.employerDashboardList.length,
                      padding: EdgeInsets.symmetric(
                        horizontal: getSize(15),
                        vertical: getSize(5),
                      ),
                      clipBehavior: Clip.none,
                      shrinkWrap: true,
                      physics: BouncingScrollPhysics(),
                      itemBuilder: (_, index) {
                        return getCheckoutContainer(index, context);
                      },
                    ),
        );
      },
    );
  }

  getCheckoutContainer(
    // HomeState state,
    int index,
    BuildContext context,
  ) {
    // var productConfigarationList =
    //     jsonDecode(state.cartListDTO[index].product?.product_form_json ?? "");
    // var dataList = ProductFromJson.fromJson(productConfigarationList)
    //     .data
    //     .where((element) => element.fieldType == 1)
    //     .toList();

    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        return Container(
          padding: EdgeInsets.all(getSize(10)),
          margin: EdgeInsets.symmetric(vertical: getSize(12)),
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
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              employeeDataBox(context, index),
              SizedBox(
                height: getSize(8),
              ),
              CommonButton(
                onPressed: () {
                  context.router.push(
                    PageRouteInfo(
                      ViewHomeShiftDetails.name,
                      args: ViewHomeShiftDetailsArgs(
                        postId: state.employerDashboardList[index].id ?? -1,
                      ),
                    ),
                  );
                },
                height: getSize(40),
                borderRadius: 7,
                backgroundColor: AppColors.primaryColor.withOpacity(0.1),
                buttonTextColor: AppColors.black,
                buttonFontSize: 12,
                buttonText: StringConstant.viewShiftDetails,
              ),
              Container(
                decoration: BoxDecoration(
                  color: AppColors.grey04,
                  borderRadius: BorderRadius.circular(5),
                ),
                padding: EdgeInsets.symmetric(vertical: getSize(10)),
                margin: EdgeInsets.symmetric(vertical: getSize(10)),
                child: IntrinsicHeight(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      verticalLabelValue(
                        label: "${StringConstant.shiftDate}:-",
                        value: (state.employerDashboardList[index].start_date !=
                                null)
                            ? DateFormat('MMM dd,yyyy').format(
                                DateTime.fromMillisecondsSinceEpoch((state
                                            .employerDashboardList[index]
                                            .start_date ??
                                        -1) *
                                    1000),
                              )
                            : "",
                      ),
                      verticalDivider(),
                      (state.employerDashboardList[index].shift_type == 1)
                          ? verticalLabelValue(
                              label: "${StringConstant.startAndEndTime}:-",
                              value: (state.employerDashboardList[index]
                                              .start_time !=
                                          null &&
                                      state.employerDashboardList[index]
                                              .end_time !=
                                          null)
                                  ? "${DateFormat('hh:mm a').format(DateTime.fromMillisecondsSinceEpoch((state.employerDashboardList[index].start_time ?? 0) * 1000))} to ${DateFormat('hh:mm a').format(DateTime.fromMillisecondsSinceEpoch((state.employerDashboardList[index].end_time ?? 0) * 1000))}"
                                  : "",
                            )
                          : verticalLabelValue(
                              label: "${StringConstant.totalShifts}:-",
                              value:
                                  "${state.employerDashboardList[index].total_shift ?? 0} Shifts",
                            )
                    ],
                  ),
                ),
              ),
              proposalBox(
                  title: StringConstant.totalApplications,
                  value: (state.employerDashboardList[index]
                              .total_application_counts ??
                          0)
                      .toString(),
                  onTap: () {
                    //showUnderDevelopment(context);

                    Log.debug(state.employerDashboardList[index].id);
                    final id = state.employerDashboardList[index].id;
                    context.router.push(PageRouteInfo(ViewSingleApplicants.name,
                        args: ViewSingleApplicantsArgs(postId: id ?? 0)));
                  },
                  index: index,
                  isTotalApplicants: true),
              SizedBox(
                height: getSize(10),
              ),
              proposalBox(
                title: StringConstant.totalProposals,
                value:
                    (state.employerDashboardList[index].total_proposal_counts ??
                            0)
                        .toString(),
                onTap: () {
                  //showUnderDevelopment(context);
                  Log.debug(state.employerDashboardList[index].id);

                  context.router.push(PageRouteInfo(TotalPraposalView.name));
                },
                index: index,
              ),
            ],
          ),
        );
      },
    );
  }

  Widget employeeDataBox(BuildContext context, int index) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        return Container(
          // height: getSize(113.41),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(getSize(10)),
            color: AppColors.primaryColor,
          ),
          padding: EdgeInsets.symmetric(horizontal: getSize(12)),
          child: Column(
            children: [
              ListTile(
                dense: true,
                leading: SvgPicture.asset(
                  SvgImageConstant.female,
                  width: getSize(36.28),
                  height: getSize(43.41),
                ),
                title: BaseText(
                  text:
                      state.employerDashboardList[index].roles_list_name ?? "",
                  textColor: AppColors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
                subtitle: BaseText(
                  text:
                      "(${getIndustryText(state.employerDashboardList[index].industry ?? 0)} - ${state.employerDashboardList[index].listing_id ?? ""})",
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  textColor: AppColors.white.withOpacity(0.80),
                ),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    GestureDetector(
                      onTap: () {
                        AppDialog.showDelete(
                          context,
                          title: StringConstant.deleteTheShift,
                          infoMessage: StringConstant.deleteShiftDesc,
                          cancelText: StringConstant.no,
                          onCancelClick: () {
                            context.router.maybePop();
                          },
                          onDeleteClick: () {
                            context.router.maybePop();
                            context.read<HomeBloc>().add(HomeEvent.deletePost(
                                state.employerDashboardList[index].id ?? -1));
                          },
                        );
                      },
                      child: Container(
                        color: Colors.transparent,
                        padding: EdgeInsets.symmetric(vertical: getSize(10)),
                        child: SvgPicture.asset(
                          SvgImageConstant.delete,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: getSize(12),
                    ),
                    GestureDetector(
                      onTap: () {
                        context.router
                            .push(PageRouteInfo(HealthCarePostForm.name,
                                args: HealthCarePostFormArgs(
                                    postId:
                                        state.employerDashboardList[index].id)))
                            .then((value) {
                          context
                              .read<HomeBloc>()
                              .add(HomeEvent.getEmployerDashboardList(true));
                        });
                      },
                      child: Container(
                        color: Colors.transparent,
                        padding: EdgeInsets.symmetric(vertical: getSize(10)),
                        child: SvgPicture.asset(
                          SvgImageConstant.edit,
                        ),
                      ),
                    ),
                  ],
                ),
                contentPadding: EdgeInsets.zero,
                visualDensity: VisualDensity.compact,
                minTileHeight: getSize(43.41),
              ),
              Divider(
                color: AppColors.white.withOpacity(0.7),
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
                      height: getSize(20),
                      width: getSize(20),
                    ),
                    SizedBox(
                      width: getSize(10),
                    ),
                    Expanded(
                      child: BaseText(
                        text: state.employerDashboardList[index].location
                                ?.location ??
                            "",
                        fontSize: 10,
                        fontWeight: FontWeight.w500,
                        textColor: AppColors.white,
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
      },
    );
  }

  String getIndustryText(int type) {
    switch (type) {
      case 1:
        return "Healthcare";
      case 2:
        return "Pharmacy";
      case 3:
        return "Dental";
      case 4:
        return "Hospitality";
      case 5:
        return "Ophthalmology";
      default:
    }
    return "";
  }

  Widget verticalLabelValue({
    required String label,
    required String value,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        BaseText(
          text: label,
          fontSize: 9,
          fontWeight: FontWeight.w400,
        ),
        BaseText(
          text: value,
          fontSize: 10,
          fontWeight: FontWeight.w600,
        )
      ],
    );
  }

  Widget verticalDivider() {
    return VerticalDivider(
      color: AppColors.black.withOpacity(0.56),
      indent: getSize(2),
      endIndent: getSize(2),
    );
  }

  Widget proposalBox({
    required String title,
    required String value,
    Function()? onTap,
    required int index,
    bool isTotalApplicants = false,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        // height: getSize(78),
        padding: EdgeInsets.symmetric(
          vertical: getSize(8),
          horizontal: getSize(12),
        ),
        decoration: BoxDecoration(
          color: AppColors.grey04,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            BaseText(
              text: title,
              fontSize: 12,
              fontWeight: FontWeight.w500,
              textColor: AppColors.black.withOpacity(0.7),
            ),
            Row(
              children: [
                BaseText(
                  text: value,
                  fontSize: 25,
                  fontWeight: FontWeight.w600,
                  textColor: AppColors.primaryColor,
                ),
                SizedBox(
                  width: getSize(15),
                ),
                SvgPicture.asset(
                  SvgImageConstant.threePerson,
                ),
                Spacer(),
                StackedImage(
                  index: index,
                  isTotalApplicants: isTotalApplicants,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
