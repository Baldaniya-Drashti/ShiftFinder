import 'dart:math';

import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:shift/application/contractor/full_time_position/full_time_position_bloc.dart';

import 'package:shift/injection.dart';
import 'package:shift/presentation/contractor/full_time_position/applied_position.dart';
import 'package:shift/presentation/contractor/full_time_position/open_position_view.dart';

import 'package:shift/presentation/core/widgets/underlined_tab_bar.dart';
import 'package:shift/presentation/main/widgets/home_app_bar.dart';

@RoutePage(name: "FullTimePositionView")
class FullTimePositionView extends StatelessWidget {
  const FullTimePositionView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<FullTimePositionBloc>(),
      child: Scaffold(
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
      ),
    );
  }
}
