// ignore_for_file: avoid_print, use_build_context_synchronously, prefer_const_constructors

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:shift/application/auth/contractor_auth/document_bloc/document_bloc.dart';
import 'package:shift/domain/core/document_expiry_picker.dart';
import 'package:shift/domain/core/math_utils.dart';
import 'package:shift/domain/core/string_constant.dart';
import 'package:shift/domain/core/svg_image_constants.dart';
import 'package:shift/presentation/common/utils/file_picker_utils.dart';
import 'package:shift/presentation/common/utils/flushbar_creator.dart';
import 'package:shift/presentation/common/utils/get_cookie.dart';
import 'package:shift/presentation/common/utils/image_picker_utils.dart';
import 'package:shift/presentation/common/widgets/base_text.dart';
import 'package:shift/presentation/common/widgets/center_loading_indicator.dart';
import 'package:shift/presentation/common/widgets/image_chosser.dialog.dart';
import 'package:shift/presentation/common/widgets/show_picked_file.dart';
import 'package:shift/presentation/common/widgets/upload_document_box.dart';
import 'package:shift/presentation/core/style/app_colors.dart';
import 'package:shift/presentation/core/widgets/buttons/common_button.dart';
import 'package:shift/presentation/core/widgets/dialogs/app_dialog.dart';
import 'package:path/path.dart' as path;
import 'package:shift/presentation/core/widgets/inputs/custom_text_field.dart';

class GovernmentIssueDocument extends StatefulWidget {
  const GovernmentIssueDocument({super.key});

  @override
  State<GovernmentIssueDocument> createState() =>
      _GovernmentIssueDocumentState();
}

class _GovernmentIssueDocumentState extends State<GovernmentIssueDocument> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<DocumentBloc>(context).add(DocumentEvent.getGovermentDoc());
  }

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
        return (state.isLoading)
            ? CenterLoadingIndicator()
            : SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: getSize(20)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
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
                      (state.govermentDoc.isValid())
                          ? selectedImage(
                              context,
                              state.govermentDoc.getValue() ?? "",
                              state: state,
                            )
                          : UploadDocumentBox(
                              height: getSize(390),
                              onUploadBtnPressed: () {
                                ImageChooserDialog().showImageChooserDialog(
                                  takePhotoCallback: () async {
                                    String path = await ImagePickerUtils()
                                            .pickImage(
                                                imageSource: ImageSource.camera,
                                                context: context) ??
                                        '';
                                    if (path.isNotEmpty) {
                                      print("CAMERA IMAGE PATH: $path");
                                      context.read<DocumentBloc>().add(
                                            DocumentEvent.selectGovermentDoc(
                                                path),
                                          );
                                    }
                                    context.router.maybePop();
                                  },
                                  selectPhotoCallback: () async {
                                    String path = await ImagePickerUtils()
                                            .pickImage(
                                                imageSource:
                                                    ImageSource.gallery,
                                                context: context) ??
                                        '';

                                    if (path.isNotEmpty) {
                                      print("GALLERY IMAGE PATH: $path");
                                      context.read<DocumentBloc>().add(
                                            DocumentEvent.selectGovermentDoc(
                                                path),
                                          );
                                    }
                                    context.router.maybePop();
                                  },
                                  selectPdfCallback: () async {
                                    String path = await FilePickerUtils()
                                            .pickPdf(context: context) ??
                                        '';
                                    if (path.isNotEmpty) {
                                      print("PDF FILE PATH: $path");
                                      context.read<DocumentBloc>().add(
                                            DocumentEvent.selectGovermentDoc(
                                                path),
                                          );
                                    }
                                    context.router.maybePop();
                                  },
                                  context: context,
                                );
                              },
                            ),
                      if (state.showGovernmentIdErrorMessages &&
                          !state.govermentDoc.isValid())
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: getSize(10)),
                          child: const BaseText(
                            text:
                                "* ${StringConstant.pleaseSelectGovernmentIssuedId}",
                            fontSize: 12,
                            textColor: AppColors.red,
                          ),
                        ),
                      // notApplicableExpiryCheckBox(state, context),
                      // expiryDateTextField(context, state),

                      DocumentExpiryDatePicker().notApplicableExpiryCheckBox(
                        context,
                        value: state.isGovernemtExpiryCheck,
                        isDisabled: (state.governmentExpiryDate.isNotEmpty),
                        onChanged: (value) {
                          if (value != null) {
                            context.read<DocumentBloc>().add(
                                DocumentEvent.checkNAGovermentExpiryDate(
                                    value));
                          }
                        },
                      ),
                      DocumentExpiryDatePicker.expiryDateTextField(
                        context,
                        onPickedDate: (pickedDate) {
                          context.read<DocumentBloc>().add(
                              DocumentEvent.govermentExpiryDateChanged(
                                  pickedDate.toString()));
                        },
                        selectedDate: state.governmentExpiryDate,
                        isDisabled: !state.isGovernemtExpiryCheck,
                      ),
                      if ((!state.isGovernemtExpiryCheck &&
                              state.governmentExpiryDate.isEmpty) &&
                          state.showGovernmentIdErrorMessages)
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: getSize(5)),
                          child: const BaseText(
                            text:
                                "* ${StringConstant.pleaseSelectExpiryDateIfApplicable}",
                            fontSize: 12,
                            textColor: AppColors.red,
                          ),
                        ),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: Padding(
                          padding: EdgeInsets.only(
                              top: getSize(30), bottom: getSize(50)),
                          child: CommonButton(
                            isSubmitting: state.isGovermentDocSubmitting,
                            onPressed: () {
                              context.read<DocumentBloc>().add(
                                  const DocumentEvent.govermentDocSubmit());
                            },
                            buttonText: StringConstant.txtContinue,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
      },
    );
  }

  Widget selectedImage(BuildContext context, String selectedFile,
      {required DocumentState state}) {
    return ShowPickedFile(
      selectedFile: selectedFile,
      mainBoxHeight: getSize(390),
      childBoxHeight: getSize(300),
      childBoxWidth: getSize(260),
      onDelete: () {
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
    );
  }
}
