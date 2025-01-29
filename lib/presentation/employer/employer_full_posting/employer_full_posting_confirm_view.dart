import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:shift/application/employer/employer_full_posting_confirm/employer_full_posting_confirm_bloc.dart';
import 'package:shift/domain/core/math_utils.dart';
import 'package:shift/domain/core/string_constant.dart';
import 'package:shift/domain/core/svg_image_constants.dart';
import 'package:shift/infrastructure/core/employer_long_term_add_detail_dto/employer_long_term_add_detail_dto.dart';
import 'package:shift/infrastructure/employer_long_term_success/employer_long_term_success_dto.dart';
import 'package:shift/infrastructure/main/post_shift_dto/post_shift_dto.dart';
import 'package:shift/injection.dart';
import 'package:shift/presentation/common/widgets/base_text.dart';
import 'package:shift/presentation/common/widgets/center_loading_indicator.dart';
import 'package:shift/presentation/core/app_router.gr.dart';
import 'package:shift/presentation/core/style/app_colors.dart';
import 'package:shift/presentation/core/widgets/buttons/common_button.dart';
import 'package:shift/presentation/core/widgets/date_picker_input_field.dart';
import 'package:shift/presentation/core/widgets/inputs/custom_text_field.dart';
import 'package:shift/presentation/main/widgets/home_app_bar.dart';

final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

@RoutePage(name: "EmployerFullPostingConfirmView")
class EmployerFullPostingConfirmView extends StatelessWidget {
  const EmployerFullPostingConfirmView({
    super.key,
    required this.employerFullPosting,
  });

  final EmployerLongTermSuccessDto employerFullPosting;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<EmployerFullPostingConfirmBloc>()
        ..add(
          EmployerFullPostingConfirmEvent.onCreate(employerLongTermSuccessDto: employerFullPosting),
        ),
      child: Builder(
        builder: (context) {
         final loading= context.select<EmployerFullPostingConfirmBloc,bool>((value) => value.state.postDataLoading);
          return Stack(
            children: [
              Scaffold(
                bottomNavigationBar: SafeArea(
                  minimum: EdgeInsets.all(getSize(16)),
                  child: CommonButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate() != true) return;
                      context.read<EmployerFullPostingConfirmBloc>().add(
                        EmployerFullPostingConfirmEvent.onContinue(context: context),
                      );
                    },
                    buttonText: "Continue",
                  ),
                ),
                appBar: CommonAppBar(onBackPressed: () => context.router.maybePop(), title: "Healthcare"),
                body: _EmployerFullPostingContent(),
              ),
              if(loading)CenterLoadingIndicator(),
            ],
          );
        }
      ),
    );
  }
}

class _EmployerFullPostingContent extends StatefulWidget {
  const _EmployerFullPostingContent();

  @override
  State<_EmployerFullPostingContent> createState() => _EmployerFullPostingContentState();
}

