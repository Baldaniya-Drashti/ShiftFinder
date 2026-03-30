// ignore_for_file: deprecated_member_use

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
import 'package:shift/infrastructure/core/payment_history_dto/payment_history_dto.dart';
import 'package:shift/injection.dart';
import 'package:shift/presentation/common/utils/date_time_format.dart';
import 'package:shift/presentation/common/widgets/base_text.dart';
import 'package:shift/presentation/common/widgets/center_loading_indicator.dart';
import 'package:shift/presentation/common/widgets/paginated_list_view.dart';
import 'package:shift/presentation/core/app_router.gr.dart';
import 'package:shift/presentation/core/common_lisitng/common_listing.dart';
import 'package:shift/presentation/core/helper/location_helper.dart';
import 'package:shift/presentation/core/style/app_colors.dart';
import 'package:shift/presentation/core/widgets/avatar.dart';
import 'package:shift/presentation/core/widgets/buttons/common_button.dart';
import 'package:shift/presentation/main/widgets/home_app_bar.dart';

@RoutePage(name: "InvoiceView")
class InvoiceView extends StatelessWidget {
  const InvoiceView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<EmployerInvoiceBloc>()
        ..add(EmployerInvoiceEvent.getEmployerInvoiceEvent(true)),
      child: BlocBuilder<EmployerInvoiceBloc, EmployerInvoiceState>(
        builder: (context, state) {
          return Scaffold(
            appBar: CommonAppBar(
              onBackPressed: () => context.router.maybePop(),
              title: StringConstant.invoices,
            ),
            body: Padding(
              padding: EdgeInsets.symmetric(horizontal: getSize(5)),
              child: state.isLoading
                  ? CenterLoadingIndicator(isOnlyLoader: true)
                  : state.isErrorInApi
                      ? Center(
                          child:
                              BaseText(text: StringConstant.somethindWentWrong))
                      : PaginatedListView(
                          onRefresh: () => context
                              .read<EmployerInvoiceBloc>()
                              .add(EmployerInvoiceEvent.getEmployerInvoiceEvent(
                                  true)),
                          onLoading: () => context
                              .read<EmployerInvoiceBloc>()
                              .add(EmployerInvoiceEvent.getEmployerInvoiceEvent(
                                  false)),
                          refreshController: context
                              .read<EmployerInvoiceBloc>()
                              .refreshController,
                          isNoDataFound: state.noDataFound,
                          child: ListView.separated(
                            padding: EdgeInsets.all(getSize(15)),
                            itemBuilder: (context, index) {
                              return Container(
                                padding: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: AppColors.white,
                                ),
                                child: Column(
                                  children: [
                                    userDetail(
                                        context, state.invoiceList[index]),
                                    Gap(getSize(10)),
                                    CommonButton(
                                      onPressed: () {
                                        context.router.push(PageRouteInfo(
                                            InvoiceDetailView.name,
                                            args: InvoiceDetailViewArgs(
                                                id: state.invoiceList[index]
                                                        .id ??
                                                    -1)));
                                      },
                                      buttonText: StringConstant.viewInvoice,
                                      borderRadius: 7,
                                      height: 36,
                                      buttonFontSize: 12,
                                      backgroundColor: AppColors.primaryColor
                                          .withValues(alpha: 0.15),
                                      buttonTextColor: AppColors.black,
                                    )
                                  ],
                                ),
                              );
                            },
                            separatorBuilder: (context, index) =>
                                Gap(getSize(16)),
                            itemCount: state.invoiceList.length,
                          ),
                        ),
            ),
          );
        },
      ),
    );
  }

  Widget commonDivider() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: getSize(12)),
      child: Divider(
        height: 0,
      ),
    );
  }

  Widget userDetail(BuildContext context, PaymentHistoryDTO shift) {
    final industry = CommonList.industryList
        .firstWhere((element) => element.id == shift.industry);
    return Container(
      padding:
          EdgeInsets.symmetric(horizontal: getSize(20), vertical: getSize(10)),
      decoration: BoxDecoration(
        color: AppColors.scaffoldColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          ListTile(
            dense: true,
            minTileHeight: 0,
            contentPadding: EdgeInsets.zero,
            horizontalTitleGap: getSize(5),
            minVerticalPadding: 0,
            titleAlignment: ListTileTitleAlignment.titleHeight,
            leading: Container(
              height: getSize(40),
              width: getSize(40),
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                      image: AssetImage(PngImageConstants.nurse2))),
            ),
            title: BaseText(
              text: shift.roles_list_name ?? "",
              fontWeight: FontWeight.w600,
              fontSize: 14,
              maxLines: 1,
            ),
            subtitle: BaseText(
              text: '(${industry.title ?? ""} - ${shift.listing_id ?? ""})',
              fontSize: 12,
              maxLines: 1,
            ),
            trailing: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                BaseText(
                  text: StringConstant.shiftDate,
                  fontSize: 8,
                ),
                RichText(
                  text: TextSpan(
                      style: TextStyle(
                          fontSize: getFontSize(9),
                          color: AppColors.primaryColor),
                      text: (shift.date != null)
                          ? DateFormat('dd MMM, ').format(
                              CustomDateTimeFormat.timeStampToDateTime(
                                  shift.date!))
                          : "",
                      children: [
                        TextSpan(
                          text: (shift.date != null)
                              ? "${CustomDateTimeFormat.timeStampToDateTime(shift.date!).year}"
                              : "",
                          style: TextStyle(
                            color: AppColors.black.withValues(alpha: 0.5),
                          ),
                        ),
                      ]),
                )
              ],
            ),
          ),
          commonDivider(),
          GestureDetector(
            onTap: () {
              final location = shift.location;
              final latitude = location?.latitude;
              final longitude = location?.longitude;
              if (latitude != null && longitude != null) {
                LocationHelper.openDirections(context,
                    endLat: latitude, endLng: longitude);
              }
            },
            child: Row(
              children: [
                SvgPicture.asset(
                  SvgImageConstant.location,
                  color: AppColors.black,
                ),
                Gap(getSize(5)),
                Flexible(
                  child: BaseText(
                    text: shift.location?.location ?? "",
                    fontSize: 10,
                    maxLines: 1,
                  ),
                )
              ],
            ),
          ),
          commonDivider(),
          ListTile(
            dense: true,
            contentPadding: EdgeInsets.zero,
            horizontalTitleGap: getSize(10),
            minVerticalPadding: 0,
            titleAlignment: ListTileTitleAlignment.titleHeight,
            minTileHeight: 0,
            leading: UserAvatar(
              size: getSize(35),
              url: shift.profile ?? "",
            ),
            title: BaseText(
              text: "${shift.first_name ?? ""} ${shift.last_name ?? ""}",
              fontWeight: FontWeight.w600,
              fontSize: 12,
              maxLines: 1,
            ),
            subtitle: BaseText(
              text: (shift.shift_type == "1")
                  ? StringConstant.singleShift
                  : StringConstant.multiShift,
              fontSize: 10,
              textColor: AppColors.primaryColor,
            ),
          ),
        ],
      ),
    );
  }
}
