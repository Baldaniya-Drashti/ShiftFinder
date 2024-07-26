// ignore_for_file: prefer_const_constructors, avoid_print, use_build_context_synchronously

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shift/application/auth/contractor_auth/document_bloc/document_bloc.dart';
import 'package:shift/domain/core/document_expiry_picker.dart';
import 'package:shift/domain/core/math_utils.dart';
import 'package:shift/domain/core/string_constant.dart';
import 'package:shift/domain/core/svg_image_constants.dart';
import 'package:shift/infrastructure/core/document_dto/document_dto.dart';
import 'package:shift/injection.dart';
import 'package:shift/presentation/common/utils/file_picker_utils.dart';
import 'package:shift/presentation/common/utils/flushbar_creator.dart';
import 'package:shift/presentation/common/utils/image_picker_utils.dart';
import 'package:shift/presentation/common/widgets/base_text.dart';
import 'package:shift/presentation/common/widgets/center_loading_indicator.dart';
import 'package:shift/presentation/common/widgets/image_chosser.dialog.dart';
import 'package:shift/presentation/common/widgets/selected_document_box.dart';
import 'package:shift/presentation/common/widgets/show_picked_file.dart';
import 'package:shift/presentation/common/widgets/upload_document_box.dart';
import 'package:shift/presentation/core/style/app_colors.dart';
import 'package:shift/presentation/core/widgets/buttons/common_button.dart';
import 'package:shift/presentation/core/widgets/dialogs/app_dialog.dart';
import 'package:shift/presentation/core/widgets/inputs/custom_dropdown_with_textfield.dart';
import 'package:shift/presentation/core/widgets/inputs/custom_text_field.dart';

class ProfessionalLicenses extends StatelessWidget {
  const ProfessionalLicenses({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<ProfessionalLicensesBloc>()
        ..add(ProfessionalLicensesEvent.getProfessinalLicensesList()),
      child: BlocConsumer<ProfessionalLicensesBloc, ProfessionalLicensesState>(
        listener: (context, state) {
          state.licensesDocAuthFailureOrSuccessOption.fold(
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
              (r) {},
            ),
          );
        },
        builder: (context, state) {
          return (state.isLicensesDocSubmitting)
              ? CenterLoadingIndicator()
              : Padding(
                  padding: EdgeInsets.symmetric(horizontal: getSize(20)),
                  child: SingleChildScrollView(
                    child: Form(
                      autovalidateMode: (state.showLicensesErrorMessages)
                          ? AutovalidateMode.always
                          : AutovalidateMode.disabled,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          (state.professionalLicensesList.isNotEmpty)
                              ? ListView.builder(
                                  itemCount:
                                      state.professionalLicensesList.length,
                                  shrinkWrap: true,
                                  physics: NeverScrollableScrollPhysics(),
                                  itemBuilder: (context, index) {
                                    DocumentDTO licensesObject =
                                        state.professionalLicensesList[index];
                                    return Padding(
                                      padding:
                                          EdgeInsets.only(top: getSize(10)),
                                      child: SelectedDocumentBox(
                                        // leadingImage: Image.file(File(
                                        //     licensesObject.credentialDocument ?? "")),
                                        pickedFile: licensesObject.file,
                                        title:
                                            licensesObject.document_title ?? "",
                                        subTitle1: licensesObject
                                                .province_of_registration ??
                                            "",
                                        subTitle2: licensesObject
                                                .registration_number ??
                                            "",
                                        showDeleteButton: true,
                                        deleteDescription: StringConstant
                                            .deleteProfessionalLicenseDesc,
                                        onCancelClick: () {
                                          context.router.maybePop();
                                        },
                                        onDeleteClick: () {
                                          context
                                              .read<ProfessionalLicensesBloc>()
                                              .add(ProfessionalLicensesEvent
                                                  .deleteLicensesObject(index));
                                          context.router.maybePop();
                                        },
                                      ),
                                    );
                                  })
                              : SelectedDocumentBox(
                                  leadingImageString:
                                      SvgImageConstant.documentWithVerticalLine,
                                  title: "",
                                  subTitle1:
                                      StringConstant.professionalLicensesDesc,
                                  showDeleteButton: false,
                                ),
                          SizedBox(
                            height: getSize(20),
                          ),
                          registrationNoField(context),
                          paddingBetweenFields(),
                          provinceRegistrationDropdown(context, state),
                          paddingBetweenFields(),
                          documentTitleField(context),
                          paddingBetweenFields(),
                          (state.professionalLicensesDoc.isValid())
                              ? selectedImage(
                                  context,
                                  state.professionalLicensesDoc.getValue() ??
                                      "",
                                  state: state,
                                )
                              : UploadDocumentBox(
                                  height: getSize(300),
                                  onUploadBtnPressed: () {
                                    clickUploadButton(context);
                                  },
                                ),
                          if (state.showLicensesErrorMessages &&
                              !state.professionalLicensesDoc.isValid())
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: getSize(10),
                                  horizontal: getSize(20)),
                              child: BaseText(
                                text: StringConstant
                                    .pleaseSelectProfessionalLicensesDocument,
                                fontSize: 12,
                                textColor: AppColors.red,
                              ),
                            ),
                          paddingBetweenFields(),
                          DocumentExpiryDatePicker()
                              .notApplicableExpiryCheckBox(
                            context,
                            value: state.isLicensesExpiryCheck,
                            isDisabled: (state.licensesExpiryDate.isNotEmpty),
                            onChanged: (value) {
                              if (value != null) {
                                context.read<ProfessionalLicensesBloc>().add(
                                    ProfessionalLicensesEvent
                                        .checkNALicensesExpiryDate(value));
                              }
                            },
                          ),
                          DocumentExpiryDatePicker.expiryDateTextField(
                            context,
                            onPickedDate: (pickedDate) {
                              context.read<ProfessionalLicensesBloc>().add(
                                  ProfessionalLicensesEvent
                                      .licensesExpiryDateChanged(
                                          pickedDate.toString()));
                            },
                            selectedDate: state.licensesExpiryDate,
                            isDisabled: !state.isLicensesExpiryCheck,
                          ),
                          paddingBetweenFields(height: 5),
                          if ((!state.isLicensesExpiryCheck &&
                                  state.licensesExpiryDate.isEmpty) &&
                              state.showLicensesErrorMessages)
                            Padding(
                              padding:
                                  EdgeInsets.symmetric(horizontal: getSize(20)),
                              child: const BaseText(
                                text: StringConstant
                                    .pleaseSelectExpiryDateIfApplicable,
                                fontSize: 12,
                                textColor: AppColors.red,
                              ),
                            ),
                          addMoreButton(
                            context,
                            state,
                            onPressed: () {
                              context.read<ProfessionalLicensesBloc>().add(
                                  const ProfessionalLicensesEvent
                                      .addMoreLicensesDoc());
                            },
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                                top: getSize(50), bottom: getSize(50)),
                            child: CommonButton(
                              onPressed: () {
                                context.read<ProfessionalLicensesBloc>().add(
                                    const ProfessionalLicensesEvent
                                        .licensesDocSubmit(
                                        isAddMoreBtnClick: false));
                              },
                              buttonText: StringConstant.txtContinue,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                );
        },
      ),
    );
  }

