import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shift/domain/core/math_utils.dart';
import 'package:shift/domain/core/string_constant.dart';
import 'package:shift/domain/core/svg_image_constants.dart';
import 'package:shift/presentation/common/widgets/base_text.dart';
import 'package:shift/presentation/core/style/app_colors.dart';
import 'package:shift/presentation/core/widgets/inputs/custom_text_field.dart';

class CustomDropdwonWithTextField extends StatelessWidget {
  const CustomDropdwonWithTextField({
    super.key,
    this.labelText,
    required this.hintText,
    this.value,
    required this.items,
    required this.onChanged,
    this.isLabelPadding = false,
    this.showTextfield = true,
    this.showPrefixIcon = false,
    this.validator,
    this.isOptional = false,
    this.suffixIcon,
    this.fieldOnChanged,
    this.fieldValidator,
    this.fieldController,
  });
  final String? labelText;
  final String? hintText;
  final String? value;
  final List<String> items;
  final bool? isLabelPadding;
  final bool showTextfield;
  final Function(String?)? onChanged;
  final String? Function(String?)? validator;
  final bool showPrefixIcon;
  final bool? isOptional;
  final Widget? suffixIcon;
  final Function(String)? fieldOnChanged;
  final String? Function(String?, BuildContext)? fieldValidator;
  final TextEditingController? fieldController;

  @override
  Widget build(BuildContext context) {
    final border = OutlineInputBorder(
      borderSide: const BorderSide(color: AppColors.white),
      borderRadius: BorderRadius.circular(10),
    );
    final focusedBorder = OutlineInputBorder(
      borderSide: const BorderSide(color: AppColors.white),
      borderRadius: BorderRadius.circular(10),
    );
    final errorBorder = OutlineInputBorder(
      borderSide: const BorderSide(color: AppColors.red),
      borderRadius: BorderRadius.circular(10),
    );
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (labelText != null) ...[
          Padding(
            padding: EdgeInsets.only(
                left: getSize((isLabelPadding == true) ? 20 : 0)),
            child: (isOptional == true)
                ? RichText(
                    text: TextSpan(
                        text: labelText ?? "",
                        style: TextStyle(
                            fontSize: getFontSize(14),
                            fontWeight: FontWeight.w500,
                            color: AppColors.black,
                            fontFamily: "Roboto Flex"),
                        children: [
                          TextSpan(
                            text: "  (Optional)",
                            style: TextStyle(
                              fontSize: getFontSize(10),
                              fontWeight: FontWeight.w500,
                              color: AppColors.black.withOpacity(0.8),
                              fontFamily: "Roboto Flex",
                            ),
                          )
                        ]),
                  )
                : BaseText(
                    text: labelText!,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    textColor: AppColors.black,
                  ),
          ),
          const SizedBox(height: 7),
        ],
        Container(
          decoration: BoxDecoration(
            color: showTextfield ? AppColors.white : AppColors.transparent,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: AppColors.lightGrey.withOpacity(0.2),
                blurRadius: 30,
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              DropdownButtonFormField<String>(
                validator: validator,
                dropdownColor: AppColors.white,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: AppColors.white,
                  prefixIcon: (showPrefixIcon)
                      ? Padding(
                          padding: EdgeInsets.symmetric(
                            vertical: getSize(14),
                          ),
                          child: SvgPicture.asset(
                            SvgImageConstant.association,
                            height: getSize(24),
                            width: getSize(24),
                          ),
                        )
                      : null,
                  enabledBorder: border,
                  border: border,
                  focusedErrorBorder: errorBorder,
                  focusedBorder: focusedBorder,
                  errorBorder: errorBorder,
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: getSize(18),
                  ),
                ),
                alignment: Alignment.centerLeft,
                hint: BaseText(
                  text: hintText!,
                  textColor: AppColors.black.withOpacity(0.50),
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
                value: value,
                icon: Icon(
                  Icons.keyboard_arrow_down,
                  size: getSize(25),
                  color: AppColors.black,
                ),
                isExpanded: true,
                items: items.map((val) {
                  return DropdownMenuItem(
                    value: val,
                    child: BaseText(
                      text: val,
                      fontSize: 14,
                      textColor: AppColors.black,
                    ),
                  );
                }).toList(),
                onChanged: onChanged,
              ),
              if (showTextfield) ...[
                Divider(
                  color: AppColors.black.withOpacity(0.3),
                  indent: getSize(18),
                  endIndent: getSize(18),
                ),
                textField(context),
              ],
            ],
          ),
        ),
      ],
    );
  }

  Widget textField(
    BuildContext context,
  ) {
    return CustomTextField(
      // labelText: StringConstant.address,
      // isLabelPadding: true,
      suffixIcon: suffixIcon,
      isBoxShadow: false,
      hintText: StringConstant.typeFacilityType,
      errorInputBorder: UnderlineInputBorder(
        borderSide: const BorderSide(
          color: AppColors.red,
        ),
        borderRadius: BorderRadius.circular(getSize(10)),
      ),
      errorMaxLines: 2,
      onChanged: fieldOnChanged,
      validator: fieldValidator,
      controller: fieldController,
    );
  }
}
