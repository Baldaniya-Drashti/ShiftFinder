import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:gap/gap.dart';
import 'package:shift/application/employer/hired_contractor/hired_contractor_bloc.dart';
import 'package:shift/domain/core/svg_image_constants.dart';
import 'package:shift/injection.dart';
import 'package:shift/presentation/common/widgets/base_text.dart';
import 'package:shift/presentation/common/widgets/paginated_list_view.dart';
import 'package:shift/presentation/core/style/app_colors.dart';
import 'package:shift/presentation/core/widgets/avatar.dart';
import 'package:shift/presentation/core/widgets/buttons/common_button.dart';
import 'package:shift/presentation/core/widgets/tile.dart';
import 'package:shift/presentation/main/widgets/home_app_bar.dart';

@RoutePage(name: 'HiredContractorView')
class HiredContractorView extends StatelessWidget {
  const HiredContractorView({super.key, required this.postId});

  final int postId;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<HiredContractorBloc>()
      /*..add(
          HiredContractorEvent.getHiredContractorList(postId: postId, context: context, refresh: true),
        )*/
      ,
      child: Builder(builder: (context) {
        return Scaffold(
          appBar: CommonAppBar(
            onBackPressed: () => context.router.maybePop(),
            title: 'All Hired Contractors',
          ),
          body: PaginatedListView(
            onRefresh: () {
              context
                  .read<HiredContractorBloc>()
                  .add(HiredContractorEvent.getHiredContractorList(postId: postId, context: context, refresh: true));
            },
            onLoading: () {
              context
                  .read<HiredContractorBloc>()
                  .add(HiredContractorEvent.getHiredContractorList(postId: postId, context: context, refresh: false));
            },
            refreshController: context.read<HiredContractorBloc>().refreshController,
            child: ListView.separated(
              padding: EdgeInsets.all(16),
              itemCount: 4,
              separatorBuilder: (context, index) => Gap(16),
              itemBuilder: (context, index) {
                return Material(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(10),
                  child: Padding(
                    padding: EdgeInsets.all(8),
                    child: Material(
                      color: AppColors.scaffoldColor,
                      borderRadius: BorderRadius.circular(10),
                      // child: ListTile(
                      //   visualDensity: VisualDensity.compact,
                      //   leading: UserAvatar(
                      //       url: "https://w0.peakpx.com/wallpaper/751/41/HD-wallpaper-women-mood-girl-portrait-profile-sunset.jpg"),
                      //   minLeadingWidth: 0,
                      //   title: Column(
                      //     crossAxisAlignment: CrossAxisAlignment.start,
                      //     mainAxisSize: MainAxisSize.min,
                      //     children: [
                      //       BaseText(text: "View Agreed Proposal", fontSize: 14, fontWeight: FontWeight.w600),
                      //       Gap(4),
                      //       Align(
                      //         alignment: Alignment.centerLeft,
                      //         child: Material(
                      //           borderRadius: BorderRadius.circular(3),
                      //           color: AppColors.green.withOpacity(0.15),
                      //           child: InkWell(
                      //             onTap: () {},
                      //             child: Padding(
                      //               padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 5),
                      //               child: BaseText(
                      //                 text: "View Agreed Proposal",
                      //                 fontSize: 9,
                      //                 fontWeight: FontWeight.w600,
                      //                 textColor: AppColors.green,
                      //               ),
                      //             ),
                      //           ),
                      //         ),
                      //       ),
                      //     ],
                      //   ),
                      //   trailing: CommonMaterialButton.icon(
                      //     radius: 5,
                      //     backgroundColor: AppColors.green.withOpacity(0.15),
                      //     width: 65,
                      //     height: 32,
                      //     onPressed: () {},
                      //     label: "Chat",
                      //     icon: SvgPicture.asset(
                      //       SvgImageConstant.chat,
                      //       height: 14,
                      //       width: 14,
                      //       colorFilter: ColorFilter.mode(AppColors.black, BlendMode.srcIn),
                      //     ),
                      //     textStyle: TextStyle(fontWeight: FontWeight.w600, fontSize: 10),
                      //   ),
                      // ),
                      child: Padding(
                        padding: EdgeInsets.all(12),
                        child: Row(
                          children: [
                            UserAvatar(
                              url: "https://w0.peakpx.com/wallpaper/751/41/HD-wallpaper-women-mood-girl-portrait-profile-sunset.jpg",
                            ),
                          Gap(10),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  BaseText(text: "View Agreed Proposal", fontSize: 14, fontWeight: FontWeight.w600),
                                  Gap(4),
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: Material(
                                      borderRadius: BorderRadius.circular(3),
                                      color: AppColors.green.withOpacity(0.15),
                                      child: InkWell(
                                        onTap: () {},
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 5),
                                          child: BaseText(
                                            text: "View Agreed Proposal",
                                            fontSize: 9,
                                            fontWeight: FontWeight.w600,
                                            textColor: AppColors.green,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            CommonMaterialButton.icon(
                              radius: 5,
                              backgroundColor: AppColors.green.withOpacity(0.15),
                              width: 65,
                              height: 32,
                              onPressed: () {},
                              label: "Chat",
                              icon: SvgPicture.asset(
                                SvgImageConstant.chat,
                                height: 14,
                                width: 14,
                                colorFilter: ColorFilter.mode(AppColors.black, BlendMode.srcIn),
                              ),
                              textStyle: TextStyle(fontWeight: FontWeight.w600, fontSize: 10),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        );
      }),
    );
  }
}
