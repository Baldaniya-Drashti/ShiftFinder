import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:shift/domain/core/math_utils.dart';
import 'package:shift/domain/core/string_constant.dart';
import 'package:shift/domain/core/svg_image_constants.dart';
import 'package:shift/presentation/common/widgets/base_text.dart';
import 'package:shift/presentation/core/app_router.gr.dart';
import 'package:shift/presentation/core/style/app_colors.dart';
import 'package:shift/presentation/main/widgets/home_app_bar.dart';

@RoutePage(name: "ContractorUpdateProfileView")
class ContractorUpdateProfileView extends StatelessWidget {
  const ContractorUpdateProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBar(
        onBackPressed: () => context.router.maybePop(),
        title: StringConstant.updateProfile,
      ),
      body: Padding(
        padding: EdgeInsets.all(getSize(20)),
        child: Column(
          children: [
            profileView(context),
            Gap(getSize(50)),
            Material(
              clipBehavior: Clip.antiAlias,
              borderRadius: BorderRadius.circular(15),
              color: AppColors.white,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 12),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    fieldTypeTile(
                      icon: SvgImageConstant.editUser,
                      onPressed: () {
                        context.router.push(PageRouteInfo(
                            AddContractorSkillsForm.name,
                            args: AddContractorSkillsFormArgs(isUpdate: true)));
                      },
                      label: StringConstant.roleAndExperience,
                    ),
                    fieldTypeTile(
                      icon: SvgImageConstant.capOutline,
                      onPressed: () {
                        context.router.push(PageRouteInfo(
                            EducationListScreen.name,
                            args:
                                EducationListScreenArgs(isFromProfile: true)));
                      },
                      label: StringConstant.education,
                    ),
                    fieldTypeTile(
                      icon: SvgImageConstant.references,
                      onPressed: () {
                        context.router.push(PageRouteInfo(
                            ReferenceListScreen.name,
                            args:
                                ReferenceListScreenArgs(isFromProfile: true)));
                      },
                      label: StringConstant.reference,
                    ),
                    fieldTypeTile(
                      icon: SvgImageConstant.document,
                      onPressed: () {
                        context.router.push(PageRouteInfo(
                            DocumentPageScreen.name,
                            args: DocumentPageScreenArgs(isUpdate: true)));
                      },
                      label: StringConstant.documents,
                    ),
                    fieldTypeTile(
                      icon: SvgImageConstant.document,
                      onPressed: () {
                        context.router.push(PageRouteInfo(
                            AddressProofScreen.name,
                            args: AddressProofScreenArgs(isUpdate: true)));
                      },
                      label: StringConstant.addressProof,
                    ),
                    fieldTypeTile(
                      icon: SvgImageConstant.bank,
                      onPressed: () {
                        context.router.push(PageRouteInfo(BankListView.name));
                      },
                      label: StringConstant.bankDetails,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget profileView(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SvgPicture.asset(SvgImageConstant.updateProfile),
        Gap(getSize(25)),
        BaseText(
            text: StringConstant.profile,
            fontFamily: "Aclonica",
            fontSize: 22,
            fontWeight: FontWeight.w400),
        Gap(getSize(5)),
        SizedBox(
          width: MediaQuery.sizeOf(context).width * 0.8,
          child: BaseText(
            text: StringConstant.updateProfileDesc,
            fontSize: 14,
            fontWeight: FontWeight.w500,
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }

  Widget fieldTypeTile(
      {required String icon,
      required VoidCallback onPressed,
      required String label}) {
    return ListTile(
      visualDensity: VisualDensity.compact,
      onTap: onPressed,
      title: BaseText(text: label, fontSize: 12, fontWeight: FontWeight.w500),
      leading: SvgPicture.asset(
        icon,
        height: getSize(25),
        width: getSize(25),
        colorFilter: ColorFilter.mode(AppColors.green, BlendMode.srcIn),
      ),
      trailing: SvgPicture.asset(
        SvgImageConstant.rightArrow2,
        height: getSize(20),
        width: getSize(20),
      ),
    );
  }
}
