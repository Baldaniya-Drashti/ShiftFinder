import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shift/application/employer/employer_long_term_authorize_payment/employer_long_term_authorize_payment_bloc.dart';
import 'package:shift/infrastructure/core/employer_applicant/employer_applicant_dto.dart';
import 'package:shift/injection.dart';
import 'package:shift/presentation/main/widgets/home_app_bar.dart';

@RoutePage(name: "EmployerLongTermAuthorizePaymentView")
class EmployerLongTermAuthorizePaymentView extends StatelessWidget {
  final EmployerApplicantsDto employerApplicantsDto;

  const EmployerLongTermAuthorizePaymentView({super.key, required this.employerApplicantsDto});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<EmployerLongTermAuthorizePaymentBloc>(),
      child: Scaffold(
        appBar: CommonAppBar(onBackPressed: () => context.router.maybePop(), title: "Review Details"),
      ),
    );
  }
}
