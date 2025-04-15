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
import 'package:shift/infrastructure/core/location_dto/location_dto.dart';
import 'package:shift/injection.dart';
import 'package:shift/presentation/common/widgets/base_text.dart';
import 'package:shift/presentation/common/widgets/center_loading_indicator.dart';
import 'package:shift/presentation/common/widgets/paginated_list_view.dart';
import 'package:shift/presentation/core/app_router.gr.dart';
import 'package:shift/presentation/core/style/app_colors.dart';
import 'package:shift/presentation/core/widgets/dialogs/app_dialog.dart';
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
      create: (context) => getIt<EmployerLocationBloc>()
        ..add(EmployerLocationEvent.getLocationList(context)),
      child: Scaffold(
        appBar: CommonAppBar(
          onBackPressed: () => context.router.maybePop(),
          title: StringConstant.locations,
        ),
        body: BlocBuilder<EmployerLocationBloc, EmployerLocationState>(
          builder: (context, state) {
            if (state.isLoading) {
              return CenterLoadingIndicator();
            } else if (!state.isLoading && state.locationList.isEmpty) {
              return Center(
                child: SizedBox(
                  width: getSize(280),
                  child: BaseText(
                    textColor: AppColors.black.withValues(alpha: 0.65),
                    text: StringConstant.noResultFound,
                    textAlign: TextAlign.center,
                    lineHeight: 1.2,
                  ),
                ),
              );
            }
            return PaginatedListView(
              onRefresh: () {
                context.read<EmployerLocationBloc>().add(
                    EmployerLocationEvent.getLocationList(context,
                        refresh: true));
              },
              onLoading: () {},
              refreshController: RefreshController(),
              child: Stack(
                children: [
                  SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        ListView.separated(
                          padding: EdgeInsets.symmetric(
                            horizontal: getSize(18),
                            vertical: getSize(20),
                          ),
                          separatorBuilder: (context, index) => Gap(16),
                          itemCount: state.locationList.length,
                          shrinkWrap: true,
                          physics: BouncingScrollPhysics(),
                          itemBuilder: (context, index) {
                            return _LocationInfoTile(
                                data: state.locationList[index]);
                          },
                        ),
                        Material(
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          color: AppColors.green.withValues(alpha: 0.15),
                          borderRadius: BorderRadius.circular(7),
                          child: InkWell(
                            onTap: () async {
                              final result = await context.router.push(
                                  PageRouteInfo(
                                      EmployerLocationFormView.name)) as bool?;
                              if (result ?? false) {
                                context.read<EmployerLocationBloc>().add(
                                    EmployerLocationEvent.getLocationList(
                                        context));
                              }
                            },
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: getSize(18),
                                  vertical: getSize(8)),
                              child: BaseText(
                                text: "+ ${StringConstant.addNewLocation}",
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                textColor: AppColors.green,
                              ),
                            ),
                          ),
                        ),
                        Gap(getSize(30))
                      ],
                    ),
                  ),
                  if (state.postDataLoading) CenterLoadingIndicator()
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

class _LocationInfoTile extends StatelessWidget {
  const _LocationInfoTile({required this.data});

  final LocationDTO data;

  @override
  Widget build(BuildContext context) {
    String? units;
    if ((data.add_units ?? []).isNotEmpty) {
      units = data.add_units!
          .map((e) => e.number_or_name ?? "")
          .where((value) => value != "N/A")
          .join(",");
    }

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
                  text: data.location ?? "",
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
                BaseText(
                  text: data.facility_type?.name ?? "",
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
                if (units != null && units.isNotEmpty)
                  BaseText(
                    text: "($units)",
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
                onTap: () async {
                  final result = await context.router.push(
                    PageRouteInfo(EmployerLocationFormView.name,
                        args: EmployerLocationFormViewArgs(id: data.id ?? -1)),
                  ) as bool?;
                  if (result ?? false) {
                    context
                        .read<EmployerLocationBloc>()
                        .add(EmployerLocationEvent.getLocationList(context));
                  }
                },
                child: SvgPicture.asset(SvgImageConstant.editWithBg),
              ),
              SizedBox(width: getSize(10)),
              GestureDetector(
                onTap: () async {
                  final result = await AppDialog.showCommonDialog(
                    context: context,
                    title: StringConstant.deleteLocation,
                    content: StringConstant.deleteLocationDesc,
                    successLabel: StringConstant.delete,
                  );
                  if (result ?? false) {
                    context.read<EmployerLocationBloc>().add(
                        EmployerLocationEvent.deleteLocation(
                            id: data.id ?? -1, context: context));
                  }
                },
                child: SvgPicture.asset(SvgImageConstant.bin),
              ),
            ],
          )
        ],
      ),
    );
  }
}
