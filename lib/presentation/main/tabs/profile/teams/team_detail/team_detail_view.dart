// ignore_for_file: deprecated_member_use

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shift/application/main_tab/profile/profile_sections/teams/teams_bloc.dart';
import 'package:shift/domain/core/math_utils.dart';
import 'package:shift/domain/core/string_constant.dart';
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
      create: (context) => getIt<TeamsBloc>()
        ..add(
          TeamsEvent.getTeamList(true, getTeamsListDTO.id?.toString() ?? ""),
        )
        ..add(TeamsEvent.setTeamDetail(getTeamsListDTO)),
      child: BlocConsumer<TeamsBloc, TeamsState>(
        builder: (context, state) {
          return WillPopScope(
            onWillPop: () {
              Navigator.pop(context, true);
              return Future.value(true);
            },
            child: Scaffold(
              appBar: CommonAppBar(
                onBackPressed: () => context.router.maybePop(),
                title: state.teamDetail.name ?? getTeamsListDTO.name ?? "",
              ),
              body: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: getSize(20)),
                    child: CommonTeamContainer(
                      teamName: state.teamDetail.name ?? "",
                      address: state.teamDetail.location?.location ?? "",
                      totalMembers: state.teamDetail.total_member ?? 0,
                      isFromTeamDetail: true,
                      onPressedDelete: () {
                        AcceptRejectDialog(
                          title: StringConstant.deleteTeam,
                          description: StringConstant.deleteTeamDesc,
                          onPressedAccept: () {
                            context.router.maybePop(true).then(
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
                          acceptButtonText: StringConstant.delete,
                        ).acceptRejectDialog(context);
                      },
                      onPressedEdit: () async {
                        var res = await context.router.push(
                          PageRouteInfo(
                            AddNewTeamView.name,
                            args: AddNewTeamViewArgs(
                              isUpdateMember: true,
                              getTeamsListDTO: state.teamDetail,
                            ),
                          ),
                        );
                        if (res != null && res == true) {
                          context.read<TeamsBloc>().add(
                                TeamsEvent.getTeamList(
                                  true,
                                  state.teamDetail.id?.toString() ?? "",
                                ),
                              );
                        }
                      },
                    ),
                  ),
                  SizedBox(height: getSize(30)),
                  Expanded(
                    child: (state.teamDetail.members == null ||
                            state.teamDetail.members!.isEmpty)
                        ? Center(
                            child: NoTeamMemberView(
                              teamID: getTeamsListDTO.id?.toString() ?? "",
                              addMemberPressed: () async {
                                var res = await context.router.push(
                                  PageRouteInfo(
                                    AddNewMemberView.name,
                                    args: AddNewMemberViewArgs(
                                      isUpdateMember: false,
                                      getTeamsListDTO: null,
                                      teamID: state.teamDetail.id.toString(),
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
                            ),
                          )
                        : TeamMemberList(
                            members: state.teamDetail.members ?? [],
                            teamID: state.teamDetail.id?.toString() ?? "",
                            onPressed: () async {
                              var res = await context.router.push(
                                PageRouteInfo(
                                  AddNewMemberView.name,
                                  args: AddNewMemberViewArgs(
                                    isUpdateMember: false,
                                    getTeamsListDTO: null,
                                    teamID: state.teamDetail.id.toString(),
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
                          ),
                  ),
                  // NoTeamMemberView(),
                ],
              ),
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
                      (value) => context.router.maybePop(
                        true,
                      ),
                    );
              },
            ),
          );
        },
      ),
    );
  }
}
