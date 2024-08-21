import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shift/application/contractor/contractor_full_time_position/contractor_full_time_position_bloc.dart';
import 'package:shift/domain/core/string_constant.dart';
import 'package:shift/injection.dart';
import 'package:shift/presentation/core/widgets/underlined_tab_bar.dart';
import 'package:shift/presentation/main/widgets/home_app_bar.dart';
import 'tabs/applied_position_view.dart';
import 'tabs/open_position_view.dart';

@RoutePage(name: "ContractorFullTimePositionView")
class ContractorFullTimePositionView extends StatelessWidget {
  const ContractorFullTimePositionView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<ContractorFullTimePositionBloc>()
        ..add(ContractorFullTimePositionEvent.changeTab(context, 0)),
      child: BlocBuilder<ContractorFullTimePositionBloc,
          ContractorFullTimePositionState>(
        builder: (context, state) {
          return Scaffold(
            appBar: CommonAppBar(
                onBackPressed: () => context.router.maybePop(),
                title: StringConstant.fullTimePositions),
            body: DefaultTabController(
              length: 2,
              initialIndex: state.selectedTab,
              child: Column(
                children: [
                  UnderlinedTabBar(
                    tabs: [
                      Tab(text: StringConstant.openPositions),
                      Tab(text: StringConstant.appliedPositions),
                    ],
                  ),
                  Expanded(
                    child: TabBarView(
                      children: [
                        ContractorFullTimeOpenPositionView(),
                        ContractorFullTimeAppliedPositionView(),
                      ],
                    ),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
