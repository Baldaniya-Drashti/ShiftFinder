// ignore_for_file: use_build_context_synchronously, prefer_const_constructors, avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shift/application/auth/contractor_auth/document_bloc/document_bloc.dart';
import 'package:shift/domain/core/math_utils.dart';
import 'package:shift/domain/core/string_constant.dart';
import 'package:shift/presentation/common/utils/file_picker_utils.dart';
import 'package:shift/presentation/common/utils/image_picker_utils.dart';
import 'package:shift/presentation/common/widgets/base_text.dart';
import 'package:shift/presentation/common/widgets/center_loading_indicator.dart';
import 'package:shift/presentation/common/widgets/image_chosser.dialog.dart';
import 'package:shift/presentation/common/widgets/show_picked_file.dart';
import 'package:shift/presentation/common/widgets/upload_document_box.dart';
import 'package:shift/presentation/core/style/app_colors.dart';
import 'package:shift/presentation/core/widgets/buttons/common_button.dart';
import 'package:shift/presentation/core/widgets/dialogs/app_dialog.dart';

class CovidVaccinationDocument extends StatefulWidget {
  const CovidVaccinationDocument({super.key});

  @override
  State<CovidVaccinationDocument> createState() =>
      _CovidVaccinationDocumentState();
}

class _CovidVaccinationDocumentState extends State<CovidVaccinationDocument> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<DocumentBloc>(context).add(DocumentEvent.getCovidDoc());
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<DocumentBloc, DocumentState>(
      listener: (context, state) {},
      builder: (context, state) {
        return (state.isLoading)
            ? CenterLoadingIndicator()
            : Padding(
                padding: EdgeInsets.symmetric(horizontal: getSize(20)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: BaseText(
                        text: (state.covidVaccinationDoc.isValid())
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
                      child: (state.covidVaccinationDoc.isValid())
                          ? selectedImage(
                              context,
                              state.covidVaccinationDoc.getValue() ?? "",
                              state: state,
                            )
                          : UploadDocumentBox(
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
                                            DocumentEvent
                                                .selectCovidVaccinationDoc(
                                                    path),
                                          );
                                    }
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
                                            DocumentEvent
                                                .selectCovidVaccinationDoc(
                                                    path),
                                          );
                                    }
                                  },
                                  selectPdfCallback: () async {
                                    String path = await FilePickerUtils()
                                            .pickPdf(context: context) ??
                                        '';
                                    if (path.isNotEmpty) {
                                      print("PDF FILE PATH: $path");
                                      context.read<DocumentBloc>().add(
                                            DocumentEvent
                                                .selectCovidVaccinationDoc(
                                                    path),
                                          );
                                    }
                                  },
                                  context: context,
                                );
                              },
                            ),
                    ),
                    if (state.showCovidErrorMessages &&
                        !state.covidVaccinationDoc.isValid())
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: getSize(10)),
                        child: const BaseText(
                          text:
                              "* ${StringConstant.pleaseSelectCovidVaccinationDoc}",
                          fontSize: 12,
                          textColor: AppColors.red,
                        ),
                      ),
                    Align(
                      alignment: Alignment.center,
                      child: Padding(
                        padding: EdgeInsets.only(
                            top: getSize(50), bottom: getSize(10)),
                        child: CommonButton(
                          isSubmitting: state.isCovidDocSubmitting,
                          onPressed: () {
                            context
                                .read<DocumentBloc>()
                                .add(const DocumentEvent.covidDocSubmit(
                                  isSkip: false,
                                ));
                          },
                          buttonText: StringConstant.txtContinue,
                        ),
                      ),
                    ),
                    if (!state.covidVaccinationDoc.isValid())
                      documentSkipButton(
                        context,
                        onPressed: () {
                          context
                              .read<DocumentBloc>()
                              .add(const DocumentEvent.covidDocSubmit(
                                isSkip: true,
                              ));
                        },
                      ),
                    SizedBox(height: getSize(20)),
                  ],
                ),
              );
      },
    );
  }

  Widget selectedImage(BuildContext context, String selectedFile,
      {required DocumentState state}) {
    return ShowPickedFile(
      selectedFile: selectedFile,
      childBoxWidth: getSize(300),
      childBoxHeight: getSize(380),
      onDelete: () {
        AppDialog.showDelete(
          context,
          title: StringConstant.delete,
          infoMessage: StringConstant.deleteCovidDocDesc,
          onCancelClick: () {
            Navigator.pop(context);
          },
          onDeleteClick: () {
            if (state.covidVaccinationDoc.isValid()) {
              context.read<DocumentBloc>().add(
                    DocumentEvent.deleteCovidDoc(
                        state.covidVaccinationDoc.getValue()!),
                  );
            }
            Navigator.pop(context);
          },
        );
      },
    );
  }
}
