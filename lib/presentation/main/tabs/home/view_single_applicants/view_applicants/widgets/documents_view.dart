import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:shift/domain/core/math_utils.dart';
import 'package:shift/domain/core/string_constant.dart';
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
          text: StringConstant.documentsUploadedTapToView,
          fontSize: 10,
          fontWeight: FontWeight.w600,
          textColor: Colors.black.withValues(alpha: 0.8),
        ),
        SizedBox(height: getSize(8)),
        if (data.document?.any((element) => element.document_type == 1) ??
            false) ...[
          getDocumentsContainer(
            title: StringConstant.governmentIssuedId,
            onTap: () {
              context.router.push(
                PageRouteInfo(
                  CommonDocumentView.name,
                  args: CommonDocumentViewArgs(
                    title: StringConstant.governmentIssuedId,
                    documentList: data.document
                            ?.where((element) => element.document_type == 1)
                            .toList() ??
                        [],
                    frontPage: data.document
                            ?.firstWhere(
                                (element) => element.document_type == 1)
                            .file ??
                        "",
                    backPage: data.document
                            ?.firstWhere(
                                (element) => element.document_type == 1)
                            .back_file ??
                        "",
                  ),
                ),
              );
            },
          ),
          SizedBox(height: getSize(15)),
        ],
        if (data.document?.any((element) => element.document_type == 2) ??
            false) ...[
          getDocumentsContainer(
            title: StringConstant.covid19VaccinationProof,
            onTap: () {
              context.router.push(
                PageRouteInfo(
                  CommonDocumentView.name,
                  args: CommonDocumentViewArgs(
                    title: StringConstant.covid19VaccinationProof,
                    documentList: data.document
                            ?.where((element) => element.document_type == 2)
                            .toList() ??
                        [],
                    frontPage: data.document
                            ?.firstWhere(
                                (element) => element.document_type == 2)
                            .file ??
                        "",
                    backPage: data.document
                            ?.firstWhere(
                                (element) => element.document_type == 2)
                            .back_file ??
                        "",
                  ),
                ),
              );
            },
          ),
          SizedBox(height: getSize(15)),
        ],
        if (data.document?.any((element) => element.document_type == 3) ??
            false) ...[
          getDocumentsContainer(
            title: StringConstant.credentialsRegistrations,
            onTap: () {
              context.router.push(
                PageRouteInfo(
                  CommonDocumentView.name,
                  args: CommonDocumentViewArgs(
                    title: StringConstant.credentialsRegistrations,
                    documentList: data.document
                            ?.where((element) => element.document_type == 3)
                            .toList() ??
                        [],
                    frontPage: data.document
                            ?.firstWhere(
                                (element) => element.document_type == 3)
                            .file ??
                        "",
                    backPage: data.document
                            ?.firstWhere(
                                (element) => element.document_type == 3)
                            .back_file ??
                        "",
                  ),
                ),
              );
            },
          ),
          SizedBox(
            height: getSize(15),
          ),
        ],
        if (data.document?.any((element) => element.document_type == 4) ??
            false) ...[
          getDocumentsContainer(
            title: StringConstant.professionalLicenses,
            onTap: () {
              context.router.push(
                PageRouteInfo(
                  CommonDocumentView.name,
                  args: CommonDocumentViewArgs(
                    title: StringConstant.professionalLicenses,
                    documentList: data.document
                            ?.where((element) => element.document_type == 4)
                            .toList() ??
                        [],
                    frontPage: data.document
                            ?.firstWhere(
                                (element) => element.document_type == 4)
                            .file ??
                        "",
                    backPage: data.document
                            ?.firstWhere(
                                (element) => element.document_type == 4)
                            .back_file ??
                        "",
                  ),
                ),
              );
            },
          ),
          SizedBox(
            height: getSize(15),
          ),
        ],
        if (data.document?.any((element) => element.document_type == 5) ??
            false) ...[
          getDocumentsContainer(
            title: StringConstant.immunizationsVaccinations,
            onTap: () {
              context.router.push(
                PageRouteInfo(
                  CommonDocumentView.name,
                  args: CommonDocumentViewArgs(
                    title: StringConstant.immunizationsVaccinations,
                    documentList: data.document
                            ?.where((element) => element.document_type == 5)
                            .toList() ??
                        [],
                    frontPage: data.document
                            ?.firstWhere(
                                (element) => element.document_type == 5)
                            .file ??
                        "",
                    backPage: data.document
                            ?.firstWhere(
                                (element) => element.document_type == 5)
                            .back_file ??
                        "",
                  ),
                ),
              );
            },
          ),
          SizedBox(
            height: getSize(15),
          ),
        ],
        if (data.document?.any((element) => element.document_type == 6) ??
            false) ...[
          getDocumentsContainer(
            title: StringConstant.professionalLiabilityProtection,
            onTap: () {
              context.router.push(
                PageRouteInfo(
                  CommonDocumentView.name,
                  args: CommonDocumentViewArgs(
                    title: StringConstant.professionalLiabilityProtection,
                    documentList: data.document
                            ?.where((element) => element.document_type == 6)
                            .toList() ??
                        [],
                    frontPage: data.document
                            ?.firstWhere(
                                (element) => element.document_type == 6)
                            .file ??
                        "",
                    backPage: data.document
                            ?.firstWhere(
                                (element) => element.document_type == 6)
                            .back_file ??
                        "",
                  ),
                ),
              );
            },
          ),
          SizedBox(height: getSize(15)),
        ],
        if (data.document?.any((element) => element.document_type == 7) ??
            false) ...[
          getDocumentsContainer(
            title: StringConstant.resume,
            onTap: () {
              context.router.push(
                PageRouteInfo(
                  CommonDocumentView.name,
                  args: CommonDocumentViewArgs(
                    title: StringConstant.resume,
                    documentList: data.document
                            ?.where((element) => element.document_type == 7)
                            .toList() ??
                        [],
                    frontPage: data.document
                            ?.firstWhere(
                                (element) => element.document_type == 7)
                            .file ??
                        "",
                    backPage: data.document
                            ?.firstWhere(
                                (element) => element.document_type == 7)
                            .back_file ??
                        "",
                  ),
                ),
              );
            },
          ),
          SizedBox(height: getSize(15)),
        ],
        if (data.document?.any((element) => element.document_type == 8) ??
            false) ...[
          getDocumentsContainer(
            title: StringConstant.apparelEquipment,
            onTap: () {
              context.router.push(
                PageRouteInfo(
                  CommonDocumentView.name,
                  args: CommonDocumentViewArgs(
                    title: StringConstant.apparelEquipment,
                    documentList: data.document
                            ?.where((element) => element.document_type == 8)
                            .toList() ??
                        [],
                    frontPage: data.document
                            ?.firstWhere(
                                (element) => element.document_type == 8)
                            .file ??
                        "",
                    backPage: data.document
                            ?.firstWhere(
                                (element) => element.document_type == 8)
                            .back_file ??
                        "",
                  ),
                ),
              );
            },
          ),
          SizedBox(height: getSize(15)),
        ],
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
