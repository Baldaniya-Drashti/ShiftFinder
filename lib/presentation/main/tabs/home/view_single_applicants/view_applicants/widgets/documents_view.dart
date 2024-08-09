import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:shift/domain/core/math_utils.dart';
import 'package:shift/presentation/common/widgets/base_text.dart';
import 'package:shift/presentation/core/app_router.gr.dart';

class DocumentsView extends StatelessWidget {
  const DocumentsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        BaseText(
          text: 'Documents Uploaded (Tap To View)',
          fontSize: 10,
          fontWeight: FontWeight.w600,
          textColor: Colors.black.withOpacity(0.8),
        ),
        SizedBox(
          height: getSize(8),
        ),
        getDocumentsContainer(
          title: 'Government Issued Id',
          onTap: () {
            context.router.push(
              PageRouteInfo(
                CommonDocumentView.name,
                args: CommonDocumentViewArgs(
                  title: 'Government Issued Id',
                  pdfUrl:
                      'https://cdn.syncfusion.com/content/PDFViewer/flutter-succinctly.pdf',
                ),
              ),
            );
          },
        ),
        SizedBox(
          height: getSize(15),
        ),
        getDocumentsContainer(
          title: 'Covid 19 Vaccination Proof',
          onTap: () {
            context.router.push(
              PageRouteInfo(
                CommonDocumentView.name,
                args: CommonDocumentViewArgs(
                  title: 'Covid 19 Vaccination Proof',
                  pdfUrl:
                      'https://cdn.syncfusion.com/content/PDFViewer/flutter-succinctly.pdf',
                ),
              ),
            );
          },
        ),
        SizedBox(
          height: getSize(15),
        ),
        getDocumentsContainer(
          title: 'Credentials/Registrations',
          onTap: () {
            context.router.push(
              PageRouteInfo(
                CommonDocumentView.name,
                args: CommonDocumentViewArgs(
                  title: 'Government Issued Id',
                  pdfUrl:
                      'https://cdn.syncfusion.com/content/PDFViewer/flutter-succinctly.pdf',
                ),
              ),
            );
          },
        ),
        SizedBox(
          height: getSize(15),
        ),
        getDocumentsContainer(
          title: 'Professional License',
          onTap: () {
            context.router.push(
              PageRouteInfo(
                CommonDocumentView.name,
                args: CommonDocumentViewArgs(
                  title: 'Professional License',
                  pdfUrl:
                      'https://cdn.syncfusion.com/content/PDFViewer/flutter-succinctly.pdf',
                ),
              ),
            );
          },
        ),
        SizedBox(
          height: getSize(15),
        ),
        getDocumentsContainer(
          title: 'Immunizations/Vaccinations',
          onTap: () {
            context.router.push(
              PageRouteInfo(
                CommonDocumentView.name,
                args: CommonDocumentViewArgs(
                  title: 'Immunizations/Vaccinations',
                  pdfUrl:
                      'https://cdn.syncfusion.com/content/PDFViewer/flutter-succinctly.pdf',
                ),
              ),
            );
          },
        ),
        SizedBox(
          height: getSize(15),
        ),
        getDocumentsContainer(
          title: 'Covid 19 Vaccination Proof',
          onTap: () {
            context.router.push(
              PageRouteInfo(
                CommonDocumentView.name,
                args: CommonDocumentViewArgs(
                  title: 'Covid 19 Vaccination Proof',
                  pdfUrl:
                      'https://cdn.syncfusion.com/content/PDFViewer/flutter-succinctly.pdf',
                ),
              ),
            );
          },
        ),
        SizedBox(
          height: getSize(15),
        ),
        getDocumentsContainer(
          title: 'Professional Liability Protection',
          onTap: () {
            context.router.push(
              PageRouteInfo(
                CommonDocumentView.name,
                args: CommonDocumentViewArgs(
                  title: 'Government Issued Id',
                  pdfUrl:
                      'https://cdn.syncfusion.com/content/PDFViewer/flutter-succinctly.pdf',
                ),
              ),
            );
          },
        ),
        SizedBox(
          height: getSize(15),
        ),
        getDocumentsContainer(
          title: 'Resume',
          onTap: () {
            context.router.push(
              PageRouteInfo(
                CommonDocumentView.name,
                args: CommonDocumentViewArgs(
                  title: 'Resume',
                  pdfUrl:
                      'https://cdn.syncfusion.com/content/PDFViewer/flutter-succinctly.pdf',
                ),
              ),
            );
          },
        ),
        SizedBox(
          height: getSize(15),
        ),
        getDocumentsContainer(
          title: 'Apparel/Equipment',
          onTap: () {
            context.router.push(
              PageRouteInfo(
                CommonDocumentView.name,
                args: CommonDocumentViewArgs(
                  title: 'Government Issued Id',
                  pdfUrl:
                      'https://cdn.syncfusion.com/content/PDFViewer/flutter-succinctly.pdf',
                ),
              ),
            );
          },
        ),
        SizedBox(
          height: getSize(15),
        ),
      ],
    );
  }

  getDocumentsContainer({required String title, required Function() onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: getSize(20),
          vertical: getSize(14),
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            BaseText(
              text: title,
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
            Icon(Icons.arrow_forward_rounded)
          ],
        ),
      ),
    );
  }
}
