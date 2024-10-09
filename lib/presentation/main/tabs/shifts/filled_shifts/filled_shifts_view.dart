import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shift/application/main_tab/shifts/shifts_bloc_bloc.dart';
import 'package:shift/domain/core/math_utils.dart';
import 'package:shift/domain/core/svg_image_constants.dart';
import 'package:shift/presentation/common/widgets/base_text.dart';
import 'package:shift/presentation/core/widgets/dropdown/custom_dropdown_textfield.dart';
import 'package:shift/presentation/main/tabs/shifts/filled_shifts/widgets/filled_shift_list.dart';

@RoutePage(name: 'FilledShiftsView')
class FilledShiftsView extends StatelessWidget {
  const FilledShiftsView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ShiftsBloc, ShiftsBlocState>(
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
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
            SizedBox(
              height: getSize(8),
            ),
            locationAddressTextField(context, state),
            SizedBox(
              height: getSize(12),
            ),
            Expanded(
              child: FilledShiftListView(),
            )
          ],
        );
      },
    );
  }

  Widget locationAddressTextField(
    BuildContext context,
    ShiftsBlocState state,
  ) {

    return CustomDropdownTextfield(
      valueController: state.singleValueDropDownController,
      list: state.locationList,
      hintText: 'Location',
      validator: (p0) {
        if (p0 == null || p0.isEmpty) {
          return 'Please select location';
        } else {
          return null;
        }
      },
      prefixIcon: Center(
        widthFactor: 1,
        child: SvgPicture.asset(
          SvgImageConstant.locationIcon,
          colorFilter: ColorFilter.mode(Colors.black, BlendMode.srcATop),
          height: 16,
          width: 16,
        ),
      ),
    );

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: getSize(20)),
      child: CustomDropdownTextfield(

        valueController: state.singleValueDropDownController,
        list: state.locationList,
        hintText: 'Location',
        validator: (p0) {
          if (p0 == null || p0.isEmpty) {
            return 'Please select location';
          } else {
            return null;
          }
        },
        prefixIcon: Center(
          widthFactor: 1,
          child: SvgPicture.asset(
            SvgImageConstant.locationIcon,
            colorFilter: ColorFilter.mode(Colors.black, BlendMode.srcATop),
            height: 16,
            width: 16,
          ),
        ),
      ),
    );
  }
}
