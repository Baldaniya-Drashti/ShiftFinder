import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:shift/application/contractor/contractor_statement/contractor_statement_bloc.dart';
import 'package:shift/domain/core/string_constant.dart';
import 'package:shift/domain/core/svg_image_constants.dart';
import 'package:shift/injection.dart';
import 'package:shift/presentation/billing/invoice_detail_view.dart';
import 'package:shift/presentation/billing/transaction_info.dart';
import 'package:shift/presentation/common/widgets/base_text.dart';
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
      create: (context) => getIt<ContractorStatementBloc>(),
      child: Scaffold(
        appBar: CommonAppBar(
          onBackPressed: () => context.router.maybePop(),
          title: "Statements",
        ),
        body: ListView(
          padding: EdgeInsets.all(12),
          children: [
            Builder(
              builder: (context) {
                final currentFilter = context.select<ContractorStatementBloc, StatementFilterModel>(
                  (value) => value.state.currentStatementFilter,
                );
                return CustomDropdownField<StatementFilterModel>(
                  label: StringConstant.filter,
                  value: currentFilter,
                  items: [
                    StatementFilterModel(id: 1, label: "Shifts Earnings"),
                    StatementFilterModel(id: 2, label: "Compensations"),
                    StatementFilterModel(id: 3, label: "Referrals Bonus"),
                    StatementFilterModel(id: 4, label: "Bank"),
                  ]
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
                    context.read<ContractorStatementBloc>().add(ContractorStatementEvent.onFilterChanged(value: value));
                  },
                );
              },
            ),
            Gap(16),
            BlocSelector<ContractorStatementBloc, ContractorStatementState, List<DateTime>>(
              selector: (state) => state.selectedDates,
              builder: (context, selectedDates) {
                return DateRangePickerTile(
                  selectedDate: selectedDates,
                  onDateSelected: (value) {
                    context.read<ContractorStatementBloc>().add(ContractorStatementEvent.onSelectDateRange(value: value));
                  },
                  label: StringConstant.period,
                );
              },
            ),
            Gap(16),
            _BaseStatementTile()
          ],
        ),
      ),
    );
  }
}

class _BaseStatementTile extends StatelessWidget {
  const _BaseStatementTile();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(child: BaseText(text: "ShiftFinder", fontSize: 12, fontWeight: FontWeight.w400)),
              Material(
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
                        colorFilter: ColorFilter.mode(AppColors.green, BlendMode.srcIn),
                      ),
                      Gap(8),
                      BaseText(
                        textAlign: TextAlign.center,
                        text: "Download",
                        fontSize: 10,
                        fontWeight: FontWeight.w600,
                        textColor: AppColors.green,
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
          BaseText(text: "Total Earning Statement", fontWeight: FontWeight.w400, fontSize: 10),
          Gap(12),
          BaseText(text: "Contractor Name", fontSize: 12),
          Gap(6),
          Row(
            children: [
              BaseText(text: "Statement Period", fontSize: 10),
              Gap(3),
              BaseText(
                text: "2 Apr 2024 to  2 May 2024",
                fontSize: 10,
                fontWeight: FontWeight.w600,
              ),
            ],
          ),
          Gap(6),
          Divider(),
          Gap(12),
          BlocBuilder<ContractorStatementBloc, ContractorStatementState>(
            builder: (context, state) {
              return switch (state.currentStatementFilter.id) {
                1 => _Earning(),
                2 => _Compensation(),
                3 => _ReferralBonus(),
                4 => _Bank(),
                _ => _Earning(),
              };
            },
          )
        ],
      ),
    );
  }
}

