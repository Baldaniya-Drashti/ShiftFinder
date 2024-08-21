// ignore_for_file: must_be_immutable

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shift/application/main_tab/shifts/agreed_proposal_bloc/agreed_proposal_bloc.dart';
import 'package:shift/domain/core/string_constant.dart';
import 'package:shift/injection.dart';
import 'package:shift/presentation/common/widgets/base_text.dart';
import 'package:shift/presentation/common/widgets/center_loading_indicator.dart';
import 'package:shift/presentation/main/tabs/shifts/multi_agreed_shift.dart';
import 'package:shift/presentation/main/tabs/shifts/single_agreed_shift.dart';

@RoutePage(name: 'AgreedProposal')
class AgreedProposal extends StatelessWidget {
  int userId;
  int postId;
  int shiftType;
  AgreedProposal(
      {super.key,
      required this.userId,
      required this.postId,
      required this.shiftType});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) => getIt<AgreedProposalBloc>()
          ..add(AgreedProposalEvent.getProposalDataEvent(
            context,
            postId: postId,
            userId: userId,
          )),
        child: BlocBuilder<AgreedProposalBloc, AgreedProposalState>(
          builder: (context, state) {
            return (state.isLoading)
                ? CenterLoadingIndicator(isOnlyLoader: true)
                : state.errorApi
                    ? Center(
                        child:
                            BaseText(text: StringConstant.somethindWentWrong))
                    : (shiftType == 1)
                        ? SingleAgreedShift(contractor: state.contractorDetail)
                        : MultiAgreedShift(contractor: state.contractorDetail);
          },
        ),
      ),
    );
  }
}
