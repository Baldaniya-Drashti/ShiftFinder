import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:shift/application/employer/monthly_statement/monthly_statement_bloc.dart';
import 'package:shift/domain/core/png_image_constants.dart';
import 'package:shift/domain/core/svg_image_constants.dart';
import 'package:shift/injection.dart';
import 'package:shift/presentation/billing/transaction_info.dart';
import 'package:shift/presentation/common/widgets/base_text.dart';
import 'package:shift/presentation/core/style/app_colors.dart';
import 'package:shift/presentation/core/widgets/date_range_picker_tile.dart';
import 'package:shift/presentation/core/widgets/dialogs/app_dialog.dart';
import 'package:shift/presentation/core/widgets/tile.dart';
import 'package:shift/presentation/main/widgets/home_app_bar.dart';

@RoutePage(name: "MonthlyStatementView")
class MonthlyStatementView extends StatelessWidget {
  const MonthlyStatementView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<MonthlyStatementBloc>(),
      child: Builder(builder: (context) {
        return Scaffold(
          appBar: CommonAppBar(
            onBackPressed: () => context.router.maybePop(),
            title: 'Monthly Statements',
          ),
          body: SingleChildScrollView(
            padding: const EdgeInsets.all(18.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                BlocSelector<MonthlyStatementBloc, MonthlyStatementState, List<DateTime>>(
                  selector: (state) => state.selectedDateTime,
                  builder: (context, selectedDateTime) {
                    return DateRangePickerTile(
                      label: "Period",
                      selectedDate: selectedDateTime,
                      onDateSelected: (value) {
                        context.read<MonthlyStatementBloc>().add(MonthlyStatementEvent.onDateSelected(dates: value));
                      },
                    );
                  },
                ),
                Gap(16),
                BlocBuilder<MonthlyStatementBloc, MonthlyStatementState>(
                  builder: (context, state) {
                    return BaseTileDecoration(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox.square(
                                dimension: 60,
                                child: Image.asset(PngImageConstants.leafWithBG),
                              ),
                              Gap(8),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Expanded(
                                          child: BaseText(text: "Louis Vuitton Pvt. Ltd.", fontWeight: FontWeight.w600, fontSize: 16),
                                        ),
                                      ],
                                    ),
                                    BaseText(text: "(Healthcare - 2DFG175)", fontSize: 12, fontWeight: FontWeight.w400),
                                    Row(
                                      children: [
                                        SvgPicture.asset(
                                          SvgImageConstant.location,
                                          colorFilter: ColorFilter.mode(AppColors.green, BlendMode.srcIn),
                                          height: 24,
                                          width: 24,
                                        ),
                                        Expanded(
                                          child: BaseText(
                                            text: "4517 Washington Manchester, Kentucky 39495",
                                            fontSize: 10,
                                            fontWeight: FontWeight.w500,
                                            maxLines: 1,
                                          ),
                                        )
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                          Gap(8),
                          Divider(),
                          Gap(12),
                          Material(
                            color: AppColors.green.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(7),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  BaseText(text: "Statement Details", fontSize: 10, fontWeight: FontWeight.w500),
                                  Flexible(
                                    child: BaseText(
                                      text: getFormattedString(state.selectedDateTime),
                                      fontSize: 10,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Gap(8),
                          _StatementListView()
                        ],
                      ),
                    );
                  },
                )
              ],
            ),
          ),
        );
      }),
    );
  }
}

class _StatementListView extends StatelessWidget {
  const _StatementListView();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListView.separated(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) => _StatementDetailTile(),
          separatorBuilder: (context, index) => Divider(),
          itemCount: 3,
        ),
        Gap(12),
        Material(
          borderRadius: BorderRadius.circular(10),
          color: AppColors.scaffoldColor,
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                MonthlyStatementInfo(label: "Total Wage", value: "\$1350.00"),
                MonthlyStatementInfo(label: "Total ShiftFinder Service Fee", value: "\$1350.00"),
                MonthlyStatementInfo(label: "Total Shift Cancellation Fee", value: "\$1350.00"),
                Divider(),
                MonthlyStatementInfo(label: "Net Amount", value: "\$1350.00", valueColor: AppColors.green),
              ],
            ),
          ),
        )
      ],
    );
  }
}

class _StatementDetailTile extends StatelessWidget {
  const _StatementDetailTile();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        TransactionInfo(label: "Date of Transaction", value: "12 July 2024"),
        TransactionInfo(label: "Contractor Name", value: "Karen Adderiy"),
        TransactionInfo(label: "ShiftFinder Service Fee", value: "\$50"),
        TransactionInfo(label: "Wage", value: "\$300", valueColor: AppColors.green),
      ],
    );
  }
}

