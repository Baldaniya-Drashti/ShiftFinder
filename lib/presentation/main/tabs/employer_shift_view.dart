import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shift/application/main_tab/shifts/shifts_bloc_bloc.dart';
import 'package:shift/injection.dart';

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

class _EmployerShiftViewState extends State<EmployerShiftView>
    with SingleTickerProviderStateMixin {
  late TabController tabController;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<ShiftsBloc>()
        ..add(ShiftsBlocEvent.getLocationListAPI())
        ..add(ShiftsBlocEvent.fetchFilledShiftList(refresh: true))
        ..add(ShiftsBlocEvent.fetchApprovedShiftList(refresh: true))
        ..add(ShiftsBlocEvent.fetchCancelledShiftList(refresh: true)),
      child: BlocBuilder<ShiftsBloc, ShiftsBlocState>(
        builder: (context, state) {
          return DefaultTabController(
            length: 3,
            initialIndex: state.selectedTab,
            child: Column(
              children: [
                TabBarViewWidget(),
                Expanded(
                  child: (state.selectedTab == 0)
                      ? FilledShiftsView()
                      : (state.selectedTab == 1)
                          ? ApproveShiftView()
                          : CancelledShiftView(),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
