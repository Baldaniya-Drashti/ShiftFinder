import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:shift/application/employer/proposal_detail/proposal_detail_bloc.dart';
import 'package:shift/domain/core/math_utils.dart';
import 'package:shift/domain/core/png_image_constants.dart';
import 'package:shift/domain/core/string_constant.dart';
import 'package:shift/domain/core/svg_image_constants.dart';
import 'package:shift/infrastructure/core/employer_proposal_dto/employer_proposal_dto.dart';
import 'package:shift/injection.dart';
import 'package:shift/presentation/common/utils/date_time_format.dart';
import 'package:shift/presentation/common/widgets/base_text.dart';
import 'package:shift/presentation/core/style/app_colors.dart';
import 'package:shift/presentation/core/widgets/buttons/common_button.dart';
import 'package:shift/presentation/core/widgets/texts/common_texts.dart';
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
    return BlocProvider(
      create: (context) => getIt<ProposalDetailBloc>()
        ..add(
            ProposalDetailEvent.checkConfirmAvailability(widget.confirmDialog)),
      child: BlocBuilder<ProposalDetailBloc, ProposalDetailState>(
        builder: (context, state) {
          return PopScope(
            canPop: false,
            child: Scaffold(
              appBar: CommonAppBar(
                onBackPressed: () =>
                    Navigator.pop(context, state.isConfirmProposalDate),
                title: StringConstant.viewAvailability,
              ),
              body: Padding(
                padding: EdgeInsets.all(getSize(20)),
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
                          Gap(getSize(12)),
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
                                  Gap(6),
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
                    Gap(getSize(16)),
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
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
                            Gap(getSize(25)),
                            Container(
                              decoration: BoxDecoration(
                                color: Color(0XFFEDEDED),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              padding: EdgeInsets.all(getSize(8)),
                              child: GestureDetector(
                                onTap: () {
                                  bool value =
                                      state.isConfirmProposalDate ?? false;
                                  value = !value;

                                  context.read<ProposalDetailBloc>().add(
                                      ProposalDetailEvent
                                          .checkConfirmAvailability(value));
                                },
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(top: 6, left: 8),
                                      child: SizedBox(
                                        height: getSize(20),
                                        width: getSize(16.67),
                                        child: Checkbox(
                                          value: state.isConfirmProposalDate,
                                          activeColor: AppColors.primaryColor,
                                          side: BorderSide(
                                            width: getSize(1.5),
                                            color: AppColors.black
                                                .withValues(alpha: 0.5),
                                          ),
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(5),
                                          ),
                                          onChanged: (value) {
                                            if (value != null) {
                                              context
                                                  .read<ProposalDetailBloc>()
                                                  .add(ProposalDetailEvent
                                                      .checkConfirmAvailability(
                                                          value));
                                            }
                                          },
                                        ),
                                      ),
                                    ),
                                    Gap(getSize(15)),
                                    Expanded(
                                      child: BaseText(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 12,
                                        text: StringConstant
                                            .confirmProposalTimeDesc,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                            if (state.isConfirmError &&
                                state.isConfirmProposalDate == false)
                              commonErrorText(
                                  "* Please confirm that you reviewed proposed availability",
                                  padding: EdgeInsets.only(
                                      left: getSize(10), top: getSize(15))),
                            Padding(
                              padding: EdgeInsets.only(
                                  top: getSize(40), bottom: getSize(40)),
                              child: CommonButton(
                                  onPressed: () {
                                    context.read<ProposalDetailBloc>().add(
                                        ProposalDetailEvent.isCheckAvailability(
                                            context));
                                  },
                                  buttonText: StringConstant.confirm),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class _EmployerAvailabilityListTile extends StatelessWidget {
  const _EmployerAvailabilityListTile({required this.data});

  final EmployerProposalShiftDetailDto data;

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
