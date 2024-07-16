// ignore_for_file: avoid_print

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
import 'package:shift/presentation/core/style/app_colors.dart';
import 'package:shift/presentation/core/widgets/buttons/common_button.dart';
import 'package:shift/presentation/core/widgets/custom_year_picker/custom_date_picker_dropdown.dart';
import 'package:shift/presentation/core/widgets/custom_year_picker/order_format.dart';
import 'package:shift/presentation/main/widgets/home_app_bar.dart';

@RoutePage(name: 'addExperienceDetailScreen')
class AddExperienceDetail extends StatelessWidget {
  const AddExperienceDetail({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<ExperienceBloc>()
        ..add(const ExperienceEvent.getExperinceDataEvent()),
      child: Scaffold(
        appBar: CommonAppBar(
          onBackPressed: () {
            context.router.maybePop();
          },
          title: StringConstant.experience,
        ),
        body: BlocConsumer<ExperienceBloc, ExperienceState>(
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
                      .push(const PageRouteInfo(ReferenceListScreen.name));
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
                    Image.asset(PngImageConstants.add_experience_desc),
                    SizedBox(
                      height: getSize(20),
                    ),
                    Expanded(
                      child: mainListView(context, state),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        bottom: getSize(40),
                      ),
                      child: CommonButton(
                        onPressed: () {
                          context.read<ExperienceBloc>().add(
                              const ExperienceEvent.continueBtnPressedEvent());
                        },
                        buttonText: StringConstant.txtContinue,
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

  Widget mainListView(BuildContext context, ExperienceState state) {
    return ListView.builder(
      itemCount: state.records.length,
      itemBuilder: (context, index) {
        var currentObj = state.records[index];
        return Column(
          children: [
            Container(
              height: getSize(46),
              width: double.infinity,
              margin: EdgeInsets.symmetric(
                vertical: getSize(10),
              ),
              alignment: Alignment.centerLeft,
              padding: EdgeInsets.symmetric(
                horizontal: getSize(20),
              ),
              decoration: BoxDecoration(
                color: AppColors.grey.withOpacity(0.4),
                borderRadius: BorderRadius.circular(10),
              ),
              child: BaseText(
                text: "${index + 1}. ${currentObj.name}",
                textAlign: TextAlign.center,
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                customPicker(
                  context,
                  showYear: true,
                  showMonth: false,
                  onChangeyear: (value) {
                    context
                        .read<ExperienceBloc>()
                        .add(ExperienceEvent.updateRecordEvent(
                          index: index,
                          year: value ?? "",
                          month: currentObj.month ?? "",
                          name: currentObj.name ?? "",
                        ));
                  },
                ),
                customPicker(
                  context,
                  showYear: false,
                  showMonth: true,
                  onChangedMonth: (value) {
                    print("SELECTE MONTH $value");
                    context
                        .read<ExperienceBloc>()
                        .add(ExperienceEvent.updateRecordEvent(
                          index: index,
                          year: currentObj.year ?? "",
                          month: value ?? "",
                          name: currentObj.name ?? "",
                        ));
                  },
                ),
              ],
            ),
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
    return SizedBox(
      width: getSize(180),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          BaseText(
            text: (showYear) ? StringConstant.year : StringConstant.month,
            fontSize: 14,
            fontWeight: FontWeight.w500,
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
            startYear: 1900,
            endYear: 2020,
            width: getSize(0),
            hintYear: StringConstant.year,
            hintMonth: StringConstant.month,
            onChangedMonth: onChangedMonth,
            onChangedYear: onChangeyear,
            isExpanded: false,
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
}
