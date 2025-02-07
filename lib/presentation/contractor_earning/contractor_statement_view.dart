import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:shift/application/contractor/contractor_statement/contractor_statement_bloc.dart';
import 'package:shift/domain/core/math_utils.dart';
import 'package:shift/domain/core/string_constant.dart';
import 'package:shift/domain/core/svg_image_constants.dart';
import 'package:shift/infrastructure/contractor_main/earning/statement_dto/statement_dto.dart';
import 'package:shift/injection.dart';
import 'package:shift/presentation/billing/contractor_statement_viewer.dart';
import 'package:shift/presentation/billing/invoice_detail_view.dart';
import 'package:shift/presentation/billing/transaction_info.dart';
import 'package:shift/presentation/common/utils/flushbar_creator.dart';
import 'package:shift/presentation/common/utils/get_cookie.dart';
import 'package:shift/presentation/common/utils/save_file_to_storage.dart';
import 'package:shift/presentation/common/widgets/base_text.dart';
import 'package:shift/presentation/common/widgets/center_loading_indicator.dart';
import 'package:shift/presentation/common/widgets/no_data_ui.dart';
import 'package:shift/presentation/core/common_lisitng/common_listing.dart';
import 'package:shift/presentation/core/style/app_colors.dart';
import 'package:shift/presentation/core/widgets/date_range_picker_tile.dart';
import 'package:shift/presentation/core/widgets/drop_down_field.dart';
import 'package:shift/presentation/main/widgets/home_app_bar.dart';

