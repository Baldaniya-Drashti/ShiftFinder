import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:shift/presentation/core/widgets/underlined_tab_bar.dart';
import 'package:shift/presentation/main/widgets/home_app_bar.dart';

import 'tabs/applied_position_view.dart';
import 'tabs/open_position_view.dart';

@RoutePage(name: "ContractorFullTimePositionView")
class ContractorFullTimePositionView extends StatelessWidget {
  const ContractorFullTimePositionView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBar(onBackPressed: () => context.router.maybePop(), title: "Full Time Positions"),
      body: DefaultTabController(
        length: 2,
        child: Column(
          children: [
            UnderlinedTabBar(
              tabs: [
                Tab(text: "Open Positions"),
                Tab(text: "Applied Positions"),
              ],
            ),
            Expanded(
              child: TabBarView(
                children: [
                  OpenPositionView(),
                  AppliedPositionView(),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
