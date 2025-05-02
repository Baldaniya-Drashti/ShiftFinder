import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:shift/application/employer/monthly_statement/monthly_statement_bloc.dart';
import 'package:shift/domain/core/math_utils.dart';
import 'package:shift/domain/core/png_image_constants.dart';
import 'package:shift/domain/core/string_constant.dart';
import 'package:shift/domain/core/svg_image_constants.dart';
import 'package:shift/infrastructure/core/monthly_statement_dto/monthly_statement_dto.dart';
import 'package:shift/injection.dart';
import 'package:shift/presentation/billing/transaction_info.dart';
import 'package:shift/presentation/common/utils/date_time_format.dart';
import 'package:shift/presentation/common/widgets/base_text.dart';
import 'package:shift/presentation/common/widgets/center_loading_indicator.dart';
import 'package:shift/presentation/common/widgets/no_data_ui.dart';
import 'package:shift/presentation/core/common_lisitng/common_listing.dart';
import 'package:shift/presentation/core/style/app_colors.dart';
import 'package:shift/presentation/core/widgets/buttons/common_button.dart';
import 'package:shift/presentation/core/widgets/date_range_picker_tile.dart';
import 'package:shift/presentation/core/widgets/tile.dart';
import 'package:shift/presentation/main/widgets/home_app_bar.dart';

@RoutePage(name: "MonthlyStatementView")
class MonthlyStatementView extends StatelessWidget {
  const MonthlyStatementView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<MonthlyStatementBloc>()
        ..add(MonthlyStatementEvent.getMonthlyStatementListEvent(true)),
      child: BlocBuilder<MonthlyStatementBloc, MonthlyStatementState>(
        builder: (context, state) {
          return Scaffold(
            appBar: CommonAppBar(
              onBackPressed: () => context.router.maybePop(),
              title: StringConstant.monthlyStatement,
            ),
            body: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                BlocSelector<MonthlyStatementBloc, MonthlyStatementState,
                    List<DateTime>>(
                  selector: (state) => state.selectedDateTime,
                  builder: (context, selectedDateTime) {
                    return DateRangePickerTile(
                      label: StringConstant.period,
                      selectedDate: selectedDateTime,
                      onDateSelected: (value) {
                        context.read<MonthlyStatementBloc>().add(
                            MonthlyStatementEvent.onDateSelected(dates: value));
                      },
                    );
                  },
                ),
                Expanded(
                  child: (state.isLoading)
                      ? CenterLoadingIndicator(isOnlyLoader: true)
                      : (state.statement.list == null)
                          ? NoDataText(
                              title: '',
                              description: StringConstant
                                  .pleaseSelectDateToViewMonthlyStatement)
                          : SingleChildScrollView(
                              padding: EdgeInsets.all(getSize(18)),
                              child: BaseTileDecoration(
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    companyDetail(context,
                                        statement: state.statement),
                                    Padding(
                                      padding: EdgeInsets.symmetric(
                                          vertical: getSize(10)),
                                      child: Divider(),
                                    ),
                                    if (state.statement.list != null &&
                                        state.statement.list!.isNotEmpty) ...[
                                      Material(
                                        color: AppColors.green
                                            .withValues(alpha: 0.2),
                                        borderRadius: BorderRadius.circular(7),
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 14, vertical: 10),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              BaseText(
                                                  text: StringConstant
                                                      .statementDetails,
                                                  fontSize: 10,
                                                  fontWeight: FontWeight.w500),
                                              Flexible(
                                                child: BaseText(
                                                  text: getFormattedString(
                                                      state.selectedDateTime),
                                                  fontSize: 10,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      Gap(getSize(8)),
                                      _StatementListView(
                                        statement: state.statement,
                                      ),
                                    ] else
                                      BaseText(
                                        text: StringConstant.noResultFound,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 14,
                                      ),
                                  ],
                                ),
                              ),
                            ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget companyDetail(BuildContext context,
      {required MonthlyStatementDTO statement}) {
    final industry = CommonList.industryList.firstWhere((element) {
      if (statement.industry_id != null) {
        return element.id == statement.industry_id;
      }
      return element.id == 1;
    });

    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox.square(
          dimension: getSize(60),
          child: Image.asset(PngImageConstants.splash_logo),
        ),
        Gap(getSize(8)),
        Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    BaseText(
                      text: statement.company_name ?? "",
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    BaseText(
                        text: industry.title ?? "",
                        fontSize: 10,
                        fontWeight: FontWeight.w400),
                  ],
                ),
              ),
              if (statement.list != null && statement.list!.isNotEmpty) ...[
                downLoadInvoiceBtn(
                  onTap: () {
                    context.read<MonthlyStatementBloc>().add(
                            MonthlyStatementEvent.downloadMonthlyStatementEvent(
                          context,
                          statement: statement,
                        ));
                  },
                ),
              ],
            ],
          ),
        ),
      ],
    );
  }

  Widget downLoadInvoiceBtn({required void Function() onTap}) {
    return CommonButton(
      buttonText: "",
      onPressed: onTap,
      borderRadius: 5,
      width: 76,
      height: 20,
      backgroundColor: AppColors.primaryColor.withValues(alpha: 0.20),
      buttonTextColor: AppColors.primaryColor,
      customWidget: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          SvgPicture.asset(
            SvgImageConstant.download,
            width: getSize(10),
            height: getSize(10),
          ),
          SizedBox(width: getSize(5)),
          BaseText(
            textAlign: TextAlign.center,
            text: StringConstant.download,
            fontSize: 8,
            fontWeight: FontWeight.w500,
            textColor: AppColors.green,
          ),
        ],
      ),
    );
  }
}

