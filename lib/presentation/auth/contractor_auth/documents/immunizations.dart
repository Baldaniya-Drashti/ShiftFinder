// ignore_for_file: prefer_const_constructors, use_build_context_synchronously, avoid_print, file_names

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
import 'package:shift/presentation/common/utils/file_picker_utils.dart';
import 'package:shift/presentation/common/utils/image_picker_utils.dart';
import 'package:shift/presentation/common/widgets/base_text.dart';
import 'package:shift/presentation/common/widgets/image_chosser.dialog.dart';
import 'package:shift/presentation/common/widgets/selected_document_box.dart';
import 'package:shift/presentation/common/widgets/show_picked_file.dart';
import 'package:shift/presentation/common/widgets/upload_document_box.dart';
import 'package:shift/presentation/core/style/app_colors.dart';
import 'package:shift/presentation/core/widgets/buttons/common_button.dart';
import 'package:shift/presentation/core/widgets/dialogs/app_dialog.dart';
import 'package:shift/presentation/core/widgets/inputs/custom_text_field.dart';

class ImmunizationsVaccinations extends StatelessWidget {
  const ImmunizationsVaccinations({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ImmunizationBloc()
        ..add(ImmunizationEvent.getImmunizationDataOnInit()),
      child: BlocConsumer<ImmunizationBloc, ImmunizationState>(
        listener: (context, state) {},
        builder: (context, state) {
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: getSize(20)),
            child: SingleChildScrollView(
              child: Form(
                autovalidateMode: (state.showImmunizationErrorMessages)
                    ? AutovalidateMode.always
                    : AutovalidateMode.disabled,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    (state.immunizationList.isNotEmpty)
                        ? ListView.builder(
                            itemCount: state.immunizationList.length,
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) {
                              ImmunizationDTO immunizationObject =
                                  state.immunizationList[index];
                              return Padding(
                                padding: EdgeInsets.only(top: getSize(10)),
                                child: SelectedDocumentBox(
                                  // leadingImage: Image.file(File(
                                  //     immunizationObject.immunizationDocument ??
                                  //         "")),
                                  pickedFile:
                                      immunizationObject.immunizationDocument,
                                  title:
                                      immunizationObject.nameOfImmunization ??
                                          "",
                                  showDeleteButton: true,
                                  deleteDescription:
                                      StringConstant.deleteImmunizationDesc,
                                  onCancelClick: () {
                                    context.router.maybePop();
                                  },
                                  onDeleteClick: () {
                                    context.read<ImmunizationBloc>().add(
                                        ImmunizationEvent
                                            .deleteImmunizationObject(index));
                                    context.router.maybePop();
                                  },
                                ),
                              );
                            })
                        : SelectedDocumentBox(
                            leadingImageString:
                                SvgImageConstant.documentWithVerticalLine,
                            title: "",
                            subTitle1: StringConstant.immunizationDesc,
                            showDeleteButton: false,
                          ),
                    SizedBox(
                      height: getSize(20),
                    ),
                    immunizationNameField(context),
                    paddingBetweenFields(),
                    (state.immunizationDoc.isValid())
                        ? selectedImage(
                            context,
                            state.immunizationDoc.getValue() ?? "",
                            state: state,
                          )
                        : UploadDocumentBox(
                            height: getSize(300),
                            onUploadBtnPressed: () {
                              clickUploadButton(context);
                            },
                          ),
                    if (state.showImmunizationErrorMessages &&
                        !state.immunizationDoc.isValid())
                      Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: getSize(10), horizontal: getSize(20)),
                        child: const BaseText(
                          text: StringConstant.pleaseSelectImmunizationDocument,
                          fontSize: 12,
                          textColor: AppColors.red,
                        ),
                      ),
                    paddingBetweenFields(),
                    DocumentExpiryDatePicker().notApplicableExpiryCheckBox(
                      context,
                      value: state.isImmunizationExpiryCheck,
                      isDisabled: (state.immunizationExpiryDate.isNotEmpty),
                      onChanged: (value) {
                        if (value != null) {
                          context.read<ImmunizationBloc>().add(
                              ImmunizationEvent.checkNAImmunizationExpiryDate(
                                  value));
                        }
                      },
                    ),
                    DocumentExpiryDatePicker.expiryDateTextField(
                      context,
                      onPickedDate: (pickedDate) {
                        context.read<ImmunizationBloc>().add(
                            ImmunizationEvent.immunizationExpiryDateChanged(
                                pickedDate.toString()));
                      },
                      selectedDate: state.immunizationExpiryDate,
                      isDisabled: !state.isImmunizationExpiryCheck,
                    ),
                    paddingBetweenFields(height: 5),
                    if ((!state.isImmunizationExpiryCheck &&
                            state.immunizationExpiryDate.isEmpty) &&
                        state.showImmunizationErrorMessages)
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: getSize(20)),
                        child: const BaseText(
                          text:
                              StringConstant.pleaseSelectExpiryDateIfApplicable,
                          fontSize: 12,
                          textColor: AppColors.red,
                        ),
                      ),
                    addMoreButton(
                      context,
                      state,
                      onPressed: () {
                        context.read<ImmunizationBloc>().add(
                            const ImmunizationEvent.addMoreImmunizationDoc());
                      },
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          top: getSize(50), bottom: getSize(50)),
                      child: CommonButton(
                        onPressed: () {
                          context.read<ImmunizationBloc>().add(
                              const ImmunizationEvent.immunizationDocSubmit(
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
      {required ImmunizationState state}) {
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
                  if (state.immunizationDoc.isValid()) {
                    context.read<ImmunizationBloc>().add(
                          ImmunizationEvent.deleteImmunizationDoc(
                              state.immunizationDoc.getValue()!),
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
          context.read<ImmunizationBloc>().add(
                ImmunizationEvent.selectImmunizationDoc(path),
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
          context.read<ImmunizationBloc>().add(
                ImmunizationEvent.selectImmunizationDoc(path),
              );
        }
        context.router.maybePop();
      },
      selectPdfCallback: () async {
        String path = await FilePickerUtils().pickPdf(context: context) ?? '';
        if (path.isNotEmpty) {
          print("SELECTED FILE PATH: $path");
          context.read<ImmunizationBloc>().add(
                ImmunizationEvent.selectImmunizationDoc(path),
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

  Widget immunizationNameField(BuildContext context) {
    return CustomTextField(
      labelText: StringConstant.nameOfImmunizationsVaccinations,
      hintText: StringConstant.nameOfImmunizationsVaccinations,
      onChanged: (value) => context
          .read<ImmunizationBloc>()
          .add(ImmunizationEvent.immunizationsNameChanegd(value)),
      validator: (_, context) =>
          context.read<ImmunizationBloc>().state.immunizationName.value.fold(
                (f) => f.maybeMap(
                  empty: (value) => StringConstant.pleaseAddImmunizationName,
                  orElse: () => null,
                ),
                (_) => null,
              ),
    );
  }

  Widget addMoreButton(BuildContext context, ImmunizationState state,
      {required VoidCallback onPressed}) {
    bool isAllDetailsAdded = (state.immunizationName.isValid() &&
            state.immunizationDoc.isValid() &&
            (state.isImmunizationExpiryCheck ||
                state.immunizationExpiryDate.isNotEmpty))
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
