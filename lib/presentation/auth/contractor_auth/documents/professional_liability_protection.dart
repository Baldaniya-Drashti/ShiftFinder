// ignore_for_file: prefer_const_constructors, use_build_context_synchronously, avoid_print

import 'dart:io';

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
import 'package:shift/infrastructure/auth/contractor/document/upload_document_dto.dart';
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

class ProfessionalLiabilityProtection extends StatelessWidget {
  const ProfessionalLiabilityProtection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<ProfessionalLiabilityBloc>()
        ..add(ProfessionalLiabilityEvent.getLiabilityList()),
      child:
          BlocConsumer<ProfessionalLiabilityBloc, ProfessionalLiabilityState>(
        listener: (context, state) {
          state.liabilityDocAuthFailureOrSuccessOption.fold(
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
          return (state.isLiabilityDocSubmitting)
              ? CenterLoadingIndicator()
              : Padding(
                  padding: EdgeInsets.symmetric(horizontal: getSize(20)),
                  child: SingleChildScrollView(
                    child: Form(
                      autovalidateMode: (state.showLiabilityErrorMessages)
                          ? AutovalidateMode.always
                          : AutovalidateMode.disabled,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          (state.liabilityList.isNotEmpty)
                              ? ListView.builder(
                                  itemCount: state.liabilityList.length,
                                  shrinkWrap: true,
                                  physics: NeverScrollableScrollPhysics(),
                                  itemBuilder: (context, index) {
                                    DocumentDTO liabilityObject =
                                        state.liabilityList[index];
                                    return Padding(
                                      padding:
                                          EdgeInsets.only(top: getSize(10)),
                                      child: SelectedDocumentBox(
                                        // leadingImage: Image.file(
                                        //   File(liabilityObject.immunizationDocument ??
                                        //       ""),
                                        // ),
                                        pickedFile: liabilityObject.file,
                                        title: StringConstant
                                            .professionalLiabilityProtection,
                                        showDeleteButton: true,
                                        deleteDescription:
                                            StringConstant.deleteLiabilityDesc,
                                        onCancelClick: () {
                                          context.router.maybePop();
                                        },
                                        onDeleteClick: () {
                                          context
                                              .read<ProfessionalLiabilityBloc>()
                                              .add(ProfessionalLiabilityEvent
                                                  .deleteLiabilityObject(
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
                                  subTitle1: StringConstant.liabilityDesc,
                                  showDeleteButton: false,
                                ),
                          SizedBox(
                            height: getSize(20),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: BaseText(
                              text: (state.liabilityDoc.isValid())
                                  ? StringConstant.uploadedDocument
                                  : StringConstant.pleaseUploadTheDocument,
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          SizedBox(
                            height: getSize(10),
                          ),
                          (state.liabilityDoc.isValid())
                              ? selectedImage(
                                  context,
                                  state.liabilityDoc.getValue() ?? "",
                                  state: state,
                                )
                              : UploadDocumentBox(
                                  height: getSize(400),
                                  onUploadBtnPressed: () {
                                    clickUploadButton(context);
                                  },
                                ),
                          if (state.showLiabilityErrorMessages &&
                              !state.liabilityDoc.isValid())
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: getSize(10),
                                  horizontal: getSize(20)),
                              child: const BaseText(
                                text: StringConstant
                                    .pleaseSelectLiabilityDocument,
                                fontSize: 12,
                                textColor: AppColors.red,
                              ),
                            ),
                          paddingBetweenFields(),
                          DocumentExpiryDatePicker()
                              .notApplicableExpiryCheckBox(
                            context,
                            value: state.isLiabilityExpiryCheck,
                            isDisabled: (state.liabilityExpiryDate.isNotEmpty),
                            onChanged: (value) {
                              if (value != null) {
                                context.read<ProfessionalLiabilityBloc>().add(
                                    ProfessionalLiabilityEvent
                                        .checkNALiabilityExpiryDate(value));
                              }
                            },
                          ),
                          DocumentExpiryDatePicker.expiryDateTextField(
                            context,
                            onPickedDate: (pickedDate) {
                              context.read<ProfessionalLiabilityBloc>().add(
                                  ProfessionalLiabilityEvent
                                      .liabilityExpiryDateChanged(
                                          pickedDate.toString()));
                            },
                            selectedDate: state.liabilityExpiryDate,
                            isDisabled: !state.isLiabilityExpiryCheck,
                          ),
                          paddingBetweenFields(height: 5),
                          if ((!state.isLiabilityExpiryCheck &&
                                  state.liabilityExpiryDate.isEmpty) &&
                              state.showLiabilityErrorMessages)
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
                              context.read<ProfessionalLiabilityBloc>().add(
                                  const ProfessionalLiabilityEvent
                                      .addMoreLiabilityDoc());
                            },
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                                top: getSize(40), bottom: getSize(50)),
                            child: CommonButton(
                              onPressed: () {
                                context.read<ProfessionalLiabilityBloc>().add(
                                    const ProfessionalLiabilityEvent
                                        .liabilityDocSubmit(
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
      {required ProfessionalLiabilityState state}) {
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
            context.router.maybePop();
          },
          onDeleteClick: () {
            if (state.liabilityDoc.isValid()) {
              context.read<ProfessionalLiabilityBloc>().add(
                    ProfessionalLiabilityEvent.deleteLiabilityDoc(
                        state.liabilityDoc.getValue()!),
                  );
            }
            context.router.maybePop();
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
          context.read<ProfessionalLiabilityBloc>().add(
                ProfessionalLiabilityEvent.selectLiabilityDoc(path),
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
          context.read<ProfessionalLiabilityBloc>().add(
                ProfessionalLiabilityEvent.selectLiabilityDoc(path),
              );
        }
        context.router.maybePop();
      },
      selectPdfCallback: () async {
        String path = await FilePickerUtils().pickPdf(context: context) ?? '';
        if (path.isNotEmpty) {
          print("SELECTED FILE PATH: $path");
          context.read<ProfessionalLiabilityBloc>().add(
                ProfessionalLiabilityEvent.selectLiabilityDoc(path),
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

  Widget addMoreButton(BuildContext context, ProfessionalLiabilityState state,
      {required VoidCallback onPressed}) {
    bool isAllDetailsAdded = (state.liabilityDoc.isValid() &&
            (state.isLiabilityExpiryCheck ||
                state.liabilityExpiryDate.isNotEmpty))
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
