import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shift/application/main_tab/profile/profile_sections/teams/teams_bloc.dart';
import 'package:shift/domain/core/math_utils.dart';
import 'package:shift/infrastructure/main/employer_team/get_teams_dto.dart';
import 'package:shift/injection.dart';
import 'package:shift/presentation/common/utils/flushbar_creator.dart';
import 'package:shift/presentation/core/app_router.gr.dart';

import 'package:shift/presentation/main/tabs/home/view_single_applicants/widgets/accept_reject_dialog.dart';
import 'package:shift/presentation/main/tabs/profile/teams/team_detail/widgets/no_team_member_view.dart';
import 'package:shift/presentation/main/tabs/profile/teams/team_detail/widgets/team_member_list.dart';
import 'package:shift/presentation/main/tabs/profile/teams/widgets/common_team_container.dart';
import 'package:shift/presentation/main/widgets/home_app_bar.dart';

@RoutePage(name: 'TeamDetailView')
class TeamDetailView extends StatelessWidget {
  final GetTeamsListDTO getTeamsListDTO;
  const TeamDetailView({super.key, required this.getTeamsListDTO});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<TeamsBloc>(),
      child: BlocConsumer<TeamsBloc, TeamsState>(
        builder: (context, state) {
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
                    onPressedDelete: () {
                      AcceptRejectDialog(
                        title: 'Delete Team',
                        description:
                            'Deleting this team will prevent you from sharing the shift posting summary with its members. Are you sure you want to proceed?',
                        onPressedAccept: () {
                          context.router.maybePop().then(
                            (value) {
                              context.read<TeamsBloc>().add(
                                    TeamsEvent.deleteTeam(
                                      getTeamsListDTO.id?.toString() ?? "",
                                    ),
                                  );
                            },
                          );
                        },
                        onPressedReject: () {
                          context.router.maybePop();
                        },
                        acceptButtonText: 'Delete',
                      ).acceptRejectDialog(context);
                    },
                    onPressedEdit: () {
                      context.router.push(
                        PageRouteInfo(
                          AddNewTeamView.name,
                          args: AddNewTeamViewArgs(
                            isUpdateMember: true,
                            getTeamsListDTO: getTeamsListDTO,
                          ),
                        ),
                      );
                    },
                  ),
                ),
                SizedBox(
                  height: getSize(30),
                ),
                getTeamsListDTO.members!.isEmpty
                    ? NoTeamMemberView(
                        teamID: getTeamsListDTO.id?.toString() ?? "",
                      )
                    : Expanded(
                        child: TeamMemberList(
                          members: getTeamsListDTO.members ?? [],
                          teamID: getTeamsListDTO.id?.toString() ?? "",
                        ),
                      ),
                // NoTeamMemberView(),
              ],
            ),
          );
        },
        listener: (BuildContext context, TeamsState state) {
          state.failureOrSuccessOption.fold(
            () {},
            (either) => either.fold(
              (failure) {
                showError(
                  message: failure.maybeMap(
                    showAPIResponseMessage: (value) => value.message,
                    networkError: (value) =>
                        'Please check your internet connectivity',
                    orElse: () => "Server Error. Try again later.",
                  ),
                ).show(context);
              },
              (r) async {
                await showSuccess(message: r).show(context).then(
                      (value) => context.router.popUntil(
                        (route) => route.isFirst,
                      ),
                    );
                //context.router.push(const PageRouteInfo(MainTabView.name));
              },
            ),
          );
        },
      ),
    );
  }
}
