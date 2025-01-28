// ignore_for_file: use_build_context_synchronously, avoid_print, deprecated_member_use, prefer_const_constructors_in_immutables, non_constant_identifier_names, prefer_const_literals_to_create_immutables

import 'dart:io';
import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shift/application/auth/register_form/register_form_bloc.dart';
import 'package:shift/application/employer/profile/edit_profile/edit_profile_bloc.dart';
import 'package:shift/domain/core/math_utils.dart';
import 'package:shift/domain/core/png_image_constants.dart';
import 'package:shift/domain/core/string_constant.dart';
import 'package:shift/domain/core/svg_image_constants.dart';
import 'package:shift/injection.dart';
import 'package:shift/presentation/auth/register/verify_mobile_number.dart';
import 'package:shift/presentation/common/utils/app_focus.dart';
import 'package:shift/presentation/common/utils/flushbar_creator.dart';
import 'package:shift/presentation/common/utils/get_cookie.dart';
import 'package:shift/presentation/common/utils/image_picker_utils.dart';
import 'package:shift/presentation/common/widgets/base_text.dart';
import 'package:shift/presentation/common/widgets/center_loading_indicator.dart';
import 'package:shift/presentation/common/widgets/common_country_code_picker.dart';
import 'package:shift/presentation/common/widgets/image_chosser.dialog.dart';
import 'package:shift/presentation/core/style/app_colors.dart';
import 'package:shift/presentation/core/widgets/buttons/common_button.dart';
import 'package:shift/presentation/core/widgets/dialogs/location_dialog.dart';
import 'package:shift/presentation/core/widgets/inputs/custom_country_code_removing_formatter.dart';
import 'package:shift/presentation/core/widgets/inputs/custom_text_field.dart';
import 'package:shift/presentation/core/widgets/texts/common_texts.dart';
import 'package:shift/presentation/main/widgets/home_app_bar.dart';
import 'package:badges/badges.dart' as badges;

