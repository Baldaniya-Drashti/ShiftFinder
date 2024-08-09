import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:shift/domain/core/math_utils.dart';
import 'package:shift/presentation/common/widgets/base_text.dart';
import 'package:shift/presentation/main/widgets/home_app_bar.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

@RoutePage(name: 'CommonDocumentView')
class CommonDocumentView extends StatelessWidget {
  final String title;
  final String pdfUrl;
  const CommonDocumentView(
      {super.key, required this.title, required this.pdfUrl});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBar(
        onBackPressed: () {
          context.router.maybePop();
        },
        title: title,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: getSize(20),
          vertical: getSize(10),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            BaseText(
              text: 'The document',
              fontWeight: FontWeight.w500,
            ),
            SizedBox(
              height: getSize(10),
            ),
            Expanded(
              child: SfPdfViewer.network(
                pdfUrl,
                // scrollDirection: PdfScrollDirection.horizontal,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
