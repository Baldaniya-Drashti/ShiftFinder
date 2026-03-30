// ignore_for_file: deprecated_member_use, must_be_immutable

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:shift/application/contractor/contractor_main_tab_bloc/send_proposal_bloc/send_proposal_bloc.dart';
import 'package:shift/domain/core/math_utils.dart';
import 'package:shift/domain/core/string_constant.dart';
import 'package:shift/domain/core/svg_image_constants.dart';
import 'package:shift/infrastructure/core/skill_list_model/skill_dto.dart';
import 'package:shift/infrastructure/main/date_time_dto/date_time_dto.dart';
import 'package:shift/infrastructure/main/healthcare_post/healthcare_post_dto.dart';
import 'package:shift/infrastructure/main/shift_detail_dto/shift_detail_dto.dart';
import 'package:shift/injection.dart';
import 'package:shift/presentation/common/utils/app_focus.dart';
import 'package:shift/presentation/common/utils/date_time_format.dart';
import 'package:shift/presentation/common/utils/get_cookie.dart';
import 'package:shift/presentation/common/widgets/base_text.dart';
import 'package:shift/presentation/common/widgets/center_loading_indicator.dart';
import 'package:shift/presentation/core/app_router.gr.dart';
import 'package:shift/presentation/core/common_lisitng/common_listing.dart';
import 'package:shift/presentation/core/helper/location_helper.dart';
import 'package:shift/presentation/core/style/app_colors.dart';
import 'package:shift/presentation/core/widgets/buttons/common_button.dart';
import 'package:shift/presentation/core/widgets/inputs/custom_dropdown_with_textfield.dart';
import 'package:shift/presentation/core/widgets/inputs/custom_text_field.dart';
import 'package:shift/presentation/core/widgets/inputs/custom_time_picker_dropdown.dart';
import 'package:shift/presentation/core/widgets/texts/common_texts.dart';
import 'package:shift/presentation/main/widgets/home_app_bar.dart';

@RoutePage(name: 'SendProposal')
class SendProposal extends StatelessWidget {
  bool isFromCounterPropose;
  int postId;
  int? id;

