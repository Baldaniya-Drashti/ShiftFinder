// ignore_for_file: prefer_const_constructors, use_build_context_synchronously, avoid_print

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
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
      create: (context) =>
          getIt<EquipmentBloc>()..add(EquipmentEvent.getEquipmentList()),
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
              (r) {},
            ),
          );
          state.submitDocAuthFailureOrSuccessOption.fold(
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
                  const PageRouteInfo(AddBankDetailsScreen.name),
                );
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
          return (state.isEquipmentDocSubmitting)
              ? CenterLoadingIndicator()
              : Padding(
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
                                    DocumentDTO immunizationObject =
                                        state.equipmentList[index];
                                    return Padding(
                                      padding:
                                          EdgeInsets.only(top: getSize(10)),
                                      child: SelectedDocumentBox(
                                        pickedFile: immunizationObject.file,
                                        title:
                                            immunizationObject.document_title ??
                                                "",
                                        showDeleteButton: true,
                                        deleteDescription:
                                            StringConstant.deleteEquipmentDesc,
                                        onCancelClick: () {
                                          context.router.maybePop();
                                        },
                                        onDeleteClick: () {
                                          context.read<EquipmentBloc>().add(
                                              EquipmentEvent
                                                  .deleteEquipmentObject(
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
                                  vertical: getSize(10),
                                  horizontal: getSize(20)),
                              child: const BaseText(
                                text: StringConstant
                                    .pleaseSelectEquipmentDocument,
                                fontSize: 12,
                                textColor: AppColors.red,
                              ),
                            ),
                          paddingBetweenFields(),
                          addMoreButton(
                            context,
                            state,
                            onPressed: () {
                              context.read<EquipmentBloc>().add(
                                  const EquipmentEvent.addMoreEquipmentDoc());
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
    return ShowPickedFile(
      selectedFile: selectedFile,
      mainBoxHeight: getSize(400),
      childBoxHeight: getSize(350),
      childBoxWidth: getSize(315),
      onDelete: () {
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
      selectPdfCallback: () async {
        String path = await FilePickerUtils().pickPdf(context: context) ?? '';
        if (path.isNotEmpty) {
          print("SELECTED FILE PATH: $path");
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
      textCapitalization: TextCapitalization.sentences,
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
