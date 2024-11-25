import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shift/application/employer/profile/edit_profile/edit_profile_bloc.dart';
import 'package:shift/domain/core/math_utils.dart';
import 'package:shift/domain/core/png_image_constants.dart';
import 'package:shift/domain/core/string_constant.dart';
import 'package:shift/domain/core/svg_image_constants.dart';
import 'package:shift/injection.dart';
import 'package:shift/presentation/auth/register/verify_mobile_number.dart';
import 'package:shift/presentation/common/utils/flushbar_creator.dart';
import 'package:shift/presentation/common/utils/get_cookie.dart';
import 'package:shift/presentation/common/utils/image_picker_utils.dart';
import 'package:shift/presentation/common/widgets/base_text.dart';
import 'package:shift/presentation/common/widgets/common_country_code_picker.dart';
import 'package:shift/presentation/common/widgets/image_chosser.dialog.dart';
import 'package:shift/presentation/core/logger/logger.dart';
import 'package:shift/presentation/core/style/app_colors.dart';
import 'package:shift/presentation/core/widgets/buttons/common_button.dart';
import 'package:shift/presentation/core/widgets/inputs/custom_country_code_removing_formatter.dart';
import 'package:shift/presentation/core/widgets/inputs/custom_text_field.dart';
import 'package:shift/presentation/main/widgets/home_app_bar.dart';
import 'package:badges/badges.dart' as badges;

import '../../../common/utils/app_focus.dart';

@RoutePage(name: 'EditProfileView')
class EditProfileView extends StatefulWidget {
  const EditProfileView({super.key});

  @override
  State<EditProfileView> createState() => _EditProfileViewState();
}

class _EditProfileViewState extends State<EditProfileView> {
  late TextEditingController _firstNameController;
  late TextEditingController _lastNameController;
  late TextEditingController _companyNameController;
  late TextEditingController _phoneNumberController;
  late TextEditingController _associationController;
  late TextEditingController _companyDescriptionController;
  late TextEditingController _emailController;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();

