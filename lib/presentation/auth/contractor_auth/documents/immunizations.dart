// ignore_for_file: prefer_const_constructors, use_build_context_synchronously, avoid_print, file_names

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shift/application/auth/contractor_auth/document_bloc/document_bloc.dart';
import 'package:shift/domain/core/math_utils.dart';
import 'package:shift/domain/core/string_constant.dart';
import 'package:shift/domain/core/svg_image_constants.dart';
import 'package:shift/infrastructure/core/document_dto/document_dto.dart';
import 'package:shift/injection.dart';
import 'package:shift/presentation/common/utils/file_picker_utils.dart';
import 'package:shift/presentation/common/utils/flushbar_creator.dart';
import 'package:shift/presentation/common/utils/image_picker_utils.dart';
import 'package:shift/presentation/common/widgets/base_text.dart';
import 'package:shift/presentation/common/widgets/center_loading_indicator.dart';
import 'package:shift/presentation/common/widgets/image_chosser.dialog.dart';
import 'package:shift/presentation/common/widgets/selected_document_box.dart';
import 'package:shift/presentation/common/widgets/show_picked_file.dart';
import 'package:shift/presentation/common/widgets/upload_document_box.dart';
import 'package:shift/presentation/core/style/app_colors.dart';
import 'package:shift/presentation/core/widgets/buttons/common_button.dart';
import 'package:shift/presentation/core/widgets/dialogs/app_dialog.dart';
import 'package:shift/presentation/core/widgets/inputs/custom_text_field.dart';

