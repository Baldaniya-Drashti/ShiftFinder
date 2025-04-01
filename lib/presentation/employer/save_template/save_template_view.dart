// ignore_for_file: deprecated_member_use

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:shift/application/employer/add_full_position/add_full_position_bloc.dart';
import 'package:shift/application/employer/save_template/save_template_bloc.dart';
import 'package:shift/domain/core/math_utils.dart';
import 'package:shift/domain/core/png_image_constants.dart';
import 'package:shift/domain/core/string_constant.dart';
import 'package:shift/domain/core/svg_image_constants.dart';
import 'package:shift/injection.dart';
import 'package:shift/presentation/common/widgets/base_text.dart';
import 'package:shift/presentation/common/widgets/center_loading_indicator.dart';
import 'package:shift/presentation/common/widgets/paginated_list_view.dart';
import 'package:shift/presentation/core/app_router.gr.dart';
import 'package:shift/presentation/core/style/app_colors.dart';
import 'package:shift/presentation/core/widgets/drop_down_field.dart';
import 'package:shift/presentation/core/widgets/inputs/custom_search_field.dart';
import 'package:shift/presentation/main/widgets/home_app_bar.dart';

@RoutePage(name: "SaveTemplateView")
class SaveTemplateView extends StatefulWidget {
  const SaveTemplateView({super.key});

  @override
  State<SaveTemplateView> createState() => _SaveTemplateViewState();
}

