import 'package:flutter/material.dart';
import 'package:shift/domain/core/math_utils.dart';
import 'package:shift/presentation/common/widgets/base_text.dart';
import 'package:shift/presentation/employer/profile/previous_shift_view/previous_shift_fav_view.dart';

class PreviousShiftBlockedView extends StatelessWidget {
  const PreviousShiftBlockedView({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(getSize(20)),
      child: Column(
        children: [
          SizedBox(
            height: getSize(12),
          ),
          BaseText(
            text: "You can unblock a contractor from your blocked list by clicking the blocked button again.",
            fontSize: 12,
            fontWeight: FontWeight.w600,
          ),
          SizedBox(
            height: getSize(18),
          ),
          Expanded(
            child: ListView.separated(
              shrinkWrap: true,
              itemBuilder: (context, index) => PreviousShiftFavTile(
                profileImage: '',
                title: "Barbara ",
                subtitle: 'CT Technologist',
                traling: ElevatedButton.icon(
                  onPressed: () {},
                  label: BaseText(text: ""),
                ),
              ),
              separatorBuilder: (context, index) => SizedBox(
                height: getSize(16),
              ),
              itemCount: 4,
            ),
          )
        ],
      ),
    );
  }
}
