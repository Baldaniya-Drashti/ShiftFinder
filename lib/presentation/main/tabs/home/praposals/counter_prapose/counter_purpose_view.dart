import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shift/application/employer/counter_proposal_detail/counter_proposal_detail_bloc.dart';
import 'package:shift/domain/core/math_utils.dart';
import 'package:shift/domain/core/string_constant.dart';
import 'package:shift/infrastructure/core/employer_proposal_dto/employer_proposal_dto.dart';
import 'package:shift/infrastructure/core/proposal_detail_dto/proposal_detail_dto.dart';
import 'package:shift/injection.dart';
import 'package:shift/presentation/common/widgets/base_text.dart';
import 'package:shift/presentation/common/widgets/center_loading_indicator.dart';
import 'package:shift/presentation/core/common_lisitng/common_listing.dart';
import 'package:shift/presentation/core/logger/logger.dart';
import 'package:shift/presentation/core/style/app_colors.dart';
import 'package:shift/presentation/core/widgets/buttons/common_button.dart';
import 'package:shift/presentation/core/widgets/inputs/custom_dropdown_with_textfield.dart';
import 'package:shift/presentation/core/widgets/inputs/custom_text_field.dart';
import 'package:shift/presentation/core/widgets/texts/common_texts.dart';
import 'package:shift/presentation/main/tabs/home/praposals/widgets/person_praposal_view.dart';
import 'package:shift/presentation/main/tabs/home/view_single_applicants/widgets/accept_reject_dialog.dart';
import 'package:shift/presentation/main/widgets/home_app_bar.dart';

@RoutePage(name: 'CounterPurposeView')
class CounterPurposeView extends StatefulWidget {
  const CounterPurposeView({super.key, required this.data});

  final EmployerProposalDto data;

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
      create: (context) => getIt<CounterProposalDetailBloc>()
        ..add(CounterProposalDetailEvent.addProposalData(data: widget.data))
        ..add(CounterProposalDetailEvent.getHoursList()),
      child: Scaffold(
        appBar: CommonAppBar(
          onBackPressed: () {
            context.router.maybePop();
          },
          title: 'Counter Propose',
        ),
        body: BlocBuilder<CounterProposalDetailBloc, CounterProposalDetailState>(
          builder: (context, state) {
            return Stack(
              children: [
                GestureDetector(
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
                              rateHourField(context, state),
                              if (state.showErrorMessages && !state.rateHour.isValid())
                                commonErrorText(
                                  (double.tryParse(state.rateHour.getValue()) != null && double.parse(state.rateHour.getValue()) <= 0)
                                      ? StringConstant.pleaseEnterValidRateHour
                                      : StringConstant.pleaseEnterRateHour,
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
                              if (widget.data.commute_allowance_type == 2) ...[
                                commuteAllownceDropDown(context, state),
                                if (state.showErrorMessages && !state.commuteHour.isValid())
                                  commonErrorText(
                                    StringConstant.pleaseSelectCommuteAllownceValue,
                                  ),
                              ] else ...[
                                commuteAllownceField(context, state),
                                if (state.showErrorMessages && !state.commuteRate.isValid())
                                  commonErrorText(
                                    (double.tryParse(state.commuteRate.getValue()) != null &&
                                            double.parse(state.commuteRate.getValue()) <= 0)
                                        ? StringConstant.flatRateShouldNotBeZero
                                        : StringConstant.pleaseSelectCommuteAllownceValue,
                                  ),
                              ]
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

                              if (widget.data.accommodation_allowance_type == 2) ...[
                                accomdationAllownceDropDown(context, state),
                                if (state.showErrorMessages && !state.accomdationHour.isValid())
                                  commonErrorText(
                                    (double.tryParse(state.accomdationRate.getValue()) != null &&
                                            double.parse(state.accomdationRate.getValue()) <= 0)
                                        ? StringConstant.flatRateShouldNotBeZero
                                        : StringConstant.pleaseSelectAccomdationAllownceValue,
                                  ),
                              ] else ...[
                                accomdationAllownceField(context, state),
                                if (state.showErrorMessages && !state.accomdationRate.isValid())
                                  commonErrorText(
                                    StringConstant.pleaseSelectAccomdationAllownceValue,
                                  ),
                              ]
                            ],
                          ),
                        ),
                        SizedBox(
                          height: getSize(50),
                        ),
                        CommonButton(
                          onPressed: () {
                            context.read<CounterProposalDetailBloc>().add(
                                  CounterProposalDetailEvent.sendCounterProposal(context: context),
                                );
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
                if (state.postDataLoading) CenterLoadingIndicator(),
              ],
            );
          },
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

  Widget rateHourField(BuildContext context, CounterProposalDetailState state) {
    return CustomTextField(
      isLabelPadding: true,
      isPrefixValueShow: true,
      errorMaxLines: 2,
      maxLength: 5,
      initialValue: (state.rateHour.isValid()) ? state.rateHour.getValue() : null,
      hintText: StringConstant.rateHour,
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
          textColor: (state.rateHour.isValid()) ? AppColors.black : AppColors.black.withOpacity(0.5),
        ),
      ),
      prefixIconConstraints: BoxConstraints(maxWidth: getSize(100), minHeight: 0),
      onChanged: (value) {
        context.read<CounterProposalDetailBloc>().add(CounterProposalDetailEvent.rateHourChanged(value));
      },
      errorInputBorder: InputBorder.none,
      validator: (p0, p1) => context.read<CounterProposalDetailBloc>().state.rateHour.value.fold(
            (f) => f.maybeMap(
              empty: (value) => StringConstant.pleaseEnterRateHour,
              invalidRate: (value) => StringConstant.pleaseEnterValidRateHour,
              orElse: () => null,
            ),
            (_) => null,
          ),
    );
  }

  Widget commuteAllownceField(BuildContext context, CounterProposalDetailState state) {
    return CustomTextField(
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

  Widget commuteAllownceDropDown(BuildContext context, CounterProposalDetailState state) {
    return CustomDropdwonWithTextField(
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
      value: (state.commuteHour.isValid()) ? state.commuteHour.getValue() : null,
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
      fieldPrefixIconConstraints: BoxConstraints(maxWidth: getSize(100), minHeight: 0),
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
          context.read<CounterProposalDetailBloc>().add(CounterProposalDetailEvent.commuteHourChanged(value));
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
    );
  }

  Widget accomdationAllownceField(BuildContext context, CounterProposalDetailState state) {
    return CustomTextField(
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

  Widget accomdationAllownceDropDown(BuildContext context, CounterProposalDetailState state) {
    return CustomDropdwonWithTextField(
      hintText: StringConstant.accommodationAllowance,
      isLabelPadding: true,
      showTextfield: false,
      showDropDown: false,
      value: (state.accomdationHour.isValid()) ? state.accomdationHour.getValue() : null,
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
      fieldPrefixIconConstraints: BoxConstraints(maxWidth: getSize(100), minHeight: 0),
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
          context.read<CounterProposalDetailBloc>().add(CounterProposalDetailEvent.accomdationHourChanged(value));
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
    );
  }
}
