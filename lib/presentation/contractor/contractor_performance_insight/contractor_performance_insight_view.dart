import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:shift/presentation/auth/employer_auth/location_detail_form.dart';
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
      body: Column(
        children: [
          DateRangePickerTile(
            onDateSelected: (value) {},
            label: "Period",
          ),
          SizedBox(
            height: 30,
            child: WeeklyHoursChart(),
          )
        ],
      ),
    );
  }
}

class WeeklyHoursChart extends StatelessWidget {
  final List<double> weeklyHours = [18, 26, 14, 32]; // Sample hours data

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Hours Worked',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 16),
          BarChart(
            BarChartData(
              alignment: BarChartAlignment.spaceAround,
              maxY: 40,
              barGroups: weeklyHours.asMap().entries.map((entry) {
                final weekIndex = entry.key;
                final hours = entry.value;
                return BarChartGroupData(
                  x: weekIndex,
                  barRods: [
                    BarChartRodData(
                      toY: hours,
                      color: Colors.green,
                      width: 18,
                      borderRadius: BorderRadius.circular(8),
                      backDrawRodData: BackgroundBarChartRodData(
                        show: true,
                        toY: 40,
                        color: Colors.green.shade100,
                      ),
                    ),
                  ],
                  showingTooltipIndicators: [0],
                );
              }).toList(),
              titlesData: FlTitlesData(
                leftTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    reservedSize: 40,
                    getTitlesWidget: (value, meta) {
                      return Text(
                        '${value.toInt()} h',
                        style: TextStyle(color: Colors.grey),
                      );
                    },
                  ),
                ),
                bottomTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    getTitlesWidget: (value, meta) {
                      return Text(
                        'Week ${value.toInt() + 1}',
                        style: TextStyle(color: Colors.grey),
                      );
                    },
                  ),
                ),
              ),
              gridData: FlGridData(show: false),
              borderData: FlBorderData(show: false),
              barTouchData: BarTouchData(
                enabled: true,
                touchTooltipData: BarTouchTooltipData(
                  tooltipPadding: EdgeInsets.zero,
                  getTooltipItem: (group, groupIndex, rod, rodIndex) {
                    return BarTooltipItem(
                      '${rod.toY.toInt()} h',
                      TextStyle(color: Colors.grey.shade800, fontWeight: FontWeight.bold),
                    );
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