@RoutePage(name: "ContractorStatementView")
class ContractorStatementView extends StatelessWidget {
  const ContractorStatementView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<ContractorStatementBloc>()
        ..add(ContractorStatementEvent.getStatement(context)),
      child: BlocBuilder<ContractorStatementBloc, ContractorStatementState>(
        builder: (context, state) {
          return Scaffold(
            appBar: CommonAppBar(
              onBackPressed: () => context.router.maybePop(),
              title: StringConstant.statements,
            ),
            body: Padding(
              padding: EdgeInsets.all(getSize(12)),
              child: Column(
                children: [
                  Builder(
                    builder: (context) {
                      final currentFilter = context.select<
                          ContractorStatementBloc, StatementFilterModel>(
                        (value) => value.state.currentStatementFilter,
                      );
                      return CustomDropdownField<StatementFilterModel>(
                        label: StringConstant.filter,
                        value: currentFilter,
                        items: CommonList.statementList
                            .map(
                              (e) => DropdownMenuItem<StatementFilterModel>(
                                value: e,
                                child: BaseText(
                                  text: e.label,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            )
                            .toList(),
                        onChanged: (value) {
                          context.read<ContractorStatementBloc>().add(
                              ContractorStatementEvent.onFilterChanged(context,
                                  value: value));
                        },
                      );
                    },
                  ),
                  Gap(getSize(16)),
                  BlocSelector<ContractorStatementBloc,
                      ContractorStatementState, List<DateTime>>(
                    selector: (state) => state.selectedDates,
                    builder: (context, selectedDates) {
                      return DateRangePickerTile(
                        selectedDate: selectedDates,
                        onDateSelected: (value) {
                          context.read<ContractorStatementBloc>().add(
                              ContractorStatementEvent.onSelectDateRange(
                                  context,
                                  value: value));
                        },
                        label: StringConstant.period,
                      );
                    },
                  ),
                  Gap(getSize(16)),
                  Expanded(
                    child: (state.isLoading)
                        ? CenterLoadingIndicator(isOnlyLoader: true)
                        : (state.statement == null)
                            ? NoDataText(
                                title: '',
                                description:
                                    'Please select date to view ${state.currentStatementFilter.label}',
                              )
                            : SingleChildScrollView(
                                child: BaseStatementTile(
                                  statementPeriod: state.selectedDates,
                                  statement: state.statement ?? StatementDTO(),
                                  currentStatement:
                                      state.currentStatementFilter,
                                ),
                              ),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class BaseStatementTile extends StatelessWidget {
  final List<DateTime> statementPeriod;
  final StatementDTO statement;
  final StatementFilterModel currentStatement;

  const BaseStatementTile(
      {super.key,
      required this.statementPeriod,
      required this.statement,
      required this.currentStatement});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(getSize(16)),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(20)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                  child: BaseText(
                      text: StringConstant.shiftFinder,
                      fontSize: 12,
                      fontWeight: FontWeight.w400)),
              GestureDetector(
                onTap: () async {
                  final pdfData = await GenerateContractorStatement()
                      .completeEarningStatement(
                    selectedDates: statementPeriod,
                    statement: statement,
                    currentStatement: currentStatement,
                  );

                  String? pdfPath =
                      await SaveFileToStorage.savePdfToShiftFinderDirectory(
                          pdfData,
                          fileName: '${currentStatement.label}.pdf');

                  if (pdfPath != null) {
                    print('PDF saved to: $pdfPath');
                    showSuccess(
                            message:
                                "${currentStatement.label} Statement Downloaded..!")
                        .show(context);
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(
                    //     builder: (context) => PdfViewerScreen(pdfPath: pdfPath),
                    //   ),
                    // );
                  } else {
                    showError(message: "Failed to download PDF!").show(context);
                  }
                },
                child: Material(
                  borderRadius: BorderRadius.circular(5),
                  color: AppColors.green.withOpacity(0.15),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        SvgPicture.asset(
                          SvgImageConstant.download,
                          height: 16,
                          width: 16,
                          colorFilter: ColorFilter.mode(
                              AppColors.green, BlendMode.srcIn),
                        ),
                        Gap(getSize(8)),
                        BaseText(
                          textAlign: TextAlign.center,
                          text: StringConstant.download,
                          fontSize: 10,
                          fontWeight: FontWeight.w600,
                          textColor: AppColors.green,
                        ),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
          BaseText(
              text: StringConstant.totalEarningStatement,
              fontWeight: FontWeight.w400,
              fontSize: 10),
          Gap(getSize(12)),
          BaseText(
            text:
                "${getCurrentUser().firstName ?? ""} ${getCurrentUser().lastName ?? ""}",
            fontSize: 12,
            fontWeight: FontWeight.w600,
          ),
          Gap(getSize(6)),
          Row(
            children: [
              BaseText(text: StringConstant.statementPeriod, fontSize: 10),
              Gap(3),
              BaseText(
                text: getFormattedString(statementPeriod),
                fontSize: 10,
                fontWeight: FontWeight.w600,
              ),
            ],
          ),
          Gap(getSize(6)),
          Divider(),
          Gap(getSize(12)),
          BlocBuilder<ContractorStatementBloc, ContractorStatementState>(
            builder: (context, state) {
              return switch (state.currentStatementFilter.id) {
                1 => _Earning(statement: state.statement ?? StatementDTO()),
                2 =>
                  _Compensation(statement: state.statement ?? StatementDTO()),
                3 =>
                  _ReferralBonus(statement: state.statement ?? StatementDTO()),
                4 => _Bank(statement: state.statement ?? StatementDTO()),
                _ => _Earning(statement: state.statement ?? StatementDTO()),
              };
            },
          )
        ],
      ),
    );
  }
}

class _Earning extends StatelessWidget {
  final StatementDTO statement;
  const _Earning({required this.statement});

  @override
  Widget build(BuildContext context) {
    final completedShift = statement.list ?? [];

    return Column(
      children: [
        StatementHeadingTitle(
          title: StringConstant.completedShiftsEarning,
          color: AppColors.green.withOpacity(0.15),
        ),
        Gap(8),
        ListView.separated(
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: completedShift.length,
          separatorBuilder: (context, index) => Divider(),
          itemBuilder: (context, index) {
            final earning = completedShift[index];
            return Column(
              children: [
                TransactionInfo(
                    label: StringConstant.date,
                    value: DateFormat('dd MMM yyyy').format(
                        DateTime.fromMillisecondsSinceEpoch(
                            earning.date! * 1000))),
                TransactionInfo(
                    label: StringConstant.companyName,
                    value: earning.company_name ?? ""),
                TransactionInfo(
                    label: StringConstant.location,
                    value: earning.location?.location ?? ""),
                TransactionInfo(
                    label: StringConstant.hoursWorked,
                    value: earning.hours_worked ?? ""),
                TransactionInfo(
                    label: StringConstant.hourlyRate,
                    value: "\$${earning.hourly_rate ?? 0.0}"),
                TransactionInfo(
                    label: StringConstant.wages,
                    value: "\$${earning.total_wage ?? 0.0}"),
                TransactionInfo(
                    label: StringConstant.allowances,
                    value: "\$${earning.total_allowance ?? 0.0}"),
                TransactionInfo(
                    label: StringConstant.earnings,
                    value: "\$${earning.total_earnings ?? 0.0}",
                    valueColor: AppColors.green),
              ],
            );
          },
        ),
        Gap(getSize(12)),
        Material(
          borderRadius: BorderRadius.circular(10),
          color: AppColors.green.withOpacity(0.2),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Expanded(
                  child: BaseText(
                    text: StringConstant.netEarnings,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                BaseText(
                  text:
                      "\$${statement.additional_data?.completed_total_earnings ?? 0.0}",
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}

class _Compensation extends StatelessWidget {
  final StatementDTO statement;
  const _Compensation({required this.statement});

  @override
  Widget build(BuildContext context) {
    final completedShift = statement.list ?? [];

    return Column(
      children: [
        StatementHeadingTitle(
          title: StringConstant.compensationReceivedFromCancellations,
          color: AppColors.green.withOpacity(0.15),
        ),
        Gap(getSize(8)),
        ListView.separated(
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          separatorBuilder: (context, index) => Divider(),
          itemCount: completedShift.length,
          itemBuilder: (context, index) {
            final earning = completedShift[index];
            return Column(
              children: [
                TransactionInfo(
                    label: StringConstant.date,
                    value: DateFormat('dd MMM yyyy').format(
                        DateTime.fromMillisecondsSinceEpoch(
                            earning.date! * 1000))),
                TransactionInfo(
                    label: StringConstant.companyName,
                    value: earning.company_name ?? ""),
                TransactionInfo(
                    label: StringConstant.location,
                    value: earning.location?.location ?? ""),
                TransactionInfo(
                    label: StringConstant.compensationFee,
                    value: "\$${earning.amount ?? 0.0}",
                    valueColor: AppColors.green),
              ],
            );
          },
        ),
        Gap(getSize(12)),
        Material(
          borderRadius: BorderRadius.circular(10),
          color: AppColors.green.withOpacity(0.2),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Expanded(
                  child: BaseText(
                    text: StringConstant.totalCancellationFee,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                BaseText(
                  text:
                      "\$${statement.additional_data?.total_cancellation_fee ?? 0.0}",
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}

class _ReferralBonus extends StatelessWidget {
  final StatementDTO statement;
  const _ReferralBonus({required this.statement});

  @override
  Widget build(BuildContext context) {
    final completedShift = statement.list ?? [];

    return Column(
      children: [
        StatementHeadingTitle(
          title: StringConstant.compensationReceivedFromCancellations,
          color: AppColors.green.withOpacity(0.15),
        ),
        Gap(getSize(8)),
        ListView.separated(
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          separatorBuilder: (context, index) => Divider(),
          itemCount: completedShift.length,
          itemBuilder: (context, index) {
            final earning = completedShift[index];
            return Column(
              children: [
                TransactionInfo(
                    label: StringConstant.date,
                    value: DateFormat('dd MMM yyyy').format(
                        DateTime.fromMillisecondsSinceEpoch(
                            earning.date! * 1000))),
                TransactionInfo(
                    label: StringConstant.referredContractorName,
                    value: earning.referred_contractor_name ?? ""),
                TransactionInfo(
                    label: StringConstant.bonusAmount,
                    value: "\$${earning.amount ?? 0.0}",
                    valueColor: AppColors.green),
              ],
            );
          },
        ),
        Gap(getSize(3)),
        Material(
          borderRadius: BorderRadius.circular(10),
          color: AppColors.green.withOpacity(0.2),
          child: Padding(
            padding: EdgeInsets.all(getSize(16)),
            child: Row(
              children: [
                Expanded(
                  child: BaseText(
                    text: StringConstant.totalBonus,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                BaseText(
                  text: "\$${statement.additional_data?.total_bonus ?? 0.0}",
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}

class _Bank extends StatelessWidget {
  final StatementDTO statement;
  const _Bank({required this.statement});

  @override
  Widget build(BuildContext context) {
    final completedShift = statement.list ?? [];

    return Column(
      children: [
        StatementHeadingTitle(
          title: StringConstant.compensationReceivedFromCancellations,
          color: AppColors.green.withOpacity(0.15),
        ),
        Gap(getSize(8)),
        ListView.separated(
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          separatorBuilder: (context, index) => Divider(),
          itemCount: completedShift.length,
          itemBuilder: (context, index) {
            final earning = completedShift[index];

            return Column(
              children: [
                TransactionInfo(
                    label: StringConstant.date,
                    value: DateFormat('dd MMM yyyy').format(
                        DateTime.fromMillisecondsSinceEpoch(
                            earning.date! * 1000))),
                TransactionInfo(
                  label: StringConstant.depositAmount,
                  value: "\$${earning.amount ?? 0.0}",
                  valueColor: AppColors.primaryColor,
                ),
              ],
            );
          },
        ),
        Gap(getSize(12)),
        Material(
          borderRadius: BorderRadius.circular(10),
          color: AppColors.green.withOpacity(0.2),
          child: Padding(
            padding: EdgeInsets.all(getSize(16)),
            child: Row(
              children: [
                Expanded(
                  child: BaseText(
                    text: StringConstant.totalAmount,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                BaseText(
                  text: "\$${statement.additional_data?.total_withdraw ?? 0.0}",
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}

class StatementFilterModel {
  final int id;
  final String label;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is StatementFilterModel &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          label == other.label;

  @override
  int get hashCode => id.hashCode ^ label.hashCode;

  const StatementFilterModel({
    required this.id,
    required this.label,
  });
}
