import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shift/application/employer/proposal/total_proposal_bloc.dart';
import 'package:shift/domain/core/math_utils.dart';
import 'package:shift/domain/core/string_constant.dart';

import 'package:shift/infrastructure/core/employer_proposal_dto/employer_proposal_dto.dart';
import 'package:shift/injection.dart';
import 'package:shift/presentation/common/widgets/base_text.dart';
import 'package:shift/presentation/common/widgets/center_loading_indicator.dart';
import 'package:shift/presentation/core/style/app_colors.dart';
import 'package:shift/presentation/main/tabs/home/praposals/widgets/main_praposal_view.dart';
import 'package:shift/presentation/main/tabs/home/praposals/widgets/person_list_widget.dart';
import 'package:shift/presentation/main/widgets/home_app_bar.dart';

@RoutePage(name: 'TotalPraposalView')
class TotalPraposalView extends StatelessWidget {
  const TotalPraposalView({super.key, required this.postId});

  final int postId;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<TotalProposalBloc>()
        ..add(
          TotalProposalEvent.getTotalProposalList(
              id: postId, isRefresh: true, context: context),
        ),
      child: Scaffold(
        appBar: CommonAppBar(
          onBackPressed: () {
            context.router.maybePop();
          },
          title: StringConstant.viewProposal,
        ),
        body: BlocBuilder<TotalProposalBloc, TotalProposalState>(
          builder: (context, state) {
            if (state.isLoading) {
              return CenterLoadingIndicator();
            } else if (!state.isLoading &&
                state.totalProposedDataList.isEmpty &&
                state.additionalData == null) {
              return Center(
                child: SizedBox(
                  width: getSize(280),
                  child: BaseText(
                    textColor: AppColors.black.withOpacity(0.65),
                    text: 'No result found.',
                    textAlign: TextAlign.center,
                    lineHeight: 1.2,
                  ),
                ),
              );
            }

            return ListView(
              shrinkWrap: true,
              physics: BouncingScrollPhysics(),
              children: [
                SizedBox(height: getSize(20)),
                MainPraposalView(
                  additionalData: state.additionalData ?? EmployerProposalDto(),
                  postId: postId,
                ),
                if (state.totalProposedDataList.isNotEmpty)
                  PersonListWidget(postId: postId),
              ],
            );
          },
        ),
      ),
    );
  }
}
