import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shift/application/main_tab/profile/profile_sections/teams/add_new_member/add_new_member_bloc.dart';
import 'package:shift/domain/core/math_utils.dart';
import 'package:shift/domain/core/svg_image_constants.dart';
import 'package:shift/presentation/common/widgets/base_text.dart';
import 'package:shift/presentation/common/widgets/common_country_code_picker.dart';
import 'package:shift/presentation/core/style/app_colors.dart';
import 'package:shift/presentation/core/widgets/buttons/common_button.dart';
import 'package:shift/presentation/core/widgets/inputs/custom_text_field.dart';
import 'package:shift/presentation/main/tabs/home/view_single_applicants/widgets/accept_reject_dialog.dart';
import 'package:shift/presentation/main/widgets/home_app_bar.dart';

@RoutePage(name: 'AddNewMemberView')
class AddNewMemberView extends StatelessWidget {
  final bool isUpdateMember;
  const AddNewMemberView({super.key, this.isUpdateMember = false});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AddNewMemberBloc(),
      child: BlocConsumer<AddNewMemberBloc, AddNewMemberState>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
            appBar: CommonAppBar(
              onBackPressed: () => context.router.maybePop(),
              title: isUpdateMember
                  ? 'Edit Member’s Details'
                  : 'Add New Team Member',
            ),
            body: GestureDetector(
              onTap: () => FocusScope.of(context).unfocus(),
              child: Form(
                autovalidateMode: state.showErrorMessages
                    ? AutovalidateMode.always
                    : AutovalidateMode.disabled,
                child: ListView(
                  shrinkWrap: true,
                  padding: EdgeInsets.symmetric(horizontal: getSize(20)),
                  physics: BouncingScrollPhysics(),
                  children: [
                    memberDetail(
                      title: 'Member Name',
                      image: SvgImageConstant.person,
                      textCapitalization: TextCapitalization.words,
                      value: 'Member Name',
                      onChanged: (value) {
                        context.read<AddNewMemberBloc>().add(
                              AddNewMemberEvent.changeTeamMemberName(value),
                            );
                      },
                      validator: (p0, p1) => state.teamNameTextField.value.fold(
                        (l) => l.maybeMap(
                          empty: (value) => 'Please enter team member name',
                          orElse: () => null,
                        ),
                        (r) => null,
                      ),
                    ),
                    memberDetail(
                      title: 'Job Location',
                      image: SvgImageConstant.locationIcon,
                      value: 'Job Location',
                      onChanged: (value) {
                        context.read<AddNewMemberBloc>().add(
                              AddNewMemberEvent.jobLocationChange(value),
                            );
                      },
                      validator: (p0, p1) => state.locationTextField.value.fold(
                        (l) => l.maybeMap(
                          empty: (value) => 'Please enter job location',
                          orElse: () => null,
                        ),
                        (r) => null,
                      ),
                    ),
                    memberDetail(
                      title: 'Phone Number',
                      image: SvgImageConstant.call,
                      value: 'Phone Number',
                      keyboardType: TextInputType.phone,
                      onChanged: (value) {
                        context.read<AddNewMemberBloc>().add(
                              AddNewMemberEvent.phoneNumberChange(value),
                            );
                      },
                      validator: (p0, p1) => state.mobileNumber.value.fold(
                        (l) => l.maybeMap(
                          empty: (value) => 'Please enter phone number',
                          invalidMobileNumber: (value) =>
                              'Please enter valid phone number',
                          orElse: () => null,
                        ),
                        (r) => null,
                      ),
                    ),
                    memberDetail(
                      title: 'E-mail',
                      image: SvgImageConstant.email,
                      value: 'E-mail',
                      keyboardType: TextInputType.emailAddress,
                      onChanged: (value) {
                        context.read<AddNewMemberBloc>().add(
                              AddNewMemberEvent.emailChange(value),
                            );
                      },
                      validator: (p0, p1) => state.emailAddress.value.fold(
                        (l) => l.maybeMap(
                          empty: (value) => 'Please enter email',
                          invalidEmail: (value) => 'Please enter valid email',
                          orElse: () => null,
                        ),
                        (r) => null,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            bottomNavigationBar: SafeArea(
              child: Padding(
                padding: EdgeInsets.only(
                  left: getSize(20),
                  right: getSize(20),
                  top: getSize(20),
                  bottom: !isFullScreenDevice(context) ? getSize(20) : 0,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CommonButton(
                      onPressed: () {
                        context.read<AddNewMemberBloc>().add(
                              AddNewMemberEvent.addNewMember(),
                            );
                      },
                      buttonText: isUpdateMember ? 'Update' : 'Add',
                    ),
                    SizedBox(height: getSize(isUpdateMember ? 20 : 0)),
                    Visibility(
                      visible: isUpdateMember,
                      child: GestureDetector(
                        onTap: () {
                          AcceptRejectDialog(
                            title: 'Delete Team Member',
                            description:
                                'Are you sure you want to delete the team memeber?',
                            onPressedAccept: () {},
                            onPressedReject: () {
                              context.router.maybePop();
                            },
                            acceptButtonText: 'Delete',
                          ).acceptRejectDialog(context);
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SvgPicture.asset(
                              SvgImageConstant.delete,
                              colorFilter: ColorFilter.mode(
                                AppColors.redAccent,
                                BlendMode.srcATop,
                              ),
                            ),
                            SizedBox(width: getSize(5)),
                            BaseText(
                              text: 'Delete Team Member',
                              fontSize: 12,
                              textColor: AppColors.redAccent,
                              fontWeight: FontWeight.w600,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  memberDetail({
    required String title,
    required String image,
    required String value,
    required Function(String)? onChanged,
    required String? Function(String?, BuildContext)? validator,
    TextInputType? keyboardType,
    TextCapitalization? textCapitalization,
  }) {
    return BlocBuilder<AddNewMemberBloc, AddNewMemberState>(
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: getSize(20)),
            BaseText(
              text: title,
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
            SizedBox(height: getSize(8)),
            CustomTextField(
              prefixIcon: title == 'Phone Number'
                  ? CommonCountryCodePicker(
                      initialSelection: state.selectedCountryFlag,
                      onChanged: (countryCode) {
                        context.read<AddNewMemberBloc>().add(
                              AddNewMemberEvent.changeCountryCode(
                                countryCode.phoneCode,
                                countryCode.flagEmoji,
                              ),
                            );
                      },
                    )
                  : Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: getSize(10),
                        vertical: getSize(14),
                      ),
                      child: SvgPicture.asset(
                        image,
                        //   color: AppColors.black.withOpacity(0.5),
                      ),
                    ),
              onChanged: onChanged,
              validator: validator,
              keyboardType: keyboardType,
              textCapitalization: textCapitalization ?? TextCapitalization.none,
              hintText: value,
            ),
          ],
        );
      },
    );
  }
}
