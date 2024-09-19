// ignore_for_file: deprecated_member_use

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shift/application/contractor/contractor_main_tab_bloc/send_proposal_bloc/send_proposal_bloc.dart';
import 'package:shift/domain/core/math_utils.dart';
import 'package:shift/domain/core/string_constant.dart';
import 'package:shift/domain/core/svg_image_constants.dart';
import 'package:shift/injection.dart';
import 'package:shift/presentation/common/utils/app_focus.dart';
import 'package:shift/presentation/common/widgets/base_text.dart';
import 'package:shift/presentation/core/app_router.gr.dart';
import 'package:shift/presentation/core/common_lisitng/common_listing.dart';
import 'package:shift/presentation/core/style/app_colors.dart';
import 'package:shift/presentation/core/widgets/buttons/common_button.dart';
import 'package:shift/presentation/core/widgets/inputs/custom_dropdown_with_textfield.dart';
import 'package:shift/presentation/core/widgets/inputs/custom_text_field.dart';
import 'package:shift/presentation/core/widgets/inputs/custom_time_picker_dropdown.dart';
import 'package:shift/presentation/main/widgets/home_app_bar.dart';

@RoutePage(name: 'SendProposal')
class SendProposal extends StatelessWidget {
  const SendProposal({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        AppFocus.unfocus(context);
      },
      child: BlocProvider(
        create: (context) => getIt<SendProposalBloc>(),
        child: Scaffold(
          appBar: CommonAppBar(
            onBackPressed: () {
              context.router.maybePop();
            },
            title: StringConstant.sendProposal,
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: getSize(20)),
              child: Column(
                children: [
                  contractorDataBox(context),
                  paddingBetweenFields(),
                  availability(context),
                  paddingBetweenFields(),
                  shiftDate(),
                  paddingBetweenFields(),
                  proposalTerms(),
                  paddingBetweenFields(),
                  startTime(context),
                  paddingBetweenFields(),
                  endTime(context),
                  paddingBetweenFields(),
                  rateHourDropDown(context),
                  paddingBetweenFields(),
                  commuteAllownceField(context),
                  paddingBetweenFields(),
                  commuteAllownceDropDown(context),
                  paddingBetweenFields(),
                  accomdationAllownceField(context),
                  paddingBetweenFields(),
                  accomdationAllownceDropDown(context),
                  paddingBetweenFields(),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: getSize(20)),
                    child: CommonButton(
                      onPressed: () {},
                      buttonText: StringConstant.sendProposal,
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
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
              height: getSize(43.41),
              width: getSize(36.28),
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

  Widget contractorDataBox(BuildContext context) {
    return Container(
      // height: getSize(113.41),
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
              text: "CT Technologist",
              textColor: AppColors.black,
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                BaseText(
                  text: "Louis Vuitton Pvt. Ltd.",
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  textColor: AppColors.black.withOpacity(0.80),
                ),
                BaseText(
                  text: "(Healthcare - 2DFG125)",
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  textColor: AppColors.black.withOpacity(0.80),
                ),
              ],
            ),
            trailing: BaseText(
              text: "2 Days Ago",
              fontSize: 10,
              fontWeight: FontWeight.w600,
              textColor: AppColors.black.withOpacity(0.80),
            ),
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
                        text: "4517 Washington Manchester, Kentucky 39495",
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        textColor: AppColors.black,
                      ),
                      BaseText(
                        text: "10.2 Km Away",
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
          SizedBox(
            height: getSize(12),
          ),
        ],
      ),
    );
  }

  Widget shiftDate() {
    return Container(
        // height: getSize(113.41),
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
                  textColor: AppColors.black.withOpacity(0.7),
                ),
                SizedBox(height: getSize(5)),
                highLightText(boldValue: "12 May, ", timidValue: "2024"),
              ],
            ),
          ],
        ));
  }

  Widget availability(BuildContext context) {
    return Container(
        // height: getSize(113.41),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(getSize(10)),
          color: AppColors.white,
        ),
        padding: EdgeInsets.symmetric(
            horizontal: getSize(12), vertical: getSize(10)),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Flexible(
              child: ListTile(
                titleAlignment: ListTileTitleAlignment.top,
                horizontalTitleGap: 0,
                contentPadding: EdgeInsets.only(left: getSize(5)),
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
                  textColor: AppColors.black.withOpacity(0.7),
                ),
                subtitle: BaseText(
                  text: StringConstant.availabilityDesc,
                  fontSize: 10,
                  fontWeight: FontWeight.w400,
                  maxLines: 5,
                  textColor: AppColors.black.withOpacity(0.7),
                ),
              ),
            ),
            /*SizedBox(width: getSize(5)),
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
                  text: StringConstant.proposeAvailability,
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  textColor: AppColors.black.withOpacity(0.7),
                ),
                SizedBox(
                  width: getHorizontalSize(160),
                  child: BaseText(
                    text: StringConstant.availabilityDesc,
                    fontSize: 10,
                    fontWeight: FontWeight.w400,
                    maxLines: 5,
                    textColor: AppColors.black.withOpacity(0.7),
                  ),
                ),
              ],
            ),
            Spacer(),*/
            CommonButton(
              onPressed: () {
                context.router.push(PageRouteInfo(ProposeAvailability.name));
              },
              height: 29,
              width: 132,
              buttonFontSize: 12,
              borderRadius: 5,
              buttonFontWeight: FontWeight.w500,
              buttonText: StringConstant.enterAvailability,
            ),
          ],
        ));
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
            color: AppColors.primaryColor.withOpacity(0.5),
          ),
        ),
        TextSpan(
          text: thirdValue ?? "",
        ),
      ],
    ));
  }

  Widget startTime(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        CustomTimePickerDropdown(
          labelText: StringConstant.startTime,
          disableDropDownColor: AppColors.grey04,
          /*hourValue:
              (state.startHour.isValid()) ? state.startHour.getValue() : null,
          minuteValue: (state.startMinute.isValid())
              ? state.startMinute.getValue()
              : null,*/
          hourOnChanged: (value) {},
          minOnChanged: (value) {},
        ),
        /*(state.singleShiftErrorMessages &&
                (!isStartHourValid(state) && !isStartMinValid(state)))
            ? commonErrorText(
                StringConstant.pleaseSelectHourAndMinutesOfStartTime)
            : (state.singleShiftErrorMessages && !isStartHourValid(state))
                ? commonErrorText(StringConstant.pleaseSelectHourOfStartTime)
                : (state.singleShiftErrorMessages && !isStartMinValid(state))
                    ? commonErrorText(
                        StringConstant.pleaseSelectMinutesOfStartTime)
                    : Container(),*/
      ],
    );
  }

  Widget endTime(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        CustomTimePickerDropdown(
          labelText: StringConstant.endTime,
          disableDropDownColor: AppColors.grey04,
          /*hourValue:
              (state.endHour.isValid()) ? state.endHour.getValue() : null,
          minuteValue:
              (state.endMinute.isValid()) ? state.endMinute.getValue() : null,*/
          hourOnChanged: (value) {},
          minOnChanged: (value) {},
        ),

        /*(state.singleShiftErrorMessages &&
                (!isEndHourValid(state) && !isEndMinValid(state)))
            ? commonErrorText(
                StringConstant.pleaseSelectHourAndMinutesOfEndTime)
            : (state.singleShiftErrorMessages && !isEndHourValid(state))
                ? commonErrorText(StringConstant.pleaseSelectHourOfEndTime)
                : (state.singleShiftErrorMessages && !isEndMinValid(state))
                    ? commonErrorText(
                        StringConstant.pleaseSelectMinutesOfEndTime)
                    : Container(),*/
      ],
    );
  }

  Widget rateHourDropDown(BuildContext context) {
    return CustomTextField(
      labelText: StringConstant.rateHour,
      isLabelPadding: true,
      isPrefixValueShow: true,
      errorMaxLines: 2,
      maxLength: 5,
      hintText: StringConstant.rateHour,
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
            // textColor: (state.rateHour.isValid())
            //     ? AppColors.black
            //     : AppColors.black.withOpacity(0.5),
          )),
      prefixIconConstraints:
          BoxConstraints(maxWidth: getSize(100), minHeight: 0),
      onChanged: (value) {},
      /*validator: (p0, p1) => context
          .read<HealthcarePostBloc>()
          .state
          .rateHour
          .value
          .fold(
            (f) => f.maybeMap(
              empty: (value) => StringConstant.pleaseEnterRateHour,
              invalidRate: (value) => StringConstant.pleaseEnterValidRateHour,
              orElse: () => null,
            ),
            (_) => null,
          ),*/
    );
  }

  Widget commuteAllownceField(BuildContext context) {
    return CustomTextField(
      labelText: StringConstant.commuteAllowance,
      isLabelPadding: true,
      isPrefixValueShow: true,
      errorMaxLines: 2,
      maxLength: 5,
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
            // textColor: (state.rateHour.isValid())
            //     ? AppColors.black
            //     : AppColors.black.withOpacity(0.5),
          )),
      prefixIconConstraints:
          BoxConstraints(maxWidth: getSize(100), minHeight: 0),
      onChanged: (value) {},
      /*validator: (p0, p1) => context
          .read<HealthcarePostBloc>()
          .state
          .rateHour
          .value
          .fold(
            (f) => f.maybeMap(
              empty: (value) => StringConstant.pleaseEnterRateHour,
              invalidRate: (value) => StringConstant.pleaseEnterValidRateHour,
              orElse: () => null,
            ),
            (_) => null,
          ),*/
    );
  }

  Widget commuteAllownceDropDown(BuildContext context) {
    return CustomDropdwonWithTextField(
      labelText: StringConstant.commuteAllowance,
      hintText: StringConstant.commuteAllowance,
      isLabelPadding: true,
      fieldMaxLength: 5,
      showTextfield: false,
      showDropDown: false,
      childDroDwonHintText: StringConstant.selectHours,
      fieldInputFormatters: [
        FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}')),
      ],
      fieldKeyboardType: TextInputType.numberWithOptions(decimal: true),
      fieldHintText: "0.00",
      /*value: (state.selectedCommuteAllownce.isValid())
          ? state.selectedCommuteAllownce.getValue()
          : null,*/

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
            textColor: AppColors.black.withOpacity(0.7),
          )),
      fieldPrefixIconConstraints:
          BoxConstraints(maxWidth: getSize(100), minHeight: 0),
      items: CommonList.commuteAllownceList.map((val) {
        return DropdownMenuItem<String>(
          value: val,
          child: BaseText(
            text: val,
            fontSize: 14,
            textColor: AppColors.black,
          ),
        );
      }).toList(),
      onChanged: (value) {
        // if (value != null) {
        //   context
        //       .read<PostShiftBloc>()
        //       .add(PostShiftEvent.commuteAllownceChanged(value));
        // }
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
    );
  }

  Widget accomdationAllownceField(BuildContext context) {
    return CustomTextField(
      labelText: StringConstant.accommodationAllowance,
      isLabelPadding: true,
      isPrefixValueShow: true,
      errorMaxLines: 2,
      maxLength: 5,
      hintText: StringConstant.accommodationAllowance,
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
            // textColor: (state.rateHour.isValid())
            //     ? AppColors.black
            //     : AppColors.black.withOpacity(0.5),
          )),
      prefixIconConstraints:
          BoxConstraints(maxWidth: getSize(100), minHeight: 0),
      onChanged: (value) {},
      /*validator: (p0, p1) => context
          .read<HealthcarePostBloc>()
          .state
          .rateHour
          .value
          .fold(
            (f) => f.maybeMap(
              empty: (value) => StringConstant.pleaseEnterRateHour,
              invalidRate: (value) => StringConstant.pleaseEnterValidRateHour,
              orElse: () => null,
            ),
            (_) => null,
          ),*/
    );
  }

  Widget accomdationAllownceDropDown(BuildContext context) {
    return CustomDropdwonWithTextField(
      labelText: StringConstant.accommodationAllowance,
      hintText: StringConstant.accommodationAllowance,
      isLabelPadding: true,
      fieldMaxLength: 5,
      showTextfield: false,
      showDropDown: false,
      childDroDwonHintText: StringConstant.selectHours,
      fieldInputFormatters: [
        FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}')),
      ],
      fieldKeyboardType: TextInputType.numberWithOptions(decimal: true),
      fieldHintText: "0.00",
      /*value: (state.selectedCommuteAllownce.isValid())
          ? state.selectedCommuteAllownce.getValue()
          : null,*/

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
            textColor: AppColors.black.withOpacity(0.7),
          )),
      fieldPrefixIconConstraints:
          BoxConstraints(maxWidth: getSize(100), minHeight: 0),
      items: CommonList.commuteAllownceList.map((val) {
        return DropdownMenuItem<String>(
          value: val,
          child: BaseText(
            text: val,
            fontSize: 14,
            textColor: AppColors.black,
          ),
        );
      }).toList(),
      onChanged: (value) {
        // if (value != null) {
        //   context
        //       .read<PostShiftBloc>()
        //       .add(PostShiftEvent.commuteAllownceChanged(value));
        // }
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
    );
  }
}
