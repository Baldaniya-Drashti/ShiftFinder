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
import 'package:shift/presentation/common/utils/image_picker_utils.dart';
import 'package:shift/presentation/common/widgets/base_text.dart';
import 'package:shift/presentation/common/widgets/image_chosser.dialog.dart';
import 'package:shift/presentation/common/widgets/show_picked_file.dart';
import 'package:shift/presentation/common/widgets/upload_document_box.dart';
import 'package:shift/presentation/core/style/app_colors.dart';
import 'package:shift/presentation/core/widgets/buttons/common_button.dart';
import 'package:shift/presentation/core/widgets/dialogs/app_dialog.dart';

class ResumeDocument extends StatelessWidget {
  const ResumeDocument({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ResumeBloc(),
      child: BlocConsumer<ResumeBloc, ResumeState>(
        listener: (context, state) {},
        builder: (context, state) {
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: getSize(20)),
            child: Form(
              autovalidateMode: (state.showResumeErrorMessages)
                  ? AutovalidateMode.always
                  : AutovalidateMode.disabled,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: BaseText(
                      text: (state.resumeDoc.isValid())
                          ? StringConstant.uploadedResume
                          : StringConstant.uploadYourResume,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(
                    height: getSize(10),
                  ),
                  Expanded(
                    child: (state.resumeDoc.isValid())
                        ? selectedImage(
                            context,
                            state.resumeDoc.getValue() ?? "",
                            state: state,
                          )
                        : UploadDocumentBox(
                            height: getSize(400),
                            onUploadBtnPressed: () {
                              clickUploadButton(context);
                            },
                          ),
                  ),
                  Padding(
                    padding:
                        EdgeInsets.only(top: getSize(40), bottom: getSize(50)),
                    child: CommonButton(
                      onPressed: () {
                        context
                            .read<ResumeBloc>()
                            .add(const ResumeEvent.resumeDocSubmit());
                      },
                      buttonText: StringConstant.txtContinue,
                    ),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget selectedImage(BuildContext context, String selectedFile,
      {required ResumeState state}) {
    return Stack(
      children: [
        ShowPickedFile(
          selectedFile: selectedFile,
          childBoxHeight: getSize(425),
          childBoxWidth: getSize(315),
        ),
        Positioned(
          top: getSize(60),
          left: getSize(330),
          child: GestureDetector(
            onTap: () {
              AppDialog.showDelete(
                context,
                title: StringConstant.delete,
                infoMessage: StringConstant.deleteGovernmentIdDesc,
                onCancelClick: () {
                  context.router.maybePop();
                },
                onDeleteClick: () {
                  if (state.resumeDoc.isValid()) {
                    context.read<DocumentBloc>().add(
                          DocumentEvent.deleteGovermentDoc(
                              state.resumeDoc.getValue()!),
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
          context.read<ResumeBloc>().add(
                ResumeEvent.selectResumeDoc(path),
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
          context.read<ResumeBloc>().add(
                ResumeEvent.selectResumeDoc(path),
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
}
