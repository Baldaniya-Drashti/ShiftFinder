import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:shift/domain/core/math_utils.dart';
import 'package:shift/domain/core/string_constant.dart';
import 'package:shift/infrastructure/core/employer_long_full_term_dashboard/employer_long_full_term_dashboard_dto.dart';
import 'package:shift/presentation/common/widgets/base_text.dart';
import 'package:shift/presentation/core/app_router.gr.dart';
import 'package:shift/presentation/core/style/app_colors.dart';
import 'package:shift/presentation/main/widgets/home_app_bar.dart';

@RoutePage(name: "LongTermHiredContractorList")
class LongTermHiredContractorList extends StatelessWidget {
  final List<UserDto> userList;
  final int postId;
  const LongTermHiredContractorList(
      {super.key, required this.userList, required this.postId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBar(
        onBackPressed: () {
          context.router.maybePop();
        },
        title: StringConstant.allHiredContractors,
      ),
      body: ListView.builder(
          padding: EdgeInsets.symmetric(vertical: getSize(10)),
          itemCount: userList.length,
          itemBuilder: (context, index) {
            return GestureDetector(
                onTap: () {
                  context.router.push(
                    PageRouteInfo(
                      ViewApplicantProfile.name,
                      args: ViewApplicantProfileArgs(
                          id: userList[index].user_id ?? -1,
                          postId: postId,
                          isLongOrFull: 1),
                    ),
                  );
                },
                child: contractorDetail(context, userList[index]));
          }),
    );
  }

  Widget contractorDetail(BuildContext context, UserDto contractor) {
    return Container(
      margin:
          EdgeInsets.symmetric(vertical: getSize(8), horizontal: getSize(20)),
      padding: EdgeInsets.all(getSize(5)),
      decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(getSize(10)),
          boxShadow: [
            BoxShadow(
              blurRadius: 5,
              color: AppColors.grey,
            )
          ]),
      child: Container(
        padding: EdgeInsets.symmetric(
          vertical: getSize(15),
          horizontal: getSize(15),
        ).copyWith(left: getSize(5)),
        decoration: BoxDecoration(
          color: AppColors.scaffoldColor,
          borderRadius: BorderRadius.circular(getSize(10)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            CircleAvatar(
              radius: getSize(22),
              backgroundColor: AppColors.green,
              child: CircleAvatar(
                backgroundColor: AppColors.scaffoldColor,
                radius: getSize(21),
                backgroundImage: (contractor.profile != null &&
                        contractor.profile!.isNotEmpty)
                    ? NetworkImage(contractor.profile ?? "")
                    : null,
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: getSize(10)),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  BaseText(
                    text:
                        '${contractor.first_name ?? ""} ${contractor.last_name ?? ""}',
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                  SizedBox(width: getSize(5)),
                  Icon(
                    Icons.arrow_forward_ios_rounded,
                    size: getSize(14),
                  ),
                ],
              ),
            ),
            Spacer(),
          ],
        ),
      ),
    );
  }
}
