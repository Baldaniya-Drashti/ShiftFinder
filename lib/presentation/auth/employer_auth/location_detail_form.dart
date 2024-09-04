// ignore_for_file: deprecated_member_use, prefer_const_constructors, must_be_immutable

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shift/application/location_details/location_details_bloc.dart';
import 'package:shift/domain/core/math_utils.dart';
import 'package:shift/domain/core/string_constant.dart';
import 'package:shift/domain/core/svg_image_constants.dart';
import 'package:shift/injection.dart';
import 'package:shift/presentation/common/utils/app_focus.dart';
import 'package:shift/presentation/common/utils/flushbar_creator.dart';
import 'package:shift/presentation/common/widgets/base_text.dart';
import 'package:shift/presentation/common/widgets/center_loading_indicator.dart';
import 'package:shift/presentation/core/app_router.gr.dart';
import 'package:shift/presentation/core/style/app_colors.dart';
import 'package:shift/presentation/core/widgets/buttons/common_button.dart';
import 'package:shift/presentation/core/widgets/dialogs/dialogs.dart';
import 'package:shift/presentation/core/widgets/inputs/custom_dropdown_with_textfield.dart';
import 'package:shift/presentation/core/widgets/inputs/custom_text_field.dart';
import 'package:shift/presentation/core/widgets/texts/common_texts.dart';
import 'package:shift/presentation/main/widgets/home_app_bar.dart';

@RoutePage(name: 'locationDetailForm')
class LocationDetailForm extends StatelessWidget {
  bool isFromSplash = false;

  LocationDetailForm({super.key, this.isFromSplash = false});

