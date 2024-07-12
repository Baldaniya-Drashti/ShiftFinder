// ignore_for_file: avoid_print, use_build_context_synchronously

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
import 'package:shift/presentation/common/utils/flushbar_creator.dart';
import 'package:shift/presentation/common/utils/image_picker_utils.dart';
import 'package:shift/presentation/common/widgets/base_text.dart';
import 'package:shift/presentation/common/widgets/image_chosser.dialog.dart';
import 'package:shift/presentation/common/widgets/upload_document_box.dart';
import 'package:shift/presentation/core/style/app_colors.dart';
import 'package:shift/presentation/core/widgets/buttons/common_button.dart';
import 'package:shift/presentation/core/widgets/dialogs/app_dialog.dart';

@RoutePage(name: 'GovernmentIssueDocument')
class GovernmentIssueDocument extends StatelessWidget {
  const GovernmentIssueDocument({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<DocumentBloc, DocumentState>(
      listener: (context, state) {
        state.governmentDocAuthFailureOrSuccessOption.fold(
          () {},
          (either) => either.fold(
            (failure) {
              showError(
                message: failure.maybeMap(
                  orElse: () => "Something went wrong!",
                ),
              ).show(context);
            },
            (r) {
              print("LISTENER CALLED");
            },
          ),
        );
      },
      builder: (context, state) {
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: getSize(20)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: BaseText(
                  text: (state.govermentDoc.isValid())
                      ? StringConstant.uploadedDocument
                      : StringConstant.pleaseUploadTheDocument,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(
                height: getSize(10),
              ),
              Expanded(
                child: (state.govermentDoc.isValid())
                    ? selectedImage(
                        context,
                        state.govermentDoc.getValue() ?? "",
                        state: state,
                      )
                    : UploadDocumentBox(
                        onUploadBtnPressed: () {
                          ImageChooserDialog().showImageChooserDialog(
                            takePhotoCallback: () async {
                              String path = await ImagePickerUtils().pickImage(
                                      imageSource: ImageSource.camera,
                                      context: context) ??
                                  '';
                              if (path.isNotEmpty) {
                                print("CAMERA IMAGE PATH: $path");
                                context.read<DocumentBloc>().add(
                                      DocumentEvent.selectGovermentDoc(path),
                                    );
                              }
                              context.router.maybePop();
                            },
                            selectPhotoCallback: () async {
                              String path = await ImagePickerUtils().pickImage(
                                      imageSource: ImageSource.gallery,
                                      context: context) ??
                                  '';

                              if (path.isNotEmpty) {
                                print("GALLERY IMAGE PATH: $path");
                                context.read<DocumentBloc>().add(
                                      DocumentEvent.selectGovermentDoc(path),
                                    );
                              }
                              context.router.maybePop();
                            },
                            context: context,
                          );
                        },
                      ),
              ),
              if (state.showGovernmentIdErrorMessages)
                Padding(
                  padding: EdgeInsets.symmetric(vertical: getSize(10)),
                  child: const BaseText(
                    text: "* ${StringConstant.pleaseSelectGovernmentIssuedId}",
                    fontSize: 12,
                    textColor: AppColors.red,
                  ),
                ),
              Padding(
                padding: EdgeInsets.only(top: getSize(90), bottom: getSize(50)),
                child: CommonButton(
                  isSubmitting: state.isGovermentDocSubmitting,
                  onPressed: () {
                    context
                        .read<DocumentBloc>()
                        .add(const DocumentEvent.govermentDocSubmit());
                  },
                  buttonText: StringConstant.txtContinue,
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget selectedImage(BuildContext context, String selectedFile,
      {required DocumentState state}) {
    return Stack(
      children: [
        Container(
            decoration: BoxDecoration(
              color: AppColors.grey.withOpacity(0.4),
              borderRadius: BorderRadius.circular(10),
            ),
            alignment: Alignment.center,
            child: Container(
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: AppColors.grey,
                    spreadRadius: 0.2,
                    blurRadius: 10,
                  )
                ],
              ),
              height: getSize(384),
              width: getSize(298),
              child: Image.file(
                File(selectedFile),
                fit: BoxFit.cover,
                width: double.infinity,
              ),
            )),
        Positioned(
          top: getSize(52),
          left: getSize(325),
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
                  if (state.govermentDoc.isValid()) {
                    context.read<DocumentBloc>().add(
                          DocumentEvent.deleteGovermentDoc(
                              state.govermentDoc.getValue()!),
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
}
