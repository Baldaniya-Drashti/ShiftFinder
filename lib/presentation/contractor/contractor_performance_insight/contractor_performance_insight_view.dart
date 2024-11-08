import 'package:auto_route/auto_route.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:shift/presentation/auth/employer_auth/location_detail_form.dart';
import 'package:shift/presentation/common/widgets/base_text.dart';
import 'package:shift/presentation/core/style/app_colors.dart';
import 'package:shift/presentation/core/widgets/date_range_picker_tile.dart';
import 'package:shift/presentation/main/widgets/home_app_bar.dart';

@RoutePage(name: "ContractorPerformanceInsightView")
class ContractorPerformanceInsightView extends StatelessWidget {
  const ContractorPerformanceInsightView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBar(
        onBackPressed: () => context.router.maybePop(),
        title: "Performance Insights",
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            DateRangePickerTile(
              onDateSelected: (value) {},
              label: "Period",
            ),
          ],
        ),
      ),
    );
  }
}

class _MonthlyIndexItem extends StatelessWidget {
  const _MonthlyIndexItem({
    super.key,
    required this.label,
    required this.value,
    required this.icon,
  });

  final String label;
  final String value;
  final String icon;

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(10),
      color: AppColors.white,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [SvgPicture.asset(icon), Gap(4), BaseText(text: label, fontWeight: FontWeight.w500, fontSize: 10)],
            ),
            Gap(4),
            BaseText(text: value, fontSize: 12, fontWeight: FontWeight.w600)
          ],
        ),
      ),
    );
  }
}
