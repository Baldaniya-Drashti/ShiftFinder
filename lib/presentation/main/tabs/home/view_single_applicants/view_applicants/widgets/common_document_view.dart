import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:shift/domain/core/math_utils.dart';
import 'package:shift/domain/core/png_image_constants.dart';
import 'package:shift/domain/core/string_constant.dart';
import 'package:shift/domain/core/svg_image_constants.dart';
import 'package:shift/infrastructure/core/document_dto/document_dto.dart';
import 'package:shift/presentation/common/widgets/base_text.dart';
import 'package:shift/presentation/core/app_router.gr.dart';
import 'package:shift/presentation/core/style/app_colors.dart';
import 'package:shift/presentation/main/widgets/home_app_bar.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

@RoutePage(name: 'CommonDocumentView')
class CommonDocumentView extends StatelessWidget {
  final String title;
  final String frontPage;
  final String backPage;
  final List<DocumentDTO> documentList;

  const CommonDocumentView(
      {super.key,
      required this.title,
      required this.frontPage,
      required this.backPage,
      required this.documentList});

  @override
  Widget build(BuildContext context) {
    print("docuemnttt--> $documentList");
    return Scaffold(
      appBar: CommonAppBar(
        onBackPressed: () {
          context.router.maybePop();
        },
        title: title,
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: getSize(20),
            vertical: getSize(10),
          ),
          child: ListView.builder(
              itemCount: documentList.length,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return documentUI(context, documentList[index]);
              }),
        ),
      ),
    );
  }

  Widget documentUI(BuildContext context, DocumentDTO document) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        docDetail(document),
        if (document.document_type == 1 ||
            document.document_type == 3 ||
            document.document_type == 4 ||
            document.document_type == 6)
          expiryDate(document),

        /// Front page
        if (backPage.isNotEmpty)
          Padding(
            padding: EdgeInsets.only(left: getSize(15), top: getSize(10)),
            child: BaseText(
              text: StringConstant.frontPage,
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          ),
        if (frontPage.contains("jpg") || frontPage.contains("png")) ...[
          Padding(
            padding: EdgeInsets.symmetric(vertical: getSize(20)),
            child: Center(
                child: CachedNetworkImage(
              imageUrl: frontPage,
            )),
          ),
        ] else if (frontPage.contains("pdf")) ...[
          GestureDetector(
            onTap: () {
              context.router.push(PageRouteInfo(ContractorPdfViewer.name,
                  args: ContractorPdfViewerArgs(pdfUrl: frontPage)));
            },
            child: Container(
              margin: EdgeInsets.symmetric(vertical: getSize(10)),
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: AppColors.white,
                    spreadRadius: 0.2,
                    blurRadius: 0,
                  ),
                ],
                border: Border.all(color: AppColors.transparent),
                borderRadius: BorderRadius.circular(5),
              ),
              height: getSize(384),
              width: double.infinity,
              child: Icon(
                Icons.picture_as_pdf,
                size: getSize(100),
                color: Colors.red,
              ),
            ),
          ),
        ],

        /// Back page
        if (backPage.isNotEmpty) ...[
          Padding(
            padding: EdgeInsets.only(left: getSize(15)),
            child: BaseText(
              text: StringConstant.backPage,
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          ),
          if (backPage.contains("jpg") || backPage.contains("png")) ...[
            Padding(
              padding: EdgeInsets.symmetric(vertical: getSize(20)),
              child: Center(
                  child: CachedNetworkImage(
                imageUrl: backPage,
              )),
            ),
          ] else if (backPage.contains("pdf")) ...[
            GestureDetector(
              onTap: () {
                context.router.push(PageRouteInfo(ContractorPdfViewer.name,
                    args: ContractorPdfViewerArgs(pdfUrl: backPage)));
              },
              child: Container(
                margin: EdgeInsets.symmetric(vertical: getSize(10)),
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.white,
                      spreadRadius: 0.2,
                      blurRadius: 0,
                    ),
                  ],
                  border: Border.all(color: AppColors.transparent),
                  borderRadius: BorderRadius.circular(5),
                ),
                height: getSize(384),
                width: double.infinity,
                child: Icon(
                  Icons.picture_as_pdf,
                  size: getSize(100),
                  color: Colors.red,
                ),
              ),
            ),
          ],
        ]
      ],
    );
  }

  Widget expiryDate(DocumentDTO document) {
    return (document.expiry_date_not_applicable == 1)
        ? Container(
            margin: EdgeInsets.symmetric(vertical: getSize(10)),
            padding: EdgeInsets.symmetric(
              horizontal: getSize(20),
              vertical: getSize(10),
            ),
            width: double.infinity,
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(5),
            ),
            child: BaseText(
              text: StringConstant.expiryDateIsNotApplicable,
              fontWeight: FontWeight.w500,
              fontSize: 12,
            ),
          )
        : (document.expiry_date != null)
            ? Container(
                margin: EdgeInsets.symmetric(vertical: getSize(10)),
                padding: EdgeInsets.symmetric(
                  horizontal: getSize(20),
                  vertical: getSize(10),
                ),
                width: double.infinity,
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Row(
                  children: [
                    SvgPicture.asset(
                      SvgImageConstant.calendar,
                      height: getSize(20),
                      width: getSize(20),
                    ),
                    SizedBox(width: getSize(10)),
                    BaseText(
                      text:
                          "Expiry date - ${DateFormat("dd MMM, yyyy").format(DateTime.fromMillisecondsSinceEpoch(
                        (document.expiry_date ?? -1) * 1000,
                      ))}",
                      fontWeight: FontWeight.w500,
                      fontSize: 12,
                    ),
                  ],
                ),
              )
            : Container();
  }

  Widget docDetail(DocumentDTO document) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: getSize(20),
        vertical: getSize(14),
      ),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          SvgPicture.asset(
            SvgImageConstant.documentWithVerticalLine,
            width: getSize(59.56),
            height: getSize(63),
            fit: BoxFit.fitHeight,
          ),
          SizedBox(width: getSize(15)),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              BaseText(
                text: document.document_title ?? title,
                fontSize: 12,
                fontWeight: FontWeight.w600,
                lineHeight: getSize(3),
              ),
              if (document.province_of_registration != null &&
                  document.province_of_registration!.isNotEmpty)
                BaseText(
                  text: document.province_of_registration ?? "",
                  fontSize: 10,
                  fontWeight: FontWeight.w500,
                  lineHeight: getSize(2),
                ),
              if (document.registration_number != null &&
                  document.registration_number!.isNotEmpty)
                BaseText(
                  text: document.registration_number ?? "",
                  fontSize: 10,
                  lineHeight: getSize(3),
                  fontWeight: FontWeight.w400,
                ),
            ],
          ),
        ],
      ),
    );
  }
}
