// ignore_for_file: avoid_print, prefer_const_constructors, must_be_immutable

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shift/application/auth/contractor_auth/reference_bloc/reference_bloc.dart';
import 'package:shift/domain/core/math_utils.dart';
import 'package:shift/domain/core/string_constant.dart';
import 'package:shift/domain/core/svg_image_constants.dart';
import 'package:shift/infrastructure/core/reference_dto/reference_dto.dart';
import 'package:shift/injection.dart';
import 'package:shift/presentation/common/utils/flushbar_creator.dart';
import 'package:shift/presentation/common/widgets/base_text.dart';
import 'package:shift/presentation/common/widgets/center_loading_indicator.dart';
import 'package:shift/presentation/common/widgets/no_data_ui.dart';
import 'package:shift/presentation/core/app_router.gr.dart';
import 'package:shift/presentation/core/style/app_colors.dart';
import 'package:shift/presentation/core/widgets/buttons/common_button.dart';
import 'package:shift/presentation/core/widgets/dialogs/app_dialog.dart';
import 'package:shift/presentation/main/widgets/home_app_bar.dart';

@RoutePage(name: 'referenceListScreen')
class ReferenceListScreen extends StatelessWidget {
  final bool isFromSplash;

  const ReferenceListScreen({super.key, this.isFromSplash = false});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          getIt<ReferenceBloc>()..add(ReferenceEvent.getReferenceList()),
      child: BlocConsumer<ReferenceBloc, ReferenceState>(
        listener: (context, state) {
          state.skipFailureOrSuccessOption.fold(
            () {},
            (either) => either.fold(
              (failure) {
                showError(
                  message: failure.maybeMap(
                    showAPIResponseMessage: (value) => value.message,
                    networkError: (value) =>
                        'Please check your internet connectivity',
                    orElse: () => "Server Error. Try again later.",
                  ),
                ).show(context);
              },
              (r) {
                context.router.push(PageRouteInfo(DocumentPageScreen.name));
              },
            ),
          );
        },
        builder: (context, state) {
          return Scaffold(
            appBar: CommonAppBar(
              forceMaterialTransparency: false,
              isShowBackBtn: !isFromSplash,
              onBackPressed: () {
                context.router.maybePop();
              },
              title: StringConstant.reference,
              showSkipBtn: (state.referenceList.isEmpty) ? true : false,
              onSkipped: () {
                context
                    .read<ReferenceBloc>()
                    .add(ReferenceEvent.skipReference());
                // context.router.replace(PageRouteInfo(DocumentPageScreen.name));
              },
            ),
            body: (state.isLoading)
                ? CenterLoadingIndicator()
                : Center(
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: getSize(20),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          (state.referenceList.isNotEmpty)
                              ? referenceListUI(context, state)
                              : Expanded(
                                  child: NoDataText(
                                    title: StringConstant.noReferenceAdded,
                                    description: StringConstant.noReferenceDesc,
                                    image: SvgImageConstant.referencePerson,
                                  ),
                                ),
                          Container(
                            color: AppColors.scaffoldColor,
                            child: Padding(
                              padding: EdgeInsets.only(
                                bottom: getSize(40),
                              ),
                              child: CommonButton(
                                onPressed: () {
                                  if (state.referenceList.isNotEmpty) {
                                    context.router.push(
                                        PageRouteInfo(DocumentPageScreen.name));
                                  } else {
                                    context.router
                                        .push(PageRouteInfo(
                                            AddReferenceDetailScreen.name))
                                        .then((value) {
                                      print("Value when back ---> $value");
                                      if (value != null && value == true) {
                                        /// REFRESH THE API AFTER ADD NEW EDUCATION DATA
                                        context.read<ReferenceBloc>().add(
                                            ReferenceEvent.getReferenceList());
                                      }
                                    });
                                  }
                                },
                                buttonText: (state.referenceList.isNotEmpty)
                                    ? StringConstant.txtContinue
                                    : StringConstant.addYourReference,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
          );
        },
      ),
    );
  }

  Widget referenceListUI(BuildContext context, ReferenceState state) {
    return Expanded(
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListView.builder(
              itemCount: state.referenceList.length,
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return Padding(
                  padding: EdgeInsets.symmetric(vertical: getSize(10)),
                  child: ListTile(
                    tileColor: AppColors.grey04,
                    minTileHeight: getSize(103),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    leading: SvgPicture.asset(
                      SvgImageConstant.personWithVerticalLine,
                      width: getSize(59.56),
                      height: getSize(63),
                      fit: BoxFit.fitHeight,
                    ),
                    title: boxTitleUI(state.referenceList[index]),
                    contentPadding:
                        EdgeInsets.only(left: getSize(15), right: getSize(10)),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        GestureDetector(
                          onTap: () {
                            context.router
                                .push(PageRouteInfo(
                                    AddReferenceDetailScreen.name,
                                    args: AddReferenceDetailScreenArgs(
                                        referenceObj:
                                            state.referenceList[index])))
                                .then((value) {
                              if (value != null && value == true) {
                                context
                                    .read<ReferenceBloc>()
                                    .add(ReferenceEvent.getReferenceList());
                              }
                            });
                          },
                          child: Container(
                            color: Colors.transparent,
                            padding: EdgeInsets.symmetric(
                                horizontal: getSize(5), vertical: getSize(10)),
                            child: SvgPicture.asset(
                              SvgImageConstant.editWithBg,
                            ),
                          ),
                        ),
                        SizedBox(width: getSize(5)),
                        GestureDetector(
                          onTap: () {
                            AppDialog.showDelete(
                              context,
                              title: StringConstant.delete,
                              infoMessage: StringConstant.deleteReferenceDesc,
                              onCancelClick: () {
                                Navigator.pop(context);
                              },
                              onDeleteClick: () {
                                Navigator.pop(context);
                                context.read<ReferenceBloc>().add(
                                    ReferenceEvent.deleteReference(
                                        state.referenceList[index].id ?? -1));
                              },
                            );
                          },
                          child: Container(
                              color: Colors.transparent,
                              padding: EdgeInsets.symmetric(
                                  horizontal: getSize(5),
                                  vertical: getSize(10)),
                              child: SvgPicture.asset(SvgImageConstant.bin)),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: getSize(20)),
              child: CommonButton(
                onPressed: () {
                  context.router
                      .push(const PageRouteInfo(AddReferenceDetailScreen.name))
                      .then((value) {
                    if (value != null && value == true) {
                      context
                          .read<ReferenceBloc>()
                          .add(ReferenceEvent.getReferenceList());
                    }
                  });
                },
                buttonText: "+ ${StringConstant.addMoreReference}",
                width: 175,
                borderRadius: 10,
                buttonFontSize: 12,
                buttonFontWeight: FontWeight.w600,
                height: 35,
                backgroundColor: AppColors.primaryColor.withOpacity(0.15),
                buttonTextColor: AppColors.primaryColor,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget boxTitleUI(ReferenceDTO reference) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        BaseText(
          text: (reference.type == 1)
              ? StringConstant.professional
              : StringConstant.personal,
          fontWeight: FontWeight.w600,
          fontSize: 14,
        ),
        BaseText(
          text: (reference.type == 1)
              ? reference.organization ?? ""
              : reference.contact_person ?? "",
          fontSize: 12,
          fontWeight: FontWeight.w500,
          textColor: AppColors.black.withOpacity(0.8),
          maxLines: 2,
        ),
        BaseText(
          text: reference.email ?? "",
          fontSize: 10,
          fontWeight: FontWeight.w400,
          textColor: AppColors.black.withOpacity(0.8),
          maxLines: 2,
        ),
      ],
    );
  }
}
