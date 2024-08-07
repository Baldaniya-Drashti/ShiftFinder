// ignore_for_file: prefer_const_constructors

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:shift/domain/core/math_utils.dart';
import 'package:shift/domain/core/string_constant.dart';
import 'package:shift/domain/core/svg_image_constants.dart';
import 'package:shift/presentation/common/widgets/base_text.dart';
import 'package:shift/presentation/common/widgets/paginated_list_view.dart';
import 'package:shift/presentation/core/app_router.gr.dart';
import 'package:shift/presentation/core/style/app_colors.dart';
import 'package:shift/presentation/core/widgets/buttons/common_button.dart';
import 'package:shift/presentation/core/widgets/dialogs/app_dialog.dart';
import 'package:shift/presentation/main/widgets/stacked_images.dart';

@RoutePage(name: 'HomeView')
class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: PaginatedListView(
        onRefresh: () {
          // context.read<CartBloc>().add(CartEvent.getCartList(true));
        },
        refreshController: RefreshController(),
        // context.read<HomeBloc>().refreshController,
        onLoading: () {
          // context.read<CartBloc>().add(CartEvent.getCartList(false));
        },
        // isNoDataFound: state.isNoDataFound,
        child:
            // state.isNoDataFound
            //     ? Text(state.isNoDataFound):
            ListView.builder(
          itemCount: 5,
          padding: EdgeInsets.symmetric(
            horizontal: getSize(15),
            vertical: getSize(5),
          ),
          clipBehavior: Clip.none,
          // shrinkWrap: true,
          physics: BouncingScrollPhysics(),
          itemBuilder: (_, index) {
            return getCheckoutContainer(index, context);
          },
        ),
      ),
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
          employeeDataBox(context),
          SizedBox(
            height: getSize(8),
          ),
          CommonButton(
            onPressed: () {
              context.router.push(PageRouteInfo(ViewHomeShiftDetails.name));
            },
            height: getSize(40),
            borderRadius: 7,
            backgroundColor: AppColors.primaryColor.withOpacity(0.1),
            buttonTextColor: AppColors.black,
            buttonFontSize: 12,
            buttonText: StringConstant.viewDetails,
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
                    value: "May 12, 2024",
                  ),
                  verticalDivider(),
                  verticalLabelValue(
                    label: "${StringConstant.startAndEndTime}:-",
                    value: "7AM to 6PM",
                  ),
                  verticalDivider(),
                  verticalLabelValue(
                    label: "${StringConstant.totalShifts}:-",
                    value: "5 Shifts",
                  )
                ],
              ),
            ),
          ),
          proposalBox(
            title: StringConstant.totalApplications,
            value: "24",
            onTap: () {
              context.router.push(PageRouteInfo(ViewSingleApplicants.name));
            },
          ),
          SizedBox(
            height: getSize(10),
          ),
          proposalBox(
            title: StringConstant.totalProposals,
            value: "13",
          ),
        ],
      ),
    );
  }

  Widget employeeDataBox(BuildContext context) {
    return Container(
      height: getSize(113.41),
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
            title: const BaseText(
              text: "CT Technologist",
              textColor: AppColors.white,
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
            subtitle: BaseText(
              text: "(Healthcare - 2DFG125)",
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
                        },
                      );
                    },
                    child: SvgPicture.asset(SvgImageConstant.delete)),
                SizedBox(
                  width: getSize(12),
                ),
                SvgPicture.asset(SvgImageConstant.edit),
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
          Row(
            children: [
              SvgPicture.asset(
                SvgImageConstant.location,
                height: getSize(20),
                width: getSize(20),
              ),
              SizedBox(
                width: getSize(10),
              ),
              const BaseText(
                text: "4517, Washington Manchester, Kentucky 39495",
                fontSize: 10,
                fontWeight: FontWeight.w500,
                textColor: AppColors.white,
              ),
            ],
          ),
        ],
      ),
    );
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
          fontSize: 8,
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

  Widget proposalBox(
      {required String title, required String value, Function()? onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        // height: getSize(78),
        padding: EdgeInsets.symmetric(
          vertical: getSize(8),
          horizontal: getSize(12),
        ),
        decoration: BoxDecoration(
            color: AppColors.grey04, borderRadius: BorderRadius.circular(10)),
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
                StackedImage(),
              ],
            )
          ],
        ),
      ),
    );
  }
}
