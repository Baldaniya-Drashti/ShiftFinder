import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shift/application/auth/contractor_auth/proof__of_legal_status_bloc/proof_of_legal_status_bloc.dart';
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

@RoutePage(name: 'ProofOfLegalStatus')
class ProofOfLegalStatus extends StatelessWidget {
  bool isFromSplash = false;

  ProofOfLegalStatus({super.key, this.isFromSplash = false});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<ProofOfLegalStatusBloc>(),
      // ..add(ProofOfLegalStatusEvent.getAddressProof()),
      child: BlocConsumer<ProofOfLegalStatusBloc, ProofOfLegalStatusState>(
        listener: (context, state) {
          state.proofFailureOrSuccessOption.fold(
            () {},
            (either) => either.fold(
              (failure) {},
              (r) {
                print("LISTENER CALLED");
              },
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
              title: StringConstant.proofOfLegalWorkStatus,
            ),
            body: (state.isLoading)
                ? CenterLoadingIndicator(isOnlyLoader: true)
                : Padding(
                    padding: EdgeInsets.symmetric(horizontal: getSize(20)),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(
                              left: getSize(15), bottom: getSize(15)),
                          child: BaseText(
                            text: StringConstant.proofOfLegalDesc1,
                            fontSize: 12,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              left: getSize(15), bottom: getSize(15)),
                          child: BaseText(
                            text: StringConstant.proofOfLegalDesc2,
                            fontSize: 12,
                          ),
                        ),
                        selectIdTypeDropdown(context, state),
                        Gap(getSize(15)),
                        (state.currentProofType.id != null)
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
                                        if (state
                                                .currentProofType.isMandatory ==
                                            true) ...[
                                          DocumentExpiryDatePicker
                                              .expiryDateTextField(
                                            context,
                                            labelStyle: TextStyle(
                                              fontSize: getFontSize(12),
                                            ),
                                            lastDate: DateTime.now()
                                                .add(Duration(days: 25 * 365)),
                                            onPickedDate: (pickedDate) {
                                              context
                                                  .read<
                                                      ProofOfLegalStatusBloc>()
                                                  .add(ProofOfLegalStatusEvent
                                                      .expiryDateChanged(
                                                          pickedDate
                                                              .toString()));
                                            },
                                            onCancelClick: () {
                                              context
                                                  .read<
                                                      ProofOfLegalStatusBloc>()
                                                  .add(ProofOfLegalStatusEvent
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
                                                text:
                                                    "* ${(state.isExpiryInValid) ? "Expiry date of ${state.currentProofType.name} valid for ${state.currentProofType.yearLimit} year, Please enter valid expiry date" : StringConstant.pleaseSelectExpiryDate}",
                                                fontSize: 12,
                                                textColor: AppColors.red,
                                              ),
                                            ),
                                        ],
                                        SizedBox(height: getSize(30)),
                                      ],
                                    ),
                                  ),
                                ),
                              )
                            : blankView(),
                        if (state.currentProofType.id != null)
                          Align(
                            alignment: Alignment.bottomCenter,
                            child: Padding(
                              padding: EdgeInsets.only(
                                  top: getSize(20), bottom: getSize(20)),
                              child: CommonButton(
                                isSubmitting: state.isSubmitting,
                                onPressed: () {
                                  context.read<ProofOfLegalStatusBloc>().add(
                                      ProofOfLegalStatusEvent
                                          .proofLegalDocSubmit(context));
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
      {required ProofOfLegalStatusState state, bool isBackFile = false}) {
    return ShowPickedFile(
      selectedFile: selectedFile,
      mainBoxHeight: getSize(300),
      childBoxHeight: getSize(250),
      childBoxWidth: getSize(260),
      onDelete: () {
        AppDialog.showDelete(
          context,
          title: StringConstant.delete,
          infoMessage: StringConstant.deleteProofLegalDesc,
          onCancelClick: () {
            Navigator.pop(context);
          },
          onDeleteClick: () {
            if (isBackFile) {
              context.read<ProofOfLegalStatusBloc>().add(
                    ProofOfLegalStatusEvent.deleteBackDoc(
                        state.proofBackDoc.getValue()!),
                  );
            } else {
              context.read<ProofOfLegalStatusBloc>().add(
                    ProofOfLegalStatusEvent.deleteFrontDoc(
                        state.proofFrontDoc.getValue()!),
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
    ProofOfLegalStatusState state,
  ) {
    return CustomDropdownField(
      onChanged: (value) {
        if (value != null) {
          context.read<ProofOfLegalStatusBloc>().add(
              ProofOfLegalStatusEvent.selectAddressProofType(
                  value ?? SkillDTO()));
        }
      },
      hintText: StringConstant.selectYourLegalWorkStatus,
      value:
          (state.currentProofType.id != null) ? state.currentProofType : null,
      items: state.proofDropDownList.map((val) {
        return DropdownMenuItem<SkillDTO>(
            value: val, child: BaseText(text: val.name ?? "", fontSize: 12));
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

  Widget pickImageView(ProofOfLegalStatusState state, BuildContext context) {
    print("state.currentProofType-----------> ${state.currentProofType}");
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: EdgeInsets.only(left: getSize(15), bottom: getSize(10)),
          child: BaseText(
            text: StringConstant.frontPage,
            fontSize: 12,
            fontWeight: FontWeight.w500,
          ),
        ),
        imageView(
          state,
          context,
          doc: state.proofFrontDoc.getValue(),
          showDocError:
              (state.showErrorMesages && !state.proofFrontDoc.isValid()),
          errorMsg:
              StringConstant.pleaseSelectFrontPageOfProofOfLegalWorkStatus,
          takePhotoCallback: (path) {
            context.read<ProofOfLegalStatusBloc>().add(
                  ProofOfLegalStatusEvent.selectFrontDoc(path),
                );
          },
          selectPhotoCallback: (path) {
            context.read<ProofOfLegalStatusBloc>().add(
                  ProofOfLegalStatusEvent.selectFrontDoc(path),
                );
          },
          selectPdfCallback: (path) {
            context.read<ProofOfLegalStatusBloc>().add(
                  ProofOfLegalStatusEvent.selectFrontDoc(path),
                );
          },
        ),
        Padding(
          padding: EdgeInsets.only(left: getSize(15), bottom: getSize(10))
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
          doc: state.proofBackDoc.getValue(),
          showDocError:
              (state.showErrorMesages && !state.proofBackDoc.isValid()),
          errorMsg:
              StringConstant.pleaseSelectFrontPageOfProofOfLegalWorkStatus,
          takePhotoCallback: (path) {
            context.read<ProofOfLegalStatusBloc>().add(
                  ProofOfLegalStatusEvent.selectBackDoc(path),
                );
          },
          selectPhotoCallback: (path) {
            context.read<ProofOfLegalStatusBloc>().add(
                  ProofOfLegalStatusEvent.selectBackDoc(path),
                );
          },
          selectPdfCallback: (path) {
            context.read<ProofOfLegalStatusBloc>().add(
                  ProofOfLegalStatusEvent.selectBackDoc(path),
                );
          },
        ),
        /* if (state.currentProofType.id != 3 &&
            state.currentProofType.id != 4) ...[
          SizedBox(height: getSize(15)),
          DocumentExpiryDatePicker.expiryDateTextField(
            context,
            lastDate: DateTime.now().add(Duration(days: 25 * 365)),
            onPickedDate: (pickedDate) {
              context.read<ProofOfLegalStatusBloc>().add(
                  ProofOfLegalStatusEvent.govermentExpiryDateChanged(
                      pickedDate.toString()));
            },
            onCancelClick: () {
              context
                  .read<ProofOfLegalStatusBloc>()
                  .add(ProofOfLegalStatusEvent.govermentExpiryDateChanged(""));
            },
            selectedDate: state.governmentExpiryDate,
            isDisabled: !state.isGovernemtExpiryCheck,
          ),
          if ((!state.isGovernemtExpiryCheck &&
                  state.governmentExpiryDate.isEmpty) &&
              state.showErrorMesages)
            Padding(
              padding: EdgeInsets.symmetric(vertical: getSize(5)),
              child: const BaseText(
                text: "* ${StringConstant.pleaseSelectExpiryDate}",
                fontSize: 12,
                textColor: AppColors.red,
              ),
            ),
        ], */
        SizedBox(height: getSize(30)),
      ],
    );
  }

  Widget imageView(
    ProofOfLegalStatusState state,
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
                doc ?? "",
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
                        /* context.read<ProofOfLegalStatusBloc>().add(
                              ProofOfLegalStatusEvent.selectGovermentDoc(path),
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
                        /* context.read<ProofOfLegalStatusBloc>().add(
                              ProofOfLegalStatusEvent.selectGovermentDoc(path),
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
                        /* context.read<ProofOfLegalStatusBloc>().add(
                              ProofOfLegalStatusEvent.selectGovermentDoc(path),
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

  Widget blankView() {
    return Expanded(
      child: Center(
        child: SizedBox(
          width: getSize(350),
          child: BaseText(
            text:
                StringConstant.pleaseSelectYourLegalWorkStatusProofFromTheList,
            textAlign: TextAlign.center,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
