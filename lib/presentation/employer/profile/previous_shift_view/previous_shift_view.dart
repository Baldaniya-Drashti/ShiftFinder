import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shift/application/employer/profile/previous_shift/previous_shift_bloc.dart';
import 'package:shift/injection.dart';
import 'package:shift/presentation/core/widgets/underlined_tab_bar.dart';
import 'package:shift/presentation/employer/profile/previous_shift_view/previous_shift_all_view.dart';
import 'package:shift/presentation/employer/profile/previous_shift_view/previous_shift_blocked_view.dart';
import 'package:shift/presentation/employer/profile/previous_shift_view/previous_shift_fav_view.dart';
import 'package:shift/presentation/employer/profile/previous_shift_view/previous_shift_remarked_view.dart';
import 'package:shift/presentation/main/widgets/home_app_bar.dart';

@RoutePage(name: 'PreviousShiftView')
class PreviousShiftView extends StatelessWidget {
  const PreviousShiftView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<PreviousShiftBloc>()..add(PreviousShiftEvent.fetchAllPreviousPost(refresh: true)),
      child: Scaffold(
        appBar: CommonAppBar(
          onBackPressed: () => Navigator.pop(context),
          title: "All ShiftPros",
        ),
        body: DefaultTabController(
          length: 4,
          child: Column(
            children: [
              UnderlinedTabBar(
                tabs: [Tab(text: "All"), Tab(text: "Favorites"), Tab(text: "Blocked"), Tab(text: "Remarked")],
                onTap: (value) {
                  context.read<PreviousShiftBloc>().add(
                        PreviousShiftEvent.tabChangeEvent(tabIndex: value),
                      );
                },
              ),
              Expanded(
                child: TabBarView(
                  children: [
                    PreviousShiftAllView(),
                    PreviousShiftFavView(),
                    PreviousShiftBlockedView(),
                    PreviousShiftRemarkedView(),
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
