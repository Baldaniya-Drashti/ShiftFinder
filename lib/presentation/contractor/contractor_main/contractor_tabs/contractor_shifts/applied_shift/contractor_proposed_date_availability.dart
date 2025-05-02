import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:shift/domain/core/math_utils.dart';
import 'package:shift/domain/core/png_image_constants.dart';
import 'package:shift/domain/core/string_constant.dart';
import 'package:shift/domain/core/svg_image_constants.dart';
import 'package:shift/infrastructure/contractor_main/shift/applied_shift_dto/applied_shift_dto.dart';
import 'package:shift/presentation/common/utils/date_time_format.dart';
import 'package:shift/presentation/common/widgets/base_text.dart';
import 'package:shift/presentation/core/style/app_colors.dart';
import 'package:shift/presentation/employer/profile/previous_shift_view/previous_shift_all_view.dart';
import 'package:shift/presentation/main/widgets/home_app_bar.dart';

@RoutePage(name: 'ContractorProposedAvailability')
class ContractorProposedAvailability extends StatefulWidget {
  const ContractorProposedAvailability({
    super.key,
    required this.list,
  });

  final List<ProposalShiftDetailDTO> list;

  @override
  State<ContractorProposedAvailability> createState() =>
      _ContractorProposedAvailabilityState();
}

class _ContractorProposedAvailabilityState
    extends State<ContractorProposedAvailability> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final unavailableCount = widget.list
        .where((element) =>
            element.proposed_start_time == null &&
            element.proposed_end_time == null)
        .toList()
        .length;
    return Scaffold(
      appBar: CommonAppBar(
        onBackPressed: () => Navigator.pop(context),
        title: StringConstant.viewAvailability,
      ),
      body: Padding(
        padding: EdgeInsets.all(getSize(20)),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(getSize(16)),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.white,
              ),
              child: Row(
                children: [
                  SvgPicture.asset(SvgImageConstant.clockWithOuterLine,
                      height: getSize(40)),
                  Gap(getSize(12)),
                  Image.asset(PngImageConstants.line, height: 40),
                  Gap(getSize(12)),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      BaseText(
                          text:
                              "${StringConstant.totalNumberOfShifts} - ${widget.list.length}",
                          fontSize: 14,
                          fontWeight: FontWeight.w600),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          CircleAvatar(
                            backgroundColor: AppColors.redAccent,
                            radius: 4,
                          ),
                          Gap(getSize(6)),
                          BaseText(
                            text:
                                "${StringConstant.unavailableShifts} - $unavailableCount",
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
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ListView.separated(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) =>
                          EmployerAvailabilityListTile(
                              data: widget.list[index]),
                      separatorBuilder: (context, index) => Gap(15),
                      itemCount: widget.list.length,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class EmployerAvailabilityListTile extends StatelessWidget {
  const EmployerAvailabilityListTile({super.key, required this.data});

  final ProposalShiftDetailDTO data;

  @override
  Widget build(BuildContext context) {
    final unavailable =
        data.proposed_start_time == null && data.proposed_end_time == null;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 16),
          child: BaseText(
            text: DateFormat("dd MMM, yyyy").format(
                CustomDateTimeFormat.timeStampToDateTime(
                    (data.start_date ?? -1))),
            fontSize: 14,
            fontWeight: FontWeight.w500,
            textColor: AppColors.green,
          ),
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
                title: StringConstant.postedTime,
                description:
                    '${formatUnixTimestamp(data.posted_start_time ?? 0)} to ${formatUnixTimestamp(data.posted_end_time ?? 0)}',
              ),
              SizedBox(height: getSize(20)),
              getTitleAndDescription(
                unavailable: unavailable,
                context,
                title: StringConstant.proposedTime,
                description: unavailable
                    ? StringConstant.unavailable
                    : "${formatUnixTimestamp(data.proposed_start_time ?? 0)} to ${formatUnixTimestamp(data.proposed_end_time ?? 0)}",
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
    bool unavailable = false,
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
          padding: EdgeInsets.symmetric(
              horizontal: getSize(20), vertical: getSize(15)),
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(getSize(10)),
          ),
          child: BaseText(
            text: description,
            fontSize: 14,
            fontWeight: FontWeight.w500,
            textColor: unavailable ? AppColors.redAccent : null,
          ),
        ),
      ],
    );
  }
}
