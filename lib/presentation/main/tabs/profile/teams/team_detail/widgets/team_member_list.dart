import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shift/application/main_tab/profile/profile_sections/teams/teams_bloc.dart';
import 'package:shift/domain/core/math_utils.dart';
import 'package:shift/infrastructure/main/employer_team/get_teams_dto.dart';
import 'package:shift/presentation/common/widgets/base_text.dart';
import 'package:shift/presentation/core/app_router.gr.dart';
import 'package:shift/presentation/core/style/app_colors.dart';
import 'package:shift/presentation/core/widgets/buttons/common_button.dart';

class TeamMemberList extends StatelessWidget {
  final List<Members> members;
  final String teamID;
  final Function()? onPressed;
  const TeamMemberList({
    super.key,
    required this.members,
    required this.teamID,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TeamsBloc, TeamsState>(
      builder: (context, state) {
        return Column(
          children: [
            Flexible(
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: members.length,
                padding: EdgeInsets.symmetric(horizontal: getSize(20)),
                physics: const BouncingScrollPhysics(),
                itemBuilder: (context, index) => GestureDetector(
                  onTap: () async {
                    var res = await context.router.push(
                      PageRouteInfo(
                        AddNewMemberView.name,
                        args: AddNewMemberViewArgs(
                          isUpdateMember: true,
                          getTeamsListDTO: members[index],
                          teamID: teamID,
                        ),
                      ),
                    );
                    if (res != null && res == true) {
                      context.read<TeamsBloc>().add(
                            TeamsEvent.getTeamList(
                              true,
                              state.teamDetail.id.toString(),
                            ),
                          );
                    }
                  },
                  child: Container(
                    padding: EdgeInsets.all(getSize(5)),
                    margin: EdgeInsets.symmetric(vertical: getSize(7.5)),
                    decoration: BoxDecoration(
                      color: AppColors.white,
                      borderRadius: BorderRadius.circular(
                        getSize(10),
                      ),
                    ),
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: getSize(12),
                        vertical: getSize(17),
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.scaffoldColor,
                        borderRadius: BorderRadius.circular(
                          getSize(10),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: BaseText(
                              text: members[index].name ?? "",
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          Icon(Icons.arrow_forward_ios_rounded)
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: getSize(20),
            ),
            CommonButton(
              height: 28,
              width: 200,
              onPressed: () async {
                var res = await context.router.push(
                  PageRouteInfo(
                    AddNewMemberView.name,
                    args: AddNewMemberViewArgs(
                      isUpdateMember: false,
                      getTeamsListDTO: null,
                      teamID: teamID,
                    ),
                  ),
                );
                if (res != null && res == true) {
                  context.read<TeamsBloc>().add(
                        TeamsEvent.getTeamList(
                          true,
                          state.teamDetail.id.toString(),
                        ),
                      );
                }
              },
              backgroundColor: AppColors.green.withOpacity(0.15),
              buttonText: '+ Add New Team Member',
              buttonTextColor: AppColors.green,
              buttonFontSize: 12,
              borderRadius: 7,
              buttonFontWeight: FontWeight.w600,
            ),
            SizedBox(
              height: getSize(30),
            ),
          ],
        );
      },
    );
  }
}
