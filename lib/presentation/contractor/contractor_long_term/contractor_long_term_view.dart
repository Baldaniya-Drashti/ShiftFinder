import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shift/application/contractor/contractor_long_time/contractor_long_term_bloc.dart';
import 'package:shift/injection.dart';
import 'package:shift/presentation/contractor/contractor_long_term/tabs/applied_position_view.dart';
import 'package:shift/presentation/contractor/contractor_long_term/tabs/open_position_view.dart';
import 'package:shift/presentation/contractor/contractor_long_term/tabs/upcoming_position_view.dart';
import 'package:shift/presentation/core/widgets/underlined_tab_bar.dart';
import 'package:shift/presentation/main/widgets/home_app_bar.dart';

@RoutePage(name: "ContractorLongTermView")
class ContractorLongTermView extends StatelessWidget {
  const ContractorLongTermView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBar(
          onBackPressed: () => context.router.maybePop(),
          title: "Long Term Positions"),
      body: BlocProvider(
        create: (context) => getIt<ContractorLongTermBloc>()
          ..add(
            ContractorLongTermEvent.fetchOpenPositionList(refresh: true),
          )
          ..add(
              ContractorLongTermEvent.fetchUpcomingPositionList(refresh: true))
          ..add(
            ContractorLongTermEvent.fetchAppliedPositionList(refresh: true),
          ),
        child: DefaultTabController(
          length: 3,
          child: Column(
            children: [
              UnderlinedTabBar(
                tabs: [
                  Tab(text: "Open Positions"),
                  Tab(text: "Upcoming Positions"),
                  Tab(text: "Applied Positions"),
                ],
              ),
              Expanded(
                child: TabBarView(
                  children: [
                    ContractorLongTermOpenPosition(),
                    ContractorUpcomingPositionView(),
                    ContractorLongTermAppliedPosition(),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
