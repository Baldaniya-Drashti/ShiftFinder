import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shift/application/employer/counter_proposal_detail/counter_proposal_detail_bloc.dart';
import 'package:shift/domain/core/math_utils.dart';
import 'package:shift/domain/core/string_constant.dart';
import 'package:shift/infrastructure/core/proposal_detail_dto/proposal_detail_dto.dart';
import 'package:shift/injection.dart';
import 'package:shift/presentation/common/widgets/base_text.dart';
import 'package:shift/presentation/core/common_lisitng/common_listing.dart';
import 'package:shift/presentation/core/logger/logger.dart';
import 'package:shift/presentation/core/style/app_colors.dart';
import 'package:shift/presentation/core/widgets/buttons/common_button.dart';
import 'package:shift/presentation/core/widgets/inputs/custom_dropdown_with_textfield.dart';
import 'package:shift/presentation/core/widgets/inputs/custom_text_field.dart';
import 'package:shift/presentation/main/tabs/home/praposals/widgets/person_praposal_view.dart';
import 'package:shift/presentation/main/tabs/home/view_single_applicants/widgets/accept_reject_dialog.dart';
import 'package:shift/presentation/main/widgets/home_app_bar.dart';

@RoutePage(name: 'CounterPurposeView')
class CounterPurposeView extends StatefulWidget {
  const CounterPurposeView({super.key, required this.data});

  final ProposalDetailDto data;

  @override
  State<CounterPurposeView> createState() => _CounterPurposeViewState();
}