    final user = getCurrentUser();
    _emailController = TextEditingController(text: user.email);
    _firstNameController = TextEditingController(text: user.firstName);
    _lastNameController = TextEditingController(text: user.lastName);
    _companyNameController = TextEditingController(text: user.companyName);
    _phoneNumberController = TextEditingController(text: user.phone.toString());
    _associationController = TextEditingController(text: user.association);
    _companyDescriptionController = TextEditingController(text: user.companyDescription);
  }

  @override
  Widget build(BuildContext context) {
    final user = getCurrentUser();
    Log.success(user);

    return BlocProvider(
      create: (context) => getIt<EditProfileBloc>(),
      child: BlocListener<EditProfileBloc, EditProfileState>(
        listener: (context, state) {
          state.editProfileFailureOrSuccessOption.fold(
            () {},
            (either) => either.fold(
              (failure) {
                showError(
                  message: failure.maybeMap(
                    showAPIResponseMessage: (value) => value.message,
                    networkError: (value) => 'Please check your internet connectivity',
                    orElse: () => "Server Error. Try again later.",
                  ),
                ).show(context);
                AppFocus.unfocus(context);
              },
              (r) {
                final user = getCurrentUser();
                var phone = user.phone.toString() == _phoneNumberController.text.trim();
                var email = user.email.toString() == _emailController.text.trim();
                AppFocus.unfocus(context);

                // if (getCurrentRole() == 1 && phone) {
                //   return;
                // } else if (getCurrentRole() == 2 && email) {
                //   return;
                // }
                  Log.debug("==>${_phoneNumberController.text}");
                  Log.debug(user.phone);
                VerifyPhoneNumber().getVerifyPhoneNoBottomSheet(
                    context,
                    (getCurrentRole() == 1) ? _phoneNumberController.text.trim() : _emailController.text.trim(),
                    "+${state.selectedCountrycode.isEmpty ? user.countryCode : state.selectedCountrycode}",
                    "${state.selectedCountryFlag.isEmpty ? user.countryNameCode : state.selectedCountrycode}",
                    "");
              },
            ),
          );
        },
        child: Scaffold(
          appBar: CommonAppBar(
            onBackPressed: () => Navigator.pop(context),
            title: "All ShiftPros",
          ),
          body: BlocBuilder<EditProfileBloc, EditProfileState>(
            builder: (context, state) {
              return Form(
                key: _formKey,
                child: ListView(
                  padding: EdgeInsets.all(20),
                  children: [
                    Stack(
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
                                    String path =
                                        await ImagePickerUtils().pickImage(imageSource: ImageSource.camera, context: context) ?? '';
                                    if (path.isNotEmpty) {
                                      print("CAMERA IMAGE PATH: $path");
                                      context.read<EditProfileBloc>().add(
                                            EditProfileEvent.changeProfilePic(path),
                                          );
                                    }
                                  },
                                  selectPhotoCallback: () async {
                                    String path =
                                        await ImagePickerUtils().pickImage(imageSource: ImageSource.gallery, context: context) ?? '';

                                    if (path.isNotEmpty) {
                                      print("GALLERY IMAGE PATH: $path");
                                      context.read<EditProfileBloc>().add(
                                            EditProfileEvent.changeProfilePic(path),
                                          );
                                    }
                                  },
                                  context: context,
                                );
                                //           ),
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
                                      badgeColor: AppColors.white, borderSide: BorderSide(color: AppColors.primaryColor, width: 0.4)),
                                  child: Container(
                                    height: getSize(100),
                                    width: getSize(100),
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                      color: AppColors.white,
                                      shape: BoxShape.circle,
                                      image: state.selectedImage.isNotEmpty
                                          ? DecorationImage(
                                              fit: BoxFit.cover,
                                              image: FileImage(
                                                File(state.selectedImage),
                                              ),
                                            )
                                          : user.profileImage != null
                                              ? DecorationImage(
                                                  image: CachedNetworkImageProvider(user.profileImage ?? ""),
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
                            Gap(getSize(8)),
                            BaseText(
                              text: (getCurrentRole() == 1) ? StringConstant.profilePhoto : StringConstant.companyLogo,
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              textColor: AppColors.black.withOpacity(0.7),
                            ),
                            // if (state.showErrorMessages && state.selectImage.isEmpty) commonErrorText("* Please select profile photo"),
                          ],
                        ),
                      ],
                    ),
                    CustomTextField(
                      textInputAction: TextInputAction.next,
                      autoValidateMode: AutovalidateMode.onUserInteraction,
                      controller: _firstNameController,
                      hintText: StringConstant.firstName,
                      labelText: StringConstant.firstName,
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
                      onChanged: (value) => context.read<EditProfileBloc>().add(EditProfileEvent.firstNameChanged(value)),
                      validator: (value, context) {
                        // empty: (value) => StringConstant.pleaseEnterYourFirstName,
                        // invalidUsername: (value) => StringConstant.pleaseEnterYourValidFirstName,
                        if (value == null || value.isEmpty) {
                          return StringConstant.pleaseEnterYourFirstName;
                        } else if (value.length <= 2 || value.length >= 32) {
                          return StringConstant.pleaseEnterYourValidFirstName;
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: getSize(10)),
                    CustomTextField(
                      textInputAction: TextInputAction.next,
                      autoValidateMode: AutovalidateMode.onUserInteraction,
                      controller: _lastNameController,
                      hintText: StringConstant.lastName,
                      labelText: StringConstant.lastName,
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
                      onChanged: (value) => context.read<EditProfileBloc>().add(EditProfileEvent.lastNameChanged(value)),
                      // validator: (_, context) => context.read<EditProfileBloc>().state.lastName.value.fold(
                      //       (f) => f.maybeMap(
                      //         empty: (value) => StringConstant.pleaseEnterYourLastName,
                      //         invalidUsername: (value) => StringConstant.pleaseEnterYourValidLastName,
                      //         orElse: () => null,
                      //       ),
                      //       (_) => null,
                      //     ),
                      validator: (value, context) {
                        if (value == null || value.isEmpty) {
                          return StringConstant.pleaseEnterYourLastName;
                        } else if (value.length >= 32) {
                          return StringConstant.pleaseEnterYourValidLastName;
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: getSize(10)),
                    CustomTextField(
                      textInputAction: TextInputAction.next,
                      autoValidateMode: AutovalidateMode.onUserInteraction,
                      controller: _companyNameController,
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
                      onChanged: (value) => context.read<EditProfileBloc>().add(EditProfileEvent.companyNameChanged(value)),
                      // validator: (p0, p1) => context.read<EditProfileBloc>().state.companyName.value.fold(
                      //       (f) => f.maybeMap(
                      //         empty: (value) => StringConstant.pleaseEnterCompanyName,
                      //         orElse: () => null,
                      //       ),
                      //       (_) => null,
                      //     ),
                      validator: (p0, p1) {
                        if (p0 == null || p0.isEmpty) {
                          return StringConstant.pleaseEnterCompanyName;
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: getSize(10)),
                    CustomTextField(
                      textInputAction: TextInputAction.next,
                      autoValidateMode: AutovalidateMode.onUserInteraction,
                      controller: _phoneNumberController,
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
                      // validator: (_, context) => context.read<EditProfileBloc>().state.phoneNumber.value.fold(
                      //       (f) => f.maybeMap(
                      //         empty: (value) => StringConstant.pleaseEnterMobileNumber,
                      //         invalidMobileNumber: (_) => StringConstant.phoneNumberShouldBeBetween10And15Digits,
                      //         orElse: () => null,
                      //       ),
                      //       (_) => null,
                      //     ),

                      validator: (value, context) {
                        if (value == null || value.isEmpty) {
                          return StringConstant.pleaseEnterMobileNumber;
                        } else if (value.length < 10) {
                          return StringConstant.phoneNumberShouldBeBetween10And15Digits;
                        }
                        return null;
                      },
                      prefixIcon: CommonCountryCodePicker(
                        initialSelection: state.selectedCountryFlag.isEmpty ? user.countryNameCode : state.selectedCountryFlag,
                        onChanged: (countryCode) {
                          print("===> ${user.countryNameCode}");
                          print("===> ${state.selectedCountryFlag}");
                          context.read<EditProfileBloc>().add(
                                EditProfileEvent.selectCountryCode(
                                  countryCode.phoneCode,
                                  countryCode.flagEmoji,
                                ),
                              );
                        },
                      ),
                    ),
                    SizedBox(height: getSize(10)),
                    CustomTextField(
                      textInputAction: TextInputAction.next,
                      autoValidateMode: AutovalidateMode.onUserInteraction,
                      controller: _associationController,
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
                      onChanged: (value) => context.read<EditProfileBloc>().add(EditProfileEvent.associationTextChanged(value)),
                    ),
                    SizedBox(height: getSize(10)),
                    CustomTextField(
                      textInputAction: TextInputAction.next,
                      autoValidateMode: AutovalidateMode.onUserInteraction,
                      controller: _companyDescriptionController,
                      labelText: StringConstant.companyDescription,
                      hintText: StringConstant.typeHere,
                      isLabelPadding: true,
                      isOptional: true,
                      maxLines: 4,
                      keyboardType: TextInputType.multiline,
                      onChanged: (value) => context.read<EditProfileBloc>().add(EditProfileEvent.companyDescChanged(value)),
                    ),
                    SizedBox(height: getSize(25)),
                    BlocSelector<EditProfileBloc, EditProfileState, bool>(
                      selector: (state) => state.isSubmitting,
                      builder: (context, isSubmitting) {
                        return CommonButton(
                          isSubmitting: isSubmitting,
                          onPressed: () {
                            if (!_formKey.currentState!.validate()) {
                              showError(message: StringConstant.someDetailsAreMissingOrInvalidPleaseCheck).show(context);
                              return;
                            }

                            final number = _phoneNumberController.text.trim();
                            final firstName = _firstNameController.text.trim();
                            final lastName = _lastNameController.text.trim();
                            final companyName = _companyNameController.text.trim();
                            final association = _associationController.text.trim();
                            final companyDescription = _companyDescriptionController.text.trim();

                            context.read<EditProfileBloc>().add(
                                  EditProfileEvent.updateProfile(
                                    phoneNumber: number,
                                    companyDescription: companyDescription,
                                    association: association,
                                    companyName: companyName,
                                    firstName: firstName,
                                    lastName: lastName,
                                  ),
                                );
                          },
                          buttonText: "Update",
                        );
                      },
                    )
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
