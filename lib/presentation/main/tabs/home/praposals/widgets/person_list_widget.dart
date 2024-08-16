import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:shift/domain/core/math_utils.dart';
import 'package:shift/presentation/common/widgets/base_text.dart';
import 'package:shift/presentation/core/app_router.gr.dart';
import 'package:shift/presentation/core/style/app_colors.dart';

class PersonListWidget extends StatelessWidget {
  const PersonListWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      padding: EdgeInsets.all(getSize(20)),
      physics: NeverScrollableScrollPhysics(),
      itemCount: 10,
      itemBuilder: (context, index) => Padding(
        padding: EdgeInsets.symmetric(vertical: getSize(7.5)),
        child: ListTile(
          dense: true,
          onTap: () =>
              context.router.push(PageRouteInfo(ViewPersonPraposalView.name)),
          contentPadding: EdgeInsets.symmetric(
            vertical: getSize(10),
            horizontal: getSize(15),
          ),
          horizontalTitleGap: getSize(20),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(getSize(10)),
          ),
          visualDensity: VisualDensity.compact,
          tileColor: AppColors.white,
          title: BaseText(
            text: 'Rochel Foose',
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
          leading: CircleAvatar(
            radius: getSize(20),
            backgroundColor: AppColors.green,
            child: CircleAvatar(
              radius: getSize(19),
              backgroundImage: NetworkImage(
                'https://w0.peakpx.com/wallpaper/751/41/HD-wallpaper-women-mood-girl-portrait-profile-sunset.jpg',
              ),
            ),
          ),
          trailing: Icon(
            Icons.arrow_forward_rounded,
            color: AppColors.black,
          ),
        ),
      ),
    );
  }
}