  Widget selectedImage(BuildContext context, String selectedFile,
      {required ProfessionalLicensesState state}) {
    return Stack(
      alignment: Alignment.topRight,
      children: [
        ShowPickedFile(
          selectedFile: selectedFile,
          mainBoxHeight: getSize(300),
          childBoxHeight: getSize(250),
          childBoxWidth: getSize(250),
        ),
        Positioned(
          top: getSize(14),
          left: getSize(300),
          child: GestureDetector(
            onTap: () {
              AppDialog.showDelete(
                context,
                title: StringConstant.delete,
                infoMessage: StringConstant.deleteCredentialImageDesc,
                onCancelClick: () {
                  context.router.maybePop();
                },
                onDeleteClick: () {
                  if (state.professionalLicensesDoc.isValid()) {
                    context.read<ProfessionalLicensesBloc>().add(
                          ProfessionalLicensesEvent.deleteLicensesDoc(
                              state.professionalLicensesDoc.getValue()!),
                        );
                  }
                  context.router.maybePop();
                },
              );
            },
            child: SvgPicture.asset(
              SvgImageConstant.minusCircle,
            ),
          ),
        ),
      ],
    );
  }

  clickUploadButton(BuildContext context) {
    ImageChooserDialog().showImageChooserDialog(
      takePhotoCallback: () async {
        String path = await ImagePickerUtils()
                .pickImage(imageSource: ImageSource.camera, context: context) ??
            '';
        if (path.isNotEmpty) {
          print("CAMERA IMAGE PATH: $path");
          context.read<ProfessionalLicensesBloc>().add(
                ProfessionalLicensesEvent.selectLicensesDoc(path),
              );
        }
        context.router.maybePop();
      },
      selectPhotoCallback: () async {
        String path = await ImagePickerUtils().pickImage(
                imageSource: ImageSource.gallery, context: context) ??
            '';

        if (path.isNotEmpty) {
          print("GALLERY IMAGE PATH: $path");
          context.read<ProfessionalLicensesBloc>().add(
                ProfessionalLicensesEvent.selectLicensesDoc(path),
              );
        }
        context.router.maybePop();
      },
      selectPdfCallback: () async {
        String path = await FilePickerUtils().pickPdf(context: context) ?? '';
        if (path.isNotEmpty) {
          print("SELECTED FILE PATH: $path");
          context.read<ProfessionalLicensesBloc>().add(
                ProfessionalLicensesEvent.selectLicensesDoc(path),
              );
        }
        context.router.maybePop();
      },
      context: context,
    );
  }

