import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shift/application/main_tab/shifts/shifts_bloc_bloc.dart';
import 'package:shift/domain/core/math_utils.dart';
import 'package:shift/domain/core/svg_image_constants.dart';
import 'package:shift/presentation/common/widgets/base_text.dart';
import 'package:shift/presentation/core/widgets/dropdown/custom_dropdown_textfield.dart';

class CancelledShiftView extends StatelessWidget {
  const CancelledShiftView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ShiftsBloc, ShiftsBlocState>(
      builder: (context, state) {
        return Column(
          children: [
            SizedBox(
              height: getSize(15),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: getSize(20)),
              child: BaseText(
                text: 'Sort by',
                fontSize: 10,
                fontWeight: FontWeight.w500,
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: getSize(20)),
              child: BaseText(
                text: 'Sort by',
                fontSize: 10,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(
              height: getSize(8),
            ),
            locationAddressTextField(context, state),
            SizedBox(
              height: getSize(12),
            ),
          ],
        );
      },
    );
  }

  Widget locationAddressTextField(
    BuildContext context,
    ShiftsBlocState state,
  ) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: getSize(20)),
      child: CustomDropdownTextfield(
        valueController: state.cancelledShiftSortByLocationController,
        list: state.locationList,
        hintText: 'Location',
        validator: (p0) {
          if (p0 == null || p0.isEmpty) {
            return 'Please select location';
          } else {
            return null;
          }
        },
        prefixIcon: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: getSize(14),
            vertical: getSize(16),
          ),
          child: SvgPicture.asset(
            SvgImageConstant.locationIcon,
            colorFilter: ColorFilter.mode(Colors.black, BlendMode.srcATop),
            height: getSize(15),
            width: getSize(15),
          ),
        ),
      ),
    );
  }
}
