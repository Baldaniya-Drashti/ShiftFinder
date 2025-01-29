import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:shift/application/contractor/contractor_full_time_position/contractor_full_time_position_bloc.dart';
import 'package:shift/domain/core/math_utils.dart';
import 'package:shift/domain/core/png_image_constants.dart';
import 'package:shift/domain/core/string_constant.dart';
import 'package:shift/domain/core/svg_image_constants.dart';
import 'package:shift/presentation/common/widgets/base_text.dart';
import 'package:shift/presentation/common/widgets/center_loading_indicator.dart';
import 'package:shift/presentation/common/widgets/paginated_list_view.dart';
import 'package:shift/presentation/core/style/app_colors.dart';
import 'package:shift/presentation/core/widgets/buttons/common_button.dart';
import 'package:shift/presentation/core/widgets/dialogs/dialogs.dart';
import 'package:shift/presentation/core/widgets/tile.dart';

class ContractorFullTimeAppliedPositionView extends StatelessWidget {
  const ContractorFullTimeAppliedPositionView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ContractorFullTimePositionBloc, ContractorFullTimePositionState>(
      builder: (context, state) {
        return Stack(
          children: [
            PaginatedListView(
              isNoDataFound: state.isNoDataFound,
              onRefresh: () {
                context.read<ContractorFullTimePositionBloc>().add(ContractorFullTimePositionEvent.fetchAppliedPositionList(refresh: true));
              },
              onLoading: () {
                context.read<ContractorFullTimePositionBloc>().add(ContractorFullTimePositionEvent.fetchAppliedPositionList(refresh: false));
              },
              refreshController: context.read<ContractorFullTimePositionBloc>().appliedRefreshController,
              child: state.isLoading
                  ? CenterLoadingIndicator()
                  : state.isErrorInAPI
                  ? Center(
                child: BaseText(text: StringConstant.somethindWentWrong),
              )
                  : ListView.separated(
                padding: EdgeInsets.all(12),
                itemBuilder: (context, index) => BaseTileDecoration(
                  child: Column(
                    children: [
                      _buildPositionTile(context),
                      Gap(12),
                      _buildSalaryInformation(context),
                      Gap(12),
                      _buildPositionDescription(context),
                      Gap(12),
                      _buildButtons(context)
                    ],
                  ),
                ),
                separatorBuilder: (context, index) => Gap(16),
                itemCount: 5,
              ),
            ),
            if (state.postDataLoading) CenterLoadingIndicator()

          ],
        );
      },
    );
  }

  Widget _positionDetailButton(
    BuildContext context, {
    required VoidCallback onPressed,
  }) {
    return CommonButton(
      borderRadius: 7,
      height: 40,
      backgroundColor: AppColors.primaryColor.withOpacity(0.2),
      onPressed: onPressed,
      buttonText: 'View Position Details',
      buttonFontSize: 12,
      buttonFontWeight: FontWeight.w600,
      buttonTextColor: AppColors.black,
    );
  }

  Widget _buildPositionTile(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(10),
      color: AppColors.scaffoldColor,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildPositionInfo(context),
            Gap(6),
            Divider(),
            Gap(6),
            _buildLocationInfo(context),
          ],
        ),
      ),
    );
  }

  Widget _buildPositionInfo(BuildContext context) {
    return Material(
      color: AppColors.scaffoldColor,
      child: Row(
        children: [
          Image.asset(
            PngImageConstants.nurse2,
            height: 50,
            color: AppColors.black.withOpacity(0.8),
          ),
          Gap(16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              BaseText(
                text: "Full Time",
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
              BaseText(
                text: "(Healthcare - 2DFG125)",
                fontSize: 12,
                fontWeight: FontWeight.w600,
                textColor: AppColors.black.withOpacity(0.8),
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget _buildLocationInfo(BuildContext context) {
    return CommonInfoTile(
      leading: SvgPicture.asset(
        SvgImageConstant.location,
        colorFilter: ColorFilter.mode(Colors.black, BlendMode.srcIn),
        height: 24,
        width: 24,
      ),
      title: BaseText(
        text: "4517 Washington Manchester, Kentucky 39495",
        fontWeight: FontWeight.w500,
        fontSize: 11,
        overflow: TextOverflow.ellipsis,
        maxLines: 1,
      ),
      subtitle: BaseText(
        text: "10.2 Km Away",
        fontWeight: FontWeight.w600,
        fontSize: 11,
        overflow: TextOverflow.ellipsis,
        maxLines: 1,
        textColor: AppColors.green,
      ),
    );
  }

  Widget _buildPositionDescription(BuildContext context) {
    return Material(
      color: AppColors.scaffoldColor,
      borderRadius: BorderRadius.circular(10),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            BaseText(text: "Position", fontSize: 12, fontWeight: FontWeight.w500),
            Divider(),
            BaseText(
              fontWeight: FontWeight.w400,
              fontSize: 14,
              text:
                  "Lorem ipsum dolor sit amet,gurte to consectetur adipiscing elit, sed do eghte fir eiusmod tempor incididunt ut labore et dolore magna?",
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSalaryInformation(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(10),
      color: AppColors.scaffoldColor,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      SvgPicture.asset(SvgImageConstant.dollorRound, height: 18),
                      Gap(10),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          BaseText(text: "Salary", fontSize: 12),
                          BaseText(
                            text: "93,000 – 98,000",
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            textColor: AppColors.green,
                          ),
                        ],
                      ),
                    ],
                  ),
                  Gap(22),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      SvgPicture.asset(
                        SvgImageConstant.calendar,
                        height: 18,
                        color: AppColors.black.withOpacity(0.8),
                      ),
                      Gap(10),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          BaseText(text: "Application Deadline", fontSize: 12),
                          Text.rich(
                            TextSpan(children: [
                              TextSpan(
                                text: "2024",
                                style: TextStyle(color: AppColors.green.withOpacity(0.5)),
                              )
                            ], text: "22 Oct, "),
                            style: TextStyle(fontSize: getSize(14), fontWeight: FontWeight.w600, color: AppColors.green),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 20),
              child: SvgPicture.asset(
                SvgImageConstant.clockWithBag,
                height: getSize(70),
                width: getSize(70),
                color: AppColors.primaryColor.withOpacity(0.15),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildButtons(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Material(
            borderRadius: BorderRadius.circular(7),
            color: AppColors.scaffoldColor,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: InkWell(
                onTap: () {},
                child: BaseText(
                  text: "View Shift Details",
                  fontWeight: FontWeight.w600,
                  fontSize: 12,
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
        ),
        Gap(14),
        Expanded(
          child: Material(
            borderRadius: BorderRadius.circular(7),
            color: AppColors.redAccent.withOpacity(0.15),
            child: InkWell(
              onTap: () async {
                final result = await AppDialog.showCommonDialog(
                  context: context,
                  title: "Cancel",
                  content: "Are you sure you want to cancel this application?",
                  successLabel: "Ok",
                );
                if (result ?? false) {
                  ///TODO:
                }
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: BaseText(
                  text: "Cancel Application",
                  fontWeight: FontWeight.w600,
                  fontSize: 12,
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}
