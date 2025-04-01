import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:shift/application/employer/payment_history/payment_history_bloc.dart';
import 'package:shift/domain/core/math_utils.dart';
import 'package:shift/domain/core/string_constant.dart';
import 'package:shift/domain/core/svg_image_constants.dart';
import 'package:shift/infrastructure/core/payment_history_dto/payment_history_dto.dart';
import 'package:shift/injection.dart';
import 'package:shift/presentation/billing/common_payment_history_tile.dart';
import 'package:shift/presentation/common/widgets/base_text.dart';
import 'package:shift/presentation/common/widgets/center_loading_indicator.dart';
import 'package:shift/presentation/common/widgets/paginated_list_view.dart';
import 'package:shift/presentation/core/style/app_colors.dart';
import 'package:shift/presentation/main/widgets/home_app_bar.dart';

@RoutePage(name: "PaymentHistoryView")
class PaymentHistoryView extends StatelessWidget {
  const PaymentHistoryView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<PaymentHistoryBloc>()
        ..add(PaymentHistoryEvent.getPaymentHistoryEvent(true, context)),
      child: BlocBuilder<PaymentHistoryBloc, PaymentHistoryState>(
        builder: (context, state) {
          return Scaffold(
            appBar: CommonAppBar(
              onBackPressed: () => context.router.maybePop(),
              title: StringConstant.paymentHistory,
            ),
            body: Padding(
              padding: EdgeInsets.symmetric(horizontal: getSize(5)),
              child: state.isLoading
                  ? CenterLoadingIndicator(isOnlyLoader: true)
                  : state.isErrorInApi
                      ? Center(
                          child:
                              BaseText(text: StringConstant.somethindWentWrong))
                      : PaginatedListView(
                          onRefresh: () => context
                              .read<PaymentHistoryBloc>()
                              .add(PaymentHistoryEvent.getPaymentHistoryEvent(
                                  true, context)),
                          onLoading: () => context
                              .read<PaymentHistoryBloc>()
                              .add(PaymentHistoryEvent.getPaymentHistoryEvent(
                                  false, context)),
                          refreshController: context
                              .read<PaymentHistoryBloc>()
                              .refreshController,
                          isNoDataFound: state.noDataFound,
                          child: ListView.separated(
                            padding:
                                EdgeInsets.symmetric(horizontal: getSize(10)),
                            itemBuilder: (context, index) =>
                                CommonPaymentHistoryTile(
                              shift: state.historyList[index],
                              child: _PaymentHistoryExpandableTile(
                                shift: state.historyList[index],
                              ),
                            ),
                            separatorBuilder: (context, index) =>
                                Gap(getSize(15)),
                            itemCount: state.historyList.length,
                          ),
                        ),
            ),
          );
        },
      ),
    );
  }
}

class _PaymentHistoryExpandableTile extends StatelessWidget {
  final PaymentHistoryDTO shift;

  const _PaymentHistoryExpandableTile({required this.shift});

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      dense: true,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      collapsedShape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      collapsedBackgroundColor: AppColors.scaffoldColor,
      backgroundColor: AppColors.scaffoldColor,
      visualDensity: VisualDensity.compact,
      childrenPadding: EdgeInsets.all(getSize(15)).copyWith(top: 0),
      tilePadding: EdgeInsets.symmetric(horizontal: getSize(15)),
      clipBehavior: Clip.none,

      // trailing: SvgPicture.asset(SvgImageConstant.downArrow),
      title: _buildPaymentDetailTitle(context,
          title: StringConstant.totalAmountPayable,
          amount: shift.total_amount_payble ?? ""),
      children: [
        Stack(
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _buildPaymentDetailTitle(context,
                    title: StringConstant.totalWage,
                    amount: shift.total_wage ?? ""),
                Gap(10),
                _buildPaymentDetailTitle(context,
                    title: StringConstant.totalAllowance,
                    amount: shift.total_allowance ?? ""),
              ],
            ),
            Positioned(
              right: 0,
              bottom: 0,
              child: SizedBox.square(
                dimension: getSize(65),
                child: SvgPicture.asset(
                  SvgImageConstant.billingAccount,
                  colorFilter: ColorFilter.mode(
                      AppColors.green.withValues(alpha: 0.15), BlendMode.srcIn),
                ),
              ),
            )
          ],
        )
      ],
    );
  }

  Widget _buildPaymentDetailTitle(
    BuildContext context, {
    required String title,
    required String amount,
  }) {
    final Widget content = Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        SvgPicture.asset(SvgImageConstant.dollorRound, height: 18, width: 18),
        Gap(getSize(8)),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            BaseText(
              text: title,
              fontSize: 10,
              fontWeight: FontWeight.w500,
            ),
            BaseText(
              text: amount,
              fontSize: 12,
              fontWeight: FontWeight.w500,
              textColor: AppColors.green,
            ),
          ],
        ),
      ],
    );
    return content;
  }
}