  SendProposal(
      {super.key,
      required this.postId,
      required this.id,
      this.isFromCounterPropose = false});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        AppFocus.unfocus(context);
      },
      child: BlocProvider(
        create: (context) => getIt<SendProposalBloc>()
          ..add(SendProposalEvent.getContractorShiftDetail(
              postID: postId,
              id: id,
              isFromCounterPropose: isFromCounterPropose)),
        child: BlocBuilder<SendProposalBloc, SendProposalState>(
          builder: (context, state) {
            return Scaffold(
              appBar: CommonAppBar(
                onBackPressed: () {
                  context.router.maybePop();
                },
                title: StringConstant.sendProposal,
              ),
              body: (state.isLoading)
                  ? CenterLoadingIndicator(isOnlyLoader: true)
                  : Form(
                      autovalidateMode: (state.showErrorMessages)
                          ? AutovalidateMode.always
                          : AutovalidateMode.disabled,
                      child: SingleChildScrollView(
                        child: Padding(
                          padding:
                              EdgeInsets.symmetric(horizontal: getSize(10)),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              contractorDataBox(context, state.shift),
                              paddingBetweenFields(),
                              Visibility(
                                  visible:
                                      state.shift.shift_detail?.shift_type == 2,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      availability(context, state),
                                      paddingBetweenFields(),
                                    ],
                                  )),
                              if (state.shift.shift_detail?.shift_type ==
                                  1) ...[
                                shiftDate(state.shift),
                                paddingBetweenFields(),
                              ],
                              if (state.shift.shift_detail?.shift_type == 1 ||
                                  (state.shift.shift_detail?.shift_type == 2 &&
                                      state.shift.shift_detail
                                              ?.same_or_different_time ==
                                          1)) ...[
                                unpaidBreak(state.shift),
                                paddingBetweenFields(),
                              ],
                              proposalTerms(),
                              paddingBetweenFields(),
                              Visibility(
                                  visible: (state
                                              .shift.shift_detail?.shift_type ==
                                          1 ||
                                      (state.shift.shift_detail?.shift_type ==
                                              2 &&
                                          state.shift.shift_detail
                                                  ?.same_or_different_time ==
                                              1)),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      startTime(context, state),
                                      paddingBetweenFields(),
                                      endTime(context, state),
                                      paddingBetweenFields(),
                                      totalPaybleHours(state),
                                      paddingBetweenFields(),
                                    ],
                                  )),
                              hourlyRateRow(context, state),
                              paddingBetweenFields(),
                              Visibility(
                                  visible: state.shift.shift_detail
                                          ?.commute_allowance_type ==
                                      1,
                                  child:
                                      commuteAllownceRateRow(context, state)),
                              Visibility(
                                  visible: state.shift.shift_detail
                                          ?.commute_allowance_type ==
                                      2,
                                  child:
                                      commuteAllownceHourRow(context, state)),
                              Visibility(
                                  visible: state.shift.shift_detail
                                          ?.accommodation_allowance_type ==
                                      1,
                                  child: accomdationAllownceRateRow(
                                      context, state)),
                              Visibility(
                                  visible: state.shift.shift_detail
                                          ?.accommodation_allowance_type ==
                                      2,
                                  child: accomdationAllownceHourRow(
                                      context, state)),
                              Padding(
                                padding:
                                    EdgeInsets.symmetric(vertical: getSize(20)),
                                child: CommonButton(
                                  onPressed: () {
                                    if (state.shift.shift_detail?.shift_type ==
                                        1) {
                                      context.read<SendProposalBloc>().add(
                                          SendProposalEvent
                                              .submitSingleShiftProposalEvent(
                                                  context));
                                    } else {
                                      if (state.shift.shift_detail
                                              ?.same_or_different_time ==
                                          1) {
                                        context.read<SendProposalBloc>().add(
                                            SendProposalEvent
                                                .submitSameMultiShiftProposalEvent(
                                                    context));
                                      } else {
                                        context.read<SendProposalBloc>().add(
                                            SendProposalEvent
                                                .submitDifferentMultiShiftProposalEvent(
                                                    context));
                                      }
                                    }
                                  },
                                  buttonText: StringConstant.sendProposal,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
            );
          },
        ),
      ),
    );
  }

  Widget verticalDivider() {
    return VerticalDivider(
      width: getSize(15),
      color: AppColors.black.withValues(alpha: 0.30),
      thickness: getSize(2),
      indent: getSize(10),
      endIndent: getSize(5),
    );
  }

  Widget hourlyRateRow(BuildContext context, SendProposalState state) {
    ProposalDTO proposal =
        state.shift.shift_detail?.proposal_received ?? ProposalDTO();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: EdgeInsets.only(left: getSize(15), bottom: getSize(10)),
          child: BaseText(
            text: StringConstant.rateHour,
            fontSize: 14,
          ),
        ),
        Container(
          padding: EdgeInsets.symmetric(
              vertical: getSize(10), horizontal: getSize(10)),
          decoration: BoxDecoration(
            color: AppColors.grey04,
            borderRadius: BorderRadius.circular(10),
          ),
          child: IntrinsicHeight(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisSize: MainAxisSize.min,
              children: [
                rateHourField(
                  context,
                  label: StringConstant.posted,
                  initialValue: "${proposal.posted_hourly_rate ?? 0.0}",
                  readOnly: true,
                ),
                verticalDivider(),
                rateHourField(
                  context,
                  initialValue: state.rateHour.getValue(),
                  label: StringConstant.proposed,
                ),
                if (proposal.counter_proposal_hourly_rate != null) ...[
                  verticalDivider(),
                  rateHourField(
                    context,
                    label: "Counter \nProposed",
                    initialValue:
                        "${proposal.counter_proposal_hourly_rate ?? 0.0}",
                    readOnly: true,
                  ),
                ],
              ],
            ),
          ),
        ),
        if (state.showErrorMessages && !state.rateHour.isValid())
          commonErrorText(
              context.read<SendProposalBloc>().state.rateHour.value.fold(
                    (f) => f.maybeMap(
                      empty: (value) => StringConstant.pleaseEnterRateHour,
                      invalidRate: (value) =>
                          StringConstant.pleaseEnterValidRateHour,
                      orElse: () => "",
                    ),
                    (_) => "",
                  ))
      ],
    );
  }

  Widget commuteAllownceRateRow(BuildContext context, SendProposalState state) {
    ProposalDTO proposal =
        state.shift.shift_detail?.proposal_received ?? ProposalDTO();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: EdgeInsets.only(left: getSize(15), bottom: getSize(10)),
          child: BaseText(
            text: StringConstant.commuteAllowance,
            fontSize: 14,
          ),
        ),
        Container(
          padding: EdgeInsets.symmetric(
              vertical: getSize(10), horizontal: getSize(10)),
          decoration: BoxDecoration(
            color: AppColors.grey04,
            borderRadius: BorderRadius.circular(10),
          ),
          child: IntrinsicHeight(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisSize: MainAxisSize.min,
              children: [
                commuteAllownceField(
                  context,
                  label: StringConstant.posted,
                  initialValue:
                      "${proposal.posted_commute_allowance_rate ?? 0.0}",
                  readOnly: true,
                ),
                verticalDivider(),
                commuteAllownceField(
                  context,
                  initialValue: state.commuteRate.getValue(),
                  label: StringConstant.proposed,
                ),
                if (proposal.counter_commute_allowance_rate != null) ...[
                  verticalDivider(),
                  commuteAllownceField(
                    context,
                    label: "Counter \nProposed",
                    initialValue:
                        "${proposal.counter_commute_allowance_rate ?? 0.0}",
                    readOnly: true,
                  ),
                ],
              ],
            ),
          ),
        ),
        if (state.showErrorMessages && !state.commuteRate.isValid())
          commonErrorText(
            (double.tryParse(state.commuteRate.getValue()) != null &&
                    double.parse(state.commuteRate.getValue()) <= 0)
                ? StringConstant.flatRateShouldNotBeZero
                : StringConstant.pleaseSelectCommuteAllownceValue,
          ),
      ],
    );
  }

  Widget accomdationAllownceRateRow(
      BuildContext context, SendProposalState state) {
    ProposalDTO proposal =
        state.shift.shift_detail?.proposal_received ?? ProposalDTO();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: EdgeInsets.only(left: getSize(15), bottom: getSize(10)),
          child: BaseText(
            text: StringConstant.accommodationAllowance,
            fontSize: 14,
          ),
        ),
        Container(
          padding: EdgeInsets.symmetric(
              vertical: getSize(10), horizontal: getSize(10)),
          decoration: BoxDecoration(
            color: AppColors.grey04,
            borderRadius: BorderRadius.circular(10),
          ),
          child: IntrinsicHeight(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisSize: MainAxisSize.min,
              children: [
                accomdationAllownceField(
                  context,
                  label: StringConstant.posted,
                  initialValue:
                      "${proposal.posted_accommodation_allowance_rate ?? 0.0}",
                  readOnly: true,
                ),
                verticalDivider(),
                accomdationAllownceField(
                  context,
                  initialValue: state.accomdationRate.getValue(),
                  label: StringConstant.proposed,
                ),
                if (proposal.counter_accommodation_allowance_rate != null) ...[
                  verticalDivider(),
                  accomdationAllownceField(
                    context,
                    label: "Counter \nProposed",
                    initialValue:
                        "${proposal.counter_accommodation_allowance_rate ?? 0.0}",
                    readOnly: true,
                  ),
                ],
              ],
            ),
          ),
        ),
        if (state.showErrorMessages && !state.accomdationRate.isValid())
          commonErrorText(
            (double.tryParse(state.accomdationRate.getValue()) != null &&
                    double.parse(state.accomdationRate.getValue()) <= 0)
                ? StringConstant.flatRateShouldNotBeZero
                : StringConstant.pleaseSelectAccomdationAllownceValue,
          ),
      ],
    );
  }

  Widget accomdationAllownceHourRow(
      BuildContext context, SendProposalState state) {
    ProposalDTO proposal =
        state.shift.shift_detail?.proposal_received ?? ProposalDTO();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: EdgeInsets.only(left: getSize(15), bottom: getSize(10)),
          child: BaseText(
            text: StringConstant.accommodationAllowance,
            fontSize: 14,
          ),
        ),
        Container(
          padding: EdgeInsets.symmetric(
              vertical: getSize(10), horizontal: getSize(10)),
          alignment: Alignment.bottomCenter,
          decoration: BoxDecoration(
            color: AppColors.grey04,
            borderRadius: BorderRadius.circular(10),
          ),
          child: IntrinsicHeight(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisSize: MainAxisSize.min,
              children: [
                accomdationAllownceDropDown(
                  context,
                  state,
                  label: StringConstant.posted,
                  initialValue: getAllownceHourName(
                      proposal.posted_accommodation_allowance_hour_id ?? 0,
                      state),
                  readOnly: true,
                ),
                verticalDivider(),
                accomdationAllownceDropDown(
                  context,
                  state,
                  initialValue: (state.accomdationHour.isValid())
                      ? state.accomdationHour.getValue()
                      : null,
                  label: StringConstant.proposed,
                ),
                if (proposal.counter_accommodation_allowance_hour_id !=
                    null) ...[
                  verticalDivider(),
                  accomdationAllownceDropDown(
                    context,
                    state,
                    label: "Counter \nProposed",
                    initialValue: getAllownceHourName(
                        proposal.counter_accommodation_allowance_hour_id ?? 0,
                        state),
                    readOnly: true,
                  ),
                ],
              ],
            ),
          ),
        ),
        if (state.showErrorMessages && !state.accomdationHour.isValid())
          commonErrorText(
            StringConstant.pleaseSelectAccomdationAllownceValue,
          ),
      ],
    );
  }

  Widget commuteAllownceHourRow(BuildContext context, SendProposalState state) {
    ProposalDTO proposal =
        state.shift.shift_detail?.proposal_received ?? ProposalDTO();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.end,
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: EdgeInsets.only(left: getSize(15), bottom: getSize(10)),
          child: BaseText(
            text: StringConstant.commuteAllowance,
            fontSize: 14,
          ),
        ),
        Container(
          padding: EdgeInsets.symmetric(
              vertical: getSize(10), horizontal: getSize(10)),
          decoration: BoxDecoration(
            color: AppColors.grey04,
            borderRadius: BorderRadius.circular(10),
          ),
          child: IntrinsicHeight(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisSize: MainAxisSize.min,
              children: [
                commuteAllownceDropDown(
                  context,
                  state,
                  label: StringConstant.posted,
                  initialValue: getAllownceHourName(
                      proposal.posted_commute_allowance_hour_id ?? 0, state),
                  readOnly: true,
                ),
                verticalDivider(),
                commuteAllownceDropDown(
                  context,
                  state,
                  initialValue: (state.commuteHour.isValid())
                      ? state.commuteHour.getValue()
                      : null,
                  label: StringConstant.proposed,
                ),
                if (proposal.counter_commute_allowance_hour_id != null) ...[
                  verticalDivider(),
                  commuteAllownceDropDown(
                    context,
                    state,
                    label: "Counter \nProposed",
                    initialValue: getAllownceHourName(
                        proposal.counter_commute_allowance_hour_id ?? 0, state),
                    readOnly: true,
                  ),
                ],
              ],
            ),
          ),
        ),
        if (state.showErrorMessages && !state.commuteHour.isValid())
          commonErrorText(StringConstant.pleaseSelectCommuteAllownceValue),
      ],
    );
  }

  String? getAllownceHourName(int id, SendProposalState state) {
    final hour = state.accomdationHoursList
        .firstWhere((hour) => hour.id == id, orElse: () => SkillDTO());
    return hour.name;
  }

  Widget paddingBetweenFields({double? height}) {
    return SizedBox(
      height: getSize(height ?? 15),
    );
  }

  Widget proposalTerms() {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: getSize(12),
        vertical: getSize(10),
      ),
      margin: EdgeInsets.symmetric(vertical: getSize(5)),
      width: double.infinity,
      decoration: BoxDecoration(
          color: AppColors.white, borderRadius: BorderRadius.circular(10)),
      child: ListTile(
        contentPadding: EdgeInsets.zero,
        minVerticalPadding: 0,
        horizontalTitleGap: getSize(0),
        leading: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              height: getSize(50),
              width: getSize(40),
              child: SvgPicture.asset(
                SvgImageConstant.female,
                color: AppColors.primaryColor,
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: getSize(10)),
              child: SvgPicture.asset(
                SvgImageConstant.verticalLine,
              ),
            ),
          ],
        ),
        title: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            BaseText(
              text: StringConstant.yourProposalTerms,
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
            SizedBox(height: getSize(5)),
            Flexible(
              child: BaseText(
                text: StringConstant.proposalTermsDesc,
                fontSize: 12,
                fontWeight: FontWeight.w500,
                lineHeight: getSize(1),
                maxLines: 10,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget contractorDataBox(BuildContext context, HealthcarePostDTO post) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(getSize(10)),
        color: AppColors.white,
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
              color: AppColors.primaryColor,
            ),
            isThreeLine: true,
            title: BaseText(
              text: post.roles_list_name ?? "",
              textColor: AppColors.black,
              fontSize: 16,
              fontWeight: FontWeight.w600,
              maxLines: 1,
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                BaseText(
                  text: post.company_name ?? "",
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  textColor: AppColors.black.withValues(alpha: 0.80),
                ),
                BaseText(
                  text:
                      "(${CommonList.industryList.where((item) => item.id == getCurrentIndustry()).map((item) => item.title).join(', ')} - ${post.listing_id})",
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  textColor: AppColors.black.withValues(alpha: 0.80),
                ),
                BaseText(
                  text: post.location?.facility_type?.name ?? "",
                  fontSize: 10,
                  fontWeight: FontWeight.w500,
                ),
              ],
            ),
            trailing: BaseText(
              text: post.last_ago ?? "",
              fontSize: 10,
              fontWeight: FontWeight.w600,
              textColor: AppColors.black.withValues(alpha: 0.80),
            ),
            contentPadding: EdgeInsets.zero,
            visualDensity: VisualDensity.compact,
            minTileHeight: getSize(43.41),
          ),
          Divider(
            color: AppColors.black.withValues(alpha: 0.2),
            thickness: getSize(0.5),
          ),
          GestureDetector(
            onTap: () {
              final location = post.location;
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
                        text: post.location?.location ?? "",
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        textColor: AppColors.black,
                      ),
                      BaseText(
                        text: post.distance ?? "",
                        fontSize: 10,
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

  Widget shiftDate(HealthcarePostDTO post) {
    return Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(getSize(10)),
          color: AppColors.white,
        ),
        padding: EdgeInsets.symmetric(
            horizontal: getSize(12), vertical: getSize(10)),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            SizedBox(width: getSize(5)),
            SvgPicture.asset(
              SvgImageConstant.calendar,
              color: AppColors.black,
              height: getSize(20),
              width: getSize(20),
            ),
            SizedBox(width: getSize(10)),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                BaseText(
                  text: StringConstant.shiftDate,
                  fontSize: 10,
                  fontWeight: FontWeight.w400,
                  textColor: AppColors.black.withValues(alpha: 0.7),
                ),
                SizedBox(height: getSize(5)),
                highLightText(
                  boldValue: convertTimeStampToDate(
                      post.shift_detail?.detail?[0].date ?? -1),
                  timidValue: "",
                ),
              ],
            ),
          ],
        ));
  }

  Widget unpaidBreak(HealthcarePostDTO post) {
    return Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(getSize(10)),
          color: AppColors.white,
        ),
        padding: EdgeInsets.symmetric(
            horizontal: getSize(12), vertical: getSize(10)),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            SizedBox(width: getSize(5)),
            SvgPicture.asset(
              SvgImageConstant.clock,
              color: AppColors.black,
              height: getSize(20),
              width: getSize(20),
            ),
            SizedBox(width: getSize(10)),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                BaseText(
                  text: StringConstant.unpaidBreak,
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  textColor: AppColors.black.withValues(alpha: 0.7),
                ),
                SizedBox(height: getSize(5)),
                BaseText(
                  text: post.shift_detail?.unpaid_break?.name ?? "",
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  textColor: AppColors.primaryColor,
                ),
              ],
            ),
          ],
        ));
  }

  Widget totalPaybleHours(SendProposalState state) {
    return CustomTextField(
      labelText: StringConstant.totalPayableHours,
      hintText: state.totalPaybleHours,
      hintAsValue: true,
      readOnly: true,
      fillColor: AppColors.grey04,
    );
  }

  String convertTimeStampToDate(int timestamp,
      {bool isYear = false, bool isTime = false}) {
    DateTime dateTime = CustomDateTimeFormat.timeStampToDateTime(
      timestamp,
    );

    if (isTime) {
      return DateFormat('hh:mm a').format(dateTime);
    } else {
      if (isYear) {
        return DateFormat('yyyy').format(dateTime);
      } else {
        return DateFormat('dd MMM, yyyy').format(dateTime);
      }
    }
  }

  Widget availability(BuildContext context, SendProposalState state) {
    final unAvailableList =
        state.multiDates.where((ele) => ele.isUnAvailable == true);
    return Container(
      // height: getSize(113.41),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(getSize(10)),
        color: AppColors.white,
      ),
      padding:
          EdgeInsets.symmetric(horizontal: getSize(12), vertical: getSize(10)),
      child: ListTile(
        titleAlignment: ListTileTitleAlignment.center,
        horizontalTitleGap: 0,
        contentPadding: EdgeInsets.only(left: getSize(5)),
        minTileHeight: getSize(59),
        leading: SvgPicture.asset(
          SvgImageConstant.calendar,
          color: AppColors.black,
          height: getSize(20),
          width: getSize(20),
        ),
        title: BaseText(
          text: StringConstant.proposeAvailability,
          fontSize: 12,
          fontWeight: FontWeight.w400,
          textColor: AppColors.black,
        ),
        subtitle: (state.shift.shift_detail?.same_or_different_time == 1)
            ? BaseText(
                text: (unAvailableList.isNotEmpty)
                    ? "${StringConstant.unavailableDates} - ${unAvailableList.length}"
                    : StringConstant.availableForEveryDates,
                fontSize: 10,
                fontWeight: FontWeight.w400,
                maxLines: 5,
                textColor: (unAvailableList.isNotEmpty)
                    ? AppColors.redAccent
                    : AppColors.primaryColor,
              )
            : BaseText(
                text: StringConstant.availabilityDesc,
                fontSize: 10,
                fontWeight: FontWeight.w400,
                maxLines: 5,
                textColor: AppColors.black.withValues(alpha: 0.7),
              ),
        trailing: CommonButton(
          onPressed: () {
            context.router
                .push(PageRouteInfo(ProposeAvailability.name,
                    args: ProposeAvailabilityArgs(
                      post: state.shift,
                      updatedDates: state.multiDates,
                      totalPayableHours: state.totalPaybleHours,
                    )))
                .then((value) {
              if (value != null) {
                final newValue = value as List;

                final updatedDates = newValue[0] as List<DateTimeDTO>;
                final totalPayableHours = newValue[1] as String;

                context
                    .read<SendProposalBloc>()
                    .add(SendProposalEvent.setMultiDate(
                      updatedDates: updatedDates,
                      totalPayableHours: totalPayableHours,
                    ));
              }
            });
          },
          height: 29,
          width: 132,
          buttonFontSize: 12,
          borderRadius: 5,
          buttonFontWeight: FontWeight.w500,
          buttonText: StringConstant.enterAvailability,
        ),
      ),
    );
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
        color: AppColors.primaryColor,
      ),
      children: [
        TextSpan(
          text: timidValue,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: AppColors.primaryColor.withValues(alpha: 0.5),
          ),
        ),
        TextSpan(
          text: thirdValue ?? "",
        ),
      ],
    ));
  }

  Widget startTime(BuildContext context, SendProposalState state) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        CustomTimePickerDropdown(
          labelText: StringConstant.startTime,
          disableDropDownColor: AppColors.grey04,
          hourValue:
              (state.startHour.isValid()) ? state.startHour.getValue() : null,
          minuteValue: (state.startMinute.isValid())
              ? state.startMinute.getValue()
              : null,
          hourOnChanged: (value) {
            if (value != null) {
              context
                  .read<SendProposalBloc>()
                  .add(SendProposalEvent.startHourChanged(value));
            }
          },
          minOnChanged: (value) {
            if (value != null) {
              context
                  .read<SendProposalBloc>()
                  .add(SendProposalEvent.startMinuteChanged(value));
            }
          },
        ),
      ],
    );
  }

  Widget endTime(BuildContext context, SendProposalState state) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        CustomTimePickerDropdown(
          labelText: StringConstant.endTime,
          disableDropDownColor: AppColors.grey04,
          hourValue:
              (state.endHour.isValid()) ? state.endHour.getValue() : null,
          minuteValue:
              (state.endMinute.isValid()) ? state.endMinute.getValue() : null,
          hourOnChanged: (value) {
            if (value != null) {
              context
                  .read<SendProposalBloc>()
                  .add(SendProposalEvent.endHourChanged(value));
            }
          },
          minOnChanged: (value) {
            if (value != null) {
              context
                  .read<SendProposalBloc>()
                  .add(SendProposalEvent.endMinuteChanged(value));
            }
          },
        ),
      ],
    );
  }

  Widget rateHourField(
    BuildContext context, {
    String? label,
    String? initialValue,
    bool readOnly = false,
  }) {
    return Expanded(
      child: CustomTextField(
        labelText: label ?? StringConstant.rateHour,
        isLabelPadding: false,
        isPrefixValueShow: true,
        errorMaxLines: 2,
        maxLength: 5,
        initialValue: (initialValue != null) ? initialValue : null,
        hintText: StringConstant.rateHour,
        readOnly: readOnly,
        fillColor: readOnly ? AppColors.grey04 : null,
        keyboardType:
            TextInputType.numberWithOptions(decimal: true, signed: true),
        inputFormatters: [
          FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}')),
        ],
        prefixIcon: Padding(
          padding: EdgeInsets.only(
            left: getSize(20),
            top: getSize(14),
            bottom: getSize(14),
          ),
          child: BaseText(
            text: '\$ ',
            fontSize: 14,
            fontWeight: FontWeight.w500,
            textColor: (initialValue != null)
                ? AppColors.black
                : AppColors.black.withValues(alpha: 0.5),
          ),
        ),
        prefixIconConstraints:
            BoxConstraints(maxWidth: getSize(100), minHeight: 0),
        onChanged: (value) {
          context
              .read<SendProposalBloc>()
              .add(SendProposalEvent.rateHourChanged(value));
        },
        errorInputBorder: InputBorder.none,
        validator: null,
      ),
    );
  }

  Widget commuteAllownceField(
    BuildContext context, {
    String? label,
    String? initialValue,
    bool readOnly = false,
  }) {
    return Expanded(
      child: CustomTextField(
        labelText: label,
        isLabelPadding: true,
        isPrefixValueShow: true,
        errorMaxLines: 2,
        maxLength: 5,
        readOnly: readOnly,
        initialValue: (initialValue != null) ? initialValue : null,
        fillColor: readOnly ? AppColors.grey04 : null,
        hintText: StringConstant.commuteAllowance,
        keyboardType:
            TextInputType.numberWithOptions(decimal: true, signed: true),
        inputFormatters: [
          FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}')),
        ],
        prefixIcon: Padding(
            padding: EdgeInsets.only(
              left: getSize(20),
              top: getSize(14),
              bottom: getSize(14),
            ),
            child: BaseText(
              text: '\$ ',
              fontSize: 14,
              fontWeight: FontWeight.w500,
            )),
        prefixIconConstraints:
            BoxConstraints(maxWidth: getSize(100), minHeight: 0),
        onChanged: (value) {
          context
              .read<SendProposalBloc>()
              .add(SendProposalEvent.commuteRateChanged(value));
        },
      ),
    );
  }

  Widget accomdationAllownceField(
    BuildContext context, {
    String? label,
    String? initialValue,
    bool readOnly = false,
  }) {
    return Expanded(
      child: CustomTextField(
        labelText: label,
        isLabelPadding: true,
        isPrefixValueShow: true,
        errorMaxLines: 2,
        maxLength: 5,
        hintText: StringConstant.accommodationAllowance,
        readOnly: readOnly,
        initialValue: (initialValue != null) ? initialValue : null,
        fillColor: readOnly ? AppColors.grey04 : null,
        keyboardType:
            TextInputType.numberWithOptions(decimal: true, signed: true),
        inputFormatters: [
          FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}')),
        ],
        prefixIcon: Padding(
            padding: EdgeInsets.only(
              left: getSize(20),
              top: getSize(14),
              bottom: getSize(14),
            ),
            child: BaseText(
              text: '\$ ',
              fontSize: 14,
              fontWeight: FontWeight.w500,
            )),
        prefixIconConstraints:
            BoxConstraints(maxWidth: getSize(100), minHeight: 0),
        onChanged: (value) {
          context
              .read<SendProposalBloc>()
              .add(SendProposalEvent.accomdationRateChanged(value));
        },
      ),
    );
  }

  Widget commuteAllownceDropDown(
    BuildContext context,
    SendProposalState state, {
    String? label,
    String? initialValue,
    bool readOnly = false,
  }) {
    return Flexible(
      child: CustomDropdwonWithTextField(
        verticalAlignment: MainAxisAlignment.end,
        labelText: label,
        hintText: StringConstant.commuteAllowance,
        isLabelPadding: true,
        fieldMaxLength: 5,
        showTextfield: false,
        showDropDown: false,
        dropDownReadOnly: readOnly,
        dropDownIcon: readOnly ? Container() : null,
        value: (initialValue != null) ? initialValue : null,
        childDroDwonHintText: StringConstant.selectHours,
        fieldInputFormatters: [
          FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}')),
        ],
        fieldKeyboardType: TextInputType.numberWithOptions(decimal: true),
        fieldHintText: "0.00",
        fieldPrefixIcon: Padding(
            padding: EdgeInsets.only(
              left: getSize(20),
              top: getSize(14),
              bottom: getSize(14),
            ),
            child: BaseText(
              text: '\$ ',
              fontSize: 14,
              fontWeight: FontWeight.w500,
              textColor: AppColors.black.withValues(alpha: 0.7),
            )),
        fieldPrefixIconConstraints:
            BoxConstraints(maxWidth: getSize(100), minHeight: 0),
        items: state.accomdationHoursList.map((val) {
          return DropdownMenuItem<String>(
            value: val.name,
            child: BaseText(
              text: val.name ?? "",
              fontSize: 14,
              textColor: AppColors.black,
            ),
          );
        }).toList(),
        onChanged: (value) {
          if (value != null) {
            context
                .read<SendProposalBloc>()
                .add(SendProposalEvent.commuteHourChanged(value));
          }
        },
        childDropDownItems: CommonList.commuteAllownceList.map((val) {
          return DropdownMenuItem<String>(
            value: val,
            child: BaseText(
              text: val,
              fontSize: 14,
              textColor: AppColors.black,
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget accomdationAllownceDropDown(
    BuildContext context,
    SendProposalState state, {
    String? label,
    String? initialValue,
    bool readOnly = false,
  }) {
    return Expanded(
      child: CustomDropdwonWithTextField(
        verticalAlignment: MainAxisAlignment.end,
        labelText: label,
        hintText: StringConstant.accommodationAllowance,
        isLabelPadding: true,
        showTextfield: false,
        showDropDown: false,
        dropDownReadOnly: readOnly,
        dropDownIcon: readOnly ? Container() : null,
        value: (initialValue != null) ? initialValue : null,
        items: state.accomdationHoursList.map((val) {
          return DropdownMenuItem<String>(
            value: val.name,
            child: BaseText(
              text: val.name ?? "",
              fontSize: 14,
              textColor: AppColors.black,
            ),
          );
        }).toList(),
        onChanged: (value) {
          if (value != null) {
            context
                .read<SendProposalBloc>()
                .add(SendProposalEvent.accomdationHourChanged(value));
          }
        },
      ),
    );
  }
}
