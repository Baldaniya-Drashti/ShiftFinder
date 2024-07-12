import 'package:flutter/material.dart';
import 'package:shift/domain/core/math_utils.dart';
import 'package:shift/domain/core/string_constant.dart';
import 'package:shift/domain/core/svg_image_constants.dart';
import 'package:shift/presentation/common/widgets/selected_document_box.dart';
import 'package:shift/presentation/common/widgets/upload_document_box.dart';
import 'package:shift/presentation/core/style/app_colors.dart';
import 'package:shift/presentation/core/widgets/buttons/common_button.dart';
import 'package:shift/presentation/core/widgets/inputs/custom_dropdown_with_textfield.dart';
import 'package:shift/presentation/core/widgets/inputs/custom_text_field.dart';

class CredentialRegistration extends StatelessWidget {
  const CredentialRegistration({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: getSize(20)),
      child: SingleChildScrollView(
        child: Column(
          children: [
            SelectedDocumentBox(
              // leadingImageString: SvgImageConstant.documentWithVerticalLine,
              title: "",
              subTitle1: StringConstant.credentialRegistrationDesc,
              showDeleteButton: false,
            ),
            ListView.builder(
                itemCount: 2,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: EdgeInsets.only(top: getSize(10)),
                    child: SelectedDocumentBox(
                      // leadingImageString:
                      //     SvgImageConstant.documentWithVerticalLine,
                      title: "Document Title",
                      subTitle1: "Province of Registration",
                      subTitle2: "Registration Number",
                      showDeleteButton: false,
                    ),
                  );
                }),
            SizedBox(
              height: getSize(20),
            ),
            registrationNoField(),
            paddingBetweenFields(),
            provinceRegistrationDropdown(),
            paddingBetweenFields(),
            documentTitleField(),
            paddingBetweenFields(),
            UploadDocumentBox(
              height: getSize(300),
              onUploadBtnPressed: () {},
            ),
            paddingBetweenFields(),
            addMoreButton(
              onPressed: () {},
            ),
            Padding(
              padding: EdgeInsets.only(top: getSize(50), bottom: getSize(50)),
              child: CommonButton(
                onPressed: () {},
                buttonText: StringConstant.txtContinue,
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget paddingBetweenFields({double? height}) {
    return SizedBox(
      height: getSize(height ?? 15),
    );
  }

  Widget registrationNoField() {
    return const CustomTextField(
      labelText: StringConstant.registrationNumber,
      hintText: StringConstant.registrationNumber,
      isOptional: true,
    );
  }

  Widget documentTitleField() {
    return const CustomTextField(
      labelText: StringConstant.documentTitle,
      hintText: StringConstant.documentTitle,
    );
  }

  Widget provinceRegistrationDropdown() {
    return CustomDropdwonWithTextField(
      labelText: StringConstant.provinceOfRegistration,
      hintText: StringConstant.selectYourProvinceOfRegistration,
      isLabelPadding: true,
      showTextfield: false,
      items: [],
      onChanged: (value) {},
    );
  }

  Widget addMoreButton({required VoidCallback onPressed}) {
    return CommonButton(
      onPressed: onPressed,
      buttonText: "+ ${StringConstant.addMore}",
      width: 105,
      borderRadius: 10,
      buttonFontSize: 12,
      buttonFontWeight: FontWeight.w600,
      height: 35,
      backgroundColor: AppColors.primaryColor.withOpacity(0.05),
      buttonTextColor: AppColors.primaryColor.withOpacity(0.3),
    );
  }
}