class _SaveTemplateViewState extends State<SaveTemplateView> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<SaveTemplateBloc>()
        ..add(SaveTemplateEvent.getSavedTemplateList(context, refresh: true)),
      child: Scaffold(
        appBar: CommonAppBar(
          onBackPressed: () => context.router.maybePop(),
          title: StringConstant.savedTemplates,
        ),
        body: BlocBuilder<SaveTemplateBloc, SaveTemplateState>(
          builder: (context, state) {
            return Stack(
              children: [
                Padding(
                  padding: EdgeInsets.all(getSize(16)),
                  child: NestedScrollView(
                    headerSliverBuilder: (context, innerBoxIsScrolled) {
                      return [
                        SliverToBoxAdapter(
                            child: Container(
                          decoration: BoxDecoration(
                            color: Color(0xFFEDEDED),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          padding: EdgeInsets.all(getSize(12))
                              .copyWith(left: getSize(16), right: getSize(16)),
                          child: Row(
                            children: [
                              SvgPicture.asset(
                                SvgImageConstant.saveTemplate2,
                                height: getSize(45),
                                width: getSize(45),
                                colorFilter: ColorFilter.mode(
                                    AppColors.green, BlendMode.srcIn),
                              ),
                              Gap(getSize(12)),
                              Image.asset(
                                PngImageConstants.line,
                                height: getSize(80),
                              ),
                              Gap(getSize(16)),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    BaseText(
                                      text: StringConstant.templates,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                    ),
                                    Gap(getSize(2)),
                                    BaseText(
                                      text: StringConstant.saveTemplatesDesc,
                                      maxLines: 3,
                                      overflow: TextOverflow.ellipsis,
                                      fontSize: 11,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ],
                                ),
                              ),
                              Gap(getSize(12)),
                            ],
                          ),
                        )),
                        SliverGap(16),
                        SliverToBoxAdapter(
                          child: DebouncingTextField(
                            onSearch: (query) {
                              context.read<SaveTemplateBloc>().add(
                                  SaveTemplateEvent.onSearchJobRole(context,
                                      query: query));
                            },
                          ),
                        ),
                        SliverGap(20),
                        SliverToBoxAdapter(
                          child: BlocSelector<SaveTemplateBloc,
                              SaveTemplateState, CommonDropdownModel?>(
                            selector: (state) => state.selectedFilterType,
                            builder: (context, state) {
                              return CustomDropdownField<CommonDropdownModel>(
                                label: StringConstant.filter,
                                hintText: StringConstant.filter,
                                value: state,
                                radius: 10,
                                hintTextStyle: TextStyle(
                                  fontSize: getFontSize(15),
                                  fontWeight: FontWeight.w400,
                                  color: AppColors.black.withValues(alpha: 0.5),
                                ),
                                items: [
                                  CommonDropdownModel(
                                      id: 1, label: StringConstant.single),
                                  CommonDropdownModel(
                                      id: 2, label: StringConstant.multi),
                                  CommonDropdownModel(
                                      id: 3, label: StringConstant.longTerm),
                                  CommonDropdownModel(
                                      id: 4, label: StringConstant.fullTime),
                                ].map(
                                  (e) {
                                    return DropdownMenuItem<
                                        CommonDropdownModel>(
                                      value: e,
                                      child: BaseText(
                                        text: e.label,
                                        fontSize: 14,
                                        maxLines: 1,
                                      ),
                                    );
                                  },
                                ).toList(),
                                onChanged: (value) {
                                  if (value != null) {
                                    context.read<SaveTemplateBloc>().add(
                                          SaveTemplateEvent.onFilterChanged(
                                            context,
                                            value as CommonDropdownModel,
                                          ),
                                        );
                                  }
                                },
                              );
                            },
                          ),
                        ),
                        if (state.selectedFilterType?.id == 2) ...[
                          SliverGap(20),
                          SliverToBoxAdapter(
                            child: Material(
                              borderRadius: BorderRadius.circular(10),
                              color: AppColors.surfaceColor,
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                    vertical: getSize(16),
                                    horizontal: getSize(22)),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    _buildRadioOptions(
                                      context,
                                      onChanged: (value) {
                                        context.read<SaveTemplateBloc>().add(
                                            SaveTemplateEvent
                                                .onSelectMultiShift(context,
                                                    type: value));
                                      },
                                      label: StringConstant.sameTimeForAllDates,
                                      groupValue: state.selectedMultiShift,
                                      value: 1,
                                    ),
                                    Divider(),
                                    _buildRadioOptions(
                                      context,
                                      onChanged: (value) {
                                        context.read<SaveTemplateBloc>().add(
                                            SaveTemplateEvent
                                                .onSelectMultiShift(context,
                                                    type: value));
                                      },
                                      label: StringConstant
                                          .differentTimeForEachDate,
                                      groupValue: state.selectedMultiShift,
                                      value: 2,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                        SliverGap(20),
                      ];
                    },
                    body: PaginatedListView(
                      onRefresh: () {
                        context.read<SaveTemplateBloc>().add(
                            SaveTemplateEvent.getSavedTemplateList(context,
                                refresh: true));
                      },
                      onLoading: () {
                        context.read<SaveTemplateBloc>().add(
                            SaveTemplateEvent.getSavedTemplateList(context,
                                refresh: false));
                      },
                      refreshController:
                          context.read<SaveTemplateBloc>().refreshController,
                      isNoDataFound: state.noDataFound,
                      child: state.loading
                          ? CenterLoadingIndicator(isOnlyLoader: true)
                          : state.error
                              ? Center(
                                  child: BaseText(
                                      text: StringConstant.somethindWentWrong))
                              : ListView.separated(
                                  physics: NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  itemBuilder: (context, index) {
                                    final data = state.savedTemplateList[index];
                                    return Container(
                                      decoration: BoxDecoration(
                                        color: Color(0xFFEDEDED),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      padding: EdgeInsets.all(getSize(12))
                                          .copyWith(
                                              left: getSize(16),
                                              right: getSize(16)),
                                      child: InkWell(
                                        onTap: () {
                                          print(
                                              "state.selectedFilterType?.id---> ${state.selectedFilterType?.id}");
                                          if (state.selectedFilterType?.id ==
                                              3) {
                                            context.router.push(
                                              PageRouteInfo(
                                                EmployerLongTermPositionAddView
                                                    .name,
                                                args:
                                                    EmployerLongTermPositionAddViewArgs(
                                                  postId: data.id,
                                                  isCreate: false,
                                                  fromTemplate: true,
                                                ),
                                              ),
                                            );
                                          } else if (state
                                                  .selectedFilterType?.id ==
                                              4) {
                                            context.router.push(
                                              PageRouteInfo(
                                                EmployerFullPositionAddView
                                                    .name,
                                                args:
                                                    EmployerFullPositionAddViewArgs(
                                                  postId: data.id ?? -1,
                                                  isCreate: false,
                                                  fromTemplate: true,
                                                ),
                                              ),
                                            );
                                          } else {
                                            context.router.push(
                                              PageRouteInfo(
                                                HealthCarePostForm.name,
                                                args: HealthCarePostFormArgs(
                                                  postId: data.id ?? -1,
                                                  fromSaveTemplate: true,
                                                  isCreate: false,
                                                ),
                                              ),
                                            );
                                          }
                                        },
                                        child: Row(
                                          children: [
                                            Image.asset(
                                              PngImageConstants.nurse2,
                                              height: 45,
                                              width: 45,
                                              color: AppColors.green,
                                            ),
                                            Gap(getSize(12)),
                                            Image.asset(
                                              PngImageConstants.line,
                                              height: getSize(80),
                                            ),
                                            Gap(getSize(16)),
                                            Expanded(
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  BaseText(
                                                    text: (data.post_type == 2)
                                                        ? (data.job_type == 1)
                                                            ? StringConstant
                                                                .fullTime
                                                            : StringConstant
                                                                .partTime
                                                        : (data.post_type == 1)
                                                            ? data.roles_list_name ??
                                                                ""
                                                            : data.roles ?? "",
                                                    maxLines: 1,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                  Gap(getSize(2)),
                                                  BaseText(
                                                    text: data.location
                                                            ?.location ??
                                                        "",
                                                    maxLines: 1,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    fontSize: 11,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                  Gap(getSize(4)),
                                                  BaseText(
                                                    text: (state.selectedFilterType
                                                                    ?.id ==
                                                                3 &&
                                                            data.post_type == 1)
                                                        ? StringConstant
                                                            .longTerm
                                                        : (state.selectedFilterType
                                                                        ?.id ==
                                                                    2 &&
                                                                data.shift == 2)
                                                            ? StringConstant
                                                                .multiShift
                                                            : (state.selectedFilterType
                                                                            ?.id ==
                                                                        1 &&
                                                                    data.shift ==
                                                                        1)
                                                                ? StringConstant
                                                                    .singleShift
                                                                : "",
                                                    maxLines: 1,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    fontSize: 10,
                                                    fontWeight: FontWeight.w600,
                                                    textColor: AppColors.green,
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Gap(getSize(16)),
                                            GestureDetector(
                                              onTap: () {
                                                context
                                                    .read<SaveTemplateBloc>()
                                                    .add(SaveTemplateEvent
                                                        .onDeleteCodeSavedTemplate(
                                                      id: data.id ?? -1,
                                                      shiftType: (data.post_type ==
                                                                  1 ||
                                                              data.post_type ==
                                                                  2)
                                                          ? 2
                                                          : 1,
                                                      context: context,
                                                    ));
                                              },
                                              child: SvgPicture.asset(
                                                  SvgImageConstant.bin),
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                  separatorBuilder: (context, index) =>
                                      Gap(getSize(16)),
                                  itemCount: state.savedTemplateList.length,
                                ),
                    ),
                  ),
                ),
                if (state.postDataLoading) CenterLoadingIndicator()
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildRadioOptions(
    BuildContext context, {
    required void Function(int value) onChanged,
    required String label,
    required int groupValue,
    required int value,
  }) {
    return GestureDetector(
      onTap: () {
        onChanged(value);
      },
      child: Row(
        children: [
          Radio(
            fillColor: WidgetStateProperty.resolveWith(
              (states) {
                if (states.contains(WidgetState.selected)) {
                  return AppColors.green;
                }
                return Colors.grey;
              },
            ),
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            visualDensity: VisualDensity.compact,
            value: value,
            groupValue: groupValue,
            onChanged: (value) {
              if (value == null) return;
              onChanged(value);
            },
          ),
          Gap(getSize(8)),
          Expanded(
              child: BaseText(
                  text: label, fontSize: 13, fontWeight: FontWeight.w500)),
        ],
      ),
    );
  }
}
