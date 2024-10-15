import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:shift/domain/core/math_utils.dart';
import 'package:shift/presentation/main/tabs/home/praposals/widgets/main_praposal_view.dart';
import 'package:shift/presentation/main/tabs/home/praposals/widgets/person_list_widget.dart';
import 'package:shift/presentation/main/widgets/home_app_bar.dart';

@RoutePage(name: 'TotalPraposalView')
class TotalPraposalView extends StatelessWidget {
  const TotalPraposalView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBar(
        onBackPressed: () {
          context.router.maybePop();
        },
        title: 'View Proposals',
      ),
      body: ListView(
        shrinkWrap: true,
        physics: BouncingScrollPhysics(),
        children: [
          SizedBox(height: getSize(20)),
          MainPraposalView(),
          PersonListWidget(),
        ],
      ),
    );
  }
}
