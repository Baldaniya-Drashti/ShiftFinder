import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shift/application/auth/contractor_auth/document_bloc/document_bloc.dart';
import 'package:shift/domain/core/document_expiry_picker.dart';
import 'package:shift/domain/core/math_utils.dart';
import 'package:shift/domain/core/string_constant.dart';
import 'package:shift/infrastructure/core/skill_list_model/skill_dto.dart';
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
import 'package:shift/presentation/core/widgets/drop_down_field.dart';
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
              // showError(
              //   message: failure.maybeMap(
              //     showAPIResponseMessage: (value) => value.message,
              //     networkError: (value) =>
              //         'Please check your internet connectivity',
              //     orElse: () => "Something went wrong!",
              //   ),
              // ).show(context);
            },
            (r) {
              print("LISTENER CALLED");
            },
          ),
        );
      },
      builder: (context, state) {
        return (state.isLoading)
            ? CenterLoadingIndicator(isOnlyLoader: true)
            : Padding(
                padding: EdgeInsets.symmetric(horizontal: getSize(20)),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    selectIdTypeDropdown(context, state),
                    (state.currentGovermentDocType.id != null)
                        ? Expanded(
                            child: SingleChildScrollView(
                              child: Form(
                                autovalidateMode:
                                    (state.showGovernmentIdErrorMessages)
                                        ? AutovalidateMode.always
                                        : AutovalidateMode.disabled,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    /* (state.currentGovermentDocType.id == 3)
                                        ? citizenshipCardView()
                                        : (state.currentGovermentDocType.id ==
                                                4)
                                            ? citizenshipCertificateView()
                                            :  */
                                    driverLicenseView(state, context),
                                    SizedBox(height: getSize(30)),
                                  ],
                                ),
                              ),
                            ),
                          )
                        : blankView(),
                    if (state.currentGovermentDocType.id != null)
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: Padding(
                          padding: EdgeInsets.only(
                              top: getSize(20), bottom: getSize(20)),
                          child: CommonButton(
                            isSubmitting: state.isGovermentDocSubmitting,
                            onPressed: () {
                              context.read<DocumentBloc>().add(
                                  DocumentEvent.govermentDocSubmit(context));
                            },
                            buttonText: StringConstant.txtContinue,
                          ),
                        ),
                      ),
                  ],
                ),
              );
      },
    );
  }

  Widget defaultView(DocumentState state, BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        documentTitleField(state, context),
        SizedBox(
          height: getSize(15),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: BaseText(
            text: (state.govermentDoc.isValid())
                ? StringConstant.uploadedDocument
                : StringConstant.pleaseUploadTheDocument,
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(height: getSize(10)),
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
                    },
                    selectPdfCallback: () async {
                      String path =
                          await FilePickerUtils().pickPdf(context: context) ??
                              '';
                      if (path.isNotEmpty) {
                        print("PDF FILE PATH: $path");
                        context.read<DocumentBloc>().add(
                              DocumentEvent.selectGovermentDoc(path),
                            );
                      }
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
              text: "* ${StringConstant.pleaseUnploadGovernmentIssuedId}",
              fontSize: 12,
              textColor: AppColors.red,
            ),
          ),
        DocumentExpiryDatePicker().notApplicableExpiryCheckBox(
          context,
          value: state.isGovernemtExpiryCheck,
          isDisabled: (state.governmentExpiryDate.isNotEmpty),
          onChanged: (value) {
            if (value != null) {
              context
                  .read<DocumentBloc>()
                  .add(DocumentEvent.checkNAGovermentExpiryDate(value));
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
          onCancelClick: () {
            context
                .read<DocumentBloc>()
                .add(DocumentEvent.govermentExpiryDateChanged(""));
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
              text: "* ${StringConstant.pleaseSelectExpiryDateIfApplicable}",
              fontSize: 12,
              textColor: AppColors.red,
            ),
          ),
        SizedBox(height: getSize(30)),
      ],
    );
  }

  Widget documentTitleField(DocumentState state, BuildContext context) {
    return CustomTextField(
      labelText: StringConstant.documentTitle,
      hintText: StringConstant.documentTitle,
      initialValue: state.govmentDocTitle.getValue(),
      onChanged: (value) => context
          .read<DocumentBloc>()
          .add(DocumentEvent.govtDocumentTitleChanged(value)),
      validator: (_, context) =>
          context.read<DocumentBloc>().state.govmentDocTitle.value.fold(
                (f) => f.maybeMap(
                  empty: (value) => StringConstant.pleaseAddDocumentTitle,
                  orElse: () => null,
                ),
                (_) => null,
              ),
    );
  }

  Widget selectedImage(BuildContext context, String selectedFile,
      {required DocumentState state, bool isBackFile = false}) {
    return ShowPickedFile(
      selectedFile: selectedFile,
      mainBoxHeight: getSize(300),
      childBoxHeight: getSize(250),
      childBoxWidth: getSize(260),
      onDelete: () {
        AppDialog.showDelete(
          context,
          title: StringConstant.delete,
          infoMessage: StringConstant.deleteGovernmentIdDesc,
          onCancelClick: () {
            Navigator.pop(context);
          },
          onDeleteClick: () {
            if (isBackFile) {
              context.read<DocumentBloc>().add(
                    DocumentEvent.deleteGovermentBackDoc(
                        state.govermentBackDoc.getValue()!),
                  );
            } else {
              context.read<DocumentBloc>().add(
                    DocumentEvent.deleteGovermentFrontDoc(
                        state.govermentFrontDoc.getValue()!),
                  );
            }
            Navigator.pop(context);
          },
        );
      },
    );
  }

  Widget selectIdTypeDropdown(
    BuildContext context,
    DocumentState state,
  ) {
    return CustomDropdownField(
      label: StringConstant.selectAGovtIssuedId,
      fontSize: 14,
      onChanged: (value) {
        if (value != null) {
          context
              .read<DocumentBloc>()
              .add(DocumentEvent.selectGovenmentType(value ?? SkillDTO()));
        }
      },
      hintText: StringConstant.selectYourId,
      value: (state.currentGovermentDocType.id != null)
          ? state.currentGovermentDocType
          : null,
      items: state.govermentDropDownList.map((val) {
        return DropdownMenuItem<SkillDTO>(
          value: val,
          child: BaseText(
            text: val.name ?? "",
            fontSize: 14,
            textColor: AppColors.black,
          ),
        );
      }).toList(),
    );
  }

  Widget driverLicenseView(DocumentState state, BuildContext context) {
    print(
        "state.currentGovermentDocType-----------> ${state.currentGovermentDocType}");
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(
              horizontal: getSize(18), vertical: getSize(15)),
          child: BaseText(
            text: StringConstant.frontPage,
            fontSize: 12,
            fontWeight: FontWeight.w500,
          ),
        ),
        imageView(
          state,
          context,
          doc: state.govermentFrontDoc.getValue(),
          showDocError: (state.showGovernmentIdErrorMessages &&
              !state.govermentFrontDoc.isValid()),
          errorMsg: StringConstant.pleaseSelectFrontPageOfGoverIssuedId,
          takePhotoCallback: (path) {
            context.read<DocumentBloc>().add(
                  DocumentEvent.selectGovermentFrontDoc(path),
                );
          },
          selectPhotoCallback: (path) {
            context.read<DocumentBloc>().add(
                  DocumentEvent.selectGovermentFrontDoc(path),
                );
          },
          selectPdfCallback: (path) {
            context.read<DocumentBloc>().add(
                  DocumentEvent.selectGovermentFrontDoc(path),
                );
          },
        ),
        Padding(
          padding: EdgeInsets.symmetric(
                  horizontal: getSize(18), vertical: getSize(10))
              .copyWith(top: getSize(15)),
          child: BaseText(
            text: StringConstant.backPage,
            fontSize: 12,
            fontWeight: FontWeight.w500,
          ),
        ),
        imageView(
          state,
          context,
          isBackFile: true,
          doc: state.govermentBackDoc.getValue(),
          showDocError: (state.showGovernmentIdErrorMessages &&
              !state.govermentBackDoc.isValid()),
          errorMsg: StringConstant.pleaseSelectBackPageOfGoverIssuedId,
          takePhotoCallback: (path) {
            context.read<DocumentBloc>().add(
                  DocumentEvent.selectGovermentBackDoc(path),
                );
          },
          selectPhotoCallback: (path) {
            context.read<DocumentBloc>().add(
                  DocumentEvent.selectGovermentBackDoc(path),
                );
          },
          selectPdfCallback: (path) {
            context.read<DocumentBloc>().add(
                  DocumentEvent.selectGovermentBackDoc(path),
                );
          },
        ),
        if (state.currentGovermentDocType.id != 3 &&
            state.currentGovermentDocType.id != 4) ...[
          SizedBox(height: getSize(15)),
          DocumentExpiryDatePicker.expiryDateTextField(
            context,
            lastDate: DateTime.now().add(Duration(days: 25 * 365)),
            onPickedDate: (pickedDate) {
              context.read<DocumentBloc>().add(
                  DocumentEvent.govermentExpiryDateChanged(
                      pickedDate.toString()));
            },
            onCancelClick: () {
              context
                  .read<DocumentBloc>()
                  .add(DocumentEvent.govermentExpiryDateChanged(""));
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
                text: "* ${StringConstant.pleaseSelectExpiryDate}",
                fontSize: 12,
                textColor: AppColors.red,
              ),
            ),
        ],
        SizedBox(height: getSize(30)),
      ],
    );
  }

  Widget imageView(
    DocumentState state,
    BuildContext context, {
    String? doc,
    bool showDocError = false,
    bool isBackFile = false,
    String? errorMsg,
    required void Function(String path) selectPhotoCallback,
    required void Function(String path) takePhotoCallback,
    required void Function(String path) selectPdfCallback,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        (doc != null && doc.isNotEmpty)
            ? selectedImage(
                context,
                doc,
                isBackFile: isBackFile,
                state: state,
              )
            : UploadDocumentBox(
                height: getSize(240),
                onUploadBtnPressed: () {
                  ImageChooserDialog().showImageChooserDialog(
                    takePhotoCallback: () async {
                      String path = await ImagePickerUtils().pickImage(
                              imageSource: ImageSource.camera,
                              context: context) ??
                          '';
                      if (path.isNotEmpty) {
                        takePhotoCallback(path);
                        print("CAMERA IMAGE PATH: $path");
                        /* context.read<DocumentBloc>().add(
                              DocumentEvent.selectGovermentDoc(path),
                            ); */
                      }
                    },
                    selectPhotoCallback: () async {
                      String path = await ImagePickerUtils().pickImage(
                              imageSource: ImageSource.gallery,
                              context: context) ??
                          '';

                      if (path.isNotEmpty) {
                        selectPhotoCallback(path);
                        print("GALLERY IMAGE PATH: $path");
                        /* context.read<DocumentBloc>().add(
                              DocumentEvent.selectGovermentDoc(path),
                            ); */
                      }
                    },
                    selectPdfCallback: () async {
                      String path =
                          await FilePickerUtils().pickPdf(context: context) ??
                              '';
                      if (path.isNotEmpty) {
                        selectPdfCallback(path);
                        print("PDF FILE PATH: $path");
                        /* context.read<DocumentBloc>().add(
                              DocumentEvent.selectGovermentDoc(path),
                            ); */
                      }
                    },
                    context: context,
                  );
                },
              ),
        if (showDocError)
          Padding(
            padding: EdgeInsets.symmetric(vertical: getSize(10)),
            child: BaseText(
              text: "* $errorMsg",
              fontSize: 12,
              textColor: AppColors.red,
            ),
          ),
      ],
    );
  }

  Widget citizenshipCardView() {
    return Center(
      child: BaseText(
        text: "citizenshipCardView",
        textAlign: TextAlign.center,
        fontSize: 16,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget citizenshipCertificateView() {
    return Center(
      child: BaseText(
        text: "driverLicenseView",
        textAlign: TextAlign.center,
        fontSize: 16,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget blankView() {
    return Expanded(
      child: Center(
        child: BaseText(
          text: StringConstant.selectYourIdDesc,
          textAlign: TextAlign.center,
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
