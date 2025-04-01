import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:shift/domain/core/string_constant.dart';
import 'package:shift/presentation/main/widgets/home_app_bar.dart';
// import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

@RoutePage(name: 'ContractorPdfViewer')
class ContractorPdfViewer extends StatelessWidget {
  final String pdfUrl;
  const ContractorPdfViewer({required this.pdfUrl, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBar(
        title: StringConstant.viewPdf,
        onBackPressed: () {
          context.router.maybePop();
        },
      ),
      body: PDFView(
        filePath: pdfUrl,
      ),
      //  SfPdfViewer.network(
      //   pdfUrl,
      //   // scrollDirection: PdfScrollDirection.horizontal,
      // ),
    );
  }
}
