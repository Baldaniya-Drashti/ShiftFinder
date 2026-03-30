import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shift/application/contractor/refer_colleague/refer_colleague_bloc.dart';
import 'package:shift/domain/core/math_utils.dart';
import 'package:shift/domain/core/string_constant.dart';
import 'package:shift/injection.dart';
import 'package:shift/presentation/common/widgets/base_text.dart';
import 'package:shift/presentation/common/widgets/center_loading_indicator.dart';
import 'package:shift/presentation/main/tabs/home/view_single_applicants/view_applicants/widgets/applicant_detail_container.dart';
import 'package:shift/presentation/main/tabs/home/view_single_applicants/view_applicants/widgets/applicant_specialize.dart';
import 'package:shift/presentation/main/widgets/home_app_bar.dart';

@RoutePage(name: 'ViewCollegueProfile')
class ViewCollegueProfile extends StatelessWidget {
  final int id;

  const ViewCollegueProfile({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<ReferColleagueBloc>()
        ..add(
          ReferColleagueEvent.getCollegueProfile(id: id, context: context),
        ),
      child: Scaffold(
        appBar: CommonAppBar(
          onBackPressed: () => context.router.maybePop(),
          title: StringConstant.viewProfile,
        ),
        body: BlocBuilder<ReferColleagueBloc, ReferColleagueState>(
          builder: (context, state) {
            if (state.isLoading) {
              return CenterLoadingIndicator();
            } else if (!state.isLoading && state.showErrorMessages) {
              return Center(
                  child: BaseText(text: StringConstant.somethindWentWrong));
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
                  SizedBox(height: getSize(10)),
                  ApplicantSpecialize(data: state.account),
                  SizedBox(height: getSize(16)),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
