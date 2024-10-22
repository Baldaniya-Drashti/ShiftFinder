import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:shift/application/employer/employer_location/employer_location_bloc.dart';
import 'package:shift/domain/core/math_utils.dart';
import 'package:shift/domain/core/png_image_constants.dart';
import 'package:shift/domain/core/string_constant.dart';
import 'package:shift/domain/core/svg_image_constants.dart';
import 'package:shift/injection.dart';
import 'package:shift/presentation/common/widgets/base_text.dart';
import 'package:shift/presentation/common/widgets/center_loading_indicator.dart';
import 'package:shift/presentation/common/widgets/paginated_list_view.dart';
import 'package:shift/presentation/core/style/app_colors.dart';
import 'package:shift/presentation/core/widgets/buttons/common_button.dart';
import 'package:shift/presentation/main/widgets/home_app_bar.dart';

@RoutePage(name: 'EmployerLocationView')
class EmployerLocationView extends StatefulWidget {
  const EmployerLocationView({super.key});

  @override
  State<EmployerLocationView> createState() => _EmployerLocationViewState();
}

class _EmployerLocationViewState extends State<EmployerLocationView> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<EmployerLocationBloc>(),
      child: Scaffold(
        appBar: CommonAppBar(
          onBackPressed: () => context.router.maybePop(),
          title: 'Locations',
        ),
        body: BlocBuilder<EmployerLocationBloc, EmployerLocationState>(
          builder: (context, state) {
            return Stack(
              children: [
                PaginatedListView(
                  onRefresh: () {
                    //context.read<ViewSingleApplicantsBloc>().add(ViewSingleApplicantsEvent.getApplicantsList(postId, true));
                  },
                  onLoading: () {
                    //context.read<ViewSingleApplicantsBloc>().add(ViewSingleApplicantsEvent.getApplicantsList(postId, false));
                  },
                  refreshController: context.read<EmployerLocationBloc>().refreshController,
                  isNoDataFound: state.isNoDataFound,
                  /*child: state.isLoading
                      ? CenterLoadingIndicator()
                      : state.isErrorInAPI
                          ? Center(
                              child: BaseText(text: StringConstant.somethindWentWrong),
                            )
                          : Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                ListView.builder(
                                  itemCount: 4,
                                  shrinkWrap: true,
                                  physics: BouncingScrollPhysics(),
                                  padding: EdgeInsets.symmetric(
                                    horizontal: getSize(18),
                                    vertical: getSize(20),
                                  ),
                                  itemBuilder: (context, index) {
                                    return _LocationInfoTile();
                                  },
                                ),
                              ],
                            ),*/
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ListView.separated(
                        separatorBuilder: (context, index) => Gap(16),
                        itemCount: 4,
                        shrinkWrap: true,
                        physics: BouncingScrollPhysics(),
                        padding: EdgeInsets.symmetric(
                          horizontal: getSize(18),
                          vertical: getSize(20),
                        ),
                        itemBuilder: (context, index) {
                          return _LocationInfoTile();
                        },
                      ),
                      // CommonMaterialButton.icon(onPressed: onPressed, label: label, icon: icon)
                    ],
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
}

class _LocationInfoTile extends StatelessWidget {
  const _LocationInfoTile({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(

      decoration: BoxDecoration(
        color: Color(0xFFEDEDED),
        borderRadius: BorderRadius.circular(10),
      ),
      padding: EdgeInsets.all(12).copyWith(left: 16, right: 16),
      child: Row(
        children: [
          SvgPicture.asset(
            SvgImageConstant.location,
            height: 45,
            width: 45,
            colorFilter: ColorFilter.mode(AppColors.green, BlendMode.srcIn),
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
                  text: "1901 Thornridge sndjksbdjsbd",
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
                BaseText(
                  text: "Independent Living",
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
                BaseText(
                  text: "Independent Living",
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  fontSize: 10,
                  fontWeight: FontWeight.w400,
                ),
              ],
            ),
          ),
          Gap(12),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              GestureDetector(
                onTap: () {},
                child: SvgPicture.asset(SvgImageConstant.editWithBg),
              ),
              SizedBox(width: getSize(10)),
              GestureDetector(
                onTap: () {},
                child: SvgPicture.asset(SvgImageConstant.bin),
              ),
            ],
          )
        ],
      ),
    );
  }
}
