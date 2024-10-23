import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:shift/domain/core/math_utils.dart';
import 'package:shift/infrastructure/core/applicant_dto/applicant_dto.dart';
import 'package:shift/presentation/common/widgets/base_text.dart';
import 'package:shift/presentation/core/app_router.gr.dart';
import 'package:shift/presentation/core/logger/logger.dart';

class DocumentsView extends StatelessWidget {
  const DocumentsView({super.key, required this.data});

  final ApplicantDto data;

  @override
  Widget build(BuildContext context) {


    Log.debug(data.document);


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
        if(data.document?.any((element) =>element.document_type==1,)??false)...[
          getDocumentsContainer(
            title: 'Government Issued Id',
            onTap: () {
              context.router.push(
                PageRouteInfo(
                  CommonDocumentView.name,
                  args: CommonDocumentViewArgs(
                    title: 'Government Issued Id',
                    pdfUrl: data.document?.firstWhere((element) => element.document_type == 1).file ?? "",
                  ),
                ),
              );
            },
          ),
          SizedBox(
            height: getSize(15),
          ),
        ],


        if(data.document?.any((element) =>element.document_type==2,)??false)...[
          getDocumentsContainer(
            title: 'Covid 19 Vaccination Proof',
            onTap: () {
              context.router.push(
                PageRouteInfo(
                  CommonDocumentView.name,
                  args: CommonDocumentViewArgs(
                    title: 'Covid 19 Vaccination Proof',
                    pdfUrl: data.document?.firstWhere((element) => element.document_type == 2).file ?? "",
                  ),
                ),
              );
            },
          ),
          SizedBox(
            height: getSize(15),
          ),
        ],
     if(data.document?.any((element) =>element.document_type==3)??false)...[
       getDocumentsContainer(
         title: 'Credentials/Registrations',
         onTap: () {
           context.router.push(
             PageRouteInfo(
               CommonDocumentView.name,
               args: CommonDocumentViewArgs(
                 title: 'Government Issued Id',
                 pdfUrl: data.document?.firstWhere((element) => element.document_type == 3).file ?? "",
               ),
             ),
           );
         },
       ),
       SizedBox(
         height: getSize(15),
       ),
     ],
       if(data.document?.any((element) =>element.document_type==4)??false)...[
         getDocumentsContainer(
           title: 'Professional License',
           onTap: () {
             context.router.push(
               PageRouteInfo(
                 CommonDocumentView.name,
                 args: CommonDocumentViewArgs(
                   title: 'Professional License',
                   pdfUrl: data.document?.firstWhere((element) => element.document_type == 4).file ?? "",
                 ),
               ),
             );
           },
         ),
         SizedBox(
           height: getSize(15),
         ),
       ],

        if(data.document?.any((element) =>element.document_type==5)??false)...[
          getDocumentsContainer(
            title: 'Immunizations/Vaccinations',
            onTap: () {
              context.router.push(
                PageRouteInfo(
                  CommonDocumentView.name,
                  args: CommonDocumentViewArgs(
                    title: 'Immunizations/Vaccinations',
                    pdfUrl: data.document?.firstWhere((element) => element.document_type == 5).file ?? "",
                  ),
                ),
              );
            },
          ),
          SizedBox(
            height: getSize(15),
          ),
        ],

       if(data.document?.any((element) =>element.document_type==6)??false)...[
         getDocumentsContainer(
           title: 'Covid 19 Vaccination Proof',
           onTap: () {
             context.router.push(
               PageRouteInfo(
                 CommonDocumentView.name,
                 args: CommonDocumentViewArgs(
                   title: 'Covid 19 Vaccination Proof',
                   pdfUrl: data.document?.firstWhere((element) => element.document_type == 6).file ?? "",
                 ),
               ),
             );
           },
         ),
         SizedBox(
           height: getSize(15),
         ),
       ],
        if(data.document?.any((element) =>element.document_type==7)??false)...[
          getDocumentsContainer(
            title: 'Professional Liability Protection',
            onTap: () {
              context.router.push(
                PageRouteInfo(
                  CommonDocumentView.name,
                  args: CommonDocumentViewArgs(
                    title: 'Government Issued Id',
                    pdfUrl: data.document?.firstWhere((element) => element.document_type == 7).file ?? "",
                  ),
                ),
              );
            },
          ),
          SizedBox(
            height: getSize(15),
          ),
        ],

        if(data.document?.any((element) =>element.document_type==8)??false)...[
          getDocumentsContainer(
            title: 'Resume',
            onTap: () {
              context.router.push(
                PageRouteInfo(
                  CommonDocumentView.name,
                  args: CommonDocumentViewArgs(
                    title: 'Resume',
                    pdfUrl: data.document?.firstWhere((element) => element.document_type == 8).file ?? "",
                  ),
                ),
              );
            },
          ),
          SizedBox(
            height: getSize(15),
          ),
        ],

       if(data.document?.any((element) =>element.document_type==9)??false)...[
         getDocumentsContainer(
           title: 'Apparel/Equipment',
           onTap: () {
             context.router.push(
               PageRouteInfo(
                 CommonDocumentView.name,
                 args: CommonDocumentViewArgs(
                   title: 'Government Issued Id',
                   pdfUrl: data.document?.firstWhere((element) => element.document_type == 9).file ?? "",
                 ),
               ),
             );
           },
         ),
         SizedBox(
           height: getSize(15),
         ),
       ]

      ],
    );
  }
}

getDocumentsContainer({
  required String title,
  required Function() onTap,
  String? icon,
}) {
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
          if (icon != null) ...[
            Image.asset(
              icon,
              height: getSize(18),
              width: getSize(18),
            ),
            Gap(8),
          ],
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
