// ignore_for_file: avoid_print, must_be_immutable

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shift/application/auth/contractor_auth/experience_bloc/experience_bloc.dart';
import 'package:shift/domain/core/math_utils.dart';
import 'package:shift/domain/core/png_image_constants.dart';
import 'package:shift/domain/core/string_constant.dart';
import 'package:shift/domain/core/svg_image_constants.dart';
import 'package:shift/injection.dart';
import 'package:shift/presentation/common/utils/flushbar_creator.dart';
import 'package:shift/presentation/common/widgets/base_text.dart';
import 'package:shift/presentation/core/app_router.gr.dart';
import 'package:shift/presentation/core/common_lisitng/common_listing.dart';
import 'package:shift/presentation/core/style/app_colors.dart';
import 'package:shift/presentation/core/widgets/buttons/common_button.dart';
import 'package:shift/presentation/core/widgets/custom_year_picker/custom_date_picker_dropdown.dart';
import 'package:shift/presentation/core/widgets/custom_year_picker/order_format.dart';
import 'package:shift/presentation/core/widgets/texts/common_texts.dart';
import 'package:shift/presentation/main/widgets/home_app_bar.dart';
import '../../common/widgets/center_loading_indicator.dart';

@RoutePage(name: 'addExperienceDetailScreen')
class AddExperienceDetail extends StatelessWidget {
  bool isFromSplash = false;
  bool isUpdate;
  AddExperienceDetail(
      {super.key, this.isFromSplash = false, this.isUpdate = false});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<ExperienceBloc>()
        ..add(ExperienceEvent.getExperinceDataEvent(isUpdate)),
      child: Scaffold(
        appBar: CommonAppBar(
          isShowBackBtn: !isFromSplash,
          onBackPressed: () {
            context.router.maybePop();
          },
          title: StringConstant.roleExperience,
        ),
        body: BlocConsumer<ExperienceBloc, ExperienceState>(
          listener: (context, state) {
            state.authFailureOrSuccessOption.fold(
              () {},
              (either) => either.fold(
                (failure) {
                  print("fjgdg");
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
                  // context.router
                  //     .push(const PageRouteInfo(EducationListScreen.name));
                  context.router
                      .push(PageRouteInfo(
                    AddSpecialityExperience.name,
                    args: AddSpecialityExperienceArgs(
                      isUpdate: isUpdate,
                    ),
                  ))
                      .then((value) {
                    if (value == true) {
                      Navigator.pop(context, value);
                    }
                  });
                },
              ),
            );
          },
          builder: (context, state) {
            return Form(
              autovalidateMode: (state.showErrorMessages)
                  ? AutovalidateMode.always
                  : AutovalidateMode.disabled,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: getSize(20)),
                child: Column(
                  // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    experinceDesc(),
                    SizedBox(height: getSize(20)),
                    Expanded(
                      child: (state.isLoading)
                          ? CenterLoadingIndicator(isOnlyLoader: true)
                          : SingleChildScrollView(
                              child: mainListView(context, state),
                            ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        bottom: getSize(40),
                      ),
                      child: CommonButton(
                        isSubmitting: state.isSubmitting,
                        onPressed: () {
                          context.read<ExperienceBloc>().add(
                              ExperienceEvent.continueBtnPressedEvent(
                                  isUpdate));
                        },
                        buttonText: (isUpdate)
                            ? StringConstant.update
                            : StringConstant.txtContinue,
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  experinceDesc() {
    return Container(
      height: getSize(90),
      padding: EdgeInsets.symmetric(
        horizontal: getSize(20),
      ),
      decoration: BoxDecoration(
        color: AppColors.grey.withOpacity(0.15),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          SvgPicture.asset(
            SvgImageConstant.female,
            height: getSize(50),
            width: getSize(55),
            color: AppColors.primaryColor,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: getSize(20)),
            child: SvgPicture.asset(
              SvgImageConstant.verticalLine,
              height: getSize(66),
              width: getSize(65),
            ),
          ),
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                BaseText(
                  text: StringConstant.addExperience,
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                ),
                BaseText(
                  text: (isUpdate)
                      ? StringConstant.updateRoleExperienceDec
                      : StringConstant.addRoleExperienceDec,
                  fontSize: 11.5,
                  fontWeight: FontWeight.w400,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget mainListView(BuildContext context, ExperienceState state) {
    return ListView.builder(
      itemCount: state.records.length,
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        var currentObj = state.records[index];
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: getSize(46),
              width: double.infinity,
              margin: EdgeInsets.only(
                top: getSize(15),
                bottom: getSize(10),
              ),
              alignment: Alignment.centerLeft,
              padding: EdgeInsets.symmetric(
                horizontal: getSize(20),
              ),
              decoration: BoxDecoration(
                color: AppColors.grey04,
                borderRadius: BorderRadius.circular(10),
              ),
              child: BaseText(
                text:
                    "${index + 1}. ${(isUpdate) ? currentObj.role?.name ?? "" : currentObj.name}",
                textAlign: TextAlign.center,
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: customeDropDown(
                    hintText: StringConstant.year,
                    value: (currentObj.experience_year != null &&
                            currentObj.experience_year!.isNotEmpty)
                        ? currentObj.experience_year
                        : null,
                    items: CommonList.yearList.map((val) {
                      return DropdownMenuItem<String>(
                        value: val,
                        child: BaseText(
                          text: val,
                          fontSize: 14,
                          textColor: AppColors.black,
                        ),
                      );
                    }).toList(),
                    onChanged: (value) {
                      context
                          .read<ExperienceBloc>()
                          .add(ExperienceEvent.updateRecordEvent(
                            index: index,
                            year: value ?? "",
                            month: currentObj.experience_month ?? "",
                            name: currentObj.name ?? "",
                          ));
                    },
                    // validator: (value) {
                    //   return (state.records[index].experience_year != null &&
                    //           state.records[index].experience_year!.isNotEmpty)
                    //       ? null
                    //       : StringConstant.pleaseSelectYear;
                    // },
                  ),
                ),
                SizedBox(width: getSize(20)),
                Flexible(
                  child: customeDropDown(
                    hintText: StringConstant.month,
                    value: (currentObj.experience_month != null &&
                            currentObj.experience_month!.isNotEmpty)
                        ? currentObj.experience_month
                        : null,
                    items: CommonList.monthList.map((val) {
                      return DropdownMenuItem<String>(
                        value: val,
                        child: BaseText(
                          text: val,
                          fontSize: 14,
                          textColor: AppColors.black,
                        ),
                      );
                    }).toList(),
                    onChanged: (value) {
                      print("SELECTE MONTH $value");
                      context
                          .read<ExperienceBloc>()
                          .add(ExperienceEvent.updateRecordEvent(
                            index: index,
                            year: currentObj.experience_year ?? "",
                            month: value ?? "",
                            name: currentObj.name ?? "",
                          ));
                    },
                    // validator: (value) {
                    //   return (state.records[index].experience_month != null &&
                    //           state.records[index].experience_month!
                    //               .isNotEmpty)
                    //       ? null
                    //       : StringConstant.pleaseSelectMonth;
                    // },
                  ),
                ),
                // customPicker(
                //   context,
                //   showYear: true,
                //   showMonth: false,
                //   onChangeyear: (value) {
                //     context
                //         .read<ExperienceBloc>()
                //         .add(ExperienceEvent.updateRecordEvent(
                //           index: index,
                //           year: value ?? "",
                //           month: currentObj.experience_month ?? "",
                //           name: currentObj.name ?? "",
                //         ));
                //   },
                // ),
                // SizedBox(
                //   width: getSize(20),
                // ),
                // customPicker(
                //   context,
                //   showYear: false,
                //   showMonth: true,
                //   onChangedMonth: (value) {
                //     print("SELECTE MONTH $value");
                //     context
                //         .read<ExperienceBloc>()
                //         .add(ExperienceEvent.updateRecordEvent(
                //           index: index,
                //           year: currentObj.experience_year ?? "",
                //           month: value ?? "",
                //           name: currentObj.name ?? "",
                //         ));
                //   },
                // ),
              ],
            ),
            (!(state.records[index].experience_year != null &&
                            state.records[index].experience_year!.isNotEmpty ||
                        state.records[index].experience_month != null &&
                            state
                                .records[index].experience_month!.isNotEmpty) &&
                    state.showErrorMessages)
                ? commonErrorText(
                    StringConstant.yearAndMonthMustbeSelected,
                    padding: EdgeInsets.symmetric(
                        vertical: getSize(10), horizontal: getSize(20)),
                  )
                : (!(state.records[index].experience_year != null &&
                            state.records[index].experience_year!.isNotEmpty) &&
                        state.showErrorMessages)
                    ? commonErrorText(
                        StringConstant.yearMustbeSelected,
                        padding: EdgeInsets.symmetric(
                            vertical: getSize(10), horizontal: getSize(20)),
                      )
                    : (!(state.records[index].experience_month != null &&
                                state.records[index].experience_month!
                                    .isNotEmpty) &&
                            state.showErrorMessages)
                        ? commonErrorText(
                            StringConstant.monthMustbeSelected,
                            padding: EdgeInsets.symmetric(
                                vertical: getSize(10), horizontal: getSize(20)),
                          )
                        : Container(),
            if (index == (state.records.length - 1))
              SizedBox(
                height: getSize(20),
              )
          ],
        );
      },
    );
  }

  Widget customPicker(BuildContext context,
      {bool showMonth = false,
      bool showYear = false,
      String? selectedMonth,
      String? selectedYear,
      void Function(String?)? onChangeyear,
      void Function(String?)? onChangedMonth}) {
    return Expanded(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(left: getSize(15)),
            child: BaseText(
              text: (showYear) ? StringConstant.year : StringConstant.month,
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
          DropdownDatePicker(
            menuMaxHeight: getSize(400),
            dateformatorder: OrderFormat.YMD,
            showDay: false,
            showMonth: showMonth,
            showYear: showYear,
            isDropdownHideUnderline: true,
            isFormValidator: true,
            errorMonth: StringConstant.pleaseSelectMonth,
            errorYear: StringConstant.pleaseSelectYear,
            startYear: 1970,
            endYear: 2020,
            width: getSize(0),
            hintYear: StringConstant.year,
            hintMonth: StringConstant.month,
            onChangedMonth: onChangedMonth,
            onChangedYear: onChangeyear,
            isExpanded: true,
            inputDecoration: InputDecoration(
              iconColor: AppColors.black,
              filled: true,
              fillColor: AppColors.white,
              prefixIcon: Padding(
                padding: EdgeInsets.only(
                  left: getSize(10),
                ),
                child: SvgPicture.asset(
                  SvgImageConstant.clock,
                  height: getSize(24),
                  width: getSize(24),
                ),
              ),
              prefixIconConstraints: BoxConstraints(
                maxWidth: getSize(34),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide:
                    const BorderSide(color: AppColors.white, width: 1.0),
                borderRadius: BorderRadius.circular(10),
              ),
              errorBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: AppColors.red, width: 1.0),
                borderRadius: BorderRadius.circular(10),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide:
                    const BorderSide(color: AppColors.white, width: 1.0),
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
          // Container(
          //   height: getSize(46),
          //   decoration: BoxDecoration(
          //     color: AppColors.white,
          //     borderRadius: BorderRadius.circular(10),
          //   ),
          // )
        ],
      ),
    );
  }

  Widget customeDropDown({
    String? hintText,
    String? value,
    List<DropdownMenuItem<String>>? items,
    Function(String?)? onChanged,
    String? Function(String?)? validator,
  }) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(left: getSize(20), bottom: getSize(5)),
          child: BaseText(
            text: hintText ?? "",
            fontSize: 14,
            fontWeight: FontWeight.w500,
            textColor: AppColors.black,
          ),
        ),
        DropdownButtonFormField<String>(
          validator: validator,
          menuMaxHeight: getSize(300),
          dropdownColor: AppColors.white,
          decoration: InputDecoration(
            filled: true,
            fillColor: AppColors.white,
            prefixIcon: Padding(
              padding: EdgeInsets.symmetric(
                vertical: getSize(14),
              ),
              child: SvgPicture.asset(
                SvgImageConstant.clock,
                height: getSize(24),
                width: getSize(24),
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: AppColors.white),
              borderRadius: BorderRadius.circular(10),
            ),
            border: OutlineInputBorder(
              borderSide: const BorderSide(color: AppColors.white),
              borderRadius: BorderRadius.circular(10),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: AppColors.red),
              borderRadius: BorderRadius.circular(10),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: AppColors.white),
              borderRadius: BorderRadius.circular(10),
            ),
            errorBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: AppColors.red),
              borderRadius: BorderRadius.circular(10),
            ),
            contentPadding: EdgeInsets.symmetric(
              horizontal: getSize(18),
            ),
          ),
          alignment: Alignment.centerLeft,
          hint: BaseText(
            text: hintText ?? "",
            textColor: AppColors.black.withOpacity(0.50),
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
          value: value,
          icon: SvgPicture.asset(
            SvgImageConstant.downArrow,
          ),
          isExpanded: true,
          items: items,
          onChanged: onChanged,
        ),
      ],
    );
  }
}
