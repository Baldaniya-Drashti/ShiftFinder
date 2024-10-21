import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:shift/domain/core/math_utils.dart';
import 'package:shift/domain/core/png_image_constants.dart';
import 'package:shift/domain/core/svg_image_constants.dart';
import 'package:shift/infrastructure/core/employer_proposal_dto/employer_proposal_dto.dart';
import 'package:shift/infrastructure/core/proposal_detail_dto/proposal_detail_dto.dart';
import 'package:shift/presentation/common/widgets/base_text.dart';
import 'package:shift/presentation/core/logger/logger.dart';
import 'package:shift/presentation/core/style/app_colors.dart';
import 'package:shift/presentation/employer/profile/previous_shift_view/previous_shift_all_view.dart';
import 'package:shift/presentation/main/widgets/home_app_bar.dart';

@RoutePage(name: 'EmployerAvailabilityView')
class EmployerAvailabilityView extends StatefulWidget {
  const EmployerAvailabilityView({
    super.key,
    required this.list,
    this.confirmDialog = false,
  });

  final List<EmployerProposalShiftDetailDto> list;
  final bool confirmDialog;

  @override
  State<EmployerAvailabilityView> createState() =>
      _EmployerAvailabilityViewState();
}

class _EmployerAvailabilityViewState extends State<EmployerAvailabilityView> {
  late ValueNotifier _confirmationCheckBox;

  @override
  void initState() {
    super.initState();
    _confirmationCheckBox = ValueNotifier(widget.confirmDialog);
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: true,

      // onPopInvokedWithResult: (didPop, result) {
      //   context.router.maybePop(_confirmationCheckBox.value);
      // },
      onPopInvoked: (result) {
        context.router.maybePop(_confirmationCheckBox.value);
      },
      child: Scaffold(
        appBar: CommonAppBar(
          onBackPressed: () =>
              context.router.maybePop(_confirmationCheckBox.value),
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
                    SvgPicture.asset(SvgImageConstant.clockWithOuterLine,
                        height: 40),
                    Gap(12),
                    Image.asset(
                      PngImageConstants.line,
                      height: 40,
                    ),
                    Gap(12),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        BaseText(
                            text:
                                "Total Number of Shifts - ${widget.list.length}",
                            fontSize: 14,
                            fontWeight: FontWeight.w600),
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
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      ListView.separated(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) =>
                            _EmployerAvailabilityListTile(
                                data: widget.list[index]),
                        separatorBuilder: (context, index) => Gap(28),
                        itemCount: widget.list.length,
                      ),
                      Gap(25),
                      Container(
                        decoration: BoxDecoration(
                          color: Color(0XFFEDEDED),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        padding: EdgeInsets.all(8),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(top: 6, left: 8),
                              child: SizedBox(
                                height: getSize(20),
                                width: getSize(16.67),
                                child: ValueListenableBuilder(
                                  valueListenable: _confirmationCheckBox,
                                  builder: (context, value, child) {
                                    return Checkbox(
                                      value: _confirmationCheckBox.value,
                                      activeColor: AppColors.primaryColor,
                                      side: BorderSide(
                                        width: getSize(1.5),
                                        color: AppColors.black.withOpacity(0.5),
                                      ),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                      onChanged: (value) {
                                        _confirmationCheckBox.value = value;
                                      },
                                    );
                                  },
                                ),
                              ),
                            ),
                            Gap(12),
                            Expanded(
                              child: BaseText(
                                fontWeight: FontWeight.w500,
                                fontSize: 12,
                                text:
                                    "I confirm that I have reviewed the proposed availability.",
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _EmployerAvailabilityListTile extends StatelessWidget {
  const _EmployerAvailabilityListTile({super.key, required this.data});

  final EmployerProposalShiftDetailDto data;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 16),
          child: BaseText(
            text: DateFormat("dd MMM, yyyy").format(
                DateTime.fromMillisecondsSinceEpoch(data.start_date ?? 0)),
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
                title: 'Posted Time',
                description:
                    '${formatUnixTimestamp(data.posted_start_time ?? 0)} to ${formatUnixTimestamp(data.posted_end_time ?? 0)}',
              ),
              SizedBox(height: getSize(20)),
              getTitleAndDescription(
                context,
                title: 'Proposed Time',
                description:
                    '${formatUnixTimestamp(data.proposed_start_time ?? 0)} to ${formatUnixTimestamp(data.proposed_end_time ?? 0)}',
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
          ),
        ),
      ],
    );
  }
}
