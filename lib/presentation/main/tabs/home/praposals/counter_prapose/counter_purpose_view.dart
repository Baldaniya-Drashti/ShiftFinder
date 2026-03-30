import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:shift/application/employer/counter_proposal_detail/counter_proposal_detail_bloc.dart';
import 'package:shift/domain/core/math_utils.dart';
import 'package:shift/domain/core/string_constant.dart';
import 'package:shift/infrastructure/core/employer_proposal_dto/employer_proposal_dto.dart';
import 'package:shift/injection.dart';
import 'package:shift/presentation/common/utils/date_time_format.dart';
import 'package:shift/presentation/common/widgets/base_text.dart';
import 'package:shift/presentation/common/widgets/center_loading_indicator.dart';
import 'package:shift/presentation/core/common_lisitng/common_listing.dart';
import 'package:shift/presentation/core/style/app_colors.dart';
import 'package:shift/presentation/core/widgets/buttons/common_button.dart';
import 'package:shift/presentation/core/widgets/inputs/custom_dropdown_with_textfield.dart';
import 'package:shift/presentation/core/widgets/inputs/custom_text_field.dart';
import 'package:shift/presentation/core/widgets/texts/common_texts.dart';
import 'package:shift/presentation/employer/profile/previous_shift_view/previous_shift_all_view.dart';
import 'package:shift/presentation/main/widgets/home_app_bar.dart';

@RoutePage(name: 'CounterPurposeView')
class CounterPurposeView extends StatelessWidget {
  const CounterPurposeView({super.key, required this.data});

