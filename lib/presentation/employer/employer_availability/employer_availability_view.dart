import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:shift/domain/core/math_utils.dart';
import 'package:shift/domain/core/png_image_constants.dart';
import 'package:shift/domain/core/svg_image_constants.dart';
import 'package:shift/infrastructure/core/proposal_detail_dto/proposal_detail_dto.dart';
import 'package:shift/presentation/common/widgets/base_text.dart';
import 'package:shift/presentation/core/style/app_colors.dart';
import 'package:shift/presentation/employer/profile/previous_shift_view/previous_shift_all_view.dart';
import 'package:shift/presentation/main/widgets/home_app_bar.dart';

@RoutePage(name: 'EmployerAvailabilityView')
class EmployerAvailabilityView extends StatelessWidget {
  const EmployerAvailabilityView({super.key, required this.list});

  final List<PostedProposedTime> list;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBar(
        onBackPressed: () => context.router.maybePop(),
        title: "View Availability",
      ),
      body: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.white,
              ),
              child: Row(
                children: [
                  SvgPicture.asset(SvgImageConstant.clockWithOuterLine, height: 40),
                  Gap(12),
                  Image.asset(
                    PngImageConstants.line,
                    height: 40,
                  ),
                  Gap(12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      BaseText(text: "Total Number of Shifts - ${list.length}", fontSize: 14, fontWeight: FontWeight.w600),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          CircleAvatar(
                            backgroundColor: AppColors.redAccent,
                            radius: 4,
                          ),
                          Gap(6),
                          BaseText(
                            text: "Unavailable Shifts - 2",
                            fontWeight: FontWeight.w500,
                            fontSize: 10,
                          ),
                        ],
                      )
                    ],
                  )
                ],
              ),
            ),
            Gap(16),
            Expanded(
              child: ListView.separated(
                itemBuilder: (context, index) => _EmployerAvailabilityListTile(data: list[index]),
                separatorBuilder: (context, index) => Gap(16),
                itemCount: list.length,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _EmployerAvailabilityListTile extends StatelessWidget {
  const _EmployerAvailabilityListTile({super.key, required this.data});

  final PostedProposedTime data;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        BaseText(
          text: DateFormat("dd MMM, yyyy").format(DateTime.fromMillisecondsSinceEpoch(data.start_time ?? 0)),
          fontSize: 14,
          fontWeight: FontWeight.w500,
          textColor: AppColors.green,
        ),
        SizedBox(height: getSize(10)),
        Container(
          padding: EdgeInsets.all(getSize(20)),
          decoration: BoxDecoration(
            color: Color(0xFFEDEDED),
            borderRadius: BorderRadius.circular(getSize(20)),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              getTitleAndDescription(
                context,
                title: 'Posted Time',
                description: '${formatUnixTimestamp(data.start_time ?? 0)} to ${formatUnixTimestamp(data.end_time ?? 0)}',
              ),
              SizedBox(height: getSize(20)),
              getTitleAndDescription(
                context,
                title: 'Proposed Time',
                description: '9:30 AM to 7:15 PM',
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget getTitleAndDescription(
    BuildContext context, {
    required String title,
    required String description,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        BaseText(
          text: title,
          fontSize: 14,
          fontWeight: FontWeight.w500,
        ),
        SizedBox(height: getSize(8)),
        Container(
          width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.symmetric(horizontal: getSize(20), vertical: getSize(15)),
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(getSize(10)),
          ),
          child: BaseText(
            text: description,
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}
