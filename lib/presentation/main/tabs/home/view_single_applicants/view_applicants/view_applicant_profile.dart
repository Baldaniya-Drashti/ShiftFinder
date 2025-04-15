import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shift/application/profile/applicant_profile/applicant_profile_bloc.dart';
import 'package:shift/domain/core/math_utils.dart';
import 'package:shift/domain/core/png_image_constants.dart';
import 'package:shift/domain/core/string_constant.dart';
import 'package:shift/injection.dart';
import 'package:shift/presentation/common/widgets/base_text.dart';
import 'package:shift/presentation/common/widgets/center_loading_indicator.dart';
import 'package:shift/presentation/core/app_router.gr.dart';
import 'package:shift/presentation/core/style/app_colors.dart';
import 'package:shift/presentation/main/tabs/home/view_single_applicants/view_applicants/widgets/applicant_detail_container.dart';
import 'package:shift/presentation/main/tabs/home/view_single_applicants/view_applicants/widgets/applicant_specialize.dart';
import 'package:shift/presentation/main/tabs/home/view_single_applicants/view_applicants/widgets/documents_view.dart';
import 'package:shift/presentation/main/widgets/home_app_bar.dart';

@RoutePage(name: 'ViewApplicantProfile')
class ViewApplicantProfile extends StatelessWidget {
  final int id;
  final int postId;
  final int? isLongOrFull;

  const ViewApplicantProfile(
      {super.key, required this.id, required this.postId, this.isLongOrFull});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<ApplicantProfileBloc>()
        ..add(
          ApplicantProfileEvent.fetchApplicantProfile(
              id: id,
              context: context,
              postId: postId,
              isLongOrFull: isLongOrFull),
        ),
      child: Scaffold(
        appBar: CommonAppBar(
          onBackPressed: () => context.router.maybePop(),
          title: StringConstant.viewProfile,
        ),
        body: BlocBuilder<ApplicantProfileBloc, ApplicantProfileState>(
          builder: (context, state) {
            if (state.isLoading) {
              return CenterLoadingIndicator();
            } else if (!state.isLoading && state.isErrorInAPI) {
              return Center(
                  child: BaseText(text: StringConstant.somethindWentWrong));
            } else if (!state.isLoading && state.isNoDataFound) {
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

            return SafeArea(
              child: ListView(
                shrinkWrap: true,
                physics: BouncingScrollPhysics(),
                padding: EdgeInsets.symmetric(
                  horizontal: getSize(20),
                ),
                children: [
                  ApplicantsDetailView(data: state.account),
                  SizedBox(
                    height: getSize(10),
                  ),
                  ApplicantSpecialize(data: state.account),
                  SizedBox(
                    height: getSize(16),
                  ),
                  if (state.account.education != null &&
                      state.account.education!.isNotEmpty)
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        BaseText(
                          text: StringConstant.education,
                          fontSize: 10,
                          fontWeight: FontWeight.w600,
                          textColor: Colors.black.withValues(alpha: 0.8),
                        ),
                        SizedBox(height: getSize(8)),
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: getSize(20),
                            vertical: getSize(14),
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.white,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: InkWell(
                            onTap: () {
                              context.router.push(
                                PageRouteInfo(EducationProfileListView.name,
                                    args: EducationProfileListViewArgs(
                                        applicantDto: state.account)),
                              );
                            },
                            child: Row(
                              children: [
                                Image.asset(
                                  PngImageConstants.education,
                                  height: getSize(28),
                                  width: getSize(28),
                                ),
                                SizedBox(width: getSize(15)),
                                Image.asset(
                                  PngImageConstants.line,
                                  height: getSize(25),
                                ),
                                SizedBox(width: getSize(15)),
                                Expanded(
                                  child: BaseText(
                                    text: StringConstant.programCompleted,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                Icon(Icons.arrow_forward_rounded)
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  if (state.account.reference != null &&
                      state.account.reference!.isNotEmpty) ...[
                    SizedBox(height: getSize(12)),
                    BaseText(
                      text: StringConstant.referencesTapToView,
                      fontSize: 10,
                      fontWeight: FontWeight.w600,
                      textColor: Colors.black.withValues(alpha: 0.8),
                    ),
                    if (state.account.reference
                            ?.where((element) => element.type == 1)
                            .toList()
                            .isNotEmpty ??
                        false) ...[
                      SizedBox(height: getSize(12)),
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: getSize(20),
                          vertical: getSize(14),
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.white,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: InkWell(
                          onTap: () {
                            context.router.push(
                              PageRouteInfo(
                                ProfessionalProfileView.name,
                                args: ProfessionalProfileViewArgs(
                                    applicantDto: state.account),
                              ),
                            );
                          },
                          child: Row(
                            children: [
                              Image.asset(
                                PngImageConstants.person,
                                height: getSize(30),
                                width: getSize(30),
                              ),
                              SizedBox(width: getSize(15)),
                              Image.asset(
                                PngImageConstants.line,
                                height: getSize(25),
                              ),
                              SizedBox(width: getSize(15)),
                              Expanded(
                                child: BaseText(
                                  text: StringConstant.professional,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Icon(Icons.arrow_forward_rounded)
                            ],
                          ),
                        ),
                      ),
                    ],
                    if (state.account.reference
                            ?.where((element) => element.type == 2)
                            .toList()
                            .isNotEmpty ??
                        false) ...[
                      SizedBox(height: getSize(16)),
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: getSize(20),
                          vertical: getSize(14),
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.white,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: InkWell(
                          onTap: () {
                            context.router.push(
                              PageRouteInfo(
                                PersonalProfileView.name,
                                args: PersonalProfileViewArgs(
                                    applicantDto: state.account),
                              ),
                            );
                          },
                          child: Row(
                            children: [
                              Image.asset(
                                PngImageConstants.person,
                                height: getSize(30),
                                width: getSize(30),
                              ),
                              SizedBox(width: getSize(15)),
                              Image.asset(
                                PngImageConstants.line,
                                height: getSize(25),
                              ),
                              SizedBox(width: getSize(15)),
                              Expanded(
                                child: BaseText(
                                  text: StringConstant.personal,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Icon(Icons.arrow_forward_rounded)
                            ],
                          ),
                        ),
                      ),
                    ],
                  ],
                  SizedBox(height: getSize(20)),
                  DocumentsView(data: state.account),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
