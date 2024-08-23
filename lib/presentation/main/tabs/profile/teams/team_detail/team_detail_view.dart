import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:shift/domain/core/math_utils.dart';
import 'package:shift/presentation/main/tabs/profile/teams/team_detail/widgets/team_member_list.dart';
import 'package:shift/presentation/main/tabs/profile/teams/widgets/common_team_container.dart';
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
          Padding(
            padding: EdgeInsets.symmetric(horizontal: getSize(20)),
            child: CommonTeamContainer(
              teamName: teamName,
              address: '2464 Royal Ln. Mesa, New...',
              totalMembers: 5,
              isFromTeamDetail: true,
            ),
          ),
          SizedBox(
            height: getSize(30),
          ),
          Expanded(
            child: TeamMemberList(),
          ),
          // NoTeamMemberView(),
        ],
      ),
    );
  }
}