  TextEditingController addressController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<LocationDetailsBloc>()
        ..add(LocationDetailsEvent.getFacilityTypeList()),
      child: GestureDetector(
        onTap: () {
          AppFocus.unfocus(context);
        },
        child: Scaffold(
            appBar: CommonAppBar(
              isShowBackBtn: !isFromSplash,
              onBackPressed: () {
                LocationDetailsBloc.locationCtrl.clear();
                context.router.maybePop();
              },
              title: StringConstant.locationDetails,
            ),
            body: BlocConsumer<LocationDetailsBloc, LocationDetailsState>(
              listener: (context, state) {
                state.authFailureOrSuccessOption.fold(
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
                      context.router
                          .push(const PageRouteInfo(AddCardDetailPage.name))
                          .then((value) {
                        AppFocus.unfocus(context);
                      });
                    },
                  ),
                );
              },
              builder: (context, state) {
                return (state.isLoading)
                    ? CenterLoadingIndicator()
                    : Padding(
                        padding: EdgeInsets.symmetric(horizontal: getSize(20)),
                        child: Form(
                          autovalidateMode: state.showErrorMessages
                              ? AutovalidateMode.always
                              : AutovalidateMode.disabled,
                          child: SingleChildScrollView(
                            physics: BouncingScrollPhysics(),
                            child: Column(
                              children: [
                                locationAddressTextField(context, state),
                                paddingBetweenFields(),
                                facilityTypeField(context, state),
                                paddingBetweenFields(),
                                locationIdField(context, state),
                                paddingBetweenFields(),
                                accreditationNumberField(context, state),
                                paddingBetweenFields(),
                                locationNoteField(context, state),
                                paddingBetweenFields(),
                                Padding(
                                  padding: EdgeInsets.only(left: getSize(20)),
                                  child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: RichText(
                                      text: TextSpan(
                                        text: StringConstant.addUnits,
                                        style: TextStyle(
                                          fontSize: getFontSize(14),
                                          fontWeight: FontWeight.w500,
                                          color: AppColors.black,
                                          fontFamily: "Roboto Flex",
                                        ),
                                        children: [
                                          TextSpan(
                                            text: "  (Optional)",
                                            style: TextStyle(
                                              fontSize: getFontSize(10),
                                              fontWeight: FontWeight.w500,
                                              color: AppColors.black
                                                  .withOpacity(0.8),
                                              fontFamily: "Roboto Flex",
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                paddingBetweenFields(height: 10),
                                unitBox(context, state),
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                      vertical: getSize(50)),
                                  child: CommonButton(
                                    isSubmitting: state.isSubmitting,
                                    onPressed: () {
                                      context.read<LocationDetailsBloc>().add(
                                          const LocationDetailsEvent
                                              .continueBtnPressed());
                                    },
                                    buttonText: StringConstant.txtContinue,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
              },
            )),
      ),
    );
  }

  Widget paddingBetweenFields({double? height}) {
    return SizedBox(
      height: getSize(height ?? 15),
    );
  }

  Widget facilityTypeField(
    BuildContext context,
    LocationDetailsState state,
  ) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomDropdwonWithTextField(
          labelText: StringConstant.facilityType,
          fieldHintText: StringConstant.typeFacilityType,
          isLabelPadding: true,
          showPrefixIcon: true,
          showTextfield: state.faciltyTypeDDValue.toLowerCase() == "other",
          items: state.facilityTypeList.map((val) {
            return DropdownMenuItem<String>(
              value: val.name,
              child: BaseText(
                text: val.name ?? '',
                fontSize: 14,
                textColor: AppColors.black,
              ),
            );
          }).toList(),
          validator: (p0) =>
              context.read<LocationDetailsBloc>().state.faciltyType.value.fold(
                    (f) => f.maybeMap(
                      empty: (value) => StringConstant.pleaseEnterFacilityType,
                      orElse: () => null,
                    ),
                    (_) => null,
                  ),
          onChanged: (value) {
            if (value != null) {
              context.read<LocationDetailsBloc>().add(
                    LocationDetailsEvent.facilityTypeChanged(value),
                  );
            }
          },
          fieldOnChanged: (value) => context.read<LocationDetailsBloc>().add(
                LocationDetailsEvent.addOtherfaciltyType(value),
              ),
          // fieldValidator: (p1, _) => context
          //     .read<LocationDetailsBloc>()
          //     .state
          //     .otherFaciltyType
          //     .value
          //     .fold(
          //       (f) => f.maybeMap(
          //         empty: (value) => StringConstant.pleaseEnterOtherFacilityType,
          //         orElse: () => null,
          //       ),
          //       (_) => null,
          //     ),
          hintText: StringConstant.selectFacilityType,
        ),
        if (state.faciltyType.getValue()!.toLowerCase() == "other" &&
            (state.otherFaciltyType.getValue()!.isEmpty) &&
            state.showErrorMessages)
          commonErrorText(StringConstant.pleaseEnterOtherFacilityType),
      ],
    );
  }

  Widget locationAddressTextField(
    BuildContext context,
    LocationDetailsState state,
  ) {
    return Column(
      children: [
        CustomTextField(
          labelText: StringConstant.locationAddress,
          isLabelPadding: true,
          hintText: StringConstant.locationAddress,
          isOptional: true,
          optionalWidget: GestureDetector(
            onTap: () {
              AppDialog.showInfo(
                  context, StringConstant.mutltiplelocationInfoDesc);
            },
            child: SvgPicture.asset(
              SvgImageConstant.infoCircle,
            ),
          ),
          errorMaxLines: 2,
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
          // controller: addressController..text = state.address.getValue() ?? "",
          controller: LocationDetailsBloc.locationCtrl,
          onChanged: (value) {
            context
                .read<LocationDetailsBloc>()
                .add(LocationDetailsEvent.addressChanged(value));
          },
          validator: (p0, p1) =>
              context.read<LocationDetailsBloc>().state.address.value.fold(
                    (f) => f.maybeMap(
                      empty: (value) => StringConstant.pleaseEnterAddress,
                      orElse: () => null,
                    ),
                    (_) => null,
                  ),
        ),
        if (state.searchLocationList.isNotEmpty)
          Container(
            height: getSize(200),
            color: AppColors.white,
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: state.searchLocationList.length,
              itemBuilder: (context, index) {
                return ListTile(
                  onTap: () {
                    final selectedLocation =
                        state.searchLocationList[index]["description"];

                    context.read<LocationDetailsBloc>().add(
                        LocationDetailsEvent.locationSelectedFromSearchList(
                            selectedLocation));
                  },
                  dense: true,
                  titleAlignment: ListTileTitleAlignment.top,
                  leading: SvgPicture.asset(SvgImageConstant.locationIcon),
                  title: BaseText(
                    text: state.searchLocationList[index]["description"],
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                );
              },
            ),
          ),
      ],
    );
  }

  Widget locationIdField(
    BuildContext context,
    LocationDetailsState state,
  ) {
    return CustomTextField(
      labelText: StringConstant.locationID,
      hintText: StringConstant.locationID,
      isLabelPadding: true,
      isOptional: true,
      errorMaxLines: 2,
      prefixIcon: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: getSize(14),
          vertical: getSize(14),
        ),
        child: SvgPicture.asset(
          SvgImageConstant.note,
          height: getSize(24),
          width: getSize(24),
          color: AppColors.primaryColor,
        ),
      ),
      onChanged: (value) {
        context
            .read<LocationDetailsBloc>()
            .add(LocationDetailsEvent.locationIdChanged(value));
      },
      validator: null,
    );
  }

  Widget accreditationNumberField(
    BuildContext context,
    LocationDetailsState state,
  ) {
    return CustomTextField(
      labelText: StringConstant.accreditationNumber,
      hintText: StringConstant.accreditationNumber,
      isLabelPadding: true,
      isOptional: true,
      errorMaxLines: 2,
      prefixIcon: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: getSize(14),
          vertical: getSize(14),
        ),
        child: SvgPicture.asset(
          SvgImageConstant.circleC,
          height: getSize(24),
          width: getSize(24),
          color: AppColors.primaryColor,
        ),
      ),
      onChanged: (value) {
        context
            .read<LocationDetailsBloc>()
            .add(LocationDetailsEvent.accreditationNumberChanged(value));
      },
      validator: null,
    );
  }

