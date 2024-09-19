import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:shift/presentation/main/tabs/shifts/widgets/approve_shift_view.dart';
import 'package:shift/presentation/main/tabs/shifts/widgets/cancelled_shift_view.dart';
import 'package:shift/presentation/main/tabs/shifts/widgets/filled_shifts_view.dart';

@RoutePage(name: 'HistoryView')
class HistoryView extends StatelessWidget {
  const HistoryView({super.key});

  @override
  Widget build(BuildContext context) {
    return TabBarView(
      physics: BouncingScrollPhysics(),
      children: [
        FilledShiftsView(),
        ApproveShiftView(),
        CancelledShiftView(),
      ],
    );
  }
}
