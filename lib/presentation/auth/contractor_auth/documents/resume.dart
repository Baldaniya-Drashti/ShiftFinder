// ignore_for_file: prefer_const_constructors, use_build_context_synchronously, avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shift/application/auth/contractor_auth/document_bloc/document_bloc.dart';
import 'package:shift/domain/core/math_utils.dart';
import 'package:shift/domain/core/string_constant.dart';
import 'package:shift/injection.dart';
import 'package:shift/presentation/common/utils/file_picker_utils.dart';
import 'package:shift/presentation/common/utils/flushbar_creator.dart';
import 'package:shift/presentation/common/utils/image_picker_utils.dart';
import 'package:shift/presentation/common/widgets/base_text.dart';
import 'package:shift/presentation/common/widgets/center_loading_indicator.dart';
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
      create: (context) => getIt<ResumeBloc>()..add(ResumeEvent.getResumeDoc()),
      child: BlocConsumer<ResumeBloc, ResumeState>(
        listener: (context, state) {
          state.resumeDocAuthFailureOrSuccessOption.fold(
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
          return (state.isResumeDocSubmitting)
              ? CenterLoadingIndicator()
              : Padding(
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
                            text: (state.resume.file != null &&
                                    state.resume.file!.isNotEmpty)
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
                          child: (state.resume.file != null &&
                                  state.resume.file!.isNotEmpty)
                              ? selectedImage(
                                  context,
                                  state.resume.file ?? "",
                                  state: state,
                                )
                              : UploadDocumentBox(
                                  height: getSize(400),
                                  onUploadBtnPressed: () {
                                    clickUploadButton(context);
                                  },
                                ),
                        ),
                        if (state.showResumeErrorMessages &&
                            (state.resume.file == null ||
                                (state.resume.file != null &&
                                    state.resume.file!.isEmpty)))
                          Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: getSize(10), horizontal: getSize(20)),
                            child: const BaseText(
                              text: StringConstant.pleaseSelectResume,
                              fontSize: 12,
                              textColor: AppColors.red,
                            ),
                          ),
                        Padding(
                          padding: EdgeInsets.only(
                              top: getSize(40), bottom: getSize(10)),
                          child: Align(
                            alignment: Alignment.center,
                            child: CommonButton(
                              onPressed: () {
                                context.read<ResumeBloc>().add(
                                    ResumeEvent.resumeDocSubmit(context,
                                        isSkip: false));
                              },
                              buttonText: StringConstant.txtContinue,
                            ),
                          ),
                        ),
                        if (state.resume.file == null ||
                            (state.resume.file != null &&
                                state.resume.file!.isEmpty))
                          documentSkipButton(
                            context,
                            onPressed: () {
                              context.read<ResumeBloc>().add(
                                  ResumeEvent.resumeDocSubmit(context,
                                      isSkip: true));
                            },
                          ),
                        paddingBetweenFields(height: 20),
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
    return ShowPickedFile(
      selectedFile: selectedFile,
      childBoxHeight: getSize(425),
      childBoxWidth: getSize(315),
      onDelete: () {
        AppDialog.showDelete(
          context,
          title: StringConstant.delete,
          infoMessage: StringConstant.deleteResumeDesc,
          onCancelClick: () {
            Navigator.pop(context);
          },
          onDeleteClick: () {
            if (state.resume.file != null && state.resume.file!.isNotEmpty) {
              context
                  .read<ResumeBloc>()
                  .add(ResumeEvent.deleteResumeDoc(state.resume.file!));
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
          context.read<ResumeBloc>().add(
                ResumeEvent.selectResumeDoc(path),
              );
        }
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
      },
      selectPdfCallback: () async {
        String path = await FilePickerUtils().pickPdf(context: context) ?? '';
        if (path.isNotEmpty) {
          print("PDF FILE PATH: $path");
          context.read<ResumeBloc>().add(
                ResumeEvent.selectResumeDoc(path),
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
}