class _StatementListView extends StatelessWidget {
  final MonthlyStatementDTO statement;
  const _StatementListView({required this.statement});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListView.separated(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          separatorBuilder: (context, index) => Divider(),
          itemCount: statement.list!.length,
          itemBuilder: (context, index) =>
              _StatementDetailTile(statement.list![index]),
        ),
        Gap(getSize(12)),
        Material(
          borderRadius: BorderRadius.circular(10),
          color: AppColors.scaffoldColor,
          child: Padding(
            padding: EdgeInsets.all(getSize(12)),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                MonthlyStatementInfo(
                    label: StringConstant.totalWage,
                    value: "\$${statement.total_wage ?? ""}"),
                MonthlyStatementInfo(
                    label: StringConstant.totalShiftFinderServiceFee,
                    value: "\$${statement.total_service_fee ?? ""}"),
                MonthlyStatementInfo(
                    label: StringConstant.totalShiftCancellationFee,
                    value: "\$${statement.total_cancellation_fee ?? ""}"),
                Divider(),
                MonthlyStatementInfo(
                    label: StringConstant.netAmount,
                    value: "\$${statement.net_amount ?? ""}",
                    valueColor: AppColors.green),
              ],
            ),
          ),
        )
      ],
    );
  }
}

class _StatementDetailTile extends StatelessWidget {
  final MonthlyStatementDetailDTO list;
  const _StatementDetailTile(this.list);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        TransactionInfo(
            label: StringConstant.dateOfTransaction,
            value: (list.date_of_transaction != null)
                ? DateFormat('dd MMM yyyy').format(
                    CustomDateTimeFormat.timeStampToDateTime(
                        list.date_of_transaction!))
                : ""),
        TransactionInfo(
            label: StringConstant.contractorName,
            value:
                "${list.contractor_first_name ?? ""} ${list.contractor_last_name ?? ""}"),
        if (list.type == 2)
          TransactionInfo(
            label: StringConstant.shiftCancellationFee,
            value: "\$${list.shiftfinder_service_fee}",
            valueColor: AppColors.redAccent,
          )
        else ...[
          TransactionInfo(
              label: StringConstant.shiftFinderServiceFee,
              value: "\$${list.shiftfinder_service_fee}"),
          TransactionInfo(
              label: StringConstant.wage,
              value: "\$${list.total_wage}",
              valueColor: AppColors.green),
        ],
      ],
    );
  }
}
