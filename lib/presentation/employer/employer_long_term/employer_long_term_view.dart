import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shift/application/employer/employer_long_term/employer_long_term_bloc.dart';
import 'package:shift/domain/core/math_utils.dart';
import 'package:shift/domain/core/string_constant.dart';
import 'package:shift/injection.dart';
import 'package:shift/presentation/common/utils/get_cookie.dart';
import 'package:shift/presentation/common/widgets/center_loading_indicator.dart';
import 'package:shift/presentation/core/app_router.gr.dart';
import 'package:shift/presentation/core/widgets/buttons/common_button.dart';
import 'package:shift/presentation/core/widgets/filled_tab_bar.dart';
import 'package:shift/presentation/employer/employer_long_term/tabs/filled_position_tab_view.dart';
import 'package:shift/presentation/employer/employer_long_term/tabs/open_position_tab_view.dart';
import 'package:shift/presentation/main/widgets/home_app_bar.dart';

@RoutePage(name: "EmployerLongTermView")
class EmployerLongTermView extends StatelessWidget {
  const EmployerLongTermView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<EmployerLongTermBloc>()
        ..add(EmployerLongTermEvent.changeTab(context, 0)),
      // ..add(EmployerLongTermEvent.getEmployerLongTermOpenPosition(
      //     context: context, refresh: true))
      // ..add(EmployerLongTermEvent.getEmployerFilledPosition(
      //     context: context, refresh: true)),
      child: BlocBuilder<EmployerLongTermBloc, EmployerLongTermState>(
        builder: (context, state) {
          return Scaffold(
            appBar: CommonAppBar(
                onBackPressed: context.maybePop,
                title: StringConstant.longTermPositions),
            bottomNavigationBar: Padding(
              padding: EdgeInsets.all(getSize(16)),
              child: CommonButton(
                onPressed: () {
                  context.router
                      .push(PageRouteInfo(EmployerLongTermPositionAddView.name))
                      .then((value) {
                    final bloc = context.read<EmployerLongTermBloc>();
                    bloc.add(
                        EmployerLongTermEvent.getEmployerLongTermOpenPosition(
                            context: context, refresh: true));
                    bloc.add(EmployerLongTermEvent.getEmployerFilledPosition(
                        context: context, refresh: true));
                  });
                },
                buttonText: StringConstant.postALongTermPosition,
              ),
            ),
            body: (state.isLoading)
                ? CenterLoadingIndicator(isOnlyLoader: true)
                : DefaultTabController(
                    length: 2,
                    initialIndex: state.selectedTab,
                    child: Column(
                      children: [
                        Padding(
                          padding:
                              EdgeInsets.symmetric(horizontal: getSize(28)),
                          child: FilledTabBar(
                            onTap: (value) {
                              setNotificationTab(null);
                              context.read<EmployerLongTermBloc>().add(
                                  EmployerLongTermEvent.changeTab(
                                      context, value));
                            },
                            tabs: [
                              Tab(text: StringConstant.openPositions),
                              Tab(text: StringConstant.filledPositions),
                            ],
                          ),
                        ),
                        Expanded(
                          child: TabBarView(
                            children: [
                              OpenPositionTabView(),
                              FilledPositionTabView(),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
          );
        },
      ),
    );
  }
}
