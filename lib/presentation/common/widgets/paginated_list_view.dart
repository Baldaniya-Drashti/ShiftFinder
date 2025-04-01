// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:shift/domain/core/math_utils.dart';
import 'package:shift/presentation/common/widgets/base_text.dart';
import 'package:shift/presentation/core/style/app_colors.dart';

class PaginatedListView extends StatelessWidget {
  final Widget child;
  final bool isNoDataFound;
  final Widget? noDataWidget;
  final bool? enablePullUp;
  final bool? enablePullDown;
  final String? dataStatus;
  final VoidCallback onRefresh;
  final VoidCallback onLoading;
  final RefreshController refreshController;
  final bool reverse;
  final Axis? scrollDirection;
  final Widget? footer;
  const PaginatedListView({
    super.key,
    required this.onRefresh,
    required this.onLoading,
    required this.child,
    required this.refreshController,
    this.isNoDataFound = false,
    this.dataStatus,
    this.reverse = false,
    this.scrollDirection,
    this.enablePullUp,
    this.enablePullDown,
    this.noDataWidget,
    this.footer,
  });

  @override
  Widget build(BuildContext context) {
    return ScrollbarTheme(
      data: ScrollbarThemeData(
        thumbColor: WidgetStateProperty.all(
            AppColors.primaryColor.withValues(alpha: 0.5)),
        thickness: WidgetStateProperty.all(getSize(3)),
        radius: Radius.circular(getSize(10)),
      ),
      child: Scrollbar(
        // thumbVisibility: true,
        child: SmartRefresher(
          header: MaterialClassicHeader(
            color: AppColors.primaryColor,
          ),
          footer: footer ??
              CustomFooter(
                builder: (context, loadStatus) {
                  return SizedBox();
                },
              ),
          enablePullUp: enablePullUp ?? true,
          enablePullDown: enablePullDown ?? true,
          reverse: reverse,
          scrollDirection: scrollDirection,
          controller: refreshController,
          physics: BouncingScrollPhysics(),
          onRefresh: () {
            onRefreshData();
          },
          onLoading: () {
            onLoadMoreData();
          },
          child: isNoDataFound
              ? noDataWidget ??
                  Center(
                    child: SizedBox(
                      width: getSize(280),
                      child: BaseText(
                        textColor: AppColors.black.withValues(alpha: 0.65),
                        text: dataStatus ?? 'No result found.',
                        textAlign: TextAlign.center,
                        lineHeight: 1.2,
                      ),
                    ),
                  )
              : child,
        ),
      ),
    );
  }

  onRefreshData() {
    onRefresh();
    refreshController.refreshCompleted();
  }

  onLoadMoreData() {
    onLoading();
    refreshController.loadComplete();
  }
}
