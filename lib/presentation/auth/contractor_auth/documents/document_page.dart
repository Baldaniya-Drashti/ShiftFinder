import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shift/application/auth/contractor_auth/document_bloc/document_bloc.dart';
import 'package:shift/presentation/main/widgets/home_app_bar.dart';

@RoutePage(name: 'DocumentPageScreen')
class DocumentPage extends StatefulWidget {
  const DocumentPage({super.key});

  @override
  State<DocumentPage> createState() => _DocumentPageState();
}

class _DocumentPageState extends State<DocumentPage> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DocumentBloc(),
      child: BlocBuilder<DocumentBloc, DocumentState>(
        builder: (context, state) {
          return Scaffold(
            appBar: CommonAppBar(
              onBackPressed: () {
                if (state.currentPage == 0) {
                  context.router.maybePop();
                } else {
                  DocumentBloc.pageController.animateTo(
                    0,
                    duration: const Duration(milliseconds: 10),
                    curve: Curves.easeOut,
                  );
                }
              },
              title: DocumentBloc.appbarTitleList[state.currentPage],
            ),
            body: getPageView(state, context),
          );
        },
      ),
    );
  }

  getPageView(DocumentState state, BuildContext context) {
    return PageView.builder(
      controller: DocumentBloc.pageController,
      itemCount: DocumentBloc.documentPageList.length,
      physics: const BouncingScrollPhysics(),
      itemBuilder: (context, index) => DocumentBloc.documentPageList[index],
      onPageChanged: (value) {
        print("CUrRENT PAGE IS===> $value");
        context.read<DocumentBloc>().add(DocumentEvent.nextPage(value));
      },
    );
  }
}
