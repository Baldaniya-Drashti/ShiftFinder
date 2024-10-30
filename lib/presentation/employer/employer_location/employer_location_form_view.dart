import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shift/application/employer/employer_location_form/employer_location_form_bloc.dart';
import 'package:shift/domain/core/math_utils.dart';
import 'package:shift/domain/core/string_constant.dart';
import 'package:shift/domain/core/svg_image_constants.dart';
import 'package:shift/infrastructure/core/location_dto/location_dto.dart';
import 'package:shift/injection.dart';
import 'package:shift/presentation/common/utils/app_focus.dart';
import 'package:shift/presentation/common/utils/flushbar_creator.dart';
import 'package:shift/presentation/common/widgets/base_text.dart';
import 'package:shift/presentation/common/widgets/center_loading_indicator.dart';
import 'package:shift/presentation/core/logger/logger.dart';
import 'package:shift/presentation/core/style/app_colors.dart';
import 'package:shift/presentation/core/widgets/buttons/common_button.dart';
import 'package:shift/presentation/core/widgets/inputs/custom_dropdown_with_textfield.dart';
import 'package:shift/presentation/core/widgets/inputs/custom_text_field.dart';
import 'package:shift/presentation/core/widgets/texts/common_texts.dart';
import 'package:shift/presentation/main/widgets/home_app_bar.dart';

import '../../core/widgets/dialogs/app_dialog.dart';

@RoutePage(name: 'EmployerLocationFormView')
class EmployerLocationFormView extends StatelessWidget {
  EmployerLocationFormView({super.key, this.id});

