import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:shift/presentation/main/widgets/home_app_bar.dart';

@RoutePage(name: "ContractorStatementView")
class ContractorStatementView extends StatelessWidget {
  const ContractorStatementView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBar(
        onBackPressed: () => context.router.maybePop(),
        title: "Statements",
      ),
    );
  }
}
