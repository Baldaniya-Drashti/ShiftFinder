import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:shift/domain/core/math_utils.dart';
import 'package:shift/presentation/common/widgets/base_text.dart';
import 'package:shift/presentation/core/app_router.gr.dart';
import 'package:shift/presentation/core/style/app_colors.dart';
import 'package:shift/presentation/core/widgets/buttons/common_button.dart';

class TeamMemberList extends StatelessWidget {
  const TeamMemberList({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Flexible(
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: 10,
            padding: EdgeInsets.symmetric(horizontal: getSize(20)),
            physics: const BouncingScrollPhysics(),
            itemBuilder: (context, index) => Container(
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
                    BaseText(
                      text: 'Rochel Foose',
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                    Icon(Icons.arrow_forward_ios_rounded)
                  ],
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
          width: 185,
          onPressed: () {
            context.router.push(
              PageRouteInfo(
                AddNewMemberView.name,
              ),
            );
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
  }
}
