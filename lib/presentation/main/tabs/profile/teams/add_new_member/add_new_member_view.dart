import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shift/application/main_tab/profile/profile_sections/teams/add_new_member/add_new_member_bloc.dart';
import 'package:shift/domain/core/math_utils.dart';
import 'package:shift/domain/core/string_constant.dart';
import 'package:shift/domain/core/svg_image_constants.dart';
import 'package:shift/infrastructure/main/employer_team/get_teams_dto.dart';
import 'package:shift/injection.dart';
import 'package:shift/presentation/common/utils/flushbar_creator.dart';
import 'package:shift/presentation/common/widgets/base_text.dart';
import 'package:shift/presentation/common/widgets/common_country_code_picker.dart';
import 'package:shift/presentation/core/style/app_colors.dart';
import 'package:shift/presentation/core/widgets/buttons/common_button.dart';
import 'package:shift/presentation/core/widgets/inputs/custom_country_code_removing_formatter.dart';
import 'package:shift/presentation/core/widgets/inputs/custom_text_field.dart';
import 'package:shift/presentation/main/tabs/home/view_single_applicants/widgets/accept_reject_dialog.dart';
import 'package:shift/presentation/main/widgets/home_app_bar.dart';

@RoutePage(name: 'AddNewMemberView')
class AddNewMemberView extends StatelessWidget {
  final bool isUpdateMember;
  final String teamID;
  final Members? getTeamsListDTO;
  const AddNewMemberView(
      {super.key,
      this.isUpdateMember = false,
      required this.getTeamsListDTO,
      required this.teamID});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<AddNewMemberBloc>()
        ..add(AddNewMemberEvent.setTeamID(teamID))
        ..add(
          AddNewMemberEvent.prefillDataForUpdateTeamMember(
            getTeamsListDTO ?? Members(),
            isUpdateMember,
          ),
        ),
      child: BlocConsumer<AddNewMemberBloc, AddNewMemberState>(
        listener: (context, state) {
          state.failureOrSuccessOption.fold(
            () {},
            (either) => either.fold(
              (failure) {
                showError(
                  message: failure.maybeMap(
                    showAPIResponseMessage: (value) => value.message,
                    networkError: (value) =>
                        'Please check your internet connectivity',
                    orElse: () => "Server Error. Try again later.",
                  ),
                ).show(context);
              },
              (r) {
                if (r.isNotEmpty) {
                  showSuccess(message: r).show(context).then(
                        (value) => context.router.maybePop(true),
                      );
                } else {
                  context.router.maybePop(true);
                }
              },
            ),
          );
        },
        builder: (context, state) {
          return Scaffold(
            appBar: CommonAppBar(
              onBackPressed: () => context.router.maybePop(),
              title: isUpdateMember
                  ? StringConstant.editMembersDetails
                  : StringConstant.addNewTeamMember,
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
                      title: StringConstant.memberName,
                      image: SvgImageConstant.person,
                      prefillValue: state.teamNameTextField.getValue() ?? "",
                      textCapitalization: TextCapitalization.words,
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(
                            RegExp(r'[a-zA-Z\s]')),
                      ],
                      value: StringConstant.memberName,
                      onChanged: (value) {
                        context.read<AddNewMemberBloc>().add(
                              AddNewMemberEvent.changeTeamMemberName(value),
                            );
                      },
                      validator: (p0, p1) => state.teamNameTextField.value.fold(
                        (l) => l.maybeMap(
                          empty: (value) => 'Please add team member name',
                          orElse: () => null,
                        ),
                        (r) => null,
                      ),
                    ),
                    memberDetail(
                      title: StringConstant.jobPosition,
                      image: SvgImageConstant.bag,
                      prefillValue: state.jobPositionTextField.getValue(),
                      value: StringConstant.jobPosition,
                      onChanged: (value) {
                        context.read<AddNewMemberBloc>().add(
                              AddNewMemberEvent.jobLocationChange(value),
                            );
                      },
                      validator: (p0, p1) =>
                          state.jobPositionTextField.value.fold(
                        (l) => l.maybeMap(
                          empty: (value) => 'Please enter job positon',
                          orElse: () => null,
                        ),
                        (r) => null,
                      ),
                    ),
                    memberDetail(
                      title: StringConstant.phoneNumber,
                      image: SvgImageConstant.call,
                      prefillValue: state.mobileNumber.getValue(),
                      maxLength: 10,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                        CountryCodeRemovingFormatter(),
                      ],
                      value: StringConstant.phoneNumber,
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
                      title: StringConstant.e_mail,
                      image: SvgImageConstant.email,
                      value: StringConstant.e_mail,
                      prefillValue: state.emailAddress.getValue(),
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
                      isSubmitting: state.isSubmitting,
                      onPressed: () {
                        if (state.isEdit) {
                          context.read<AddNewMemberBloc>().add(
                                AddNewMemberEvent.updateTeamMember(
                                  getTeamsListDTO?.id?.toString() ?? "",
                                ),
                              );
                        } else {
                          context.read<AddNewMemberBloc>().add(
                                AddNewMemberEvent.addNewMember(),
                              );
                        }
                      },
                      buttonText: isUpdateMember
                          ? StringConstant.update
                          : StringConstant.add,
                    ),
                    SizedBox(height: getSize(isUpdateMember ? 20 : 0)),
                    Visibility(
                      visible: isUpdateMember,
                      child: GestureDetector(
                        onTap: () {
                          AcceptRejectDialog(
                            title: StringConstant.deleteTeamMember,
                            description:
                                'Are you sure you want to delete the team memeber?',
                            onPressedAccept: () {
                              context.router.maybePop(true).then(
                                    (value) => context
                                        .read<AddNewMemberBloc>()
                                        .add(
                                          AddNewMemberEvent.deleteTeamMember(
                                            getTeamsListDTO?.id?.toString() ??
                                                "",
                                          ),
                                        ),
                                  );
                            },
                            onPressedReject: () {
                              context.router.maybePop(true);
                            },
                            acceptButtonText: StringConstant.delete,
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
                              text: StringConstant.deleteTeamMember,
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
    String? prefillValue,
    int? maxLength,
    List<TextInputFormatter>? inputFormatters,
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
              key: state.isEdit ? Key(title) : null,
              initialValue: state.isEdit ? prefillValue : null,
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
                      ),
                    ),
              onChanged: onChanged,
              validator: validator,
              keyboardType: keyboardType,
              textCapitalization: textCapitalization ?? TextCapitalization.none,
              inputFormatters: inputFormatters,
              maxLength: maxLength,
              hintText: value,
            ),
          ],
        );
      },
    );
  }
}
