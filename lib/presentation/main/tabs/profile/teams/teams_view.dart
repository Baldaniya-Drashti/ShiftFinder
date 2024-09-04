import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shift/application/main_tab/profile/profile_sections/teams/teams_bloc.dart';
import 'package:shift/domain/core/math_utils.dart';
import 'package:shift/domain/core/string_constant.dart';
import 'package:shift/injection.dart';
import 'package:shift/presentation/common/widgets/base_text.dart';
import 'package:shift/presentation/common/widgets/paginated_list_view.dart';
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
    return BlocProvider(
      create: (context) =>
          getIt<TeamsBloc>()..add(TeamsEvent.getTeamList(true, null)),
      child: BlocConsumer<TeamsBloc, TeamsState>(
        listener: (context, state) {},
        builder: (context, state) {
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
                    child: PaginatedListView(
                      onRefresh: () {
                        context
                            .read<TeamsBloc>()
                            .add(TeamsEvent.getTeamList(true, null));
                      },
                      refreshController:
                          context.read<TeamsBloc>().refreshController,
                      onLoading: () {
                        context
                            .read<TeamsBloc>()
                            .add(TeamsEvent.getTeamList(false, null));
                      },
                      isNoDataFound: state.isNoDataFound,
                      child: state.isLoading
                          ? Center(
                              child: CircularProgressIndicator(),
                            )
                          : state.isErrorInAPI
                              ? Center(
                                  child: BaseText(
                                      text: StringConstant.somethindWentWrong),
                                )
                              : ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: state.getTeamList.length,
                                  physics: const BouncingScrollPhysics(),
                                  padding: EdgeInsets.symmetric(
                                      horizontal: getSize(20)),
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return GestureDetector(
                                      onTap: () async {
                                        var res = await context.router.push(
                                          PageRouteInfo(
                                            TeamDetailView.name,
                                            args: TeamDetailViewArgs(
                                              getTeamsListDTO:
                                                  state.getTeamList[index],
                                            ),
                                          ),
                                        );
                                        if (res != null && res == true) {
                                          context.read<TeamsBloc>().add(
                                              TeamsEvent.getTeamList(
                                                  true, null));
                                        }
                                      },
                                      child: CommonTeamContainer(
                                        teamName:
                                            state.getTeamList[index].name ?? "",
                                        address: state.getTeamList[index]
                                                .location?.location ??
                                            "",
                                        totalMembers: state.getTeamList[index]
                                                .total_member ??
                                            0,
                                      ),
                                    );
                                  },
                                ),
                    ),
                  ),
                  SizedBox(
                    height: getSize(20),
                  ),
                  CommonButton(
                    height: 28,
                    width: 135,
                    onPressed: () async {
                      var res = await context.router.push(
                        PageRouteInfo(
                          AddNewTeamView.name,
                          args: AddNewTeamViewArgs(),
                        ),
                      );
                      if (res != null && res == true) {
                        context
                            .read<TeamsBloc>()
                            .add(TeamsEvent.getTeamList(true, null));
                      }
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
        },
      ),
    );
  }
}
