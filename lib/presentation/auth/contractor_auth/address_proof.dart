import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shift/application/auth/contractor_auth/address_proof/address_proof_bloc.dart';
import 'package:shift/domain/core/document_expiry_picker.dart';
import 'package:shift/domain/core/math_utils.dart';
import 'package:shift/domain/core/string_constant.dart';
import 'package:shift/infrastructure/core/skill_list_model/skill_dto.dart';
import 'package:shift/injection.dart';
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
import 'package:shift/presentation/main/widgets/home_app_bar.dart';

@RoutePage(name: 'AddressProofScreen')
class AddressProofScreen extends StatelessWidget {
  final bool isFromSplash;
  final bool isUpdate;

  const AddressProofScreen(
      {super.key, this.isFromSplash = false, this.isUpdate = false});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          getIt<AddressProofBloc>()..add(AddressProofEvent.getAddressProof()),
      child: BlocConsumer<AddressProofBloc, AddressProofState>(
        listener: (context, state) {
          state.addressProofFailureOrSuccessOption.fold(
            () {},
            (either) => either.fold(
              (failure) {},
              (r) {},
            ),
          );
        },
        builder: (context, state) {
          return Scaffold(
            appBar: CommonAppBar(
              isShowBackBtn: !isFromSplash,
              onBackPressed: () {
                context.router.maybePop();
              },
              title: StringConstant.addressProof,
            ),
            body: (state.isLoading)
                ? CenterLoadingIndicator(isOnlyLoader: true)
                : Padding(
                    padding: EdgeInsets.symmetric(horizontal: getSize(20)),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        selectIdTypeDropdown(context, state),
                        Gap(getSize(10)),
                        docLimitNote(
                          limit: state.currentAddressProofType.short_name ?? "",
                        ),
                        Gap(getSize(15)),
                        (state.currentAddressProofType.id != null)
                            ? Expanded(
                                child: SingleChildScrollView(
                                  child: Form(
                                    autovalidateMode: (state.showErrorMesages)
                                        ? AutovalidateMode.always
                                        : AutovalidateMode.disabled,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        pickImageView(state, context),
                                        if (state.currentAddressProofType
                                                .yearLimit !=
                                            null)
                                          DocumentExpiryDatePicker
                                              .expiryDateTextField(
                                            context,
                                            isOptional: state
                                                    .currentAddressProofType
                                                    .isMandatory ==
                                                false,
                                            labelStyle: TextStyle(
                                                fontSize: getFontSize(12)),
                                            lastDate: DateTime.now()
                                                .add(Duration(days: 25 * 365)),
                                            onPickedDate: (pickedDate) {
                                              context
                                                  .read<AddressProofBloc>()
                                                  .add(AddressProofEvent
                                                      .expiryDateChanged(
                                                          pickedDate
                                                              .toString()));
                                            },
                                            onCancelClick: () {
                                              context
                                                  .read<AddressProofBloc>()
                                                  .add(AddressProofEvent
                                                      .expiryDateChanged(""));
                                            },
                                            selectedDate: state.docExpiryDate,
                                            isDisabled: true,
                                          ),
                                        if (((state.docExpiryDate.isEmpty) &&
                                                state.showErrorMesages) ||
                                            (state.docExpiryDate.isEmpty) &&
                                                (state.isExpiryInValid))
                                          Padding(
                                            padding: EdgeInsets.symmetric(
                                                vertical: getSize(5)),
                                            child: BaseText(
                                              text: (state.currentAddressProofType
                                                          .isMandatory ==
                                                      true)
                                                  ? "* ${((state.isExpiryInValid && state.currentAddressProofType.short_name != null)) ? "Expiry date ${state.currentAddressProofType.short_name?.toLowerCase()}" : StringConstant.pleaseSelectExpiryDate}"
                                                  : "",
                                              fontSize: 12,
                                              textColor: AppColors.red,
                                            ),
                                          ),
                                        SizedBox(height: getSize(30)),
                                      ],
                                    ),
                                  ),
                                ),
                              )
                            : blankView(),
                        if (state.currentAddressProofType.id != null)
                          Align(
                            alignment: Alignment.bottomCenter,
                            child: Padding(
                              padding: EdgeInsets.only(
                                  top: getSize(20), bottom: getSize(20)),
                              child: CommonButton(
                                isSubmitting: state.isSubmitting,
                                onPressed: () {
                                  context
                                      .read<AddressProofBloc>()
                                      .add(AddressProofEvent.addressProofSubmit(
                                        context,
                                        isUpdate: isUpdate,
                                      ));
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
      ),
    );
  }

  Widget selectedImage(BuildContext context, String selectedFile,
      {required AddressProofState state, bool isBackFile = false}) {
    return ShowPickedFile(
      selectedFile: selectedFile,
      mainBoxHeight: getSize(300),
      childBoxHeight: getSize(250),
      childBoxWidth: getSize(260),
      onDelete: () {
        AppDialog.showDelete(
          context,
          title: StringConstant.delete,
          infoMessage: StringConstant.deleteAddressProofDesc,
          onCancelClick: () {
            Navigator.pop(context);
          },
          onDeleteClick: () {
            if (isBackFile) {
              context.read<AddressProofBloc>().add(
                    AddressProofEvent.deleteAddressBackDoc(
                        state.addressProofBackDoc.getValue()!),
                  );
            } else {
              context.read<AddressProofBloc>().add(
                    AddressProofEvent.deleteAddressFrontDoc(
                        state.addressproofFrontDoc.getValue()!),
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
    AddressProofState state,
  ) {
    return CustomDropdownField(
      label: StringConstant.selectAnAddressProof,
      fontSize: 14,
      onChanged: (value) {
        if (value != null) {
          context.read<AddressProofBloc>().add(
              AddressProofEvent.selectAddressProofType(value ?? SkillDTO()));
        }
      },
      hintText: StringConstant.selectYourAddressProof,
      value: (state.currentAddressProofType.id != null)
          ? state.currentAddressProofType
          : null,
      items: state.addressProofDropDownList.map((val) {
        return DropdownMenuItem<SkillDTO>(
          value: val,
          child: RichText(
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
            text: TextSpan(
              text: val.name ?? "",
              style: TextStyle(
                fontSize: getFontSize(14),
                color: AppColors.black,
              ),
              children: [
                TextSpan(
                  text: (val.short_name != null && val.short_name!.isNotEmpty)
                      ? "  (${val.short_name ?? ""})"
                      : "",
                  style: TextStyle(fontSize: getFontSize(10)),
                ),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget docLimitNote({required String limit}) {
    return (limit.isNotEmpty)
        ? Container(
            alignment: Alignment.centerLeft,
            padding: EdgeInsets.symmetric(
                    horizontal: getSize(10), vertical: getSize(10))
                .copyWith(left: getSize(15)),
            decoration: BoxDecoration(
                color: AppColors.grey04,
                borderRadius: BorderRadius.circular(10)),
            child: BaseText(
              text: "${StringConstant.note}: $limit",
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
          )
        : Container();
  }

  Widget pickImageView(AddressProofState state, BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: EdgeInsets.only(left: getSize(15), bottom: getSize(10)),
          child: BaseText(
            text: StringConstant.frontPage,
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
        imageView(
          state,
          context,
          doc: state.addressproofFrontDoc.getValue(),
          showDocError:
              (state.showErrorMesages && !state.addressproofFrontDoc.isValid()),
          errorMsg: StringConstant.pleaseSelectFrontPageOfAddressProof,
          takePhotoCallback: (path) {
            context.read<AddressProofBloc>().add(
                  AddressProofEvent.selectAddressFrontDoc(path),
                );
          },
          selectPhotoCallback: (path) {
            context.read<AddressProofBloc>().add(
                  AddressProofEvent.selectAddressFrontDoc(path),
                );
          },
          selectPdfCallback: (path) {
            context.read<AddressProofBloc>().add(
                  AddressProofEvent.selectAddressFrontDoc(path),
                );
          },
        ),
        Padding(
          padding: EdgeInsets.only(left: getSize(15), bottom: getSize(10))
              .copyWith(top: getSize(15)),
          child: BaseText(
            text: StringConstant.backPage,
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
        imageView(
          state,
          context,
          isBackFile: true,
          doc: state.addressProofBackDoc.getValue(),
          showDocError:
              (state.showErrorMesages && !state.addressProofBackDoc.isValid()),
          errorMsg: StringConstant.pleaseSelectBackPageOfAddressProof,
          takePhotoCallback: (path) {
            context.read<AddressProofBloc>().add(
                  AddressProofEvent.selectAddressBackDoc(path),
                );
          },
          selectPhotoCallback: (path) {
            context.read<AddressProofBloc>().add(
                  AddressProofEvent.selectAddressBackDoc(path),
                );
          },
          selectPdfCallback: (path) {
            context.read<AddressProofBloc>().add(
                  AddressProofEvent.selectAddressBackDoc(path),
                );
          },
        ),
        SizedBox(height: getSize(30)),
      ],
    );
  }

  Widget imageView(
    AddressProofState state,
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
                      }
                    },
                    selectPdfCallback: () async {
                      String path =
                          await FilePickerUtils().pickPdf(context: context) ??
                              '';
                      if (path.isNotEmpty) {
                        selectPdfCallback(path);
                        print("PDF FILE PATH: $path");
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

  Widget blankView() {
    return Expanded(
      child: Center(
        child: SizedBox(
          width: getSize(350),
          child: BaseText(
            text:
                StringConstant.pleaseSelectYourAddressProofDocumentFromTheList,
            textAlign: TextAlign.center,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
