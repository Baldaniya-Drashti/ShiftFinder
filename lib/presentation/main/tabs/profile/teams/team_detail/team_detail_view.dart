import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:shift/presentation/main/widgets/home_app_bar.dart';

@RoutePage(name: 'TeamDetailView')
class TeamDetailView extends StatelessWidget {
  final String teamName;
  const TeamDetailView({super.key, required this.teamName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBar(
        onBackPressed: () => context.router.maybePop(),
        title: teamName,
      ),
      body: Column(
        children: [
          
        ],
      ),
    );
  }
}
