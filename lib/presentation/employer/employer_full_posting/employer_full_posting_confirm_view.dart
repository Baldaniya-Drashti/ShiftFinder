import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:shift/application/employer/employer_full_posting_confirm/employer_full_posting_confirm_bloc.dart';
import 'package:shift/domain/core/document_expiry_picker.dart';
import 'package:shift/domain/core/math_utils.dart';
import 'package:shift/domain/core/string_constant.dart';
import 'package:shift/domain/core/svg_image_constants.dart';
import 'package:shift/infrastructure/employer_long_term_success/employer_long_term_success_dto.dart';
import 'package:shift/injection.dart';
import 'package:shift/presentation/common/utils/get_cookie.dart';
import 'package:shift/presentation/common/widgets/base_text.dart';
import 'package:shift/presentation/common/widgets/center_loading_indicator.dart';
import 'package:shift/presentation/core/common_lisitng/common_listing.dart';
import 'package:shift/presentation/core/style/app_colors.dart';
import 'package:shift/presentation/core/widgets/buttons/common_button.dart';
import 'package:shift/presentation/core/widgets/inputs/custom_text_field.dart';
import 'package:shift/presentation/core/widgets/texts/common_texts.dart';
import 'package:shift/presentation/main/widgets/home_app_bar.dart';

@RoutePage(name: "EmployerFullPostingConfirmView")
class EmployerFullPostingConfirmView extends StatelessWidget {
  const EmployerFullPostingConfirmView({
    super.key,
    required this.employerFullPosting,
    this.postId,
    this.fromReview = false,
    this.fromTemplate = false,
    this.isCreate = true,
  });

