// ignore_for_file: use_build_context_synchronously, avoid_print, deprecated_member_use, prefer_const_constructors_in_immutables, non_constant_identifier_names, prefer_const_literals_to_create_immutables

import 'dart:io';
import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shift/application/contractor/contractor_edit_profile_bloc/contractor_edit_profile_bloc.dart';
import 'package:shift/domain/core/math_utils.dart';
import 'package:shift/domain/core/png_image_constants.dart';
import 'package:shift/domain/core/string_constant.dart';
import 'package:shift/domain/core/svg_image_constants.dart';
import 'package:shift/injection.dart';
import 'package:shift/presentation/common/utils/app_focus.dart';
import 'package:shift/presentation/common/utils/get_cookie.dart';
import 'package:shift/presentation/common/utils/image_picker_utils.dart';
import 'package:shift/presentation/common/widgets/base_text.dart';
import 'package:shift/presentation/common/widgets/center_loading_indicator.dart';
import 'package:shift/presentation/common/widgets/image_chosser.dialog.dart';
import 'package:shift/presentation/core/style/app_colors.dart';
import 'package:shift/presentation/core/widgets/buttons/common_button.dart';
import 'package:shift/presentation/core/widgets/dialogs/location_dialog.dart';
import 'package:shift/presentation/core/widgets/inputs/custom_text_field.dart';
import 'package:shift/presentation/core/widgets/texts/common_texts.dart';
import 'package:shift/presentation/main/widgets/home_app_bar.dart';
import 'package:badges/badges.dart' as badges;

@RoutePage(name: 'ContractorEditProfile')
class ContractorEditProfile extends StatelessWidget {
  ContractorEditProfile({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(getSize(65)),
        child: CommonAppBar(
          onBackPressed: () {
            ContractorEditProfileBloc.locationCtrl.clear();

            context.router.maybePop();
          },
          title: StringConstant.editProfile,
        ),
      ),
      body: GestureDetector(
        onTap: () {
          AppFocus.unfocus(context);
        },
        child: BlocProvider(
          create: (context) => getIt<ContractorEditProfileBloc>()
            ..add(ContractorEditProfileEvent.getCurrentProfileDetail()),
          child: BlocConsumer<ContractorEditProfileBloc,
              ContractorEditProfileState>(
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
                              emailTextField(context, state),
                              paddingBetweenFields(),
                              addressField(context, state),
                              Padding(
                                padding:
                                    EdgeInsets.symmetric(vertical: getSize(50)),
                                child: CommonButton(
                                  isSubmitting: state.isSubmitting,
                                  onPressed: () {
                                    context
                                        .read<ContractorEditProfileBloc>()
                                        .add(ContractorEditProfileEvent
                                            .updateProfile(context));
                                  },
                                  buttonText: StringConstant.update,
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

  Widget profileImageSection(
      BuildContext context, ContractorEditProfileState state) {
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
                        context.read<ContractorEditProfileBloc>().add(
                              ContractorEditProfileEvent.changeProfilePic(path),
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
                      context.read<ContractorEditProfileBloc>().add(
                            ContractorEditProfileEvent.changeProfilePic(path),
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
              textColor: AppColors.black.withValues(alpha: 0.7),
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

  Widget emailTextField(
      BuildContext context, ContractorEditProfileState state) {
    return CustomTextField(
      initialValue: state.email.getValue(),
      labelText: StringConstant.email,
      isLabelPadding: true,
      hintText: StringConstant.email,
      keyboardType: TextInputType.emailAddress,
      maxLength: 340,
      prefixIcon: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: getSize(14),
          vertical: getSize(14),
        ),
        child: SvgPicture.asset(
          SvgImageConstant.email,
          height: getSize(24),
          width: getSize(24),
          color: AppColors.primaryColor,
        ),
      ),
      onChanged: (value) => context
          .read<ContractorEditProfileBloc>()
          .add(ContractorEditProfileEvent.emailChanged(value)),
      validator: (p0, p1) =>
          context.read<ContractorEditProfileBloc>().state.email.value.fold(
                (f) => f.maybeMap(
                  empty: (value) => StringConstant.pleaseEnterEmail,
                  invalidEmail: (_) => StringConstant.pleaseEnterValidEmail,
                  orElse: () => null,
                ),
                (_) => null,
              ),
    );
  }

  Widget firstNameField(
      BuildContext context, ContractorEditProfileState state) {
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
      onChanged: (value) => context
          .read<ContractorEditProfileBloc>()
          .add(ContractorEditProfileEvent.firstNameChanged(value)),
      validator: (_, context) =>
          context.read<ContractorEditProfileBloc>().state.firstName.value.fold(
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

  Widget lastNameField(BuildContext context, ContractorEditProfileState state) {
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
          .read<ContractorEditProfileBloc>()
          .add(ContractorEditProfileEvent.lastNameChanged(value)),
      validator: (_, context) =>
          context.read<ContractorEditProfileBloc>().state.lastName.value.fold(
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

  Widget addressField(BuildContext context, ContractorEditProfileState state) {
    return CustomTextField(
      labelText: StringConstant.address,
      isLabelPadding: true,
      hintText: StringConstant.address,
      readOnly: true,
      readOnlyTextStyle: Theme.of(context)
          .textTheme
          .bodyMedium!
          .copyWith(color: AppColors.black),
      onTap: () {
        LocationDialog.showLocationDialog(
          context,
          predictions: state.selectedLocationPrediction,
          location: ContractorEditProfileBloc.locationCtrl.text,
        ).then((value) {
          if (value != null) {
            print("selected location ---> $value");
            context.read<ContractorEditProfileBloc>().add(
                ContractorEditProfileEvent.locationSelectedFromSearchList(
                    value));
          }
        });
      },
      controller: ContractorEditProfileBloc.locationCtrl,
      prefixIcon: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: getSize(14),
          vertical: getSize(14),
        ),
        child: SvgPicture.asset(
          SvgImageConstant.locationIcon,
          height: getSize(24),
          width: getSize(24),
          color: AppColors.primaryColor,
        ),
      ),
      validator: (p0, p1) => context
          .read<ContractorEditProfileBloc>()
          .state
          .locationAddress
          .value
          .fold(
            (f) => f.maybeMap(
              empty: (value) => StringConstant.pleaseEnterAddress,
              orElse: () => null,
            ),
            (_) => null,
          ),
    );
  }
}
