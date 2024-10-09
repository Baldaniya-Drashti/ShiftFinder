// ignore_for_file: avoid_print, prefer_const_constructors, must_be_immutable

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shift/application/auth/contractor_auth/document_bloc/document_bloc.dart';
import 'package:shift/injection.dart';
import 'package:shift/presentation/common/utils/app_focus.dart';
import 'package:shift/presentation/common/utils/flushbar_creator.dart';
import 'package:shift/presentation/common/widgets/center_loading_indicator.dart';
import 'package:shift/presentation/main/widgets/home_app_bar.dart';

@RoutePage(name: 'DocumentPageScreen')
class DocumentPage extends StatefulWidget {
  bool isFromSplash = false;

  DocumentPage({super.key, this.isFromSplash = false});

  @override
  State<DocumentPage> createState() => _DocumentPageState();
}

class _DocumentPageState extends State<DocumentPage> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        AppFocus.unfocus(context);
      },
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => getIt<DocumentBloc>()
              ..add(DocumentEvent.getAllDocumentStatus()),
          ),
          BlocProvider(
            create: (context) => getIt<CredentialBloc>(),
          ),
          BlocProvider(
            create: (context) => getIt<ProfessionalLicensesBloc>(),
          ),
          BlocProvider(
            create: (context) => getIt<ImmunizationBloc>(),
          ),
          BlocProvider(
            create: (context) => getIt<ProfessionalLiabilityBloc>(),
          ),
          BlocProvider(
            create: (context) => getIt<ResumeBloc>(),
          ),
          BlocProvider(
            create: (context) => getIt<EquipmentBloc>(),
          ),
        ],
        child: BlocConsumer<DocumentBloc, DocumentState>(
          listener: (context, state) {
            state.authFailureOrSuccessOption.fold(
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
                (r) {},
              ),
            );
          },
          builder: (context, state) {
            return Scaffold(
              appBar: CommonAppBar(
                forceMaterialTransparency: false,
                isShowBackBtn:
                    (state.currentPage == 0) ? !widget.isFromSplash : true,
                onBackPressed: () {
                  AppFocus.unfocus(context);
                  if (state.currentPage == 0) {
                    context.router.maybePop();
                  } else {
                    DocumentBloc.pageController
                        .animateTo(
                      0,
                      duration: const Duration(milliseconds: 10),
                      curve: Curves.easeOut,
                    )
                        .then((value) {
                      context
                          .read<DocumentBloc>()
                          .add(DocumentEvent.getAllDocumentStatus());
                    });
                  }
                },
                title: DocumentBloc.appbarTitleList[state.currentPage],
              ),
              body: (state.allListLoading)
                  ? CenterLoadingIndicator()
                  : getPageView(state, context),
            );
          },
        ),
      ),
    );
  }

  getPageView(DocumentState state, BuildContext context) {
    return PageView.builder(
      controller: DocumentBloc.pageController,
      itemCount: DocumentBloc.documentPageList.length,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) => DocumentBloc.documentPageList[index],
      onPageChanged: (value) {
        print("CURRENT PAGE IS===> $value");
        context.read<DocumentBloc>().add(DocumentEvent.nextPage(value));
      },
    );
  }
}