  Widget locationNoteField(
    BuildContext context,
    LocationDetailsState state,
  ) {
    return CustomTextField(
      labelText: StringConstant.locationNote,
      hintText: StringConstant.typeHere,
      isLabelPadding: true,
      isOptional: true,
      errorMaxLines: 2,
      maxLines: 3,
      onChanged: (value) {
        context
            .read<LocationDetailsBloc>()
            .add(LocationDetailsEvent.locationNoteChanged(value));
      },
      validator: null,
    );
  }

  Widget unitBox(BuildContext context, LocationDetailsState state) {
    return Container(
      padding: EdgeInsets.all(
        getSize(20),
      ),
      decoration: BoxDecoration(
        color: AppColors.grey04,
        borderRadius: BorderRadius.circular(
          getSize(20),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          listOfUnit(context, state),
          paddingBetweenFields(height: getSize(10)),
          unitNumberField(context, state),
          /*paddingBetweenFields(height: getSize(10)),
          CustomChipSet(
            chipList: state.unitNoNameChipList,
            backgroundColor: AppColors.grey04,
            spacing: 10,
            onDelete: (value) {
              context
                  .read<LocationDetailsBloc>()
                  .add(LocationDetailsEvent.removeUnitNumberChip(value));
            },
          ),*/
          paddingBetweenFields(height: getSize(10)),
          notesField(context, state),
          paddingBetweenFields(),
          Align(
            alignment: Alignment.center,
            child: CommonButton(
              onPressed: (state.unitNumber.isNotEmpty)
                  ? () {
                      context.read<LocationDetailsBloc>().add(
                            LocationDetailsEvent.addUnitNumberChipList(
                                state.unitNumber, state.notes),
                          );
                      unitNoNamecontroller.clear();
                      unitNotecontroller.clear();
                    }
                  : () {},
              buttonText: "+ ${StringConstant.addMore}",
              width: 105,
              borderRadius: 10,
              buttonFontSize: 12,
              buttonFontWeight: FontWeight.w600,
              height: 35,
              backgroundColor: (state.unitNumber.isNotEmpty)
                  ? AppColors.primaryColor.withOpacity(0.15)
                  : AppColors.primaryColor.withOpacity(0.05),
              buttonTextColor: (state.unitNumber.isNotEmpty)
                  ? AppColors.primaryColor
                  : AppColors.primaryColor.withOpacity(0.3),
            ),
          )
        ],
      ),
    );
  }

  TextEditingController unitNoNamecontroller = TextEditingController();
  TextEditingController unitNotecontroller = TextEditingController();
  Widget unitNumberField(
    BuildContext context,
    LocationDetailsState state,
  ) {
    return CustomTextField(
      controller: unitNoNamecontroller,
      labelText: StringConstant.unitNumberName,
      hintText: StringConstant.unitNumberName,
      isLabelPadding: false,
      errorMaxLines: 2,
      onChanged: (value) {
        context
            .read<LocationDetailsBloc>()
            .add(LocationDetailsEvent.unitNumberChanged(value));
      },
      /*suffixIcon: CommonButton(
        height: getSize(27),
        width: getSize(59),
        borderRadius: getSize(10),
        buttonText: StringConstant.add,
        buttonFontSize: 10,
        onPressed: () {
          context.read<LocationDetailsBloc>().add(
                LocationDetailsEvent.addUnitNumberChipList(
                  state.unitNumber,
                  state.notes,
                ),
              );
          unitNoNamecontroller.clear();
        },
      ),*/
      validator: null,
    );
  }

  Widget notesField(
    BuildContext context,
    LocationDetailsState state,
  ) {
    return CustomTextField(
      labelText: StringConstant.notes,
      hintText: StringConstant.typeHere,
      isOptional: true,
      isLabelPadding: false,
      maxLines: 3,
      errorMaxLines: 2,
      controller: unitNotecontroller,
      onChanged: (value) {
        context
            .read<LocationDetailsBloc>()
            .add(LocationDetailsEvent.notesChanged(value));
      },
      validator: null,
    );
  }

  Widget listOfUnit(BuildContext context, LocationDetailsState state) {
    return ListView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemCount: state.listOfUnit.length,
        itemBuilder: (_, index) {
          final unit = state.listOfUnit[index];
          return Container(
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            margin: EdgeInsets.symmetric(vertical: getSize(5)),
            child: ListTile(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              dense: true,
              visualDensity: VisualDensity.compact,
              title: BaseText(
                text: unit.number_or_name ?? "",
                fontWeight: FontWeight.w600,
                fontSize: 14,
              ),
              subtitle: (unit.units_note != null && unit.units_note!.isNotEmpty)
                  ? BaseText(
                      text: unit.units_note ?? "",
                      fontSize: 10,
                    )
                  : null,
              trailing: GestureDetector(
                onTap: () {
                  context
                      .read<LocationDetailsBloc>()
                      .add(LocationDetailsEvent.removeUnitNumberChip(index));
                },
                child: SvgPicture.asset(SvgImageConstant.bin),
              ),
            ),
          );
        });
  }
}
