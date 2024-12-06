import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:shift/application/contractor/refer_colleague/refer_colleague_bloc.dart';
import 'package:shift/domain/core/math_utils.dart';
import 'package:shift/domain/core/string_constant.dart';
import 'package:shift/domain/core/svg_image_constants.dart';
import 'package:shift/injection.dart';
import 'package:shift/presentation/common/utils/flushbar_creator.dart';
import 'package:shift/presentation/common/utils/get_cookie.dart';
import 'package:shift/presentation/common/widgets/base_text.dart';
import 'package:shift/presentation/common/widgets/center_loading_indicator.dart';
import 'package:shift/presentation/common/widgets/paginated_list_view.dart';
import 'package:shift/presentation/core/app_router.gr.dart';
import 'package:shift/presentation/core/style/app_colors.dart';
import 'package:shift/presentation/core/widgets/avatar.dart';
import 'package:shift/presentation/core/widgets/buttons/common_button.dart';
import 'package:shift/presentation/main/widgets/home_app_bar.dart';

@RoutePage(name: "ReferColleagueView")
class ReferColleagueView extends StatelessWidget {
  const ReferColleagueView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<ReferColleagueBloc>()
        ..add(ReferColleagueEvent.getReferredColleagueData(isRefresh: true)),
      child: BlocBuilder<ReferColleagueBloc, ReferColleagueState>(
        builder: (context, state) {
          return Scaffold(
            appBar: CommonAppBar(
                onBackPressed: () => context.router.maybePop(),
                title: StringConstant.referAColleague),
            body: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Material(
                    borderRadius: BorderRadius.circular(10),
                    color: AppColors.surfaceColor,
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                BaseText(
                                  text: StringConstant.referralCode,
                                  fontSize: 10,
                                ),
                                BaseText(
                                  text: getCurrentUser().your_referral_code ??
                                      "TEST12345ET",
                                  fontWeight: FontWeight.w600,
                                  textColor: AppColors.green,
                                ),
                              ],
                            ),
                          ),
                          CommonButton(
                            onPressed: () {
                              // showUnderDevelopment(context);
                              context.read<ReferColleagueBloc>().add(
                                  ReferColleagueEvent.shareReferralEvent(
                                      referralCode: "TEST12345ET"));
                            },
                            buttonText: StringConstant.share,
                            borderRadius: 10,
                            width: 120,
                            height: 37,
                            buttonFontSize: 14,
                            buttonFontWeight: FontWeight.w500,
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        left: getSize(18),
                        top: getSize(20),
                        bottom: getSize(12)),
                    child: BaseText(
                      text: StringConstant.yourReferrals,
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Expanded(
                    child: state.isLoading
                        ? CenterLoadingIndicator(isOnlyLoader: true)
                        : state.isErrorInApi
                            ? Center(
                                child: BaseText(
                                    text: StringConstant.somethindWentWrong))
                            : PaginatedListView(
                                onRefresh: () => context
                                    .read<ReferColleagueBloc>()
                                    .add(ReferColleagueEvent
                                        .getReferredColleagueData(
                                            isRefresh: true)),
                                onLoading: () => context
                                    .read<ReferColleagueBloc>()
                                    .add(ReferColleagueEvent
                                        .getReferredColleagueData(
                                            isRefresh: false)),
                                refreshController: context
                                    .read<ReferColleagueBloc>()
                                    .refreshController,
                                isNoDataFound: state.noDataFound,
                                child: ListView.separated(
                                    physics: NeverScrollableScrollPhysics(),
                                    shrinkWrap: true,
                                    separatorBuilder: (context, index) =>
                                        Gap(getSize(12)),
                                    itemCount: state.collegueList.length,
                                    itemBuilder: (context, index) {
                                      final user = state.collegueList[index];
                                      return Material(
                                        borderRadius: BorderRadius.circular(10),
                                        color: AppColors.white,
                                        child: InkWell(
                                          onTap: () {
                                            // showUnderDevelopment(context);
                                            print(
                                                "user.user_id--->${user.user_id}");
                                            context.router.push(
                                              PageRouteInfo(
                                                  ViewCollegueProfile.name,
                                                  args: ViewCollegueProfileArgs(
                                                    id: user.user_id ?? -1,
                                                  )),
                                            );
                                          },
                                          child: Padding(
                                            padding:
                                                EdgeInsets.all(getSize(12)),
                                            child: ListTile(
                                              visualDensity:
                                                  VisualDensity.compact,
                                              leading: SizedBox(
                                                height: getSize(40),
                                                width: getSize(40),
                                                child: (user.profile != null &&
                                                        user.profile!
                                                            .isNotEmpty)
                                                    ? UserAvatar(
                                                        url: state
                                                                .collegueList[
                                                                    index]
                                                                .profile ??
                                                            "",
                                                      )
                                                    : SvgPicture.asset(
                                                        SvgImageConstant
                                                            .person),
                                              ),
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10)),
                                              tileColor:
                                                  AppColors.scaffoldColor,
                                              title: Row(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  BaseText(
                                                    text:
                                                        "${user.first_name ?? ""} ${user.last_name ?? ""}",
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                  SizedBox(width: getSize(10)),
                                                  SvgPicture.asset(
                                                    SvgImageConstant.rightArrow,
                                                    height: 13,
                                                    width: 13,
                                                    color: AppColors.black
                                                        .withOpacity(0.5),
                                                  )
                                                ],
                                              ),
                                              subtitle: Row(
                                                children: [
                                                  SvgPicture.asset(
                                                    SvgImageConstant
                                                        .emailFilled,
                                                  ),
                                                  SizedBox(width: getSize(8)),
                                                  BaseText(
                                                    text: user.email ?? "",
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      );
                                    }),
                              ),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
