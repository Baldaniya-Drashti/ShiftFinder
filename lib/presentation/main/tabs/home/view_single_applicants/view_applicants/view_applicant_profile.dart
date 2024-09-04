import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:shift/domain/core/math_utils.dart';
import 'package:shift/presentation/main/tabs/home/view_single_applicants/view_applicants/widgets/applicant_detail_container.dart';
import 'package:shift/presentation/main/tabs/home/view_single_applicants/view_applicants/widgets/applicant_specialize.dart';
import 'package:shift/presentation/main/tabs/home/view_single_applicants/view_applicants/widgets/documents_view.dart';
import 'package:shift/presentation/main/tabs/home/view_single_applicants/view_applicants/widgets/education_view.dart';
import 'package:shift/presentation/main/tabs/home/view_single_applicants/view_applicants/widgets/reference_view.dart';
import 'package:shift/presentation/main/widgets/home_app_bar.dart';

@RoutePage(name: 'ViewApplicantProfile')
class ViewApplicantProfile extends StatelessWidget {
  const ViewApplicantProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBar(
        onBackPressed: () {
          context.router.maybePop();
        },
        title: 'View Profile',
      ),
      body: ListView(
        shrinkWrap: true,
        physics: BouncingScrollPhysics(),
        padding: EdgeInsets.symmetric(
          horizontal: getSize(20),
        ),
        children: [
          getApplicantswDetailContainer(),
          SizedBox(
            height: getSize(10),
          ),
          ApplicantSpecialize(),
          SizedBox(
            height: getSize(20),
          ),
          EducationView(),
          SizedBox(
            height: getSize(20),
          ),
          ReferenceView(),
          SizedBox(
            height: getSize(20),
          ),
          DocumentsView(),
        ],
      ),
    );
  }

  getApplicantswDetailContainer() {
    return ApplicantsDetailView();
  }
}
