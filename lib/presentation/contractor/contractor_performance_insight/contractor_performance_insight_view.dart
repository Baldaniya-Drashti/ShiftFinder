import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:shift/domain/core/svg_image_constants.dart';
import 'package:shift/presentation/auth/employer_auth/location_detail_form.dart';
import 'package:shift/presentation/common/widgets/base_text.dart';
import 'package:shift/presentation/core/style/app_colors.dart';
import 'package:shift/presentation/core/widgets/date_range_picker_tile.dart';
import 'package:shift/presentation/main/widgets/home_app_bar.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

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
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            DateRangePickerTile(
              onDateSelected: (value) {},
              label: "Period",
            ),
            Gap(20),
            Row(
              children: [
                Expanded(
                    child: BaseText(
                  text: "Month Index",
                  fontSize: 10,
                  fontWeight: FontWeight.w600,
                )),
                BaseText(text: "July 2024", fontSize: 10, fontWeight: FontWeight.w600, textColor: AppColors.green),
              ],
            ),
            Gap(12),
            Row(
              children: [
                Expanded(
                  child: _MonthlyIndexItem(label: "Total Earnings", value: "\$2541.25", icon: SvgImageConstant.dollorRound),
                ),
                Gap(12),
                Expanded(
                  child: _MonthlyIndexItem(label: "Hour Worked", value: "120h 36min", icon: SvgImageConstant.clock),
                ),
                Gap(12),
                Expanded(
                  child: _MonthlyIndexItem(label: "Completed Shifts", value: "16", icon: SvgImageConstant.dollorRound),
                ),
              ],
            ),
            SfCartesianChart()
          ],
        ),
      ),
    );
  }
}

class ChartData {
  ChartData({required this.x, required this.y});

  final String x;
  final num y;
}

class _MonthlyIndexItem extends StatelessWidget {
  const _MonthlyIndexItem({
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
              children: [
                SvgPicture.asset(
                  icon,
                  colorFilter: ColorFilter.mode(AppColors.green, BlendMode.srcIn),
                  height: 14,
                  width: 14,
                ),
                Gap(4),
                Flexible(child: BaseText(text: label, fontWeight: FontWeight.w500, fontSize: 10)),
              ],
            ),
            Gap(4),
            FittedBox(child: BaseText(text: value, fontSize: 12, fontWeight: FontWeight.w600))
          ],
        ),
      ),
    );
  }
}

class CommonLineGraph extends StatelessWidget {
  const CommonLineGraph({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
