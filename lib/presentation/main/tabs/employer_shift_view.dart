import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shift/application/main_tab/shifts/shifts_bloc_bloc.dart';

import 'package:shift/presentation/main/tabs/shifts/approved_shifts/approve_shift_view.dart';
import 'package:shift/presentation/main/tabs/shifts/cancelled_shifts/cancelled_shift_view.dart';
import 'package:shift/presentation/main/tabs/shifts/filled_shifts/filled_shifts_view.dart';
import 'package:shift/presentation/main/tabs/shifts/widgets/tab_bar_view.dart';

@RoutePage(name: 'EmployerShiftView')
class EmployerShiftView extends StatefulWidget {
  const EmployerShiftView({super.key});

  @override
  State<EmployerShiftView> createState() => _EmployerShiftViewState();
}

class _EmployerShiftViewState extends State<EmployerShiftView> with SingleTickerProviderStateMixin {
  late TabController tabController;

  @override
  void initState() {
    tabController = TabController(length: 3, vsync: this);
    tabController.addListener(() {
      context.read<ShiftsBloc>().add(ShiftsBlocEvent.tabChange(tabController.index));
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TabBarViewWidget(tabController: tabController),
        Expanded(
          child: TabBarView(
            physics: BouncingScrollPhysics(),
            controller: tabController,
            children: [
              FilledShiftsView(),
              ApproveShiftView(),
              CancelledShiftView(),
            ],
          ),
        ),
      ],
    );
  }
}
