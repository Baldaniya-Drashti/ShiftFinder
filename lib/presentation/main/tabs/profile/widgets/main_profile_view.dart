import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shift/application/profile/account/account_cubit.dart';
import 'package:shift/domain/core/math_utils.dart';
import 'package:shift/domain/core/png_image_constants.dart';
import 'package:shift/domain/core/svg_image_constants.dart';
import 'package:shift/presentation/common/widgets/base_text.dart';
import 'package:shift/presentation/core/style/app_colors.dart';
import 'package:shift/presentation/core/widgets/buttons/common_button.dart';

class MainProfileView extends StatelessWidget {
  const MainProfileView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AccountCubit, AccountState>(
      builder: (context, state) {
        return state.maybeWhen(
          loadInProgress: () => Center(
            child: CircularProgressIndicator(),
          ),
          loadSuccess: (account) => Container(
            margin: EdgeInsets.symmetric(horizontal: getSize(20)),
            padding: EdgeInsets.symmetric(
              horizontal: getSize(20),
              vertical: getSize(10),
            ),
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(getSize(15)),
            ),
            child: Row(
              children: [
                CircleAvatar(
                  radius: getSize(40),
                  backgroundColor: Color(0xFF046307),
                  child: CircleAvatar(
                    radius: getSize(37),
                    backgroundImage: account.profileImage != null
                        ? CachedNetworkImageProvider(account.profileImage ?? "")
                        : null,
                    backgroundColor: AppColors.white,
                    child: account.profileImage == null
                        ? Image.asset(
                            PngImageConstants.emptyProfileImage,
                            width: getSize(53),
                            height: getSize(44),
                          )
                        : Container(),
                  ),
                ),
                SizedBox(width: getSize(25)),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      BaseText(
                        text: '${account.firstName} ${account.lastName}',
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        fontFamily: 'Aclonica',
                      ),
                      SizedBox(height: getSize(5)),
                      Row(
                        children: [
                          SvgPicture.asset(
                            SvgImageConstant.building,
                            height: getSize(12),
                            width: getSize(12),
                          ),
                          SizedBox(width: getSize(6)),
                          BaseText(
                            text: account.companyName ?? "",
                            fontSize: 10,
                            fontWeight: FontWeight.w600,
                          )
                        ],
                      ),
                      SizedBox(height: getSize(5)),
                      CommonButton(
                        onPressed: () {},
                        buttonText: 'Edit Profile',
                        buttonFontSize: 10,
                        height: 22,
                        width: 87,
                        buttonFontWeight: FontWeight.w600,
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
          orElse: () => Center(
            child: Container(),
          ),
        );
      },
    );
  }
}
