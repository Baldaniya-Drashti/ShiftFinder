import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shift/application/auth/contractor_auth/card_bloc/card_bloc.dart';
import 'package:shift/application/faq/faq_bloc.dart';
import 'package:shift/injection.dart';
import 'package:shift/presentation/main/widgets/home_app_bar.dart';

@RoutePage(name: "FaqView")
class FaqView extends StatelessWidget {
  const FaqView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<FaqBloc>(),
      child: Scaffold(
        appBar: CommonAppBar(onBackPressed: () => context.router.maybePop(), title: "FAQs"),

      ),
    );
  }
}