class _CounterPurposeViewState extends State<CounterPurposeView> {
  final TextEditingController _hourlyRateController = TextEditingController();
  final TextEditingController _commuteAllowanceController = TextEditingController();
  final TextEditingController _accommodationAllowanceController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Log.debug("data=> ${widget.data}");
    return BlocProvider(
      create: (context) => getIt<CounterProposalDetailBloc>(),
      child: Scaffold(
        appBar: CommonAppBar(
          onBackPressed: () {
            context.router.maybePop();
          },
          title: 'Counter Propose',
        ),
        body: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: Form(
            child: ListView(
              shrinkWrap: true,
              physics: BouncingScrollPhysics(),
              padding: EdgeInsets.symmetric(horizontal: getSize(20)),
              children: [
                SizedBox(height: getSize(20)),
                PraposalPersonView(data: widget.data),
                SizedBox(height: getSize(20)),
                BaseText(
                  text: '12 May, 2024',
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
                    children: [
                      getTitleAndDescription(
                        context,
                        title: 'Posted Time',
                        description: '9:30 AM to 7:15 PM',
                      ),
                      SizedBox(height: getSize(20)),
                      getTitleAndDescription(
                        context,
                        title: 'Agreed Time',
                        description: '9:30 AM to 7:15 PM',
                      ),
                    ],
                  ),
                ),
                SizedBox(height: getSize(20)),
                BaseText(
                  text: 'Hourly Rate',
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
                SizedBox(height: getSize(10)),
                Container(
                  padding: EdgeInsets.all(getSize(20)),
                  decoration: BoxDecoration(
                    color: Color(0xFFEDEDED),
                    borderRadius: BorderRadius.circular(getSize(20)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      getTitleAndDescription(
                        context,
                        title: 'Posted',
                        description: '\$25',
                      ),
                      SizedBox(height: getSize(20)),
                      getTitleAndDescription(
                        context,
                        title: 'Agreed Time',
                        description: '9:30 AM to 7:15 PM',
                      ),
                      SizedBox(height: getSize(20)),
                      BaseText(
                        text: 'Counter Proposal',
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                      SizedBox(height: getSize(8)),
                      CustomTextField(
                        hintText: '\$ Counter Proposal',
                        keyboardType: TextInputType.number,
                        textInputAction: TextInputAction.done,
                        controller: _hourlyRateController,
                      ),
                    ],
                  ),
                ),
                SizedBox(height: getSize(20)),
                BaseText(
                  text: 'Commute Allowance',
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
                SizedBox(height: getSize(10)),
                Container(
                  padding: EdgeInsets.all(getSize(20)),
                  decoration: BoxDecoration(
                    color: Color(0xFFEDEDED),
                    borderRadius: BorderRadius.circular(getSize(20)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      getTitleAndDescription(
                        context,
                        title: 'Posted',
                        description: '\$20',
                      ),
                      SizedBox(height: getSize(20)),
                      getTitleAndDescription(
                        context,
                        title: 'Proposed',
                        description: '\$25',
                      ),
                      SizedBox(height: getSize(20)),
                      BaseText(
                        text: 'Counter Proposal',
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                      SizedBox(height: getSize(8)),
                      CustomTextField(
                        controller: _commuteAllowanceController,
                        hintText: '\$ Counter Proposal',
                        keyboardType: TextInputType.number,
                        textInputAction: TextInputAction.done,
                      ),
                    ],
                  ),
                ),
                SizedBox(height: getSize(20)),
                BaseText(
                  text: 'Accommodation Allowance',
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
                SizedBox(height: getSize(10)),
                Container(
                  padding: EdgeInsets.all(getSize(20)),
                  decoration: BoxDecoration(
                    color: Color(0xFFEDEDED),
                    borderRadius: BorderRadius.circular(getSize(20)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      //SendProposal
                      getTitleAndDescription(
                        context,
                        title: 'Posted',
                        description: '\$20',
                      ),
                      SizedBox(height: getSize(20)),
                      getTitleAndDescription(
                        context,
                        title: 'Proposed',
                        description: '\$25',
                      ),
                      SizedBox(height: getSize(20)),
                      BaseText(
                        text: 'Counter Proposal',
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                      SizedBox(height: getSize(8)),
                      CustomTextField(
                        controller: _accommodationAllowanceController,
                        hintText: '\$ Counter Proposal',
                        keyboardType: TextInputType.number,
                        textInputAction: TextInputAction.done,
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: getSize(50),
                ),
                CommonButton(
                  onPressed: () {
                    AcceptRejectDialog(
                      title: 'Counter Propose',
                      description: 'Are you sure you want to send a counter proposal?',
                      onPressedAccept: () {},
                      onPressedReject: () {
                        context.router.maybePop();
                      },
                      acceptButtonText: 'Send',
                    ).acceptRejectDialog(context);
                  },
                  buttonText: 'Send Counter Proposal',
                ),
                SizedBox(
                  height: getSize(20),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  getTitleAndDescription(BuildContext context, {required String title, required String description}) {
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

  getDetailsView({
    required String mainTitle,
    required String skills,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        BaseText(
          text: mainTitle,
          textColor: AppColors.green.withOpacity(0.8),
          fontSize: 10,
          fontWeight: FontWeight.w600,
        ),
        SizedBox(height: getSize(5)),
        BaseText(
          text: skills,
          fontSize: 14,
          fontWeight: FontWeight.w500,
        ),
      ],
    );
  }

  Widget commuteAllownceField(BuildContext context, CounterProposalDetailState state) {
    return CustomTextField(
      labelText: StringConstant.commuteAllowance,
      isLabelPadding: true,
      isPrefixValueShow: true,
      errorMaxLines: 2,
      maxLength: 5,
      hintText: StringConstant.commuteAllowance,
      keyboardType: TextInputType.numberWithOptions(decimal: true, signed: true),
      inputFormatters: [
        FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}')),
      ],
      initialValue: (state.commuteRate.isValid()) ? state.commuteRate.getValue() : null,
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
      prefixIconConstraints: BoxConstraints(maxWidth: getSize(100), minHeight: 0),
      onChanged: (value) {
        context.read<CounterProposalDetailBloc>().add(CounterProposalDetailEvent.commuteRateChanged(value));
      },
    );
  }

  Widget accomdationAllownceField(BuildContext context, CounterProposalDetailState state) {
    return CustomTextField(
      labelText: StringConstant.accommodationAllowance,
      isLabelPadding: true,
      isPrefixValueShow: true,
      errorMaxLines: 2,
      maxLength: 5,
      hintText: StringConstant.accommodationAllowance,
      initialValue: (state.accomdationRate.isValid()) ? state.accomdationRate.getValue() : null,
      keyboardType: TextInputType.numberWithOptions(decimal: true, signed: true),
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
      prefixIconConstraints: BoxConstraints(maxWidth: getSize(100), minHeight: 0),
      onChanged: (value) {
        context.read<CounterProposalDetailBloc>().add(CounterProposalDetailEvent.accomdationRateChanged(value));
      },

    );
  }

  Widget commuteAllownceDropDown(BuildContext context, CounterProposalDetailState state) {
    return CustomDropdwonWithTextField(
      labelText: StringConstant.commuteAllowance,
      hintText: StringConstant.commuteAllowance,
      isLabelPadding: true,
      fieldMaxLength: 5,
      showTextfield: (state.selectedCommuteAllownce.getValue() == "Flat Rate"),
      showDropDown: (state.selectedCommuteAllownce.getValue() == "Hours"),
      childDroDwonHintText: StringConstant.selectHours,
      fieldInputFormatters: [
        FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}')),
      ],
      fieldKeyboardType: TextInputType.numberWithOptions(decimal: true),
      fieldHintText: "0.00",
      value: (state.selectedCommuteAllownce.isValid()) ? state.selectedCommuteAllownce.getValue() : null,
      childDropDownValue: (state.commuteHour.isValid()) ? state.commuteHour.getValue() : null,
      fieldInitialValue: (state.commuteRate.isValid()) ? state.commuteRate.getValue() : null,
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
      fieldPrefixIconConstraints: BoxConstraints(maxWidth: getSize(100), minHeight: 0),
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
        if (value != null) {
          context.read<CounterProposalDetailBloc>().add(CounterProposalDetailEvent.commuteAllownceChanged(value));
        }
      },
      fieldOnChanged: (value) {
        context.read<CounterProposalDetailBloc>().add(CounterProposalDetailEvent.commuteRateChanged(value));
      },
      childDropDownItems: state.accomdationHoursList.map((val) {
        return DropdownMenuItem<String>(
          value: val.name,
          child: BaseText(
            text: val.name ?? "",
            fontSize: 14,
            textColor: AppColors.black,
          ),
        );
      }).toList(),
      childDropDownOnChanged: (value) {
        if (value != null) {
          context.read<CounterProposalDetailBloc>().add(CounterProposalDetailEvent.commuteHoursChanged(value));
        }
      },
    );
  }

  Widget accommodationAllowanceDropDown(BuildContext context, CounterProposalDetailState state) {
    return CustomDropdwonWithTextField(
      labelText: StringConstant.accommodationAllowance,
      hintText: StringConstant.accommodationAllowance,
      isLabelPadding: true,
      fieldMaxLength: 5,
      showTextfield: (state.selectedAccomdationAllownce.getValue() == "Flat Rate"),
      showDropDown: (state.selectedAccomdationAllownce.getValue() == "Hours"),
      childDroDwonHintText: StringConstant.selectHours,
      fieldInputFormatters: [
        FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}')),
      ],
      value: (state.selectedAccomdationAllownce.isValid()) ? state.selectedAccomdationAllownce.getValue() : null,
      childDropDownValue: (state.accomdationHour.isValid()) ? state.accomdationHour.getValue() : null,
      fieldInitialValue: (state.accomdationRate.isValid()) ? state.accomdationRate.getValue() : null,
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
            textColor: AppColors.black.withOpacity(0.7),
          )),
      fieldPrefixIconConstraints: BoxConstraints(maxWidth: getSize(100), minHeight: 0),
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
        if (value != null) {
          context.read<CounterProposalDetailBloc>().add(CounterProposalDetailEvent.accomdationAllownceChanged(value));
        }
      },
      fieldOnChanged: (value) {
        context.read<CounterProposalDetailBloc>().add(CounterProposalDetailEvent.accomdationRateChanged(value));
      },
      childDropDownItems: state.accomdationHoursList.map((val) {
        return DropdownMenuItem<String>(
          value: val.name,
          child: BaseText(
            text: val.name ?? "",
            fontSize: 14,
            textColor: AppColors.black,
          ),
        );
      }).toList(),
      childDropDownOnChanged: (value) {
        if (value != null) {
          context.read<CounterProposalDetailBloc>().add(CounterProposalDetailEvent.accomdationHoursChanged(value));
        }
      },
    );
  }
}
