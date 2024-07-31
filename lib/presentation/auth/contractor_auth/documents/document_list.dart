import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shift/application/auth/contractor_auth/document_bloc/document_bloc.dart';
import 'package:shift/domain/core/math_utils.dart';
import 'package:shift/domain/core/svg_image_constants.dart';
import 'package:shift/presentation/common/utils/get_cookie.dart';
import 'package:shift/presentation/common/widgets/base_text.dart';
import 'package:shift/presentation/core/style/app_colors.dart';

class DocumentList extends StatefulWidget {
  const DocumentList({super.key});

  @override
  State<DocumentList> createState() => _DocumentListState();
}

class _DocumentListState extends State<DocumentList> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DocumentBloc, DocumentState>(
      builder: (context, state) {
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: getSize(20)),
          child: Column(
            children: [
              documentImage(),
              Expanded(
                child: ListView.builder(
                    itemCount: DocumentBloc.documentList.length,
                    padding: EdgeInsets.symmetric(vertical: getSize(20)),
                    itemBuilder: (context, index) {
                      final list = DocumentBloc.documentList;
                      return Padding(
                        padding: EdgeInsets.symmetric(
                          vertical: getSize(10),
                        ),
                        child: GestureDetector(
                          onTap: () async {
                            // if (index != 0 &&
                            //     DocumentBloc.isDocSubmit(
                            //         state.allDocumentList, 0)) {
                            //   DocumentBloc.pageController.animateToPage(
                            //     (index + 1),
                            //     duration: const Duration(milliseconds: 1),
                            //     curve: Curves.easeInOut,
                            //   );
                            // } else if (index == 0) {
                            //   DocumentBloc.pageController.animateToPage(
                            //     (index + 1),
                            //     duration: const Duration(milliseconds: 1),
                            //     curve: Curves.easeInOut,
                            //   );
                            // } else {
                            //   showError(
                            //     message:
                            //         StringConstant.pleaseAddGovernmentIssuedId,
                            //   ).show(context);
                            // }

                            DocumentBloc.pageController.animateToPage(
                              (index + 1),
                              duration: const Duration(milliseconds: 1),
                              curve: Curves.easeInOut,
                            );
                          },
                          child: ListTile(
                            tileColor: AppColors.white,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                            title: BaseText(
                              text: list[index],
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                            trailing: (DocumentBloc.isDocSubmit(
                                    state.allDocumentList, index))
                                ? SvgPicture.asset(
                                    SvgImageConstant.checkedArrow,
                                  )
                                : null,
                          ),
                        ),
                      );
                    }),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget documentImage() {
    return Container(
      padding: EdgeInsets.symmetric(
          vertical: getSize(20), horizontal: getSize(36.025)),
      decoration: BoxDecoration(
          color: AppColors.grey.withOpacity(0.4),
          borderRadius: BorderRadius.circular(10)),
      child: Row(
        children: [
          SvgPicture.asset(
            SvgImageConstant.clockWithVerticalLine,
            height: getSize(63),
            width: getSize(57.95),
          ),
          SizedBox(
            width: getSize(15),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              BaseText(
                text:
                    "Hello,✋ ${getCurrentUser().firstName} ${getCurrentUser().lastName}",
                fontSize: 14,
                fontWeight: FontWeight.w600,
                lineHeight: 1.5,
              ),
              const BaseText(
                text:
                    "Please upload the documents listed\nbelow, Govt issue Id is compulsory. ",
                fontSize: 10,
                fontWeight: FontWeight.w400,
                maxLines: 2,
              ),
            ],
          )
        ],
      ),
    );
  }
}
