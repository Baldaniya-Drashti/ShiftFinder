import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import 'package:gap/gap.dart';
import 'package:shift/presentation/common/widgets/base_text.dart';
import 'package:shift/presentation/core/style/app_colors.dart';
import 'package:shift/presentation/core/widgets/avatar.dart';
import 'package:shift/presentation/main/widgets/home_app_bar.dart';

@RoutePage(name: 'HiredContractorView')
class HiredContractorView extends StatelessWidget {
  const HiredContractorView({super.key, required this.list});

  final List<dynamic> list;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBar(
        onBackPressed: () => context.router.maybePop(),
        title: 'All Hired Contractors',
      ),
      body: ListView.separated(
        itemCount: list.length,
        separatorBuilder: (context, index) => Gap(18),
        itemBuilder: (context, index) {
          return ListTile(
            visualDensity: VisualDensity.compact,
            leading: UserAvatar(url: "https://w0.peakpx.com/wallpaper/751/41/HD-wallpaper-women-mood-girl-portrait-profile-sunset.jpg"),
            minLeadingWidth: 0,
            title: BaseText(text: "View Agreed Proposal", fontSize: 14, fontWeight: FontWeight.w600),
            subtitle: BaseText(
              text: "View Agreed Proposal",
              fontSize: 12,
              fontWeight: FontWeight.w600,
              textColor: AppColors.green,
            ),
          );
        },
      ),
    );
  }
}