class _Earning extends StatelessWidget {
  const _Earning();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        StatementHeadingTitle(
          title: "Completed Shifts Earning",
          color: AppColors.green.withOpacity(0.15),
        ),
        Gap(8),
        ListView.separated(
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemBuilder: (context, index) {
            return Column(
              children: [
                TransactionInfo(label: "Date", value: "12 May 2024"),
                TransactionInfo(label: "Company Name", value: "Louis Vuitton Pvt. Ltd."),
                TransactionInfo(label: "Location", value: "6391 Elgin St. Celina, Delaware"),
                TransactionInfo(label: "Hours Worked", value: "9 h 30 min"),
                TransactionInfo(label: "Hourly Rate", value: "\$30.00"),
                TransactionInfo(label: "Wages", value: "\$30.00"),
                TransactionInfo(label: "Allowances", value: "\$30.00"),
                TransactionInfo(label: "Earnings", value: "\$335.00", valueColor: AppColors.green),
              ],
            );
          },
          separatorBuilder: (context, index) => Divider(),
          itemCount: 3,
        ),
        Gap(12),
        Material(
          borderRadius: BorderRadius.circular(10),
          color: AppColors.green.withOpacity(0.2),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Expanded(
                  child: BaseText(
                    text: "Net Earnings",
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                BaseText(
                  text: "\$170.00",
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
  const _Compensation();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        StatementHeadingTitle(
          title: "Compensation Received From Cancellations ",
          color: AppColors.green.withOpacity(0.15),
        ),
        Gap(8),
        ListView.separated(
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemBuilder: (context, index) {
            return Column(
              children: [
                TransactionInfo(label: "Date", value: "12 May 2024"),
                TransactionInfo(label: "Company Name", value: "Louis Vuitton Pvt. Ltd."),
                TransactionInfo(label: "Location", value: "6391 Elgin St. Celina, Delaware"),
                TransactionInfo(label: "Compensation Fee:", value: "\$120.00", valueColor: AppColors.green),
              ],
            );
          },
          separatorBuilder: (context, index) => Divider(),
          itemCount: 3,
        ),
        Gap(12),
        Material(
          borderRadius: BorderRadius.circular(10),
          color: AppColors.green.withOpacity(0.2),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Expanded(
                  child: BaseText(
                    text: "Total Cancellation Fee",
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                BaseText(
                  text: "\$200.00",
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
  const _ReferralBonus();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        StatementHeadingTitle(
          title: "Compensation Received From Cancellations ",
          color: AppColors.green.withOpacity(0.15),
        ),
        Gap(8),
        ListView.separated(
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemBuilder: (context, index) {
            return Column(
              children: [
                TransactionInfo(label: "Date", value: "12 May 2024"),
                TransactionInfo(label: "Referred Contractor Name", value: "David Malpas"),
                TransactionInfo(
                  label: "Bonus Amount",
                  value: "\$50.00",
                  valueColor: AppColors.green,
                ),
              ],
            );
          },
          separatorBuilder: (context, index) => Divider(),
          itemCount: 3,
        ),
        Gap(12),
        Material(
          borderRadius: BorderRadius.circular(10),
          color: AppColors.green.withOpacity(0.2),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Expanded(
                  child: BaseText(
                    text: "Total Bonus",
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                BaseText(
                  text: "\$170.00",
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
  const _Bank();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        StatementHeadingTitle(
          title: "Compensation Received From Cancellations ",
          color: AppColors.green.withOpacity(0.15),
        ),
        Gap(8),
        ListView.separated(
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemBuilder: (context, index) {
            return Column(
              children: [
                TransactionInfo(label: "Date", value: "12 May 2024"),
                TransactionInfo(label: "Deposit Amount", value: "\$150.00"),
              ],
            );
          },
          separatorBuilder: (context, index) => Divider(),
          itemCount: 3,
        ),
        Gap(12),
        Material(
          borderRadius: BorderRadius.circular(10),
          color: AppColors.green.withOpacity(0.2),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Expanded(
                  child: BaseText(
                    text: "Total Cancellation Fee",
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                BaseText(
                  text: "\$200.00",
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
      identical(this, other) || other is StatementFilterModel && runtimeType == other.runtimeType && id == other.id && label == other.label;

  @override
  int get hashCode => id.hashCode ^ label.hashCode;

  const StatementFilterModel({
    required this.id,
    required this.label,
  });
}
