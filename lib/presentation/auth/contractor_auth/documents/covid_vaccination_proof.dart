// ignore_for_file: use_build_context_synchronously, prefer_const_constructors, avoid_print

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
import 'package:shift/presentation/common/utils/file_picker_utils.dart';
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
    BlocProvider.of<DocumentBloc>(context)
        .add(DocumentEvent.getCovidDoc());
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<DocumentBloc, DocumentState>(
      listener: (context, state) {},
      builder: (context, state) {
        print(
            "covidVaccinationDoc-->  ${state.covidVaccinationDoc.getValue()}");
        return
          (state.isLoading)
              ? CenterLoadingIndicator()
              :
          Padding(
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
                              String path = await ImagePickerUtils().pickImage(
                                      imageSource: ImageSource.camera,
                                      context: context) ??
                                  '';
                              if (path.isNotEmpty) {
                                print("CAMERA IMAGE PATH: $path");
                                context.read<DocumentBloc>().add(
                                      DocumentEvent.selectCovidVaccinationDoc(
                                          path),
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
                                      DocumentEvent.selectCovidVaccinationDoc(
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
                                      DocumentEvent.selectCovidVaccinationDoc(
                                          path),
                                    );
                              }
                              context.router.maybePop();
                            },
                            context: context,
                          );
                        },
                      ),
              ),
              if (state.showCovidErrorMessages)
                Padding(
                  padding: EdgeInsets.symmetric(vertical: getSize(10)),
                  child: const BaseText(
                    text: "* ${StringConstant.pleaseSelectCovidVaccinationDoc}",
                    fontSize: 12,
                    textColor: AppColors.red,
                  ),
                ),
              Padding(
                padding: EdgeInsets.only(top: getSize(90), bottom: getSize(50)),
                child: CommonButton(
                  isSubmitting: state.isCovidDocSubmitting,
                  onPressed: () {
                    context
                        .read<DocumentBloc>()
                        .add(const DocumentEvent.covidDocSubmit());
                  },
                  buttonText: StringConstant.txtContinue,
                ),
              )
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
        ShowPickedFile(
          selectedFile: selectedFile,
          childBoxWidth: getSize(300),
          childBoxHeight: getSize(380),
        ),
        Positioned(
          top: getSize(60),
          left: getSize(315),
          child: GestureDetector(
            onTap: () {
              AppDialog.showDelete(
                context,
                title: StringConstant.delete,
                infoMessage: StringConstant.deleteCovidDocDesc,
                onCancelClick: () {
                  context.router.maybePop();
                },
                onDeleteClick: () {
                  if (state.covidVaccinationDoc.isValid()) {
                    context.read<DocumentBloc>().add(
                          DocumentEvent.deleteCovidDoc(
                              state.covidVaccinationDoc.getValue()!),
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
