import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:shift/application/employer/employer_invoice_bloc/employer_invoice_bloc.dart';
import 'package:shift/domain/core/math_utils.dart';
import 'package:shift/domain/core/png_image_constants.dart';
import 'package:shift/domain/core/string_constant.dart';
import 'package:shift/domain/core/svg_image_constants.dart';
import 'package:shift/infrastructure/core/employer_invoice_dto/employer_invoice_dto.dart';
import 'package:shift/injection.dart';
import 'package:shift/presentation/billing/invoice_viewer.dart';
import 'package:shift/presentation/billing/transaction_info.dart';
import 'package:shift/presentation/common/utils/date_time_format.dart';
import 'package:shift/presentation/common/utils/flushbar_creator.dart';
import 'package:shift/presentation/common/utils/get_cookie.dart';
import 'package:shift/presentation/common/utils/save_file_to_storage.dart';
import 'package:shift/presentation/common/widgets/base_text.dart';
import 'package:shift/presentation/common/widgets/center_loading_indicator.dart';
import 'package:shift/presentation/common/widgets/no_data_ui.dart';
import 'package:shift/presentation/core/common_lisitng/common_listing.dart';
import 'package:shift/presentation/core/style/app_colors.dart';
import 'package:shift/presentation/core/widgets/buttons/common_button.dart';
import 'package:shift/presentation/core/widgets/tile.dart';
import 'package:shift/presentation/main/widgets/home_app_bar.dart';

@RoutePage(name: "CompleteShiftInvoiceView")
class CompleteShiftInvoiceView extends StatelessWidget {
  final int id;
  const CompleteShiftInvoiceView({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    final isContractor = getCurrentRole() == 1;

    return BlocProvider(
      create: (context) => getIt<EmployerInvoiceBloc>()
        ..add(EmployerInvoiceEvent.getInvoiceDetailEvent(id)),
      child: BlocBuilder<EmployerInvoiceBloc, EmployerInvoiceState>(
        builder: (context, state) {
          return Scaffold(
            appBar: CommonAppBar(
              onBackPressed: () => context.router.maybePop(),
              title: StringConstant.invoice,
            ),
            body: (state.isLoading)
                ? CenterLoadingIndicator()
                : (state.selectedInvoice == null)
                    ? Center(
                        child: NoDataText(
                        title: StringConstant.noResultFound,
                        description: "",
                      ))
                    : SingleChildScrollView(
                        padding: EdgeInsets.all(getSize(16)),
                        child: Column(
                          children: [
                            BaseTileDecoration(
                              padding: EdgeInsets.symmetric(
                                  vertical: getSize(25),
                                  horizontal: getSize(10)),
                              child: Column(
                                children: [
                                  companyDetail(
                                    context,
                                    showDownloadBtn: isContractor,
                                    invoice: state.selectedInvoice!,
                                    isContractor: isContractor,
                                  ),
                                  commonDivider(),
                                  _ContractorDetail(
                                    invoice: state.selectedInvoice!,
                                  ),
                                  Gap(getSize(16)),
                                  _ShiftDetail(
                                    invoice: state.selectedInvoice!,
                                  ),
                                  Gap(getSize(16)),
                                  _PaymentDetail(
                                    invoice: state.selectedInvoice!,
                                  ),
                                  if (isContractor) ...[
                                    Divider(),
                                    TransactionInfo(
                                        label: StringConstant.totalEarnings,
                                        value:
                                            "\$${state.selectedInvoice?.total_amount_payble ?? "00"}",
                                        valueColor: AppColors.green,
                                        valueFontSize: 12),
                                    Gap(getSize(10)),
                                    downLoadInvoiceBtn(
                                      isContractor,
                                      onTap: () {
                                        downloadInvoice(context,
                                            invoice: state.selectedInvoice!,
                                            isContractor: isContractor);
                                      },
                                    ),
                                  ] else ...[
                                    Gap(getSize(16)),
                                    Container(
                                      padding: EdgeInsets.all(getSize(16)),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: AppColors.green
                                            .withValues(alpha: 0.2),
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          BaseText(
                                            text:
                                                "${StringConstant.totalAmountPayable} :",
                                            fontSize: 12,
                                            fontWeight: FontWeight.w600,
                                          ),
                                          BaseText(
                                            text:
                                                "\$${state.selectedInvoice?.total_amount_payble ?? "00"}",
                                            fontWeight: FontWeight.w600,
                                            fontSize: 16,
                                          ),
                                        ],
                                      ),
                                    )
                                  ]
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
          );
        },
      ),
    );
  }

  Widget commonDivider() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: getSize(10)),
      child: Divider(),
    );
  }

  Widget downLoadInvoiceBtn(bool isContractor,
      {required void Function() onTap}) {
    return CommonButton(
      buttonText: "",
      onPressed: onTap,
      borderRadius: 5,
      width: 76,
      height: 20,
      backgroundColor: AppColors.primaryColor.withValues(alpha: 0.20),
      buttonTextColor: AppColors.primaryColor,
      customWidget: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          SvgPicture.asset(
            SvgImageConstant.download,
            width: getSize(10),
            height: getSize(10),
          ),
          SizedBox(width: getSize(5)),
          BaseText(
            textAlign: TextAlign.center,
            text: StringConstant.download,
            fontSize: 8,
            fontWeight: FontWeight.w500,
            textColor: isContractor ? AppColors.white : AppColors.green,
          ),
        ],
      ),
    );
  }