  final EmployerProposalDto data;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<CounterProposalDetailBloc>()
        ..add(CounterProposalDetailEvent.getHoursList())
        ..add(CounterProposalDetailEvent.addProposalData(data: data)),
      child: Scaffold(
        appBar: CommonAppBar(
          onBackPressed: () {
            context.router.maybePop();
          },
          title: StringConstant.counterPropose,
        ),
        body:
            BlocBuilder<CounterProposalDetailBloc, CounterProposalDetailState>(
          builder: (context, state) {
            return (state.postDataLoading)
                ? CenterLoadingIndicator(isOnlyLoader: true)
                : GestureDetector(
                    onTap: () {
                      FocusScope.of(context).unfocus();
                    },
                    child: Form(
                      child: ListView(
                        shrinkWrap: true,
                        physics: BouncingScrollPhysics(),
                        padding: EdgeInsets.symmetric(horizontal: getSize(20)),
                        children: [
                          if (data.shift_type == 1) ...[
                            SizedBox(height: getSize(20)),
                            BaseText(
                              text: DateFormat("dd MMM, yyyy").format(
                                  CustomDateTimeFormat.timeStampToDateTime(
                                      (data.start_date ?? 0))),
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              textColor: AppColors.green,
                            ),
                            SizedBox(height: getSize(10)),
                            Container(
                              padding: EdgeInsets.all(getSize(20)),
                              decoration: BoxDecoration(
                                color: Color(0xFFEDEDED),
                                borderRadius:
                                    BorderRadius.circular(getSize(20)),
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
                                    context,
                                    title: StringConstant.agreedTime,
                                    description:
                                        '${formatUnixTimestamp(data.agreed_start_time ?? 0)} to ${formatUnixTimestamp(data.agreed_end_time ?? 0)}',
                                  ),
                                ],
                              ),
                            ),
                          ],
                          SizedBox(height: getSize(20)),
                          BaseText(
                            text: StringConstant.hourlyRate,
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
                            child: Builder(builder: (context) {
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  IntrinsicHeight(
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        getTitleAndDescription(
                                          context,
                                          title: StringConstant.posted,
                                          description:
                                              '\$${data.posted_hourly_rate ?? 0}',
                                        ),
                                        verticalDivider(),
                                        getTitleAndDescription(
                                          context,
                                          title: StringConstant.proposed,
                                          description:
                                              '\$${data.proposed_hourly_rate ?? 0}',
                                        ),
                                        verticalDivider(),
                                        rateHourField(context, state),
                                      ],
                                    ),
                                  ),
                                  if (state.showErrorMessages &&
                                      !state.rateHour.isValid())
                                    commonErrorText(
                                      (double.tryParse(state.rateHour
                                                      .getValue()) !=
                                                  null &&
                                              double.parse(state.rateHour
                                                      .getValue()) <=
                                                  0)
                                          ? StringConstant
                                              .pleaseEnterValidRateHour
                                          : StringConstant.pleaseEnterRateHour,
                                    ),
                                ],
                              );
                            }),
                          ),
                          if (data.commute_allowance_type != 0) ...[
                            SizedBox(height: getSize(20)),
                            BaseText(
                              text: StringConstant.commuteAllowance,
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                            SizedBox(height: getSize(10)),
                            Container(
                              padding: EdgeInsets.all(getSize(20)),
                              decoration: BoxDecoration(
                                color: Color(0xFFEDEDED),
                                borderRadius:
                                    BorderRadius.circular(getSize(20)),
                              ),
                              child: Builder(builder: (context) {
                                final hourly = data.commute_allowance_type == 2;
                                String postedDescription, proposedDescription;
                                if (hourly) {
                                  postedDescription =
                                      data.posted_commute_allowance_hour_name ??
                                          "";
                                  proposedDescription =
                                      data.proposed_commute_allowance_hour_name ??
                                          "";
                                } else {
                                  postedDescription =
                                      "\$${data.posted_commute_allowance_rate ?? ""}";
                                  proposedDescription =
                                      "\$${data.proposed_commute_allowance_rate ?? ""}";
                                }
                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    IntrinsicHeight(
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          getTitleAndDescription(
                                            context,
                                            title: StringConstant.posted,
                                            description: postedDescription,
                                          ),
                                          verticalDivider(),
                                          getTitleAndDescription(
                                            context,
                                            title: StringConstant.proposed,
                                            description: proposedDescription,
                                          ),
                                          verticalDivider(),
                                          if (data.commute_allowance_type ==
                                              2) ...[
                                            commuteAllownceDropDown(
                                                context, state),
                                          ] else ...[
                                            commuteAllownceField(
                                                context, state),
                                          ],
                                        ],
                                      ),
                                    ),
                                    if (data.commute_allowance_type == 2 &&
                                        state.showErrorMessages &&
                                        !state.commuteHour.isValid())
                                      commonErrorText(
                                        StringConstant
                                            .pleaseSelectCommuteAllownceValue,
                                      ),
                                    if (data.commute_allowance_type == 1 &&
                                        state.showErrorMessages &&
                                        !state.commuteRate.isValid())
                                      commonErrorText(
                                        (double.tryParse(state.commuteRate
                                                        .getValue()) !=
                                                    null &&
                                                double.parse(state.commuteRate
                                                        .getValue()) <=
                                                    0)
                                            ? StringConstant
                                                .flatRateShouldNotBeZero
                                            : StringConstant
                                                .pleaseSelectCommuteAllownceValue,
                                      ),
                                  ],
                                );
                              }),
                            ),
                          ],
                          if (data.accommodation_allowance_type != 0) ...[
                            SizedBox(height: getSize(20)),
                            BaseText(
                              text: StringConstant.accommodationAllowance,
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                            SizedBox(height: getSize(10)),
                            Container(
                              padding: EdgeInsets.all(getSize(20)),
                              decoration: BoxDecoration(
                                color: Color(0xFFEDEDED),
                                borderRadius:
                                    BorderRadius.circular(getSize(20)),
                              ),
                              child: Builder(builder: (context) {
                                final isCommuteAllowanceHourly =
                                    data.accommodation_allowance_type == 2;
                                String postedDescription, proposedDescription;

                                if (isCommuteAllowanceHourly) {
                                  postedDescription =
                                      data.posted_accommodation_allowance_hour_name ??
                                          "";
                                  proposedDescription =
                                      data.proposed_accommodation_allowance_hour_name ??
                                          "";
                                } else {
                                  postedDescription =
                                      "\$${data.posted_accommodation_allowance_rate ?? ""}";
                                  proposedDescription =
                                      "\$${data.proposed_accommodation_allowance_rate ?? ""}";
                                }
                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    IntrinsicHeight(
                                      child: Row(
                                        children: [
                                          getTitleAndDescription(
                                            context,
                                            title: StringConstant.posted,
                                            description: postedDescription,
                                          ),
                                          verticalDivider(),
                                          getTitleAndDescription(
                                            context,
                                            title: StringConstant.proposed,
                                            description: proposedDescription,
                                          ),
                                          verticalDivider(),
                                          if (data.accommodation_allowance_type ==
                                              2) ...[
                                            accomdationAllownceDropDown(
                                                context, state),
                                          ] else ...[
                                            accomdationAllownceField(
                                                context, state),
                                          ]
                                        ],
                                      ),
                                    ),
                                    if (data.accommodation_allowance_type ==
                                            2 &&
                                        state.showErrorMessages &&
                                        !state.accomdationHour.isValid())
                                      commonErrorText(
                                        (double.tryParse(state.accomdationRate
                                                        .getValue()) !=
                                                    null &&
                                                double.parse(state
                                                        .accomdationRate
                                                        .getValue()) <=
                                                    0)
                                            ? StringConstant
                                                .flatRateShouldNotBeZero
                                            : StringConstant
                                                .pleaseSelectAccomdationAllownceValue,
                                      ),
                                    if (data.accommodation_allowance_type ==
                                            1 &&
                                        state.showErrorMessages &&
                                        !state.accomdationRate.isValid())
                                      commonErrorText(
                                        StringConstant
                                            .pleaseSelectAccomdationAllownceValue,
                                      ),
                                  ],
                                );
                              }),
                            ),
                          ],
                          SizedBox(
                            height: getSize(50),
                          ),
                          CommonButton(
                            onPressed: () {
                              context.read<CounterProposalDetailBloc>().add(
                                    CounterProposalDetailEvent
                                        .sendCounterProposal(context: context),
                                  );
                            },
                            buttonText: StringConstant.sendCounterProposal,
                          ),
                          SizedBox(height: getSize(20)),
                        ],
                      ),
                    ),
                  );
          },
        ),
      ),
    );
  }

  getTitleAndDescription(BuildContext context,
      {required String title, required String description}) {
    return Flexible(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
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
              maxLines: 2,
            ),
          ),
        ],
      ),
    );
  }

  Widget verticalDivider() {
    return VerticalDivider(
      width: getSize(25),
      color: AppColors.black.withValues(alpha: 0.30),
      thickness: getSize(2),
      indent: getSize(10),
      endIndent: getSize(5),
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
          textColor: AppColors.green.withValues(alpha: 0.8),
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
    return Flexible(
      child: CustomTextField(
        isLabelPadding: false,
        isPrefixValueShow: true,
        labelText: 'Counter \nProposal',
        errorMaxLines: 2,
        maxLength: 5,
        initialValue:
            (state.rateHour.isValid()) ? state.rateHour.getValue() : null,
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
            textColor: (state.rateHour.isValid())
                ? AppColors.black
                : AppColors.black.withValues(alpha: 0.5),
          ),
        ),
        prefixIconConstraints:
            BoxConstraints(maxWidth: getSize(100), minHeight: 0),
        onChanged: (value) {
          context
              .read<CounterProposalDetailBloc>()
              .add(CounterProposalDetailEvent.rateHourChanged(value));
        },
        errorInputBorder: InputBorder.none,
        validator: (p0, p1) => context
            .read<CounterProposalDetailBloc>()
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
            ),
      ),
    );
  }

  Widget commuteAllownceField(
      BuildContext context, CounterProposalDetailState state) {
    return Flexible(
      child: CustomTextField(
        labelText: "Counter \nProposal",
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
        initialValue:
            (state.commuteRate.isValid()) ? state.commuteRate.getValue() : null,
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
              .read<CounterProposalDetailBloc>()
              .add(CounterProposalDetailEvent.commuteRateChanged(value));
        },
      ),
    );
  }

  Widget commuteAllownceDropDown(
      BuildContext context, CounterProposalDetailState state) {
    return Flexible(
      child: CustomDropdwonWithTextField(
        hintText: StringConstant.commuteAllowance,
        labelText: "Counter \nProposal",
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
        value:
            (state.commuteHour.isValid()) ? state.commuteHour.getValue() : null,
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
                .read<CounterProposalDetailBloc>()
                .add(CounterProposalDetailEvent.commuteHourChanged(value));
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

  Widget accomdationAllownceField(
      BuildContext context, CounterProposalDetailState state) {
    return Flexible(
      child: CustomTextField(
        isLabelPadding: true,
        labelText: "Counter \nProposal",
        isPrefixValueShow: true,
        errorMaxLines: 2,
        maxLength: 5,
        hintText: StringConstant.accommodationAllowance,
        initialValue: (state.accomdationRate.isValid())
            ? state.accomdationRate.getValue()
            : null,
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
              .read<CounterProposalDetailBloc>()
              .add(CounterProposalDetailEvent.accomdationRateChanged(value));
        },
      ),
    );
  }

  Widget accomdationAllownceDropDown(
      BuildContext context, CounterProposalDetailState state) {
    return Flexible(
      child: CustomDropdwonWithTextField(
        hintText: StringConstant.accommodationAllowance,
        labelText: "Counter \nProposal",
        isLabelPadding: true,
        showTextfield: false,
        showDropDown: false,
        value: (state.accomdationHour.isValid())
            ? state.accomdationHour.getValue()
            : null,
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
                .read<CounterProposalDetailBloc>()
                .add(CounterProposalDetailEvent.accomdationHourChanged(value));
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
}
