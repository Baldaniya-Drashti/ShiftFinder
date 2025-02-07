// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shift/application/bloc/pick_location_dialog_bloc.dart';
import 'package:shift/domain/core/math_utils.dart';
import 'package:shift/domain/core/string_constant.dart';
import 'package:shift/domain/core/svg_image_constants.dart';
import 'package:shift/infrastructure/core/location_dto/search_location_dto/search_location_dto.dart';
import 'package:shift/injection.dart';
import 'package:shift/presentation/common/utils/get_cookie.dart';
import 'package:shift/presentation/common/widgets/base_text.dart';
import 'package:shift/presentation/core/style/app_colors.dart';
import 'package:shift/presentation/core/widgets/buttons/common_button.dart';
import 'package:shift/presentation/core/widgets/inputs/custom_text_field.dart';

class LocationDialog {
  static Future<dynamic> showLocationDialog(
    BuildContext context, {
    Predictions? predictions,
    String? location,
    EdgeInsets? insetPadding,
    int? maxLines,
    void Function()? onPressed,
  }) async {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return BlocProvider(
            create: (context) => getIt<PickLocationDialogBloc>()
              ..add(PickLocationDialogEvent.locationSelectedFromSearchList(
                  predictions ?? Predictions(),
                  locationName: location,
                  isFromStarting: true)),
            child: BlocBuilder<PickLocationDialogBloc, PickLocationDialogState>(
              builder: (context, state) {
                return AlertDialog(
                  elevation: 80,
                  backgroundColor: AppColors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  insetPadding: insetPadding ??
                      EdgeInsets.symmetric(horizontal: getSize(20)),
                  actionsAlignment: MainAxisAlignment.center,
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      LocationDialog().addressField(context, state),
                      if (state.searchLocationList.isNotEmpty)
                        Flexible(
                          child: SingleChildScrollView(
                            child: SizedBox(
                              // height: getSize(300),
                              width: getSize(400),
                              child: ListView.builder(
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                itemCount: state.searchLocationList.length,
                                itemBuilder: (context, index) {
                                  return ListTile(
                                    onTap: () {
                                      // final selectedLocation = state.searchLocationList[index]["description"];
                                      final selectedLocation =
                                          state.searchLocationList[index];
                                      context
                                          .read<PickLocationDialogBloc>()
                                          .add(PickLocationDialogEvent
                                              .locationSelectedFromSearchList(
                                                  selectedLocation));
                                    },
                                    dense: true,
                                    titleAlignment: ListTileTitleAlignment.top,
                                    leading: SvgPicture.asset(
                                        SvgImageConstant.locationIcon),
                                    title: BaseText(
                                      text: state.searchLocationList[index]
                                              .description ??
                                          "",
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                  actions: [
                    CommonButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      width: 130,
                      buttonText: StringConstant.cancle,
                      backgroundColor: AppColors.white,
                      buttonTextColor: AppColors.primaryColor,
                      borderColor: AppColors.primaryColor,
                    ),
                    CommonButton(
                      onPressed: (state.locationAddress.isValid())
                          ? () {
                              Navigator.pop(
                                  context, state.selectedLocationPrediction);
                            }
                          : () {},
                      width: 130,
                      buttonText: StringConstant.txtContinue,
                      backgroundColor: ((state.locationAddress.isValid()))
                          ? null
                          : AppColors.primaryColor.withOpacity(0.5),
                    )
                  ],
                );
              },
            ),
          );
        });
  }

  Widget addressField(BuildContext context, PickLocationDialogState state) {
    return CustomTextField(
      labelText: (getCurrentRole() == 1)
          ? StringConstant.address
          : StringConstant.locationAddress,
      isLabelPadding: true,
      hintText: (getCurrentRole() == 1)
          ? StringConstant.address
          : StringConstant.locationAddress,
      controller: PickLocationDialogBloc.locationCtrl,
      prefixIcon: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: getSize(14),
          vertical: getSize(14),
        ),
        child: SvgPicture.asset(
          SvgImageConstant.locationIcon,
          height: getSize(24),
          width: getSize(24),
          color: AppColors.primaryColor,
        ),
      ),
      onChanged: (value) => context.read<PickLocationDialogBloc>().add(
          PickLocationDialogEvent.locationAddressChanged(
              PickLocationDialogBloc.locationCtrl.text)),
      validator: (p0, p1) => context
          .read<PickLocationDialogBloc>()
          .state
          .locationAddress
          .value
          .fold(
            (f) => f.maybeMap(
              empty: (value) => (getCurrentRole() == 1)
                  ? StringConstant.pleaseEnterAddress
                  : StringConstant.pleaseEnterLocationName,
              orElse: () => null,
            ),
            (_) => null,
          ),
    );
  }
}