  final EmployerLongTermSuccessDto employerFullPosting;
  final int? postId;
  final bool fromReview;
  final bool fromTemplate;
  final bool isCreate;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<EmployerFullPostingConfirmBloc>()
        ..add(
          EmployerFullPostingConfirmEvent.onCreate(
              employerLongTermSuccessDto: employerFullPosting, post: postId),
        ),
      child: BlocBuilder<EmployerFullPostingConfirmBloc,
          EmployerFullPostingConfirmState>(
        builder: (context, state) {
          return Scaffold(
            bottomNavigationBar: SafeArea(
              minimum: EdgeInsets.all(getSize(16)),
              child: CommonButton(
                onPressed: () {
                  context.read<EmployerFullPostingConfirmBloc>().add(
                        EmployerFullPostingConfirmEvent.onContinue(
                          context: context,
                          fromReview: fromReview,
                          isCreate: isCreate,
                          fromTemplate: fromTemplate,
                        ),
                      );
                },
                buttonText: StringConstant.txtContinue,
              ),
            ),
            appBar: CommonAppBar(
                onBackPressed: () => context.router.maybePop(),
                title: (fromTemplate)
                    ? StringConstant.editTemplate
                    : CommonList.industryList
                            .firstWhere(
                                (item) => item.id == getCurrentIndustry())
                            .title ??
                        ""),
            body: (state.postDataLoading)
                ? CenterLoadingIndicator(isOnlyLoader: true)
                : SingleChildScrollView(
                    child: Form(
                      autovalidateMode: (state.showErrorMessage)
                          ? AutovalidateMode.always
                          : AutovalidateMode.disabled,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          appDeadLineField(context, state),
                          Gap(getSize(16)),
                          isIncludeOnCall(context, state),
                          if (!fromTemplate) ...[
                            Gap(getSize(16)),
                            templateCheckBox(context, state),
                          ],
                          Gap(getSize(16)),
                          vacancyCheckBox(context, state),
                          if (state.isMoreVacancy) ...[
                            Gap(getSize(12)),
                            numberOfVacancy(context, state),
                          ],
                          Gap(getSize(16)),
                          isTermsCheck(context, state),
                          if (state.showErrorMessage && !state.isTermsCheck)
                            commonErrorText(
                                StringConstant.pleaseCheckTheBoxToProceeding)
                        ],
                      ),
                    ),
                  ),
          );
        },
      ),
    );
  }

  Widget appDeadLineField(
    BuildContext context,
    EmployerFullPostingConfirmState state,
  ) {
    return CustomTextField(
      labelText: StringConstant.applicationDeadline,
      hintText: (state.deadLineDate.isValid())
          ? DateFormat('d MMM, yyyy')
              .format(DateTime.parse(state.deadLineDate.getValue() ?? ""))
          : StringConstant.applicationDeadline,
      hintAsValue: (state.deadLineDate.isValid()) ? true : false,
      readOnly: true,
      errorInputBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: AppColors.transparent),
        borderRadius: BorderRadius.circular(getSize(10)),
      ),
      prefixIcon: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: getSize(14),
          vertical: getSize(14),
        ),
        child: SvgPicture.asset(
          SvgImageConstant.calendar,
          height: getSize(24),
          width: getSize(24),
        ),
      ),
      onTap: () {
        DocumentExpiryDatePicker.customDatePicker(
          context,
          firstDate: DateTime.now().add(Duration(days: 1)),
          onPickedDate: (pickedDate) {
            context.read<EmployerFullPostingConfirmBloc>().add(
                    EmployerFullPostingConfirmEvent
                        .onApplicationDeadlineChanged(
                  selectedDateTime: pickedDate,
                ));
          },
          onCancelClick: () {},
          selectedDate: (state.deadLineDate.isValid())
              ? DateTime.parse(state.deadLineDate.getValue() ?? "")
              : DateTime.now().add(Duration(days: 1)),
        );
      },
      validator: (_, context) => context
          .read<EmployerFullPostingConfirmBloc>()
          .state
          .deadLineDate
          .value
          .fold(
            (f) => f.maybeMap(
              empty: (value) => StringConstant.pleaseSelectApplicationDeadline,
              orElse: () => null,
            ),
            (_) => null,
          ),
    );
  }

  Widget isTermsCheck(
    BuildContext context,
    EmployerFullPostingConfirmState state,
  ) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: getSize(20),
        vertical: getSize(10),
      ),
      decoration: BoxDecoration(
          color: AppColors.grey04, borderRadius: BorderRadius.circular(10)),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: getSize(20),
            width: getSize(16.67),
            child: Checkbox(
              value: state.isTermsCheck,
              activeColor: AppColors.primaryColor,
              side: BorderSide(
                width: getSize(1.5),
                color: AppColors.black.withValues(alpha: 0.5),
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5),
              ),
              onChanged: (value) {
                if (value != null) {
                  context.read<EmployerFullPostingConfirmBloc>().add(
                      EmployerFullPostingConfirmEvent
                          .onTermsAndConditionChanged(value: value));
                }
              },
            ),
          ),
          SizedBox(width: getSize(15)),
          Expanded(
            child: BaseText(
              text: StringConstant.fullTermsDesc,
              fontSize: 12,
              maxLines: 7,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget templateCheckBox(
    BuildContext context,
    EmployerFullPostingConfirmState state,
  ) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: getSize(20),
        vertical: getSize(10),
      ),
      decoration: BoxDecoration(
          color: AppColors.grey04, borderRadius: BorderRadius.circular(10)),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: getSize(20),
            width: getSize(16.67),
            child: Checkbox(
              value: state.isSaveAsTemplate,
              activeColor: AppColors.primaryColor,
              side: BorderSide(
                width: getSize(1.5),
                color: AppColors.black.withValues(alpha: 0.5),
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5),
              ),
              onChanged: (value) {
                if (value != null) {
                  context.read<EmployerFullPostingConfirmBloc>().add(
                      EmployerFullPostingConfirmEvent.onFuturePostingChanged(
                          value: value));
                }
              },
            ),
          ),
          SizedBox(width: getSize(15)),
          Expanded(
            child: BaseText(
              text: StringConstant.saveThisAsATemplateForFuturePosting,
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget isIncludeOnCall(
    BuildContext context,
    EmployerFullPostingConfirmState state,
  ) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: getSize(20),
        vertical: getSize(10),
      ),
      decoration: BoxDecoration(
          color: AppColors.grey04, borderRadius: BorderRadius.circular(10)),
      child: GestureDetector(
        onTap: () {
          bool value = state.isIncludeOnCall;
          value = !value;
          context.read<EmployerFullPostingConfirmBloc>().add(
              EmployerFullPostingConfirmEvent.onIncludeOnCallChanged(
                  value: value));
        },
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: getSize(20),
              width: getSize(16.67),
              child: Checkbox(
                value: state.isIncludeOnCall,
                activeColor: AppColors.primaryColor,
                side: BorderSide(
                  width: getSize(1.5),
                  color: AppColors.black.withValues(alpha: 0.5),
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
                onChanged: (value) {
                  if (value != null) {
                    context.read<EmployerFullPostingConfirmBloc>().add(
                        EmployerFullPostingConfirmEvent.onIncludeOnCallChanged(
                            value: value));
                  }
                },
              ),
            ),
            SizedBox(width: getSize(15)),
            Expanded(
              child: BaseText(
                text: StringConstant.thisPositionMayIncludeOnCall,
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget vacancyCheckBox(
      BuildContext context, EmployerFullPostingConfirmState state) {
    return GestureDetector(
      onTap: () {
        bool value = state.isMoreVacancy;
        value = !value;
        context
            .read<EmployerFullPostingConfirmBloc>()
            .add(EmployerFullPostingConfirmEvent.checkIsMoreVancancy(value));
      },
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: getSize(20),
          vertical: getSize(10),
        ),
        decoration: BoxDecoration(
            color: AppColors.grey04, borderRadius: BorderRadius.circular(10)),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: getSize(20),
              width: getSize(16.67),
              child: Checkbox(
                value: state.isMoreVacancy,
                activeColor: AppColors.primaryColor,
                side: BorderSide(
                  width: getSize(1.5),
                  color: AppColors.black.withValues(alpha: 0.5),
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
                onChanged: (value) {
                  if (value != null) {
                    context.read<EmployerFullPostingConfirmBloc>().add(
                        EmployerFullPostingConfirmEvent.checkIsMoreVancancy(
                            value));
                  }
                },
              ),
            ),
            SizedBox(width: getSize(15)),
            Flexible(
              child: BaseText(
                text: StringConstant.singleShiftVacancyDesc,
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget numberOfVacancy(
      BuildContext context, EmployerFullPostingConfirmState state) {
    return CustomTextField(
      labelText: StringConstant.numberOfVacancies,
      hintText: StringConstant.numberOfVacancies,
      initialValue: state.selectedVacancy.getValue(),
      keyboardType: TextInputType.number,
      errorInputBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: AppColors.transparent),
        borderRadius: BorderRadius.circular(getSize(10)),
      ),
      maxLength: 3,
      inputFormatters: [
        FilteringTextInputFormatter.digitsOnly,
      ],
      onChanged: (value) {
        context
            .read<EmployerFullPostingConfirmBloc>()
            .add(EmployerFullPostingConfirmEvent.addVacancyChanged(value));
      },
      validator: (p0, p1) => context
          .read<EmployerFullPostingConfirmBloc>()
          .state
          .selectedVacancy
          .value
          .fold(
            (f) => f.maybeMap(
              empty: (value) => StringConstant.pleaseAddNumberOfVacancies,
              invalidVacancy: (value) =>
                  StringConstant.numberOfVacanciesMustBeGreaterThanOne,
              orElse: () => null,
            ),
            (_) => null,
          ),
    );
  }
}
