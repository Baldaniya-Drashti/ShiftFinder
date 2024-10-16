import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:shift/domain/core/math_utils.dart';
import 'package:shift/infrastructure/core/total_proposal_dto/total_proposal_dto.dart';
import 'package:shift/presentation/common/widgets/base_text.dart';
import 'package:shift/presentation/core/app_router.gr.dart';
import 'package:shift/presentation/core/logger/logger.dart';
import 'package:shift/presentation/core/style/app_colors.dart';

class PersonListWidget extends StatelessWidget {
  const PersonListWidget({
    super.key,
    required this.list,
    required this.postId,
  });

  final List<TotalProposalDto> list;
  final int postId;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      padding: EdgeInsets.all(getSize(20)),
      physics: NeverScrollableScrollPhysics(),
      itemCount: list.length,
      itemBuilder: (context, index) => Padding(
        padding: EdgeInsets.symmetric(vertical: getSize(7.5)),
        child: ListTile(
          dense: true,
          onTap: () {
          ///1 rec 2 sent

            Log.success("postId  ${postId } userId ${list[index].user_id}");
          //   context.router.push(
          //   PageRouteInfo(ViewPersonPraposalView.name),
          // );
          },
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
            text: '${list[index].first_name ?? ""} ${list[index].last_name ?? ""}',
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
          leading: CircleAvatar(
            radius: getSize(20),
            backgroundColor: AppColors.green,
            child: CircleAvatar(
              radius: getSize(19),
              backgroundImage: NetworkImage(list[index].profile ?? ""),
            ),
          ),
          trailing: Icon(
            Icons.arrow_forward_rounded,
            color: AppColors.black,
          ),
          subtitle: Row(
            mainAxisSize: MainAxisSize.min,
            children: [

              BaseText(
                text: '${list[index].first_name ?? ""} ${list[index].last_name ?? ""}',
                fontSize: 10,
                fontWeight: FontWeight.w500,
              ),



            ],
          ),
        ),
      ),
    );
  }
}
