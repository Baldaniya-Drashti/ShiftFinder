import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:shift/application/contractor/contractor_rating/contractor_rating_bloc.dart';
import 'package:shift/domain/core/math_utils.dart';
import 'package:shift/domain/core/string_constant.dart';
import 'package:shift/injection.dart';
import 'package:shift/presentation/common/widgets/base_text.dart';
import 'package:shift/presentation/common/widgets/center_loading_indicator.dart';
import 'package:shift/presentation/common/widgets/paginated_list_view.dart';
import 'package:shift/presentation/core/style/app_colors.dart';
import 'package:shift/presentation/core/widgets/avatar.dart';
import 'package:shift/presentation/employer/profile/previous_shift_view/previous_shift_all_view.dart';
import 'package:shift/presentation/main/widgets/home_app_bar.dart';

@RoutePage(name: "ContractorRatingView")
class ContractorRatingView extends StatelessWidget {
  const ContractorRatingView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<ContractorRatingBloc>()
        ..add(ContractorRatingEvent.getRatingList(
            context: context, refresh: true)),
      child: Scaffold(
        appBar: CommonAppBar(
            onBackPressed: () => context.router.maybePop(), title: "Ratings"),
        body: BlocBuilder<ContractorRatingBloc, ContractorRatingState>(
          builder: (context, state) {
            return PaginatedListView(
              isNoDataFound: state.noDataFound,
              onRefresh: () {
                context.read<ContractorRatingBloc>().add(
                      ContractorRatingEvent.getRatingList(
                          refresh: true, context: context),
                    );
              },
              onLoading: () {
                context.read<ContractorRatingBloc>().add(
                      ContractorRatingEvent.getRatingList(
                          refresh: false, context: context),
                    );
              },
              refreshController:
                  context.read<ContractorRatingBloc>().refreshController,
              child: state.loading
                  ? CenterLoadingIndicator()
                  : state.error
                      ? Center(
                          child:
                              BaseText(text: StringConstant.somethindWentWrong),
                        )
                      : SingleChildScrollView(
                          padding: EdgeInsets.symmetric(
                              vertical: getSize(10), horizontal: getSize(20)),
                          child: Column(
                            children: [
                              BaseText(
                                text: StringConstant.contractorratingDesc,
                                fontWeight: FontWeight.w600,
                                fontSize: 10,
                              ),
                              SizedBox(height: getSize(20)),
                              ListView.separated(
                                physics: NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemBuilder: (context, index) => Material(
                                  borderRadius: BorderRadius.circular(10),
                                  color: AppColors.white,
                                  child: Padding(
                                    padding: EdgeInsets.all(getSize(10)),
                                    child: ListTile(
                                      visualDensity: VisualDensity.compact,
                                      leading: UserAvatar(
                                        url: state.ratingList[index].profile ??
                                            "",
                                      ),
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      tileColor: AppColors.scaffoldColor,
                                      title: BaseText(
                                        text:
                                            "${state.ratingList[index].first_name ?? ""} ${state.ratingList[index].last_name ?? ""}",
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                      ),
                                      subtitle: BaseText(
                                        text: state.ratingList[index]
                                                .company_name ??
                                            "",
                                        fontSize: 12,
                                        fontWeight: FontWeight.w400,
                                      ),
                                      trailing: RatingStar(
                                          rating: (state.ratingList[index]
                                                      .post_rating !=
                                                  null)
                                              ? state.ratingList[index]
                                                  .post_rating!
                                                  .toDouble()
                                              : 0),
                                    ),
                                  ),
                                ),
                                separatorBuilder: (context, index) =>
                                    Gap(getSize(14)),
                                itemCount: state.ratingList.length,
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
}