  Widget companyDetail(BuildContext context,
      {bool showDownloadBtn = false,
      required EmployerInvoiceDTO invoice,
      required bool isContractor}) {
    final industry = CommonList.industryList
        .firstWhere((element) => element.id == invoice.industry);
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox.square(
          dimension: getSize(60),
          child: Image.asset(PngImageConstants.leafWithBG),
        ),
        Gap(getSize(8)),
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        BaseText(
                          text: invoice.employer_company_name ?? "",
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                          maxLines: 2,
                        ),
                        BaseText(
                          text:
                              '(${industry.title ?? ""} - ${invoice.listing_id ?? ""})',
                          fontSize: 10,
                          fontWeight: FontWeight.w400,
                          maxLines: 1,
                        ),
                      ],
                    ),
                  ),
                  if (!showDownloadBtn) ...[
                    downLoadInvoiceBtn(
                      showDownloadBtn,
                      onTap: () {
                        downloadInvoice(context,
                            invoice: invoice, isContractor: isContractor);
                      },
                    ),
                  ],
                ],
              ),
              Gap(getSize(3)),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SvgPicture.asset(
                    SvgImageConstant.location,
                    colorFilter:
                        ColorFilter.mode(AppColors.green, BlendMode.srcIn),
                    height: getSize(24),
                    width: getSize(24),
                  ),
                  Expanded(
                    child: BaseText(
                      text: invoice.location?.location ?? "",
                      fontSize: 10,
                      fontWeight: FontWeight.w500,
                      maxLines: 1,
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ],
    );
  }
}

class _ContractorDetail extends StatelessWidget {
  final EmployerInvoiceDTO invoice;
  const _ContractorDetail({required this.invoice});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        StatementHeadingTitle(title: StringConstant.contractorsDetails),
        TransactionInfo(
            label: StringConstant.name,
            value:
                "${invoice.contractor_first_name ?? ""} ${invoice.contractor_last_name ?? ""}"),
        TransactionInfo(
            label: StringConstant.email, value: invoice.contractor_email ?? ""),
        TransactionInfo(
            label: StringConstant.address,
            value: invoice.location?.location ?? "")
      ],
    );
  }
}

class _ShiftDetail extends StatelessWidget {
  final EmployerInvoiceDTO invoice;
  const _ShiftDetail({required this.invoice});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        StatementHeadingTitle(title: StringConstant.shiftsDetails),
        TransactionInfo(
            label: StringConstant.shiftType,
            value: (invoice.shift_type == "2")
                ? StringConstant.multi
                : StringConstant.single),
        TransactionInfo(
            label: StringConstant.role, value: invoice.roles_list_name ?? ""),
        TransactionInfo(
          label: StringConstant.date,
          value: (invoice.date != null)
              ? DateFormat("dd MMM, yyyy").format(
                  CustomDateTimeFormat.timeStampToDateTime((invoice.date!)))
              : "",
        )
      ],
    );
  }
}

class _PaymentDetail extends StatelessWidget {
  final EmployerInvoiceDTO invoice;
  const _PaymentDetail({required this.invoice});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        StatementHeadingTitle(title: StringConstant.paymentsDetails),
        TransactionInfo(
            label: StringConstant.totalPayableHours,
            value: invoice.total_payable_hours ?? ""),
        TransactionInfo(
            label: StringConstant.hourlyRate,
            value: "\$${invoice.hourly_rate ?? 00}"),
        TransactionInfo(
            label: StringConstant.totalWage,
            value: "\$${invoice.total_wage ?? 00}"),
        TransactionInfo(
            label: StringConstant.shiftFinderServiceFee,
            value: "\$${invoice.shiftfinder_service_fee ?? 00}"),
        TransactionInfo(
            label: StringConstant.totalAllowance,
            value: "\$${invoice.total_allowance ?? 00}"),
        Divider(),
        TransactionInfo(
          label: StringConstant.totalEarnings,
          value: "\$${invoice.total_allowance ?? 00}",
          valueColor: AppColors.primaryColor,
        ),
      ],
    );
  }
}

class StatementHeadingTitle extends StatelessWidget {
  const StatementHeadingTitle({
    super.key,
    required this.title,
    this.color,
  });

  final String title;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      padding:
          EdgeInsets.symmetric(horizontal: getSize(18), vertical: getSize(10)),
      margin: EdgeInsets.symmetric(vertical: getSize(10)),
      decoration: BoxDecoration(
        color: color ?? AppColors.scaffoldColor,
        borderRadius: BorderRadius.circular(7),
      ),
      child: BaseText(text: title, fontSize: 10, fontWeight: FontWeight.w600),
    );
  }
}

void downloadInvoice(BuildContext context,
    {required EmployerInvoiceDTO invoice, required bool isContractor}) async {
  final pdfData =
      await InvoiceGenerator().generateBillingInvoice(invoice, isContractor);

  String? pdfPath = await SaveFileToStorage.savePdfToShiftFinderDirectory(
      pdfData,
      fileName: 'PreviusShift_Invoice_${invoice.listing_id}.pdf');

  if (pdfPath != null) {
    showSuccess(
            message: "PreviusShift_Invoice_${invoice.listing_id} Downloaded..!")
        .show(context);
  } else {
    showError(message: "Failed to download PDF!").show(context);
  }
}
