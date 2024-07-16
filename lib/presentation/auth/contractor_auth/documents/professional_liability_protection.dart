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
import 'package:shift/presentation/common/utils/image_picker_utils.dart';
import 'package:shift/presentation/common/widgets/base_text.dart';
import 'package:shift/presentation/common/widgets/image_chosser.dialog.dart';
import 'package:shift/presentation/common/widgets/selected_document_box.dart';
import 'package:shift/presentation/common/widgets/upload_document_box.dart';
import 'package:shift/presentation/core/style/app_colors.dart';
import 'package:shift/presentation/core/widgets/buttons/common_button.dart';
import 'package:shift/presentation/core/widgets/dialogs/app_dialog.dart';

class ProfessionalLiabilityProtection extends StatelessWidget {
  const ProfessionalLiabilityProtection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProfessionalLiabilityBloc(),
      child:
          BlocConsumer<ProfessionalLiabilityBloc, ProfessionalLiabilityState>(
        listener: (context, state) {},
        builder: (context, state) {
          return Padding(
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
                              ImmunizationDTO liabilityObject =
                                  state.liabilityList[index];
                              return Padding(
                                padding: EdgeInsets.only(top: getSize(10)),
                                child: SelectedDocumentBox(
                                  leadingImage: Image.file(
                                    File(liabilityObject.immunizationDocument ??
                                        ""),
                                  ),
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
                                            .deleteLiabilityObject(index));
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
                            vertical: getSize(10), horizontal: getSize(20)),
                        child: const BaseText(
                          text: StringConstant.pleaseSelectLiabilityDocument,
                          fontSize: 12,
                          textColor: AppColors.red,
                        ),
                      ),
                    paddingBetweenFields(),
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
              height: getSize(250),
              width: getSize(250),
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
    bool isAllDetailsAdded = (state.liabilityDoc.isValid()) ? true : false;
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
