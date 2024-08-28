import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:shift/domain/core/math_utils.dart';
import 'package:shift/infrastructure/main/employer_team/get_teams_dto.dart';
import 'package:shift/presentation/main/tabs/profile/teams/team_detail/widgets/team_member_list.dart';
import 'package:shift/presentation/main/tabs/profile/teams/widgets/common_team_container.dart';
import 'package:shift/presentation/main/widgets/home_app_bar.dart';

@RoutePage(name: 'TeamDetailView')
class TeamDetailView extends StatelessWidget {
  final GetTeamsListDTO getTeamsListDTO;
  const TeamDetailView({super.key, required this.getTeamsListDTO});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBar(
        onBackPressed: () => context.router.maybePop(),
        title: getTeamsListDTO.name ?? "",
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: getSize(20)),
            child: CommonTeamContainer(
              teamName: getTeamsListDTO.name ?? "",
              address: getTeamsListDTO.location?.location ?? "",
              totalMembers: getTeamsListDTO.total_member ?? 0,
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