class ImmunizationsVaccinations extends StatelessWidget {
  final bool isUpdate;
  const ImmunizationsVaccinations({super.key, this.isUpdate = false});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<ImmunizationBloc>()
        ..add(ImmunizationEvent.getImmunizationDataOnInit()),
      child: BlocConsumer<ImmunizationBloc, ImmunizationState>(
        listener: (context, state) {
          state.immunizationDocAuthFailureOrSuccessOption.fold(
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
          return (state.isImmunizationDocSubmitting)
              ? CenterLoadingIndicator()
              : Padding(
                  padding: EdgeInsets.symmetric(horizontal: getSize(20)),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Expanded(
                        child: SingleChildScrollView(
                          child: Form(
                            autovalidateMode:
                                (state.showImmunizationErrorMessages)
                                    ? AutovalidateMode.always
                                    : AutovalidateMode.disabled,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                (state.immunizationList.isNotEmpty)
                                    ? ListView.builder(
                                        itemCount:
                                            state.immunizationList.length,
                                        shrinkWrap: true,
                                        physics: NeverScrollableScrollPhysics(),
                                        itemBuilder: (context, index) {
                                          DocumentDTO immunizationObject =
                                              state.immunizationList[index];
                                          return Padding(
                                            padding: EdgeInsets.only(
                                                top: getSize(10)),
                                            child: SelectedDocumentBox(
                                              pickedFile:
                                                  immunizationObject.file,
                                              title: immunizationObject
                                                      .name_of_vaccinations ??
                                                  "",
                                              showDeleteButton: true,
                                              deleteDescription: StringConstant
                                                  .deleteImmunizationDesc,
                                              onCancelClick: () {
                                                context.router.maybePop();
                                              },
                                              onDeleteClick: () {
                                                context
                                                    .read<ImmunizationBloc>()
                                                    .add(ImmunizationEvent
                                                        .deleteImmunizationObject(
                                                            index));
                                                context.router.maybePop();
                                              },
                                              showEditButton: isUpdate,
                                              onEditClick: () {
                                                editDocument(context,
                                                    immunizationObject);
                                              },
                                            ),
                                          );
                                        })
                                    : SelectedDocumentBox(
                                        leadingImageString: SvgImageConstant
                                            .documentWithVerticalLine,
                                        title: "",
                                        subTitle1:
                                            StringConstant.immunizationDesc,
                                        showDeleteButton: false,
                                      ),
                                SizedBox(
                                  height: getSize(20),
                                ),
                                immunizationNameField(context, state),
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
                                        vertical: getSize(10),
                                        horizontal: getSize(20)),
                                    child: const BaseText(
                                      text: StringConstant
                                          .pleaseSelectImmunizationDocument,
                                      fontSize: 12,
                                      textColor: AppColors.red,
                                    ),
                                  ),
                                paddingBetweenFields(),
                                addMoreButton(
                                  context,
                                  state,
                                  onPressed: () {
                                    context.read<ImmunizationBloc>().add(
                                        const ImmunizationEvent
                                            .addMoreImmunizationDoc());
                                  },
                                ),
                                paddingBetweenFields(height: 40)
                              ],
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            top: getSize(20), bottom: getSize(10)),
                        child: Align(
                          alignment: Alignment.center,
                          child: CommonButton(
                            onPressed: () {
                              context.read<ImmunizationBloc>().add(
                                  ImmunizationEvent.immunizationDocSubmit(
                                      context,
                                      isAddMoreBtnClick: false,
                                      isSkip: false));
                            },
                            buttonText: StringConstant.txtContinue,
                          ),
                        ),
                      ),
                      // if (state.immunizationList.isEmpty)
                      documentSkipButton(
                        context,
                        onPressed: () {
                          context.read<ImmunizationBloc>().add(
                              ImmunizationEvent.immunizationDocSubmit(context,
                                  isAddMoreBtnClick: false, isSkip: true));
                        },
                      ),
                      paddingBetweenFields(),
                    ],
                  ),
                );
        },
      ),
    );
  }

  Widget selectedImage(BuildContext context, String selectedFile,
      {required ImmunizationState state}) {
    return ShowPickedFile(
      selectedFile: selectedFile,
      mainBoxHeight: getSize(300),
      childBoxHeight: getSize(250),
      childBoxWidth: getSize(250),
      onDelete: () {
        AppDialog.showDelete(
          context,
          title: StringConstant.delete,
          infoMessage: StringConstant.deleteCredentialImageDesc,
          onCancelClick: () {
            Navigator.pop(context);
          },
          onDeleteClick: () {
            if (state.immunizationDoc.isValid()) {
              context.read<ImmunizationBloc>().add(
                    ImmunizationEvent.deleteImmunizationDoc(
                        state.immunizationDoc.getValue()!),
                  );
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
          context.read<ImmunizationBloc>().add(
                ImmunizationEvent.selectImmunizationDoc(path),
              );
        }
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
      },
      selectPdfCallback: () async {
        String path = await FilePickerUtils().pickPdf(context: context) ?? '';
        if (path.isNotEmpty) {
          print("SELECTED FILE PATH: $path");
          context.read<ImmunizationBloc>().add(
                ImmunizationEvent.selectImmunizationDoc(path),
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

  editDocument(
    BuildContext context,
    DocumentDTO? currentDoc,
  ) {
    return showDialog(
        context: context,
        builder: (context) {
          return BlocProvider(
            create: (context) => getIt<ImmunizationBloc>()
              ..add(ImmunizationEvent.getCurrentImmunizationDoc(currentDoc)),
            child: BlocBuilder<ImmunizationBloc, ImmunizationState>(
              builder: (context, state) {
                return (state.isImmunizationDocSubmitting)
                    ? CenterLoadingIndicator()
                    : AlertDialog(
                        backgroundColor: AppColors.scaffoldColor,
                        insetPadding: EdgeInsets.symmetric(
                            vertical: getSize(50), horizontal: getSize(10)),
                        content: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              immunizationNameField(context, state),
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
                                      vertical: getSize(10),
                                      horizontal: getSize(20)),
                                  child: const BaseText(
                                    text: StringConstant
                                        .pleaseSelectCredentialRegistrationDocument,
                                    fontSize: 12,
                                    textColor: AppColors.red,
                                  ),
                                ),
                              paddingBetweenFields(),
                              Padding(
                                padding: EdgeInsets.only(
                                    top: getSize(20), bottom: getSize(10)),
                                child: Align(
                                  alignment: Alignment.center,
                                  child: CommonButton(
                                    onPressed: () {
                                      context.read<ImmunizationBloc>().add(
                                              ImmunizationEvent
                                                  .immunizationDocUpdate(
                                            context,
                                            id: currentDoc?.id,
                                          ));
                                    },
                                    buttonText: StringConstant.update,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
              },
            ),
          );
        }).then((value) {
      if (value == true) {
        context
            .read<ImmunizationBloc>()
            .add(ImmunizationEvent.getImmunizationDataOnInit());
      }
    });
  }

  Widget immunizationNameField(BuildContext context, ImmunizationState state) {
    return CustomTextField(
      labelText: StringConstant.nameOfImmunizationsVaccinations,
      hintText: StringConstant.nameOfImmunizationsVaccinations,
      initialValue: state.immunizationName.getValue(),
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
    bool isAllDetailsAdded =
        (state.immunizationName.isValid() && state.immunizationDoc.isValid())
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
            ? AppColors.primaryColor.withValues(alpha: 0.15)
            : AppColors.primaryColor.withValues(alpha: 0.05),
        buttonTextColor: (isAllDetailsAdded)
            ? AppColors.primaryColor
            : AppColors.primaryColor.withValues(alpha: 0.3),
      ),
    );
  }
}
