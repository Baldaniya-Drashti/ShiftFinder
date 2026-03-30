import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:pdfx/pdfx.dart';
import 'package:shift/domain/core/string_constant.dart';
import 'package:shift/presentation/common/widgets/center_loading_indicator.dart';
import 'package:shift/presentation/main/widgets/home_app_bar.dart';

@RoutePage(name: 'ContractorPdfViewer')
class ContractorPdfViewer extends StatefulWidget {
  final String pdfUrl;
  final bool hideAppBar;

  const ContractorPdfViewer(
      {required this.pdfUrl, this.hideAppBar = false, super.key});

  @override
  State<ContractorPdfViewer> createState() => _ContractorPdfViewerState();
}

class _ContractorPdfViewerState extends State<ContractorPdfViewer> {
  Future<PdfDocument>? _pdfDocumentFuture;

  @override
  void initState() {
    super.initState();
    _pdfDocumentFuture = PdfDocument.openData(http
        .get(Uri.parse(widget.pdfUrl))
        .then((response) => response.bodyBytes));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: widget.hideAppBar
          ? null
          : CommonAppBar(
              title: StringConstant.viewPdf,
              onBackPressed: () {
                context.router.maybePop();
              },
            ),
      body: FutureBuilder<PdfDocument>(
          future: _pdfDocumentFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CenterLoadingIndicator(isOnlyLoader: true));
            } else if (snapshot.hasError) {
              return Center(child: Text(StringConstant.errorLoadingPdf));
            } else if (snapshot.hasData) {
              return PdfView(
                controller: PdfController(
                  /*  document: PdfDocument.openData(http
                      .get(Uri.parse(pdfUrl))
                      .then((response) => response.bodyBytes)), */
                  document: PdfDocument.openData(http
                      .get(Uri.parse(widget.pdfUrl))
                      .then((response) => response.bodyBytes)),
                ),
              );
            } else {
              return Center(child: Text(StringConstant.somethindWentWrong));
            }
          }),
    );
  }
}
