// ignore_for_file: deprecated_member_use

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
import 'package:shift/presentation/core/style/app_colors.dart';
import 'package:shift/presentation/core/widgets/buttons/common_button.dart';
import 'package:shift/presentation/core/widgets/inputs/custom_dropdown_with_textfield.dart';
import 'package:shift/presentation/core/widgets/inputs/custom_text_field.dart';
import 'package:shift/presentation/main/widgets/home_app_bar.dart';

@RoutePage(name: 'locationDetailForm')
class LocationDetailForm extends StatelessWidget {
  const LocationDetailForm({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<LocationDetailsBloc>(),
      child: GestureDetector(
        onTap: () {
          AppFocus.unfocus(context);
        },
        child: Scaffold(
            appBar: CommonAppBar(
              onBackPressed: () {
                context.router.back();
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
                    (r) {},
                  ),
                );
              },
              builder: (context, state) {
                return Padding(
                  padding: EdgeInsets.symmetric(horizontal: getSize(20)),
                  child: Form(
                    autovalidateMode: state.showErrorMessages
                        ? AutovalidateMode.always
                        : AutovalidateMode.disabled,
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          addressTextField(context, state),
                          paddingBetweenFields(),
                          CustomDropdwonWithTextField(
                            labelText: StringConstant.facilityType,
                            isLabelPadding: true,
                            showPrefixIcon: true,
                            showTextfield: state.faciltyTypeDDValue
                                .toLowerCase()
                                .contains("other"),
                            items: const [
                              "TESTING 1",
                              "Testing 2",
                              "TESTING 3",
                              "Testing 4",
                              "OTHER"
                            ],
                            validator: (p0) => context
                                .read<LocationDetailsBloc>()
                                .state
                                .faciltyType
                                .value
                                .fold(
                                  (f) => f.maybeMap(
                                    empty: (value) =>
                                        "Please enter Facility Type",
                                    orElse: () => null,
                                  ),
                                  (_) => null,
                                ),
                            onChanged: (value) {
                              if (value != null) {
                                context.read<LocationDetailsBloc>().add(
                                      LocationDetailsEvent.facilityTypeChanged(
                                          value),
                                    );
                              }
                            },
                            fieldOnChanged: (value) =>
                                context.read<LocationDetailsBloc>().add(
                                      LocationDetailsEvent.addOtherfaciltyType(
                                          value),
                                    ),
                            fieldValidator: (p1, _) => context
                                .read<LocationDetailsBloc>()
                                .state
                                .otherFaciltyType
                                .value
                                .fold(
                                  (f) => f.maybeMap(
                                    empty: (value) =>
                                        "Please enter other facility type",
                                    orElse: () => null,
                                  ),
                                  (_) => null,
                                ),
                            hintText: StringConstant.selectFacilityType,
                          ),
                          paddingBetweenFields(),
                          locationIdField(context, state),
                          paddingBetweenFields(),
                          accreditationNumberField(context, state),
                          paddingBetweenFields(),
                          locationNoteField(context, state),
                          paddingBetweenFields(),
                          Align(
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
                                      color: AppColors.black.withOpacity(0.8),
                                      fontFamily: "Roboto Flex",
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          paddingBetweenFields(height: 10),
                          unitBox(context, state),
                          Padding(
                            padding:
                                EdgeInsets.symmetric(vertical: getSize(50)),
                            child: CommonButton(
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

  Widget addressTextField(
    BuildContext context,
    LocationDetailsState state,
  ) {
    return CustomTextField(
      labelText: StringConstant.address,
      isLabelPadding: true,
      hintText: StringConstant.address,
      textCapitalization: TextCapitalization.words,
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
      onChanged: (value) {
        context
            .read<LocationDetailsBloc>()
            .add(LocationDetailsEvent.addressChanged(value));
      },
      validator: (p0, p1) =>
          context.read<LocationDetailsBloc>().state.address.value.fold(
                (f) => f.maybeMap(
                  empty: (value) => "Please enter address",
                  orElse: () => null,
                ),
                (_) => null,
              ),
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
        color: AppColors.grey.withOpacity(0.4),
        borderRadius: BorderRadius.circular(
          getSize(20),
        ),
      ),
      child: Column(
        children: [
          unitNumberField(context, state),
          paddingBetweenFields(),
          notesField(context, state),
        ],
      ),
    );
  }

  Widget unitNumberField(
    BuildContext context,
    LocationDetailsState state,
  ) {
    return CustomTextField(
      labelText: StringConstant.unitNumberName,
      hintText: StringConstant.unitNumberName,
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
      hintText: StringConstant.typeHere,
      maxLines: 3,
      errorMaxLines: 2,
      onChanged: (value) {
        context
            .read<LocationDetailsBloc>()
            .add(LocationDetailsEvent.notesChanged(value));
      },
      validator: null,
    );
  }
}