class _EmployerFullPostingContentState extends State<_EmployerFullPostingContent> {
  final TextEditingController _vacancyController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(getSize(16)),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            BlocSelector<EmployerFullPostingConfirmBloc, EmployerFullPostingConfirmState, DateTime?>(
              selector: (state) => state.employerFullPosting.application_deadline,
              builder: (context, applicationDeadline) {
                return DatePickerInputField(
                  validator: (value, context) {
                    value=value?.trim()??"";
                    if(value.isEmpty)return "Please select application deadline";
                    return null;
                  },
                  initialDate: applicationDeadline,
                  label: "Application Deadline",
                  hint: "Application Deadline",
                  onPickedDate: (date) {
                    context.read<EmployerFullPostingConfirmBloc>().add(
                          EmployerFullPostingConfirmEvent.onApplicationDeadlineChanged(selectedDateTime: date),
                        );
                  },
                );
              },
            ),
            Gap(getSize(16)),
            BlocSelector<EmployerFullPostingConfirmBloc, EmployerFullPostingConfirmState, bool>(
              selector: (state) => state.employerFullPosting.on_call_included == 1,
              builder: (context, includeOnCall) {
                return _buildCheckListTile(
                  context,
                  value: includeOnCall,
                  onChanged: (value) {
                    context.read<EmployerFullPostingConfirmBloc>().add(
                          EmployerFullPostingConfirmEvent.onIncludeOnCallChanged(value: value),
                        );
                  },
                  label: "This position may include on call.",
                );
              },
            ),
            Gap(getSize(16)),
            BlocSelector<EmployerFullPostingConfirmBloc, EmployerFullPostingConfirmState, bool>(
              selector: (state) => state.employerFullPosting.save_template_status == 1,
              builder: (context, saveFuturePosting) {
                return _buildCheckListTile(
                  context,
                  value: saveFuturePosting,
                  onChanged: (value) {
                    context.read<EmployerFullPostingConfirmBloc>().add(
                          EmployerFullPostingConfirmEvent.onFuturePostingChanged(value: value),
                        );
                  },
                  label: "Save this as a template for future posting",
                );
              },
            ),
            Gap(getSize(16)),
            BlocSelector<EmployerFullPostingConfirmBloc, EmployerFullPostingConfirmState, bool>(
              selector: (state) => state.employerFullPosting.vacancie_type == 1,
              builder: (context, moreVacancy) {
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    _buildCheckListTile(
                      context,
                      value: moreVacancy,
                      onChanged: (value) {
                        context.read<EmployerFullPostingConfirmBloc>().add(
                              EmployerFullPostingConfirmEvent.onMoreVacancyChanged(value: value),
                            );
                      },
                      label: "We are looking to fill more than one vacancies with the same  requirements.",
                    ),
                    if (moreVacancy) ...[
                      Gap(getSize(12)),
                      CustomTextField(
                        autoValidateMode: AutovalidateMode.onUserInteraction,
                        controller: _vacancyController,
                        labelText: StringConstant.numberOfVacancies,
                        hintText: StringConstant.numberOfVacancies,
                        keyboardType: TextInputType.number,
                        errorInputBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: AppColors.transparent),
                          borderRadius: BorderRadius.circular(getSize(10)),
                        ),
                        maxLength: 3,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                        ],
                        validator: (value, _) {
                          if (!moreVacancy) return null;
                          value = value?.trim() ?? "";
                          if (value.isEmpty) {
                            return StringConstant.pleaseAddNumberOfVacancies;
                          }
                          if (value == "1" || value == "0") {
                            return StringConstant.numberOfVacanciesMustBeGreaterThanOne;
                          } else {
                            return null;
                          }
                        },
                      )
                    ]
                  ],
                );
              },
            ),
            Gap(getSize(16)),
            BlocSelector<EmployerFullPostingConfirmBloc, EmployerFullPostingConfirmState, bool>(
              selector: (state) => state.employerFullPosting.employer_payment_confirmation == 1,
              builder: (context, termsAndCondition) {
                return _buildCheckListTile(
                  padding: EdgeInsets.symmetric(horizontal: 18, vertical: 12),
                  context,
                  value: termsAndCondition,
                  onChanged: (value) {
                    context.read<EmployerFullPostingConfirmBloc>().add(
                          EmployerFullPostingConfirmEvent.onTermsAndConditionChanged(value: value),
                        );
                  },
                  label:
                      "By proceeding, I confirm that we, the employer, are responsible for making payments directly to  the contractor for this full-time position. We understand that ShiftFinder is not responsible for any  disputes, including those arising from non-payment or contract violations.",
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCheckListTile(
    BuildContext context, {
    required bool value,
    required void Function(bool value) onChanged,
    required String label,
    EdgeInsets? padding,
    Widget? trailing,
  }) {
    return Container(
      padding: padding ??
          EdgeInsets.symmetric(
            horizontal: getSize(20),
            vertical: getSize(10),
          ),
      decoration: BoxDecoration(color: AppColors.grey04, borderRadius: BorderRadius.circular(10)),
      child: GestureDetector(
        onTap: () {
          onChanged(!value);
        },
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: getSize(20),
              width: getSize(16.67),
              child: Checkbox(
                value: value,
                activeColor: AppColors.primaryColor,
                side: BorderSide(
                  width: getSize(1.5),
                  color: AppColors.black.withOpacity(0.5),
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
                onChanged: (value) {
                  onChanged(value!);
                },
              ),
            ),
            SizedBox(
              width: getSize(15),
            ),
            Expanded(
              child: BaseText(
                text: label,
                fontSize: 12,
                fontWeight: FontWeight.w500,
                maxLines: 15,
              ),
            ),
            if (trailing != null) trailing
          ],
        ),
      ),
    );
  }
}
