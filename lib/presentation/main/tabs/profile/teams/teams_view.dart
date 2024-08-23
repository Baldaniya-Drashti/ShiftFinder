import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:shift/domain/core/math_utils.dart';
import 'package:shift/presentation/core/app_router.gr.dart';
import 'package:shift/presentation/core/style/app_colors.dart';
import 'package:shift/presentation/core/widgets/buttons/common_button.dart';
import 'package:shift/presentation/main/tabs/profile/teams/widgets/common_team_container.dart';
import 'package:shift/presentation/main/widgets/home_app_bar.dart';

@RoutePage(name: 'TeamsView')
class TeamsView extends StatelessWidget {
  const TeamsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBar(
        onBackPressed: () => context.router.maybePop(),
        title: 'Teams',
      ),
      body: SafeArea(
        bottom: isFullScreenDevice(context) ? true : false,
        child: Column(
          children: [
            Flexible(
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: 10,
                physics: const BouncingScrollPhysics(),
                padding: EdgeInsets.symmetric(horizontal: getSize(20)),
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                    onTap: () {
                      context.router.push(
                        PageRouteInfo(
                          TeamDetailView.name,
                          args: TeamDetailViewArgs(teamName: 'Team $index'),
                        ),
                      );
                    },
                    child: CommonTeamContainer(
                      teamName: 'Team $index',
                      address: '2464 Royal Ln. Mesa, New...',
                      totalMembers: index,
                    ),
                  );
                },
              ),
            ),
            SizedBox(
              height: getSize(20),
            ),
            CommonButton(
              height: 28,
              width: 135,
              onPressed: () {
                context.router.push(
                  PageRouteInfo(
                    AddNewTeamView.name,
                  ),
                );
              },
              backgroundColor: AppColors.green.withOpacity(0.15),
              buttonText: '+ Add New Team',
              buttonTextColor: AppColors.green,
              buttonFontSize: 12,
              borderRadius: 7,
              buttonFontWeight: FontWeight.w600,
            ),
            SizedBox(
              height: getSize(isFullScreenDevice(context) ? 0 : 20),
            ),
          ],
        ),
      ),
    );
  }
}