  final int? id;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        AppFocus.unfocus(context);
      },
      child: BlocProvider(
        create: (context) => getIt<EmployerLocationFormBloc>()
          ..add(EmployerLocationFormEvent.getFacilityTypeList())
          ..add(
            EmployerLocationFormEvent.getLocationInfo(id: id ?? -1, context: context),
          ),
        child: Scaffold(
            appBar: CommonAppBar(
              onBackPressed: () {
                EmployerLocationFormBloc.locationCtrl.clear();
                context.router.maybePop();
              },
              title: StringConstant.locationDetails,
            ),
            body: BlocConsumer<EmployerLocationFormBloc, EmployerLocationFormState>(
              listener: (context, state) {
                state.authFailureOrSuccessOption.fold(
                  () {},
                  (either) => either.fold(
                    (failure) {
                      showError(
                        message: failure.maybeMap(
                          showAPIResponseMessage: (value) => value.message,
                          networkError: (value) => 'Please check your internet connectivity',
                          orElse: () => "Server Error. Try again later.",
                        ),
                      ).show(context);
                    },
                    (r) {
                      context.router.maybePop(true);
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
                          autovalidateMode: state.showErrorMessages ? AutovalidateMode.always : AutovalidateMode.disabled,
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
                                              color: AppColors.black.withOpacity(0.8),
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
                                  padding: EdgeInsets.symmetric(vertical: getSize(50)),
                                  child: CommonButton(
                                    isSubmitting: state.isSubmitting,
                                    onPressed: () {
                                      print("Address---> ${state.address.getValue()}");
                                      context.read<EmployerLocationFormBloc>().add(EmployerLocationFormEvent.continueBtnPressed(context));
                                      unitNoNamecontroller.clear();
                                      unitNotecontroller.clear();
                                    },
                                    buttonText: state.id!=null? "Update": StringConstant.txtContinue,
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
    EmployerLocationFormState state,
  ) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomDropdwonWithTextField(
          labelText: StringConstant.facilityType,
          fieldHintText: StringConstant.typeFacilityType,
          value: state.locationData.facility_type?.name,
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
          validator: (p0) => context.read<EmployerLocationFormBloc>().state.faciltyType.value.fold(
                (f) => f.maybeMap(
                  empty: (value) => StringConstant.pleaseEnterFacilityType,
                  orElse: () => null,
                ),
                (_) => null,
              ),
          onChanged: (value) {
            if (value != null) {
              context.read<EmployerLocationFormBloc>().add(
                    EmployerLocationFormEvent.facilityTypeChanged(value),
                  );
            }
          },
          fieldOnChanged: (value) => context.read<EmployerLocationFormBloc>().add(
                EmployerLocationFormEvent.addOtherfaciltyType(value),
              ),
          // fieldValidator: (p1, _) => context
          //     .read<EmployerLocationFormBloc>()
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
    EmployerLocationFormState state,
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
              AppDialog.showInfo(context, StringConstant.mutltiplelocationInfoDesc);
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
          controller: EmployerLocationFormBloc.locationCtrl,
          onChanged: (value) {
            context
                .read<EmployerLocationFormBloc>()
                .add(EmployerLocationFormEvent.addressChanged(EmployerLocationFormBloc.locationCtrl.text));
          },
          validator: (p0, p1) => context.read<EmployerLocationFormBloc>().state.address.value.fold(
                (f) => f.maybeMap(
                  empty: (value) => StringConstant.pleaseEnterAddress,
                  orElse: () => null,
                ),
                (_) => null,
              ),
        ),
        if (state.searchLocationList.isNotEmpty && !state.showErrorMessages)
          Container(
            height: getSize(200),
            color: AppColors.white,
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: state.searchLocationList.length,
              itemBuilder: (context, index) {
                // print("searchLocationList---> ${searchLocationList}");
                return ListTile(
                  onTap: () {
                    // final selectedLocation = state.searchLocationList[index];
                    final selectedLocation = state.searchLocationList[index];

                    context
                        .read<EmployerLocationFormBloc>()
                        .add(EmployerLocationFormEvent.locationSelectedFromSearchList(selectedLocation));
                  },
                  dense: true,
                  titleAlignment: ListTileTitleAlignment.top,
                  leading: SvgPicture.asset(SvgImageConstant.locationIcon),
                  title: BaseText(
                    text: state.searchLocationList[index].description ?? "",
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
    EmployerLocationFormState state,
  ) {
    return CustomTextField(
      labelText: StringConstant.locationID,
      hintText: StringConstant.locationID,
      isLabelPadding: true,
      initialValue: state.locationData.location_id,
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
        context.read<EmployerLocationFormBloc>().add(EmployerLocationFormEvent.locationIdChanged(value));
      },
      validator: null,
    );
  }

  Widget accreditationNumberField(
    BuildContext context,
    EmployerLocationFormState state,
  ) {
    return CustomTextField(
      labelText: StringConstant.accreditationNumber,
      hintText: StringConstant.accreditationNumber,
      isLabelPadding: true,
      isOptional: true,
      errorMaxLines: 2,
      initialValue: state.accreditationNumber,
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
        context.read<EmployerLocationFormBloc>().add(EmployerLocationFormEvent.accreditationNumberChanged(value));
      },
      validator: null,
    );
  }

  Widget locationNoteField(
    BuildContext context,
    EmployerLocationFormState state,
  ) {
    return CustomTextField(
      initialValue: state.locationData.location_note??"",
      labelText: StringConstant.locationNote,
      hintText: StringConstant.typeHere,
      isLabelPadding: true,
      isOptional: true,
      errorMaxLines: 2,
      maxLines: 3,
      onChanged: (value) {
        context.read<EmployerLocationFormBloc>().add(EmployerLocationFormEvent.locationNoteChanged(value));
      },
      validator: null,
    );
  }

  Widget unitBox(BuildContext context, EmployerLocationFormState state) {
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
                  .read<EmployerLocationFormBloc>()
                  .add(EmployerLocationFormEvent.removeUnitNumberChip(value));
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
                      context.read<EmployerLocationFormBloc>().add(
                            EmployerLocationFormEvent.addUnitNumberChipList(state.unitNumber, state.notes),
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
              backgroundColor:
                  (state.unitNumber.isNotEmpty) ? AppColors.primaryColor.withOpacity(0.15) : AppColors.primaryColor.withOpacity(0.05),
              buttonTextColor: (state.unitNumber.isNotEmpty) ? AppColors.primaryColor : AppColors.primaryColor.withOpacity(0.3),
            ),
          )
        ],
      ),
    );
  }

  final TextEditingController unitNoNamecontroller = TextEditingController();
  final TextEditingController unitNotecontroller = TextEditingController();

  Widget unitNumberField(
    BuildContext context,
    EmployerLocationFormState state,
  ) {
    return CustomTextField(
      controller: unitNoNamecontroller,
      labelText: StringConstant.unitNumberName,
      hintText: StringConstant.unitNumberName,
      isLabelPadding: false,
      errorMaxLines: 2,
      onChanged: (value) {
        context.read<EmployerLocationFormBloc>().add(EmployerLocationFormEvent.unitNumberChanged(value));
      },
      /*suffixIcon: CommonButton(
        height: getSize(27),
        width: getSize(59),
        borderRadius: getSize(10),
        buttonText: StringConstant.add,
        buttonFontSize: 10,
        onPressed: () {
          context.read<EmployerLocationFormBloc>().add(
                EmployerLocationFormEvent.addUnitNumberChipList(
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
    EmployerLocationFormState state,
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
        context.read<EmployerLocationFormBloc>().add(EmployerLocationFormEvent.notesChanged(value));
      },
      validator: null,
    );
  }

  Widget listOfUnit(BuildContext context, EmployerLocationFormState state) {
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
                      editUnitDialog(context, context.read<EmployerLocationFormBloc>(), state, index);
                    },
                    child: SvgPicture.asset(SvgImageConstant.editWithBg),
                  ),
                  SizedBox(width: getSize(10)),
                  GestureDetector(
                    onTap: () {
                      context.read<EmployerLocationFormBloc>().add(EmployerLocationFormEvent.removeUnitNumberChip(index));
                    },
                    child: SvgPicture.asset(SvgImageConstant.bin),
                  ),
                ],
              ),
            ),
          );
        });
  }

  final TextEditingController updateUnitNameCtrl = TextEditingController();
  final TextEditingController updateUnitNoteCtrl = TextEditingController();

  editUnitDialog(
    BuildContext context,
    EmployerLocationFormBloc bloc,
    EmployerLocationFormState state,
    int index,
  ) {
    updateUnitNameCtrl.text = state.listOfUnit[index].number_or_name ?? "";
    updateUnitNoteCtrl.text = state.listOfUnit[index].note ?? "";
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return BlocBuilder<EmployerLocationFormBloc, EmployerLocationFormState>(
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
                          bloc.add(EmployerLocationFormEvent.updateUnitNumberChanged(value.trim()));
                        },
                        validator: null,
                      ),
                      paddingBetweenFields(height: getSize(10)),
                      CustomTextField(
                        controller: updateUnitNoteCtrl,
                        labelText: StringConstant.notes,
                        hintText: StringConstant.typeHere,
                        isOptional: true,
                        isLabelPadding: false,
                        maxLines: 3,
                        errorMaxLines: 2,
                        onChanged: (value) {
                          bloc.add(EmployerLocationFormEvent.updateUnitNotesChanged(value.trim()));
                        },
                        validator: null,
                      ),
                      paddingBetweenFields(),
                      Align(
                        alignment: Alignment.center,
                        child: CommonButton(
                          onPressed: (updateUnitNameCtrl.text.isNotEmpty)
                              ? () {
                                  bloc.add(EmployerLocationFormEvent.editUnitNumberChip(
                                      context,
                                      index,
                                      UnitDTO(
                                        number_or_name: updateUnitNameCtrl.text.trim(),
                                        note: updateUnitNoteCtrl.text.trim(),
                                      )));
                                }
                              : () {},
                          buttonText: StringConstant.update,
                          // width: 5,
                          buttonFontSize: 12,
                          buttonFontWeight: FontWeight.w600,
                          height: 35,
                          backgroundColor: (updateUnitNameCtrl.text.isNotEmpty)
                              ? AppColors.primaryColor.withOpacity(0.15)
                              : AppColors.primaryColor.withOpacity(0.05),
                          buttonTextColor:
                              (updateUnitNameCtrl.text.isNotEmpty) ? AppColors.primaryColor : AppColors.primaryColor.withOpacity(0.3),
                        ),
                      )
                    ],
                  ));
            },
          );
        });
  }
}

class _LocationForm extends StatefulWidget {
  const _LocationForm();

  @override
  State<_LocationForm> createState() => _LocationFormState();
}

class _LocationFormState extends State<_LocationForm> {
  late TextEditingController _locationIdController;
  late TextEditingController _accreditationNumberController;

  @override
  void initState() {
    super.initState();
    _locationIdController = TextEditingController();
    _accreditationNumberController = TextEditingController();
  }

  @override
  void dispose() {
    _locationIdController.dispose();
    _accreditationNumberController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Placeholder();
  }
}
