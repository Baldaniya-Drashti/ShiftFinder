// ignore_for_file: deprecated_member_use, prefer_const_constructors, must_be_immutable

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shift/application/location_details/location_details_bloc.dart';
import 'package:shift/domain/core/math_utils.dart';
import 'package:shift/domain/core/string_constant.dart';
import 'package:shift/domain/core/svg_image_constants.dart';
import 'package:shift/infrastructure/core/location_dto/location_dto.dart';
import 'package:shift/injection.dart';
import 'package:shift/presentation/common/utils/app_focus.dart';
import 'package:shift/presentation/common/utils/flushbar_creator.dart';
import 'package:shift/presentation/common/utils/get_cookie.dart';
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

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        AppFocus.unfocus(context);
      },
      child: BlocProvider(
        create: (context) => getIt<LocationDetailsBloc>()
          ..add(LocationDetailsEvent.getFacilityTypeList()),
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
                      AppFocus.unfocus(context);
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
                                if (getCurrentIndustry() == 2) ...[
                                  locationBrandField(context, state),
                                  paddingBetweenFields(),
                                ],
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
                                                  .withValues(alpha: 0.8),
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
                                          LocationDetailsEvent
                                              .continueBtnPressed(context));
                                      unitNoNamecontroller.clear();
                                      unitNotecontroller.clear();
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
          hintText: StringConstant.selectFacilityType,
        ),
        if (state.faciltyType.getValue()!.toLowerCase() == "other" &&
            (state.otherFaciltyType.getValue()!.isEmpty) &&
            state.showErrorMessages)
          commonErrorText(StringConstant.pleaseEnterOtherFacilityType),
      ],
    );
  }

  Widget locationBrandField(
    BuildContext context,
    LocationDetailsState state,
  ) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomDropdwonWithTextField(
          labelText: StringConstant.locationBrand,
          fieldHintText: StringConstant.typeYourLocationBrand,
          isLabelPadding: true,
          showPrefixIcon: true,
          ddPrefixIcon: SvgPicture.asset(
            SvgImageConstant.injection,
            height: getSize(24),
            width: getSize(24),
          ),
          showTextfield: state.locationBrandDDValue.toLowerCase() == "other",
          items: state.locationBrandList.map((val) {
            return DropdownMenuItem<String>(
              value: val.name,
              child: BaseText(
                text: val.name ?? '',
                fontSize: 14,
                textColor: AppColors.black,
              ),
            );
          }).toList(),
          validator: (p0) => context
              .read<LocationDetailsBloc>()
              .state
              .locationBrand
              .value
              .fold(
                (f) => f.maybeMap(
                  empty: (value) => StringConstant.pleaseSelectLocationBrand,
                  orElse: () => null,
                ),
                (_) => null,
              ),
          onChanged: (value) {
            if (value != null) {
              context.read<LocationDetailsBloc>().add(
                    LocationDetailsEvent.locationBrandChanged(value),
                  );
            }
          },
          fieldOnChanged: (value) => context.read<LocationDetailsBloc>().add(
                LocationDetailsEvent.addOtherLocationBrand(value),
              ),
          hintText: StringConstant.locationBrand,
        ),
        if (state.locationBrand.getValue()!.toLowerCase() == "other" &&
            (state.otherLocationBrand.getValue()!.isEmpty) &&
            state.showErrorMessages)
          commonErrorText(StringConstant.pleaseSelectOtherLocationBrand),
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
          controller: LocationDetailsBloc.locationCtrl,
          readOnly: true,
          readOnlyTextStyle: Theme.of(context)
              .textTheme
              .bodyMedium!
              .copyWith(color: AppColors.black),
          onTap: () {
            LocationDialog.showLocationDialog(
              context,
              predictions: state.selectedLocationPrediction,
              location: LocationDetailsBloc.locationCtrl.text,
            ).then((value) {
              if (value != null) {
                context.read<LocationDetailsBloc>().add(
                    LocationDetailsEvent.locationSelectedFromSearchList(value));
              }
            });
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
      hintText: StringConstant.typeHerewithDots,
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
      padding: EdgeInsets.all(getSize(20)),
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
          unitNumberField(context, state),
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
                  ? AppColors.primaryColor.withValues(alpha: 0.15)
                  : AppColors.primaryColor.withOpacity(0.05),
              buttonTextColor: (state.unitNumber.isNotEmpty)
                  ? AppColors.primaryColor
                  : AppColors.primaryColor.withValues(alpha: 0.3),
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
      validator: null,
    );
  }

  Widget notesField(
    BuildContext context,
    LocationDetailsState state,
  ) {
    return CustomTextField(
      labelText: StringConstant.notes,
      hintText: StringConstant.typeHerewithDots,
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
        padding: EdgeInsets.only(bottom: getSize(10)),
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
              subtitle: (unit.note != null && unit.note!.isNotEmpty)
                  ? BaseText(
                      text: unit.note ?? "",
                      fontSize: 10,
                    )
                  : null,
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  GestureDetector(
                    onTap: () {
                      editUnitDialog(context,
                          context.read<LocationDetailsBloc>(), state, index);
                    },
                    child: SvgPicture.asset(SvgImageConstant.editWithBg),
                  ),
                  SizedBox(width: getSize(10)),
                  GestureDetector(
                    onTap: () {
                      context.read<LocationDetailsBloc>().add(
                          LocationDetailsEvent.removeUnitNumberChip(index));
                    },
                    child: SvgPicture.asset(SvgImageConstant.bin),
                  ),
                ],
              ),
            ),
          );
        });
  }

  TextEditingController updateUnitNameCtrl = TextEditingController();
  TextEditingController updateUnitNoteCtrl = TextEditingController();

  editUnitDialog(
    BuildContext context,
    LocationDetailsBloc bloc,
    LocationDetailsState state,
    int index,
  ) {
    updateUnitNameCtrl.text = state.listOfUnit[index].number_or_name ?? "";
    updateUnitNoteCtrl.text = state.listOfUnit[index].note ?? "";

    showDialog(
        context: context,
        builder: (BuildContext context) {
          return BlocBuilder<LocationDetailsBloc, LocationDetailsState>(
            bloc: bloc,
            builder: (context, state) {
              return AlertDialog(
                  elevation: 80,
                  backgroundColor: AppColors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  insetPadding: EdgeInsets.symmetric(horizontal: getSize(20)),
                  title: BaseText(
                    text: StringConstant.editUnit,
                    fontSize: 22,
                    fontWeight: FontWeight.w400,
                    fontFamily: "Aclonica",
                    textAlign: TextAlign.center,
                  ),
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      paddingBetweenFields(height: getSize(10)),
                      CustomTextField(
                        controller: updateUnitNameCtrl,
                        labelText: StringConstant.unitNumberName,
                        hintText: StringConstant.unitNumberName,
                        isLabelPadding: false,
                        errorMaxLines: 2,
                        onChanged: (value) {
                          bloc.add(LocationDetailsEvent.updateUnitNumberChanged(
                              value.trim()));
                        },
                        validator: null,
                      ),
                      paddingBetweenFields(height: getSize(10)),
                      CustomTextField(
                        controller: updateUnitNoteCtrl,
                        labelText: StringConstant.notes,
                        hintText: StringConstant.typeHerewithDots,
                        isOptional: true,
                        isLabelPadding: false,
                        maxLines: 3,
                        errorMaxLines: 2,
                        onChanged: (value) {
                          bloc.add(LocationDetailsEvent.updateUnitNotesChanged(
                              value.trim()));
                        },
                        validator: null,
                      ),
                      paddingBetweenFields(),
                      Align(
                        alignment: Alignment.center,
                        child: CommonButton(
                          onPressed: (updateUnitNameCtrl.text.isNotEmpty)
                              ? () {
                                  bloc.add(
                                      LocationDetailsEvent.editUnitNumberChip(
                                          context,
                                          index,
                                          UnitDTO(
                                            number_or_name:
                                                updateUnitNameCtrl.text.trim(),
                                            note:
                                                updateUnitNoteCtrl.text.trim(),
                                          )));
                                }
                              : () {},
                          buttonText: StringConstant.update,
                          buttonFontSize: 12,
                          buttonFontWeight: FontWeight.w600,
                          height: 35,
                          backgroundColor: (updateUnitNameCtrl.text.isNotEmpty)
                              ? AppColors.primaryColor.withValues(alpha: 0.15)
                              : AppColors.primaryColor.withOpacity(0.05),
                          buttonTextColor: (updateUnitNameCtrl.text.isNotEmpty)
                              ? AppColors.primaryColor
                              : AppColors.primaryColor.withValues(alpha: 0.3),
                        ),
                      )
                    ],
                  ));
            },
          );
        });
  }
}
