import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:shift/application/contractor/contractor_previous_shift/contractor_previous_shift_bloc.dart';
import 'package:shift/domain/core/math_utils.dart';
import 'package:shift/domain/core/png_image_constants.dart';
import 'package:shift/domain/core/string_constant.dart';
import 'package:shift/domain/core/svg_image_constants.dart';
import 'package:shift/infrastructure/core/skill_list_model/skill_dto.dart';
import 'package:shift/presentation/common/widgets/base_text.dart';
import 'package:shift/presentation/core/common_lisitng/common_listing.dart';
import 'package:shift/presentation/core/style/app_colors.dart';
import 'package:shift/presentation/core/widgets/buttons/common_button.dart';
import 'package:shift/presentation/core/widgets/drop_down_field.dart';
import 'package:shift/presentation/core/widgets/inputs/custom_text_field.dart';
import 'package:shift/presentation/core/widgets/tile.dart';

class ContractorCancelledShiftView extends StatelessWidget {
  const ContractorCancelledShiftView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ContractorPreviousShiftBloc, ContractorPreviousShiftState>(
      builder: (context, state) {
        return SingleChildScrollView(
          padding: EdgeInsets.all(12).copyWith(top: 0),
          child: Column(
            children: [
              sortingField(context, state),
              Gap(12),
              ListView.separated(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return Container(
                    padding: EdgeInsets.all(getSize(12)),
                    decoration: BoxDecoration(
                      color: AppColors.white,
                      borderRadius: BorderRadius.circular(getSize(20)),
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.black.withOpacity(0.2),
                          blurRadius: 10,
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        userDetail(context),
                        Gap(15),
                        Row(
                          children: [
                            Expanded(
                              child: CommonInfoTile(
                                leading: SvgPicture.asset(
                                  SvgImageConstant.calendar,
                                  height: 15,
                                  width: 15,
                                  colorFilter: ColorFilter.mode(AppColors.black.withOpacity(0.6), BlendMode.srcIn),
                                ),
                                title: BaseText(
                                  text: "Shift Date",
                                  fontSize: getSize(10),
                                  textColor: AppColors.black.withOpacity(0.6),
                                  fontWeight: FontWeight.w400,
                                ),
                                subtitle: Text.rich(
                                  style: TextStyle(fontSize: 12),
                                  TextSpan(
                                    text: "12 May, ",
                                    style: TextStyle(fontWeight: FontWeight.w600),
                                    children: [
                                      TextSpan(text: "2024", style: TextStyle(color: AppColors.black.withOpacity(0.5))),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              child: CommonInfoTile(
                                key: ValueKey("time"),
                                leading: SvgPicture.asset(
                                  SvgImageConstant.clock,
                                  height: 15,
                                  width: 15,
                                  colorFilter: ColorFilter.mode(AppColors.black.withOpacity(0.6), BlendMode.srcIn),
                                ),
                                title: BaseText(
                                  text: "Time",
                                  fontSize: getSize(10),
                                  textColor: AppColors.black.withOpacity(0.6),
                                  fontWeight: FontWeight.w400,
                                ),
                                subtitle: BaseText(
                                  text: '09:15 AM to 07:30 PM',
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ],
                        ),
                        if (state.currentCancelFilter.id == 2) ...[
                          Gap(12),
                          Row(
                            children: [
                              Expanded(
                                child: CommonInfoTile(
                                  leading: SvgPicture.asset(
                                    SvgImageConstant.dollorRound,
                                    height: 15,
                                    width: 15,
                                    colorFilter: ColorFilter.mode(AppColors.black.withOpacity(0.6), BlendMode.srcIn),
                                  ),
                                  title: BaseText(
                                    text: "Compassion",
                                    fontSize: getSize(10),
                                    textColor: AppColors.black.withOpacity(0.6),
                                    fontWeight: FontWeight.w400,
                                  ),
                                  subtitle: BaseText(
                                    text: '\$150',
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                              Flexible(
                                child: CommonButton(
                                  onPressed: () {},
                                  buttonText: "View Shift Details",
                                  backgroundColor: AppColors.scaffoldColor,
                                  buttonFontSize: 12,
                                  height: 40,
                                  buttonTextColor: AppColors.black,
                                  buttonFontWeight: FontWeight.w600,
                                  borderRadius: 7,
                                ),
                              ),
                            ],
                          ),
                          Gap(10),
                          Padding(
                            padding: const EdgeInsets.only(left: 16),
                            child: BaseText(
                              text: "Reason",
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Gap(6),
                          Material(
                            borderRadius: BorderRadius.circular(10),
                            color: AppColors.scaffoldColor,
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: BaseText(
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                text:
                                    "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.",
                              ),
                            ),
                          )
                        ] else ...[
                          Gap(15),
                          CommonButton(
                            onPressed: () {},
                            buttonText: "View Shift Details",
                            backgroundColor: AppColors.scaffoldColor,
                            buttonFontSize: 12,
                            height: 43,
                            buttonTextColor: AppColors.black,
                            buttonFontWeight: FontWeight.w600,
                            borderRadius: 7,
                          ),
                        ],
                      ],
                    ),
                  );
                },
                separatorBuilder: (context, index) => Gap(15),
                itemCount: 5,
              )
            ],
          ),
        );
      },
    );
  }

  Widget sortingField(
    BuildContext context,
    ContractorPreviousShiftState state,
  ) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: getSize(10)),
      child: CustomDropdownField(
        onChanged: (value) {
          if (value != null) {
            context.read<ContractorPreviousShiftBloc>().add(ContractorPreviousShiftEvent.onCancelTypeSorting(value ?? SkillDTO()));
          }
        },
        hintText: StringConstant.location,
        value: state.currentCancelFilter,
        items: [
          SkillDTO(id: 1, name: "Withdrawn by You"),
          SkillDTO(id: 2, name: "Cancelled by Employer"),
        ].map((val) {
          return DropdownMenuItem<SkillDTO>(
            value: val,
            child: BaseText(
              text: val.name ?? "",
              fontSize: 14,
              textColor: AppColors.black,
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget userDetail(
    BuildContext context,
  ) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(getSize(10)),
        color: AppColors.scaffoldColor,
      ),
      padding: EdgeInsets.symmetric(horizontal: getSize(12)),
      child: Column(
        children: [
          ListTile(
            dense: true,
            leading: Image.asset(
              PngImageConstants.leafWithBG,
              height: getSize(40),
              width: getSize(40),
            ),
            isThreeLine: true,
            title: BaseText(
              text: "CT Technologist",
              textColor: AppColors.black,
              fontSize: 16,
              maxLines: 1,
              fontWeight: FontWeight.w600,
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                BaseText(
                  text: "Louis Vuitton Pvt. Ltd.",
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  textColor: AppColors.black.withOpacity(0.80),
                ),
                BaseText(
                  text: "(Healthcare - 2DFG125)",
                  fontSize: 10,
                  fontWeight: FontWeight.w500,
                  textColor: AppColors.black.withOpacity(0.80),
                ),
              ],
            ),
            contentPadding: EdgeInsets.zero,
            visualDensity: VisualDensity.compact,
          ),
          Divider(
            color: AppColors.black.withOpacity(0.2),
            thickness: getSize(0.5),
          ),
          GestureDetector(
            onTap: () {
              /*context.router.push(
                    PageRouteInfo(
                      ShowGoogleMap.name,
                      args: ShowGoogleMapArgs(
                        latitude: 21.191535534205194,
                        longitude: 72.78582206137469,
                      ),
                    ),
                  );*/
            },
            child: Row(
              children: [
                SvgPicture.asset(
                  SvgImageConstant.location,
                  height: getSize(25),
                  width: getSize(25),
                  color: AppColors.black,
                ),
                SizedBox(
                  width: getSize(10),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      BaseText(
                        text: "4517 Washington Manchester, Kentucky 39495",
                        fontSize: 12,
                        maxLines: 1,
                        fontWeight: FontWeight.w500,
                        textColor: AppColors.black,
                      ),
                      BaseText(
                        text: "10.2 Km Away",
                        fontSize: 10,
                        maxLines: 1,
                        fontWeight: FontWeight.w600,
                        textColor: AppColors.primaryColor,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: getSize(12),
          ),
        ],
      ),
    );
  }
}
