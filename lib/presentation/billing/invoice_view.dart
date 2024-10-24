import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:shift/presentation/billing/common_payment_history_tile.dart';
import 'package:shift/presentation/common/widgets/base_text.dart';
import 'package:shift/presentation/core/app_router.gr.dart';
import 'package:shift/presentation/core/style/app_colors.dart';
import 'package:shift/presentation/main/widgets/home_app_bar.dart';

@RoutePage(name: "InvoiceView")
class InvoiceView extends StatelessWidget {
  const InvoiceView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBar(
        onBackPressed: () => context.router.maybePop(),
        title: 'Invoices',
      ),
      body: ListView.separated(
        padding: EdgeInsets.all(18),
        itemBuilder: (context, index) => CommonPaymentHistoryTile(
          child: SizedBox(
            width: double.maxFinite,
            child: Material(
              clipBehavior: Clip.antiAliasWithSaveLayer,
              color: AppColors.green.withOpacity(0.15),
              borderRadius: BorderRadius.circular(7),
              child: InkWell(
                onTap: () {
                  context.router.push(PageRouteInfo(InvoiceDetailView.name));
                },
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 18, vertical: 8),
                  child: BaseText(
                    textAlign: TextAlign.center,
                    text: "View Invoice",
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ),
        ),
        separatorBuilder: (context, index) => Gap(16),
        itemCount: 3,
      ),
    );
  }
}
