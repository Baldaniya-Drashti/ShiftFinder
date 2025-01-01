import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:shift/domain/core/string_constant.dart';
import 'package:shift/presentation/core/widgets/filled_tab_bar.dart';
import 'package:shift/presentation/employer/employer_long_term/tabs/filled_position_tab_view.dart';
import 'package:shift/presentation/employer/employer_long_term/tabs/open_position_tab_view.dart';
import 'package:shift/presentation/main/widgets/home_app_bar.dart';

@RoutePage(name: "EmployerLongTermView")
class EmployerLongTermView extends StatelessWidget {
  const EmployerLongTermView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBar(onBackPressed: context.maybePop, title: StringConstant.longTermPositions),
      body: DefaultTabController(
        length: 3,
        child: Column(
          children: [
            FilledTabBar(tabs: [
              Tab(text: "Open Positions"),
              Tab(text: "Filled Positions"),
            ]),
            Expanded(
              child: TabBarView(
                children: [
                  OpenPositionTabView(),
                  FilledPositionTabView()
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
