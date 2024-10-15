import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:shift/application/main_tab/shifts/shifts_bloc_bloc.dart';
import 'package:shift/domain/core/math_utils.dart';
import 'package:shift/domain/core/png_image_constants.dart';
import 'package:shift/domain/core/string_constant.dart';
import 'package:shift/domain/core/svg_image_constants.dart';
import 'package:shift/presentation/common/widgets/base_text.dart';
import 'package:shift/presentation/common/widgets/center_loading_indicator.dart';
import 'package:shift/presentation/common/widgets/paginated_list_view.dart';
import 'package:shift/presentation/core/app_router.gr.dart';
import 'package:shift/presentation/core/common_lisitng/common_listing.dart';
import 'package:shift/presentation/core/logger/logger.dart';
import 'package:shift/presentation/core/style/app_colors.dart';
import 'package:shift/presentation/core/widgets/dropdown/custom_dropdown_textfield.dart';
import 'package:shift/presentation/employer/profile/previous_shift_view/previous_shift_all_view.dart';
import 'package:shift/presentation/main/tabs/shifts/filled_shifts/widgets/delete_shift_dialog.dart';
import 'package:shift/presentation/main/tabs/shifts/filled_shifts/widgets/filled_shift_list.dart';

@RoutePage(name: 'FilledShiftsView')
class FilledShiftsView extends StatelessWidget {
  const FilledShiftsView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ShiftsBloc, ShiftsBlocState>(
      builder: (context, state) {
        Log.debug("${state.filledShiftList}");
        return state.getDataLoading
            ? CenterLoadingIndicator()
            : state.errorApi
                ? Center(
                    child: BaseText(text: StringConstant.somethindWentWrong),
                  )
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: getSize(15),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: getSize(20)),
                        child: BaseText(
                          text: 'Sort by',
                          fontSize: 10,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(
                        height: getSize(8),
                      ),
                      locationAddressTextField(context, state),
                      SizedBox(
                        height: getSize(12),
                      ),
                      Expanded(
                        child: PaginatedListView(
                          onRefresh: () => ShiftsBlocEvent.fetchFilledShiftList(refresh: true),
                          onLoading: () => ShiftsBlocEvent.fetchFilledShiftList(refresh: false),
                          refreshController: context.read<ShiftsBloc>().filledRefreshController,
                          isNoDataFound: state.noDataFound,
                          child: ListView.separated(
                            separatorBuilder: (context, index) => Gap(16),
                            itemCount: state.filledShiftList.length,
                            shrinkWrap: true,
                            padding: EdgeInsets.symmetric(horizontal: getSize(10), vertical: getSize(12.5)),
                            physics: BouncingScrollPhysics(),
                            itemBuilder: (context, index) {
                              final industry =
                                  CommonList.industryList.firstWhere((element) => element.id == state.filledShiftList[index].industry);

                              return Container(
                                padding: EdgeInsets.all(getSize(10)),
                                decoration: BoxDecoration(
                                  color: AppColors.white,
                                  borderRadius: BorderRadius.circular(getSize(20)),
                                  boxShadow: [
                                    BoxShadow(
                                      color: AppColors.black.withOpacity(0.15),
                                      blurRadius: 24,
                                      offset: Offset(0, 0),
                                    ),
                                  ],
                                ),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Container(
                                      padding: EdgeInsets.all(getSize(12)),
                                      decoration: BoxDecoration(
                                        color: AppColors.scaffoldColor,
                                        borderRadius: BorderRadius.circular(getSize(10)),
                                      ),
                                      child: Column(
                                        children: [
                                          Row(
                                            children: [
                                              CircleAvatar(
                                                radius: getSize(30),
                                                backgroundColor: Colors.transparent,
                                                child: Image.asset(PngImageConstants.nurse2),

                                              ),
                                              SizedBox(width: getSize(15)),
                                              Expanded(
                                                child: Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    Row(
                                                      children: [
                                                        BaseText(
                                                          text: state.filledShiftList[index].roles_list_name ?? "",
                                                          fontSize: 16,
                                                          fontWeight: FontWeight.w600,
                                                        ),
                                                        Spacer(),
                                                        GestureDetector(
                                                          onTap: () {
                                                            DeleteShiftDialog().deleteShiftDialog(context);
                                                          },
                                                          child: Container(
                                                            alignment: Alignment.center,
                                                            height: getSize(28),
                                                            decoration: BoxDecoration(
                                                              color: AppColors.white,
                                                              borderRadius: BorderRadius.circular(getSize(5)),
                                                            ),
                                                            width: getSize(28),
                                                            child: SvgPicture.asset(
                                                              height: 16,
                                                              SvgImageConstant.delete,
                                                              colorFilter: ColorFilter.mode(AppColors.black, BlendMode.srcATop),
                                                            ),
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                    SizedBox(height: getSize(3)),
                                                    BaseText(
                                                      text: '(${industry.title ?? ""} - ${state.filledShiftList[index].listing_id ?? ""})',
                                                      fontSize: 12,
                                                      textColor: const Color.fromARGB(255, 55, 46, 46).withOpacity(0.8),
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(height: getSize(10)),
                                          Divider(
                                            height: 0,
                                            color: AppColors.black.withOpacity(0.2),
                                            thickness: 0.5,
                                          ),
                                          SizedBox(height: getSize(10)),
                                          Row(
                                            children: [
                                              SvgPicture.asset(
                                                SvgImageConstant.location,
                                                colorFilter: ColorFilter.mode(
                                                  AppColors.black,
                                                  BlendMode.srcATop,
                                                ),
                                              ),
                                              SizedBox(width: getSize(5)),
                                              BaseText(
                                                text: '${state.filledShiftList[index].location?.location ?? ""}',
                                                fontSize: 10,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(height: getSize(10)),
                                    Row(
                                      //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        SvgPicture.asset(
                                          SvgImageConstant.calendar,
                                          height: getSize(15),
                                          width: getSize(15),
                                          colorFilter: ColorFilter.mode(
                                            Colors.black,
                                            BlendMode.srcATop,
                                          ),
                                        ),
                                        SizedBox(width: getSize(7)),
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            BaseText(
                                              text: 'Shift Date',
                                              fontSize: 8,
                                              fontWeight: FontWeight.w400,
                                            ),
                                            SizedBox(height: getSize(5)),
                                            Text.rich(
                                              style: TextStyle(fontSize: 12),
                                              TextSpan(
                                                text: "${convertUnixTimeToLocalString(state.filledShiftList[index].start_date ?? 0)}, ",
                                                style: TextStyle(fontWeight: FontWeight.w500),
                                                children: [
                                                  TextSpan(
                                                      text:
                                                          "${DateTime.fromMillisecondsSinceEpoch(state.filledShiftList[index].start_date ?? 0).year}",
                                                      style: TextStyle(color: AppColors.black.withOpacity(0.5))),
                                                ],
                                              ),
                                            )
                                          ],
                                        ),
                                        Spacer(),
                                        SvgPicture.asset(
                                          SvgImageConstant.infoCircle,
                                          height: getSize(15),
                                          width: getSize(15),
                                          colorFilter: ColorFilter.mode(
                                            Colors.black,
                                            BlendMode.srcATop,
                                          ),
                                        ),
                                        SizedBox(width: getSize(7)),
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            BaseText(
                                              text: 'Time',
                                              fontSize: 8,
                                              fontWeight: FontWeight.w400,
                                            ),
                                            SizedBox(height: getSize(5)),
                                            BaseText(
                                              text:
                                                  '${formatUnixTimestamp(state.filledShiftList[index].start_time ?? 0)} to ${formatUnixTimestamp(state.filledShiftList[index].end_time ?? 0)}',
                                              fontSize: 10,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: getSize(15)),
                                    Row(
                                      //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        SvgPicture.asset(
                                          SvgImageConstant.calendar,
                                          height: getSize(15),
                                          width: getSize(15),
                                          colorFilter: ColorFilter.mode(
                                            Colors.black,
                                            BlendMode.srcATop,
                                          ),
                                        ),
                                        SizedBox(width: getSize(7)),
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            BaseText(
                                              text: 'Estimated Payables',
                                              fontSize: 8,
                                              fontWeight: FontWeight.w400,
                                            ),
                                            SizedBox(height: getSize(5)),
                                            BaseText(
                                              text: '\$${state.filledShiftList[index].estimated_payables ?? ""}',
                                              fontSize: 10,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ],
                                        ),
                                        Spacer(),
                                        Expanded(
                                          child: GestureDetector(
                                            onTap: () {
                                              context.router.push(
                                                PageRouteInfo(
                                                  ViewHomeShiftDetails.name,
                                                  args: ViewHomeShiftDetailsArgs(postId: 485),
                                                ),
                                              );
                                            },
                                            child: Container(
                                              padding: EdgeInsets.symmetric(
                                                vertical: getSize(8),
                                                // horizontal: getSize(20),
                                              ),
                                              alignment: Alignment.center,
                                              decoration: BoxDecoration(
                                                color: AppColors.scaffoldColor,
                                                borderRadius: BorderRadius.circular(getSize(7)),
                                              ),
                                              child: BaseText(
                                                text: 'View shift Details',
                                                fontSize: 10,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: getSize(10)),
                                    Container(
                                      padding: EdgeInsets.symmetric(
                                        vertical: getSize(10),
                                        horizontal: getSize(15),
                                      ),
                                      decoration: BoxDecoration(
                                        color: AppColors.scaffoldColor,
                                        borderRadius: BorderRadius.circular(getSize(10)),
                                      ),
                                      child: InkWell(
                                        onTap: () {
                                          final userId=state.filledShiftList[index].user?.userId??-1;
                                          Log.debug("${state.filledShiftList[index]}");
                                          context.router.push(
                                            PageRouteInfo(ViewApplicantProfile.name,args: ViewApplicantProfileArgs(id: userId, postId: 0)),
                                          );
                                        },
                                        child: Row(
                                          //ainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            CircleAvatar(
                                              radius: getSize(20),
                                              backgroundColor: AppColors.green,
                                              child: CircleAvatar(
                                                radius: getSize(19),
                                                backgroundImage: NetworkImage("${state.filledShiftList[index].user?.profileImage ?? ""}"),
                                              ),
                                            ),
                                            SizedBox(width: getSize(10)),
                                            BaseText(
                                              text:
                                                  '${state.filledShiftList[index].user?.firstName ?? ""} ${state.filledShiftList[index].user?.lastName ?? ""}',
                                              fontSize: 14,
                                              fontWeight: FontWeight.w500,
                                            ),
                                            SizedBox(width: getSize(5)),
                                            Icon(
                                              Icons.arrow_forward_ios_rounded,
                                              size: getSize(14),
                                            ),
                                            Spacer(),
                                            Container(
                                              padding: EdgeInsets.symmetric(
                                                vertical: getSize(8),
                                                horizontal: getSize(16),
                                              ),
                                              alignment: Alignment.center,
                                              decoration: BoxDecoration(
                                                color: AppColors.green.withOpacity(0.15),
                                                borderRadius: BorderRadius.circular(getSize(8)),
                                              ),
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                children: [
                                                  SvgPicture.asset(
                                                    SvgImageConstant.chat,
                                                    height: getSize(14),
                                                    width: getSize(14),
                                                    colorFilter: ColorFilter.mode(
                                                      Colors.black,
                                                      BlendMode.srcATop,
                                                    ),
                                                  ),
                                                  SizedBox(width: getSize(3)),
                                                  BaseText(
                                                    text: 'Chat',
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                ],
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        ),
                      )
                    ],
                  );
      },
    );
  }

  Widget locationAddressTextField(
    BuildContext context,
    ShiftsBlocState state,
  ) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: getSize(20)),
      child: CustomDropdownTextfield(
        valueController: state.singleValueDropDownController,
        list: state.locationList,
        hintText: 'Location',
        validator: (p0) {
          if (p0 == null || p0.isEmpty) {
            return 'Please select location';
          } else {
            return null;
          }
        },
        prefixIcon: Center(
          widthFactor: 1,
          child: SvgPicture.asset(
            SvgImageConstant.locationIcon,
            colorFilter: ColorFilter.mode(Colors.black, BlendMode.srcATop),
            height: 16,
            width: 16,
          ),
        ),
      ),
    );

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: getSize(20)),
      child: CustomDropdownTextfield(
        valueController: state.singleValueDropDownController,
        list: state.locationList,
        hintText: 'Location',
        validator: (p0) {
          if (p0 == null || p0.isEmpty) {
            return 'Please select location';
          } else {
            return null;
          }
        },
        prefixIcon: Center(
          widthFactor: 1,
          child: SvgPicture.asset(
            SvgImageConstant.locationIcon,
            colorFilter: ColorFilter.mode(Colors.black, BlendMode.srcATop),
            height: 16,
            width: 16,
          ),
        ),
      ),
    );
  }
}
