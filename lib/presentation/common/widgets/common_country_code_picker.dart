import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shift/domain/core/math_utils.dart';
import 'package:shift/domain/core/svg_image_constants.dart';
import 'package:shift/presentation/common/widgets/base_text.dart';

class CommonCountryCodePicker extends StatelessWidget {
  final Function(Country) onChanged;
  final String? initialSelection;
  const CommonCountryCodePicker({
    super.key,
    required this.onChanged,
    this.initialSelection,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: getSize(14)),
      child: GestureDetector(
        onTap: () {
          showFlag(context);
        },
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            SvgPicture.asset(
              SvgImageConstant.contact,
            ),
            Padding(
              padding: EdgeInsets.only(
                left: getSize(15),
                right: getSize(10),
              ),
              child: BaseText(
                text: '$initialSelection',
                fontSize: 20,
                fontWeight: FontWeight.w500,
              ),
            ),
            SvgPicture.asset(
              SvgImageConstant.downArrow,
              height: getSize(7),
              width: getSize(10),
            ),
            SizedBox(
              width: getSize(15),
            ),
          ],
        ),
      ),
    );
  }

  void showFlag(BuildContext context) {
    showCountryPicker(
      context: context,
      exclude: <String>['KN', 'MF'],
      favorite: <String>['CA'],
      //Optional. Shows phone code before the country name.
      showPhoneCode: true,
      onSelect: onChanged,
      countryListTheme: const CountryListThemeData(
        inputDecoration: InputDecoration(
          //labelText: 'Search',
          hintText: 'Start typing to search',
          prefixIcon: Icon(Icons.search),
          border: UnderlineInputBorder(
            borderSide: BorderSide(
                // color: ColorConstants.unableColor,
                ),
          ),
          focusedBorder: UnderlineInputBorder(
              // borderSide: BorderSide(color: ColorConstants.unableColor),
              ),
          enabledBorder: UnderlineInputBorder(
              // borderSide: BorderSide(color: ColorConstants.unableColor),
              ),
        ),
      ),
    );
  }

  // Country? getCountryByCode(String code) {
  //   try {
  //     return countryCodes.firstWhere(
  //         (country) => country.phoneCode == code.replaceAll('+', ''));
  //   } catch (e) {
  //     return null;
  //   }
  // }
}
