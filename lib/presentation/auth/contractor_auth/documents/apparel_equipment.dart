// ignore_for_file: prefer_const_constructors, use_build_context_synchronously, avoid_print

import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shift/application/auth/contractor_auth/document_bloc/document_bloc.dart';
import 'package:shift/domain/core/math_utils.dart';
import 'package:shift/domain/core/string_constant.dart';
import 'package:shift/domain/core/svg_image_constants.dart';
import 'package:shift/infrastructure/auth/contractor/document/upload_document_dto.dart';
import 'package:shift/presentation/common/utils/flushbar_creator.dart';
import 'package:shift/presentation/common/utils/image_picker_utils.dart';
import 'package:shift/presentation/common/widgets/base_text.dart';
import 'package:shift/presentation/common/widgets/image_chosser.dialog.dart';
import 'package:shift/presentation/common/widgets/selected_document_box.dart';
import 'package:shift/presentation/common/widgets/upload_document_box.dart';
import 'package:shift/presentation/core/app_router.gr.dart';
import 'package:shift/presentation/core/style/app_colors.dart';
import 'package:shift/presentation/core/widgets/buttons/common_button.dart';
import 'package:shift/presentation/core/widgets/dialogs/app_dialog.dart';
import 'package:shift/presentation/core/widgets/inputs/custom_text_field.dart';

class ApparelEquipment extends StatelessWidget {
  const ApparelEquipment({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => EquipmentBloc(),
      child: BlocConsumer<EquipmentBloc, EquipmentState>(
        listener: (context, state) {
          state.equipmentDocAuthFailureOrSuccessOption.fold(
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
                context.router.push(
                    const PageRouteInfo(LegalScreeningQuestionsPage.name));
                DocumentBloc.pageController.animateToPage(
                  0,
                  duration: const Duration(milliseconds: 1),
                  curve: Curves.easeInOut,
                );
              },
            ),
          );
        },
        builder: (context, state) {
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: getSize(20)),
            child: SingleChildScrollView(
              child: Form(
                autovalidateMode: (state.showEquipmentErrorMessages)
                    ? AutovalidateMode.always
                    : AutovalidateMode.disabled,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    (state.equipmentList.isNotEmpty)
                        ? ListView.builder(
                            itemCount: state.equipmentList.length,
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) {
                              ImmunizationDTO immunizationObject =
                                  state.equipmentList[index];
                              return Padding(
                                padding: EdgeInsets.only(top: getSize(10)),
                                child: SelectedDocumentBox(
                                  leadingImage: Image.file(File(
                                      immunizationObject.immunizationDocument ??
                                          "")),
                                  title:
                                      immunizationObject.nameOfImmunization ??
                                          "",
                                  showDeleteButton: true,
                                  deleteDescription:
                                      StringConstant.deleteEquipmentDesc,
                                  onCancelClick: () {
                                    context.router.maybePop();
                                  },
                                  onDeleteClick: () {
                                    context.read<EquipmentBloc>().add(
                                        EquipmentEvent.deleteEquipmentObject(
                                            index));
                                    context.router.maybePop();
                                  },
                                ),
                              );
                            })
                        : Container(),
                    SizedBox(
                      height: getSize(20),
                    ),
                    equipmentNameField(context, state),
                    paddingBetweenFields(),
                    (state.equipmentDoc.isValid())
                        ? selectedImage(
                            context,
                            state.equipmentDoc.getValue() ?? "",
                            state: state,
                          )
                        : UploadDocumentBox(
                            height: getSize(400),
                            onUploadBtnPressed: () {
                              clickUploadButton(context);
                            },
                          ),
                    if (state.showEquipmentErrorMessages &&
                        !state.equipmentDoc.isValid())
                      Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: getSize(10), horizontal: getSize(20)),
                        child: const BaseText(
                          text: StringConstant.pleaseSelectEquipmentDocument,
                          fontSize: 12,
                          textColor: AppColors.red,
                        ),
                      ),
                    paddingBetweenFields(),
                    addMoreButton(
                      context,
                      state,
                      onPressed: () {
                        context
                            .read<EquipmentBloc>()
                            .add(const EquipmentEvent.addMoreEquipmentDoc());
                      },
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          top: getSize(50), bottom: getSize(50)),
                      child: CommonButton(
                        onPressed: () {
                          context.read<EquipmentBloc>().add(
                              const EquipmentEvent.equipmentDocSubmit(
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
      {required EquipmentState state}) {
    return Stack(
      alignment: Alignment.topRight,
      children: [
        Container(
            height: getSize(400),
            decoration: BoxDecoration(
              color: AppColors.grey.withOpacity(0.4),
              borderRadius: BorderRadius.circular(10),
            ),
            padding: EdgeInsets.symmetric(vertical: getSize(10)),
            alignment: Alignment.center,
            child: Container(
              height: getSize(350),
              width: getSize(350),
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: AppColors.grey,
                    spreadRadius: 0.2,
                    blurRadius: 10,
                  )
                ],
              ),
              child: Image.file(
                File(selectedFile),
                fit: BoxFit.fitWidth,
              ),
            )),
        Positioned(
          top: getSize(14),
          left: getSize(350),
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
                  if (state.equipmentDoc.isValid()) {
                    context.read<EquipmentBloc>().add(
                          EquipmentEvent.deleteEquipmentDoc(
                              state.equipmentDoc.getValue()!),
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
          context.read<EquipmentBloc>().add(
                EquipmentEvent.selectEquipmentDoc(path),
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
          context.read<EquipmentBloc>().add(
                EquipmentEvent.selectEquipmentDoc(path),
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

  Widget equipmentNameField(BuildContext context, EquipmentState state) {
    return CustomTextField(
      labelText: StringConstant.title,
      hintText: StringConstant.title,
      onChanged: (value) => context
          .read<EquipmentBloc>()
          .add(EquipmentEvent.equipmentNameChanegd(value)),
      validator: (_, context) =>
          context.read<EquipmentBloc>().state.equipmentName.value.fold(
                (f) => f.maybeMap(
                  empty: (value) => StringConstant.pleaseAddTitle,
                  orElse: () => null,
                ),
                (_) => null,
              ),
    );
  }

  Widget addMoreButton(BuildContext context, EquipmentState state,
      {required VoidCallback onPressed}) {
    bool isAllDetailsAdded =
        (state.equipmentName.isValid() && state.equipmentDoc.isValid())
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
