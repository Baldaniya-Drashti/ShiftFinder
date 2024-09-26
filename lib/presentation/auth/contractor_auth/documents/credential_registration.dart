// ignore_for_file: prefer_const_constructors, use_build_context_synchronously, avoid_print, unnecessary_string_interpolations

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shift/application/auth/contractor_auth/document_bloc/document_bloc.dart';
import 'package:shift/domain/core/document_expiry_picker.dart';
import 'package:shift/domain/core/math_utils.dart';
import 'package:shift/domain/core/string_constant.dart';
import 'package:shift/domain/core/svg_image_constants.dart';
import 'package:shift/infrastructure/account/account_repository.dart';
import 'package:shift/infrastructure/core/document_dto/document_dto.dart';
import 'package:shift/infrastructure/core/network/injectable_module.dart';
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

class CredentialRegistration extends StatelessWidget {
  const CredentialRegistration({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CredentialBloc(AccountRepository(ApiService()))
        ..add(CredentialEvent.getCredentialDocList()),
      child: BlocConsumer<CredentialBloc, CredentialState>(
        listener: (context, state) {
          state.credintialDocAuthFailureOrSuccessOption.fold(
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
          return (state.isLoading)
              ? CenterLoadingIndicator()
              : Padding(
                  padding: EdgeInsets.symmetric(horizontal: getSize(20)),
                  child: SingleChildScrollView(
                    child: Form(
                      autovalidateMode: (state.showCredintialErrorMessages)
                          ? AutovalidateMode.always
                          : AutovalidateMode.disabled,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          (state.credentialRegistrationList.isNotEmpty)
                              ? ListView.builder(
                                  itemCount:
                                      state.credentialRegistrationList.length,
                                  shrinkWrap: true,
                                  physics: NeverScrollableScrollPhysics(),
                                  itemBuilder: (context, index) {
                                    DocumentDTO credObject =
                                        state.credentialRegistrationList[index];
                                    return Padding(
                                      padding:
                                          EdgeInsets.only(top: getSize(10)),
                                      child: SelectedDocumentBox(
                                        // leadingImage: Image.file(File(
                                        //     credObject.credentialDocument ?? "")),
                                        pickedFile: credObject.file,
                                        title: credObject.document_title ?? "",
                                        subTitle1: credObject
                                                .province_of_registration ??
                                            "",
                                        subTitle2:
                                            credObject.registration_number ??
                                                "",
                                        showDeleteButton: true,
                                        deleteDescription: StringConstant
                                            .deleteCredentialRegistrationDesc,
                                        onCancelClick: () {
                                          context.router.maybePop();
                                        },
                                        onDeleteClick: () {
                                          context.read<CredentialBloc>().add(
                                              CredentialEvent
                                                  .deleteCredentialObject(
                                                      index));
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
                                      StringConstant.credentialRegistrationDesc,
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
                          (state.credentialRegistrationDoc.isValid())
                              ? selectedImage(
                                  context,
                                  state.credentialRegistrationDoc.getValue() ??
                                      "",
                                  state: state,
                                )
                              : UploadDocumentBox(
                                  height: getSize(300),
                                  onUploadBtnPressed: () {
                                    clickUploadButton(context);
                                  },
                                ),
                          if (state.showCredintialErrorMessages &&
                              !state.credentialRegistrationDoc.isValid())
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: getSize(10),
                                  horizontal: getSize(20)),
                              child: const BaseText(
                                text: StringConstant
                                    .pleaseSelectCredentialRegistrationDocument,
                                fontSize: 12,
                                textColor: AppColors.red,
                              ),
                            ),
                          paddingBetweenFields(),
                          DocumentExpiryDatePicker()
                              .notApplicableExpiryCheckBox(
                            context,
                            value: state.isCredExpiryCheck,
                            isDisabled: (state.credentialExpiryDate.isNotEmpty),
                            onChanged: (value) {
                              if (value != null) {
                                context.read<CredentialBloc>().add(
                                    CredentialEvent.checkNACredExpiryDate(
                                        value));
                              }
                            },
                          ),
                          DocumentExpiryDatePicker.expiryDateTextField(
                            context,
                            onPickedDate: (pickedDate) {
                              context.read<CredentialBloc>().add(
                                  CredentialEvent.credExpiryDateChanged(
                                      pickedDate.toString()));
                            },
                            onCancelClick: () {
                              context.read<CredentialBloc>().add(
                                  CredentialEvent.credExpiryDateChanged(""));
                            },
                            selectedDate: state.credentialExpiryDate,
                            isDisabled: !state.isCredExpiryCheck,
                          ),
                          paddingBetweenFields(height: 5),
                          if ((!state.isCredExpiryCheck &&
                                  state.credentialExpiryDate.isEmpty) &&
                              state.showCredintialErrorMessages)
                            Padding(
                              padding:
                                  EdgeInsets.symmetric(horizontal: getSize(20)),
                              child: const BaseText(
                                text:
                                    "${StringConstant.pleaseSelectExpiryDateIfApplicable}",
                                fontSize: 12,
                                textColor: AppColors.red,
                              ),
                            ),
                          paddingBetweenFields(),
                          addMoreButton(
                            context,
                            state,
                            onPressed: () {
                              context.read<CredentialBloc>().add(
                                  const CredentialEvent.addMoreCredentialDoc());
                            },
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                                top: getSize(50), bottom: getSize(10)),
                            child: Align(
                              alignment: Alignment.center,
                              child: CommonButton(
                                onPressed: () {
                                  context.read<CredentialBloc>().add(
                                          const CredentialEvent
                                              .credentialDocSubmit(
                                        isAddMoreBtnClick: false,
                                        isSkip: false,
                                      ));
                                },
                                buttonText: StringConstant.txtContinue,
                              ),
                            ),
                          ),
                          if (state.credentialRegistrationList.isEmpty)
                            documentSkipButton(
                              context,
                              onPressed: () {
                                context.read<CredentialBloc>().add(
                                        const CredentialEvent
                                            .credentialDocSubmit(
                                      isAddMoreBtnClick: false,
                                      isSkip: true,
                                    ));
                              },
                            ),
                          paddingBetweenFields(height: 40)
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
      {required CredentialState state}) {
    return ShowPickedFile(
      selectedFile: selectedFile,
      mainBoxHeight: getSize(300),
      childBoxHeight: getSize(250),
      childBoxWidth: getSize(250),
      onDelete: () {
        AppDialog.showDelete(
          context,
          title: StringConstant.delete,
          infoMessage: StringConstant.deleteCredentialImageDesc,
          onCancelClick: () {
            Navigator.pop(context);
          },
          onDeleteClick: () {
            if (state.credentialRegistrationDoc.isValid()) {
              context.read<CredentialBloc>().add(
                    CredentialEvent.deleteCredentialDoc(
                        state.credentialRegistrationDoc.getValue()!),
                  );
            }
            Navigator.pop(context);
          },
        );
      },
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
          context.read<CredentialBloc>().add(
                CredentialEvent.selectCredentialDoc(path),
              );
        }
      },
      selectPhotoCallback: () async {
        String path = await ImagePickerUtils().pickImage(
                imageSource: ImageSource.gallery, context: context) ??
            '';

        if (path.isNotEmpty) {
          print("GALLERY IMAGE PATH: $path");
          context.read<CredentialBloc>().add(
                CredentialEvent.selectCredentialDoc(path),
              );
        }
      },
      selectPdfCallback: () async {
        String path = await FilePickerUtils().pickPdf(context: context) ?? '';
        if (path.isNotEmpty) {
          print("SELECTED FILE PATH: $path");
          context.read<CredentialBloc>().add(
                CredentialEvent.selectCredentialDoc(path),
              );
        }
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
      onChanged: (value) => context
          .read<CredentialBloc>()
          .add(CredentialEvent.registrationNumberChanegd(value)),
    );
  }

  Widget documentTitleField(BuildContext context) {
    return CustomTextField(
      labelText: StringConstant.documentTitle,
      hintText: StringConstant.documentTitle,
      onChanged: (value) => context
          .read<CredentialBloc>()
          .add(CredentialEvent.documentTitleChanged(value)),
      validator: (_, context) =>
          context.read<CredentialBloc>().state.documentTitle.value.fold(
                (f) => f.maybeMap(
                  empty: (value) => StringConstant.pleaseAddDocumentTitle,
                  orElse: () => null,
                ),
                (_) => null,
              ),
    );
  }

  Widget provinceRegistrationDropdown(
      BuildContext context, CredentialState state) {
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
          .read<CredentialBloc>()
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
              .read<CredentialBloc>()
              .add(CredentialEvent.selectProvinceRegistration(value));
        }
      },
    );
  }

  Widget addMoreButton(BuildContext context, CredentialState state,
      {required VoidCallback onPressed}) {
    bool isAllDetailsAdded = (state.selectedProvinceRegistration.isValid() &&
            state.documentTitle.isValid() &&
            state.credentialRegistrationDoc.isValid() &&
            (state.isCredExpiryCheck || state.credentialExpiryDate.isNotEmpty))
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
