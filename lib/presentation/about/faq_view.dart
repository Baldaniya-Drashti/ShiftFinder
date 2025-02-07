import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shift/application/faq/faq_bloc.dart';
import 'package:shift/domain/core/math_utils.dart';
import 'package:shift/domain/core/string_constant.dart';
import 'package:shift/domain/core/svg_image_constants.dart';
import 'package:shift/injection.dart';
import 'package:shift/presentation/common/utils/get_cookie.dart';
import 'package:shift/presentation/common/widgets/base_text.dart';
import 'package:shift/presentation/common/widgets/center_loading_indicator.dart';
import 'package:shift/presentation/common/widgets/paginated_list_view.dart';
import 'package:shift/presentation/core/style/app_colors.dart';
import 'package:shift/presentation/main/widgets/home_app_bar.dart';

@RoutePage(name: "FaqView")
class FaqView extends StatelessWidget {
  const FaqView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          getIt<FaqBloc>()..add(FaqEvent.getFaqList(context, refresh: true)),
      child: BlocBuilder<FaqBloc, FaqState>(
        builder: (context, state) {
          return Scaffold(
            appBar: CommonAppBar(
              onBackPressed: () => context.router.maybePop(),
              title: StringConstant.faqs,
            ),
            body: SizedBox(
              height: MediaQuery.of(context).size.height * 0.9,
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: getSize(10)),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      userDescUI(),

                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.7,
                        child: state.getDataLoading
                            ? CenterLoadingIndicator(isOnlyLoader: true)
                            : state.errorApi
                                ? Center(
                                    child: BaseText(
                                        text:
                                            StringConstant.somethindWentWrong))
                                : PaginatedListView(
                                    onRefresh: () => context
                                        .read<FaqBloc>()
                                        .add(FaqEvent.getFaqList(context,
                                            refresh: true)),
                                    onLoading: () => context
                                        .read<FaqBloc>()
                                        .add(FaqEvent.getFaqList(context,
                                            refresh: false)),
                                    refreshController: context
                                        .read<FaqBloc>()
                                        .refreshController,
                                    isNoDataFound: state.noDataFound,
                                    child: buildWithTrailingAnimationDisabled(
                                        state),
                                  ),
                      ),

                      // buildWithTrailingAnimationDisabled(state),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget userDescUI() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: getSize(10)),
      padding: EdgeInsets.symmetric(
          vertical: getSize(20), horizontal: getSize(36.025)),
      decoration: BoxDecoration(
          color: AppColors.grey04, borderRadius: BorderRadius.circular(10)),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          SvgPicture.asset(
            SvgImageConstant.faq,
            height: getSize(63),
            width: getSize(57.95),
          ),
          SizedBox(width: getSize(15)),
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                BaseText(
                  text:
                      "Hello,✋ ${getCurrentUser().firstName} ${getCurrentUser().lastName}",
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  lineHeight: 2,
                ),
                BaseText(
                  text: StringConstant.employerFAQDesc,
                  fontSize: 10,
                  fontWeight: FontWeight.w400,
                  maxLines: 3,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  /* Widget expansionList(BuildContext context, FaqState state) {
    return ExpansionPanelList(
      elevation: 0,
      expansionCallback: (int index, bool isExpanded) {
        context.read<FaqBloc>().add(FaqEvent.toggleExpansionEvent(index));
      },
      children: items.asMap().entries.map((entry) {
        final index = entry.key;
        final item = entry.value;

        final isExpanded = index < state.expandedStates.length
            ? state.expandedStates[index]
            : false;

        return ExpansionPanel(
          canTapOnHeader: true,
          backgroundColor: AppColors.primaryColor.withOpacity(0.1),
          headerBuilder: (context, isExpanded) {
            return ListTile(
              title: Text(
                item.header,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            );
          },
          body: Container(
            color: AppColors.white,
            child: Container(
              margin: EdgeInsets.all(getSize(10)),
              decoration: BoxDecoration(
                  color: AppColors.surfaceColor,
                  borderRadius: BorderRadius.circular(10)),
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Text(
                  item.body,
                  style: TextStyle(color: Colors.black54),
                ),
              ),
            ),
          ),
          isExpanded: isExpanded,
        );
      }).toList(),
    );
  } */

  /* static Widget buildWithTrailingAnimationDisabled(FaqState state) {
    return ExpansionTileList(
      tileGapSize: getSize(10),
      enableTrailingAnimation: false,
      tileBuilder: (context, value, child) {
        return Container(
          decoration: BoxDecoration(
              color: AppColors.white, borderRadius: BorderRadius.circular(10)),
          padding: EdgeInsets.all(getSize(10)),
          child: child,
        );
      },
      children: state.faqList.asMap().entries.map((entry) {
        final item = entry.value;
        return ExpansionTile(
            collapsedBackgroundColor: AppColors.surfaceColor,
            collapsedShape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            backgroundColor: AppColors.primaryColor.withOpacity(0.1),
            title: ListTile(
              title: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  BaseText(
                    text: "${entry.key + 1}.",
                    fontSize: 12,
                  ),
                  SizedBox(width: getSize(10)),
                  Expanded(
                    child: BaseText(
                      text: item.question ?? "",
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
            children: [
              Container(
                margin: EdgeInsets.all(getSize(10)),
                decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.circular(10)),
                child: Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      BaseText(
                        text: "•",
                        fontSize: 12,
                      ),
                      SizedBox(width: getSize(10)),
                      Expanded(
                        child: BaseText(
                          text: item.answer ?? "",
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ]
            // isExpanded: isExpanded,
            );
      }).toList(),
    );
  } */

  static Widget buildWithTrailingAnimationDisabled(FaqState state) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: state.faqList.asMap().entries.map((entry) {
        final item = entry.value;
        return Container(
          decoration: BoxDecoration(
              color: AppColors.white, borderRadius: BorderRadius.circular(10)),
          margin: EdgeInsets.symmetric(
                  vertical: getSize(5), horizontal: getSize(10))
              .copyWith(
            top: getSize((entry.key == 0) ? 30 : 0),
          ),
          padding: EdgeInsets.all(getSize(10)),
          child: ExpansionTile(
              collapsedBackgroundColor: AppColors.surfaceColor,
              collapsedShape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              backgroundColor: AppColors.primaryColor.withOpacity(0.1),
              title: ListTile(
                title: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    BaseText(
                      text: "${entry.key + 1}.",
                      fontSize: 12,
                    ),
                    SizedBox(width: getSize(10)),
                    Expanded(
                      child: BaseText(
                        text: item.question ?? "",
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
              children: [
                Container(
                  margin: EdgeInsets.all(getSize(10)),
                  decoration: BoxDecoration(
                      color: AppColors.white,
                      borderRadius: BorderRadius.circular(10)),
                  child: Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        BaseText(
                          text: "•",
                          fontSize: 12,
                        ),
                        SizedBox(width: getSize(10)),
                        Expanded(
                          child: BaseText(
                            text: item.answer ?? "",
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ]
              // isExpanded: isExpanded,
              ),
        );
      }).toList(),
    );
  }
}
