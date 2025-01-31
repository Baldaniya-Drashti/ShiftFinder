import 'dart:async';
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
import 'package:shift/presentation/core/widgets/inputs/custom_text_field.dart';
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
        ..add(SaveTemplateEvent.getSavedTemplateList(refresh: true)),
      child: Scaffold(
        appBar: CommonAppBar(
          onBackPressed: () => context.router.maybePop(),
          title: 'Saved Templates',
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
                          padding:
                              EdgeInsets.all(12).copyWith(left: 16, right: 16),
                          child: Row(
                            children: [
                              SvgPicture.asset(
                                SvgImageConstant.saveTemplate2,
                                height: 45,
                                width: 45,
                                colorFilter: ColorFilter.mode(
                                    AppColors.green, BlendMode.srcIn),
                              ),
                              Gap(12),
                              Image.asset(
                                PngImageConstants.line,
                                height: getSize(80),
                              ),
                              Gap(16),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    BaseText(
                                      text: "Templates",
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                    ),
                                    Gap(2),
                                    BaseText(
                                      text:
                                          "Search and customize your saved shif templates by job role and shift type for quick and easy posting",
                                      maxLines: 3,
                                      overflow: TextOverflow.ellipsis,
                                      fontSize: 11,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ],
                                ),
                              ),
                              Gap(12),
                            ],
                          ),
                        )),
                        SliverGap(16),
                        SliverToBoxAdapter(
                          child: DebouncingTextField(
                            onSearch: (query) {
                              context.read<SaveTemplateBloc>().add(
                                  SaveTemplateEvent.onSearchJobRole(
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
                                label: "Filter",
                                hintText: "Filter",
                                value: state,
                                radius: 10,
                                hintTextStyle: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w400,
                                  color: AppColors.black.withOpacity(0.5),
                                ),
                                items: [
                                  CommonDropdownModel(id: 1, label: "Single"),
                                  CommonDropdownModel(id: 2, label: "Multi"),
                                ].map(
                                  (e) {
                                    return DropdownMenuItem<
                                        CommonDropdownModel>(
                                      value: e,
                                      child: BaseText(
                                        text: e.label ?? "",
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
                                            value as CommonDropdownModel));
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
                                padding: const EdgeInsets.symmetric(
                                    vertical: 16, horizontal: 22),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    _buildRadioOptions(
                                      context,
                                      onChanged: (value) {
                                        context.read<SaveTemplateBloc>().add(
                                            SaveTemplateEvent
                                                .onSelectMultiShift(
                                                    type: value));
                                      },
                                      label: "Same Time For All Dates",
                                      groupValue: state.selectedMultiShift,
                                      value: 1,
                                    ),
                                    Divider(),
                                    _buildRadioOptions(
                                      context,
                                      onChanged: (value) {
                                        context.read<SaveTemplateBloc>().add(
                                            SaveTemplateEvent
                                                .onSelectMultiShift(
                                                    type: value));
                                      },
                                      label: "Different Time For Each Date",
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
                            SaveTemplateEvent.getSavedTemplateList(
                                refresh: true));
                      },
                      onLoading: () {
                        context.read<SaveTemplateBloc>().add(
                            SaveTemplateEvent.getSavedTemplateList(
                                refresh: false));
                      },
                      refreshController:
                          context.read<SaveTemplateBloc>().refreshController,
                      isNoDataFound: state.noDataFound,
                      child: state.loading
                          ? CenterLoadingIndicator(
                              isOnlyLoader: true,
                            )
                          : state.error
                              ? Center(
                                  child: BaseText(
                                      text: StringConstant.somethindWentWrong),
                                )
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
                                      padding: EdgeInsets.all(12)
                                          .copyWith(left: 16, right: 16),
                                      child: InkWell(
                                        onTap: () {
                                          context.router.push(
                                            PageRouteInfo(
                                              HealthCarePostForm.name,
                                              args: HealthCarePostFormArgs(
                                                  postId: data.id ?? -1,
                                                  fromSaveTemplate: true),
                                            ),
                                          );
                                        },
                                        child: Row(
                                          children: [
                                            Image.asset(
                                              PngImageConstants.nurse2,
                                              height: 45,
                                              width: 45,
                                              color: AppColors.green,
                                            ),
                                            Gap(12),
                                            Image.asset(
                                              PngImageConstants.line,
                                              height: getSize(80),
                                            ),
                                            Gap(16),
                                            Expanded(
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  BaseText(
                                                    text: data.roles ?? "",
                                                    maxLines: 1,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                  Gap(2),
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
                                                  Gap(4),
                                                  BaseText(
                                                    text: data.shift == 1
                                                        ? "Single Shift"
                                                        : "Multi Shift",
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
                                            Gap(16),
                                            GestureDetector(
                                              onTap: () {
                                                context
                                                    .read<SaveTemplateBloc>()
                                                    .add(
                                                      SaveTemplateEvent
                                                          .onDeleteCodeSavedTemplate(
                                                              id: data.id ?? -1,
                                                              context: context),
                                                    );
                                              },
                                              child: SvgPicture.asset(
                                                  SvgImageConstant.bin),
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                  separatorBuilder: (context, index) => Gap(16),
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
                if (states.contains(WidgetState.selected))
                  return AppColors.green;
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
          Gap(8),
          Expanded(
              child: BaseText(
                  text: label, fontSize: 13, fontWeight: FontWeight.w500)),
        ],
      ),
    );
  }
}

class DebouncingTextField extends StatefulWidget {
  const DebouncingTextField({
    super.key,
    this.delay = const Duration(milliseconds: 500),
    required this.onSearch,
  });

  final Duration delay;
  final Function(String query) onSearch;

  @override
  State<DebouncingTextField> createState() => _DebouncingTextFieldState();
}

class _DebouncingTextFieldState extends State<DebouncingTextField> {
  Timer? _debounce;

  @override
  void dispose() {
    _debounce?.cancel();
    super.dispose();
  }

  void _onSearchChanged(String query) {
    if (_debounce?.isActive ?? false) _debounce?.cancel();
    _debounce = Timer(widget.delay, () {
      FocusManager.instance.primaryFocus?.unfocus();
      widget.onSearch(query);
    });
  }

  @override
  Widget build(BuildContext context) {
    return CustomTextField(
      prefixIcon: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: getSize(14), vertical: getSize(14)),
        child: SvgPicture.asset(
          SvgImageConstant.search,
          height: getSize(24),
          width: getSize(24),
          color: AppColors.primaryColor,
        ),
      ),
      onChanged: _onSearchChanged,
      hintText: "Job Role",
      labelText: "Search by Job Role ",
    );
  }
}