  Widget paddingBetweenFields({double? height}) {
    return SizedBox(
      height: getSize(height ?? 15),
    );
  }

  Widget registrationNoField(BuildContext context) {
    return CustomTextField(
      labelText: StringConstant.registrationNumber,
      hintText: StringConstant.registrationNumber,
      keyboardType: TextInputType.number,
      isOptional: true,
      onChanged: (value) => context.read<ProfessionalLicensesBloc>().add(
          ProfessionalLicensesEvent.licensesRegistrationNumberChanegd(value)),
    );
  }

  Widget documentTitleField(BuildContext context) {
    return CustomTextField(
      labelText: StringConstant.documentTitle,
      hintText: StringConstant.documentTitle,
      onChanged: (value) => context
          .read<ProfessionalLicensesBloc>()
          .add(ProfessionalLicensesEvent.licensesDocumentTitleChanged(value)),
      validator: (_, context) => context
          .read<ProfessionalLicensesBloc>()
          .state
          .documentTitle
          .value
          .fold(
            (f) => f.maybeMap(
              empty: (value) => StringConstant.pleaseAddDocumentTitle,
              orElse: () => null,
            ),
            (_) => null,
          ),
    );
  }

  Widget provinceRegistrationDropdown(
      BuildContext context, ProfessionalLicensesState state) {
    return CustomDropdwonWithTextField(
      labelText: StringConstant.provinceOfRegistration,
      hintText: StringConstant.selectYourProvinceOfRegistration,
      isLabelPadding: true,
      showTextfield: false,
      items: [
        "Alberta",
        "British Columbia",
        "Manitoba",
        "New Brunswick",
        "Newfoundland",
        "Labrador",
        "Nova Scotia",
        "Ontario",
        "Prince Edward Island",
        "Quebec",
        "Saskatchewan"
      ].map((val) {
        return DropdownMenuItem(
          value: val,
          child: BaseText(
            text: val,
            fontSize: 14,
            textColor: AppColors.black,
          ),
        );
      }).toList(),
      validator: (p0) => context
          .read<ProfessionalLicensesBloc>()
          .state
          .selectedProvinceRegistration
          .value
          .fold(
            (f) => f.maybeMap(
              empty: (value) =>
                  StringConstant.pleaseSelectProvinceOfRegistrationDocument,
              orElse: () => null,
            ),
            (_) => null,
          ),
      value: (state.selectedProvinceRegistration.isValid())
          ? state.selectedProvinceRegistration.getValue()
          : null,
      onChanged: (value) {
        if (value != null) {
          context
              .read<ProfessionalLicensesBloc>()
              .add(ProfessionalLicensesEvent.selectProvinceLicenses(value));
        }
      },
    );
  }

  Widget addMoreButton(BuildContext context, ProfessionalLicensesState state,
      {required VoidCallback onPressed}) {
    bool isAllDetailsAdded = (state.selectedProvinceRegistration.isValid() &&
            state.documentTitle.isValid() &&
            state.professionalLicensesDoc.isValid() &&
            (state.isLicensesExpiryCheck ||
                state.licensesExpiryDate.isNotEmpty))
        ? true
        : false;
    return Align(
      alignment: Alignment.center,
      child: CommonButton(
        onPressed: (isAllDetailsAdded) ? onPressed : () {},
        buttonText: "+ ${StringConstant.addMore}",
        width: 105,
        borderRadius: 10,
        buttonFontSize: 12,
        buttonFontWeight: FontWeight.w600,
        height: 35,
        backgroundColor: (isAllDetailsAdded)
            ? AppColors.primaryColor.withOpacity(0.15)
            : AppColors.primaryColor.withOpacity(0.05),
        buttonTextColor: (isAllDetailsAdded)
            ? AppColors.primaryColor
            : AppColors.primaryColor.withOpacity(0.3),
      ),
    );
  }
}