@RoutePage(name: 'EditProfileView')
class EditProfileView extends StatelessWidget {
  EditProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(getSize(65)),
        child: CommonAppBar(
          onBackPressed: () {
            context.router.maybePop();
          },
          title: StringConstant.companyDetails,
        ),
      ),
      body: GestureDetector(
        onTap: () {
          AppFocus.unfocus(context);
        },
        child: BlocProvider(
          create: (context) => getIt<EditProfileBloc>()
            ..add(EditProfileEvent.getCurrentProfileDetail()),
          child: BlocConsumer<EditProfileBloc, EditProfileState>(
            listener: (context, state) {},
            builder: (context, state) {
              return (state.isLoading)
                  ? CenterLoadingIndicator(isOnlyLoader: true)
                  : Padding(
                      padding: EdgeInsets.symmetric(horizontal: getSize(20)),
                      child: Form(
                        autovalidateMode: (state.showErrorMessages)
                            ? AutovalidateMode.always
                            : AutovalidateMode.disabled,
                        child: SingleChildScrollView(
                          physics: const BouncingScrollPhysics(),
                          child: Column(
                            children: [
                              profileImageSection(context, state),
                              paddingBetweenFields(),
                              firstNameField(context, state),
                              paddingBetweenFields(),
                              lastNameField(context, state),
                              paddingBetweenFields(),
                              companyNameTextField(context, state),
                              paddingBetweenFields(),
                              phoneNumberTextField(context, state),
                              paddingBetweenFields(),
                              associationTextField(context, state),
                              paddingBetweenFields(),
                              companyDescTextField(context, state),
                              Padding(
                                padding:
                                    EdgeInsets.symmetric(vertical: getSize(50)),
                                child: CommonButton(
                                  isSubmitting: state.isSubmitting,
                                  onPressed: () {
                                    context.read<EditProfileBloc>().add(
                                        EditProfileEvent.updateProfile(
                                            context));
                                  },
                                  buttonText: StringConstant.register,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
            },
          ),
        ),
      ),
    );
  }

  Widget profileImageSection(BuildContext context, EditProfileState state) {
    return Stack(
      alignment: AlignmentDirectional.center,
      clipBehavior: Clip.none,
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.min,
          children: [
            GestureDetector(
              onTap: () {
                ImageChooserDialog().showImageChooserDialog(
                  takePhotoCallback: () async {
                    try {
                      String path = await ImagePickerUtils().pickImage(
                              imageSource: ImageSource.camera,
                              context: context) ??
                          '';
                      if (path.isNotEmpty) {
                        print("CAMERA IMAGE PATH: $path");
                        context.read<EditProfileBloc>().add(
                              EditProfileEvent.changeProfilePic(path),
                            );
                      }
                    } catch (e) {
                      print("Camera picker catch errorr---> $e");
                    }
                  },
                  selectPhotoCallback: () async {
                    String path = await ImagePickerUtils().pickImage(
                            imageSource: ImageSource.gallery,
                            context: context) ??
                        '';

                    if (path.isNotEmpty) {
                      print("GALLERY IMAGE PATH: $path");
                      context.read<EditProfileBloc>().add(
                            EditProfileEvent.changeProfilePic(path),
                          );
                    }
                  },
                  context: context,
                );
              },
              child: Center(
                child: badges.Badge(
                  position: badges.BadgePosition.bottomEnd(
                    bottom: getSize(2),
                    end: getSize(5),
                  ),
                  badgeContent: SvgPicture.asset(
                    SvgImageConstant.camera,
                    height: getSize(15),
                    width: getSize(15),
                  ),
                  badgeStyle: badges.BadgeStyle(
                      badgeColor: AppColors.white,
                      borderSide: BorderSide(
                          color: AppColors.primaryColor, width: 0.4)),
                  child: Container(
                    height: getSize(100),
                    width: getSize(100),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: AppColors.white,
                      shape: BoxShape.circle,
                      image: state.selectImage.isNotEmpty
                          ? state.selectImage.contains('https')
                              ? DecorationImage(
                                  image: CachedNetworkImageProvider(
                                      state.selectImage),
                                  fit: BoxFit.cover,
                                )
                              : DecorationImage(
                                  image: FileImage(
                                    File(state.selectImage),
                                  ),
                                  fit: BoxFit.cover,
                                )
                          : DecorationImage(
                              image: AssetImage(
                                (getCurrentRole() == 1)
                                    ? PngImageConstants.contractor_employer
                                    : PngImageConstants.profile_employer,
                              ),
                            ),
                      border: Border.all(
                        color: AppColors.darkGreen,
                        width: getSize(2),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            paddingBetweenFields(height: getSize(8)),
            BaseText(
              text: (getCurrentRole() == 1)
                  ? StringConstant.profilePhoto
                  : StringConstant.companyLogo,
              fontSize: 12,
              fontWeight: FontWeight.w500,
              textColor: AppColors.black.withOpacity(0.7),
            ),
            if (state.showErrorMessages && state.selectImage.isEmpty)
              commonErrorText("* Please select profile photo"),
          ],
        ),
      ],
    );
  }

  Widget paddingBetweenFields({double? height}) {
    return SizedBox(
      height: height ?? getSize(15),
    );
  }

  Widget firstNameField(BuildContext context, EditProfileState state) {
    return CustomTextField(
      hintText: StringConstant.firstName,
      labelText: StringConstant.firstName,
      initialValue: state.firstName.getValue(),
      textCapitalization: TextCapitalization.words,
      errorMaxLines: 2,
      inputFormatters: [
        FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z\s]')),
      ],
      prefixIcon: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: getSize(14),
          vertical: getSize(14),
        ),
        child: SvgPicture.asset(
          SvgImageConstant.person,
          height: getSize(24),
          width: getSize(24),
        ),
      ),
      // focusNode: state.firstNameFocusNode,
      onChanged: (value) => context
          .read<EditProfileBloc>()
          .add(EditProfileEvent.firstNameChanged(value)),
      validator: (_, context) =>
          context.read<EditProfileBloc>().state.firstName.value.fold(
                (f) => f.maybeMap(
                  empty: (value) => StringConstant.pleaseEnterYourFirstName,
                  invalidUsername: (value) =>
                      StringConstant.pleaseEnterYourValidFirstName,
                  orElse: () => null,
                ),
                (_) => null,
              ),
    );
  }

  Widget lastNameField(BuildContext context, EditProfileState state) {
    return CustomTextField(
      hintText: StringConstant.lastName,
      labelText: StringConstant.lastName,
      initialValue: state.lastName.getValue(),
      errorMaxLines: 2,
      textCapitalization: TextCapitalization.words,
      inputFormatters: [
        FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z\s]')),
      ],
      prefixIcon: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: getSize(14),
          vertical: getSize(14),
        ),
        child: SvgPicture.asset(
          SvgImageConstant.person,
          height: getSize(24),
          width: getSize(24),
        ),
      ),
      onChanged: (value) => context
          .read<EditProfileBloc>()
          .add(EditProfileEvent.lastNameChanged(value)),
      validator: (_, context) =>
          context.read<EditProfileBloc>().state.lastName.value.fold(
                (f) => f.maybeMap(
                  empty: (value) => StringConstant.pleaseEnterYourLastName,
                  invalidUsername: (value) =>
                      StringConstant.pleaseEnterYourValidLastName,
                  orElse: () => null,
                ),
                (_) => null,
              ),
    );
  }

  Widget companyNameTextField(BuildContext context, EditProfileState state) {
    return CustomTextField(
      initialValue: state.companyName.getValue(),
      labelText: StringConstant.companyName,
      isLabelPadding: true,
      hintText: StringConstant.companyName,
      textCapitalization: TextCapitalization.words,
      errorMaxLines: 2,
      prefixIcon: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: getSize(14),
          vertical: getSize(14),
        ),
        child: SvgPicture.asset(
          SvgImageConstant.building,
          height: getSize(24),
          width: getSize(24),
        ),
      ),
      onChanged: (value) => context
          .read<EditProfileBloc>()
          .add(EditProfileEvent.companyNameChanged(value)),
      validator: (p0, p1) =>
          context.read<EditProfileBloc>().state.companyName.value.fold(
                (f) => f.maybeMap(
                  empty: (value) => StringConstant.pleaseEnterCompanyName,
                  orElse: () => null,
                ),
                (_) => null,
              ),
    );
  }

  Widget phoneNumberTextField(BuildContext context, EditProfileState state) {
    return CustomTextField(
      initialValue: state.phoneNumber.getValue(),
      labelText: StringConstant.phoneNumber,
      hintText: StringConstant.phoneNumber,
      keyboardType: TextInputType.phone,
      isLabelPadding: true,
      maxLength: 10,
      errorMaxLines: 2,
      inputFormatters: [
        FilteringTextInputFormatter.digitsOnly,
        CountryCodeRemovingFormatter(),
      ],
      onChanged: (value) {
        print("Filter Phone number --> $value");
        context.read<EditProfileBloc>().add(
              EditProfileEvent.phoneNumberChanged(value),
            );
      },
      validator: (_, context) =>
          context.read<EditProfileBloc>().state.phoneNumber.value.fold(
                (f) => f.maybeMap(
                  empty: (value) => StringConstant.pleaseEnterMobileNumber,
                  invalidMobileNumber: (_) =>
                      StringConstant.phoneNumberShouldBeBetween10And15Digits,
                  orElse: () => null,
                ),
                (_) => null,
              ),
      prefixIcon: CommonCountryCodePicker(
        initialSelection: state.selectedCountryFlag,
        onChanged: (countryCode) {
          print(countryCode.flagEmoji);
          context.read<EditProfileBloc>().add(
                EditProfileEvent.selectCountryCode(
                  countryCode.phoneCode,
                  countryCode.flagEmoji,
                ),
              );
        },
      ),
    );
  }

  Widget associationTextField(BuildContext context, EditProfileState state) {
    return CustomTextField(
      initialValue: state.association,
      labelText: StringConstant.associationYouBelongTo,
      isLabelPadding: true,
      isOptional: true,
      hintText: StringConstant.association,
      prefixIcon: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: getSize(14),
          vertical: getSize(14),
        ),
        child: SvgPicture.asset(
          SvgImageConstant.association,
          height: getSize(24),
          width: getSize(24),
        ),
      ),
      onChanged: (value) => context
          .read<EditProfileBloc>()
          .add(EditProfileEvent.associationTextChanged(value)),
    );
  }

  Widget companyDescTextField(BuildContext context, EditProfileState state) {
    return CustomTextField(
      initialValue: state.companyDescription,
      labelText: StringConstant.companyDescription,
      hintText: StringConstant.typeHere,
      isLabelPadding: true,
      isOptional: true,
      maxLines: 4,
      keyboardType: TextInputType.multiline,
      onChanged: (value) => context
          .read<EditProfileBloc>()
          .add(EditProfileEvent.companyDescChanged(value)),
    );
  }
}
