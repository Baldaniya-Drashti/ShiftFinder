// ignore_for_file: avoid_print

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shift/application/auth/contractor_auth/document_bloc/document_bloc.dart';
import 'package:shift/domain/core/math_utils.dart';
import 'package:shift/domain/core/string_constant.dart';
import 'package:shift/domain/core/svg_image_constants.dart';
import 'package:shift/presentation/common/utils/flushbar_creator.dart';
import 'package:shift/presentation/common/utils/get_cookie.dart';
import 'package:shift/presentation/common/widgets/base_text.dart';
import 'package:shift/presentation/core/app_router.gr.dart';
import 'package:shift/presentation/core/style/app_colors.dart';
import 'package:shift/presentation/core/widgets/buttons/common_button.dart';

class DocumentList extends StatefulWidget {
  final bool isUpdate;
  const DocumentList({super.key, this.isUpdate = false});

  @override
  State<DocumentList> createState() => _DocumentListState();
}

class _DocumentListState extends State<DocumentList> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<DocumentBloc, DocumentState>(
      listener: (context, state) {
        state.continueFailureOrSuccessOption.fold(
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
            (r) {
              context.router
                  .push(
                const PageRouteInfo(AddressProofScreen.name),
              )
                  .then((value) {
                if (context.mounted) {
                  context
                      .read<DocumentBloc>()
                      .add(const DocumentEvent.getAllDocumentStatus());
                }
              });
            },
          ),
        );
      },
      builder: (context, state) {
        return SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: getSize(20)),
            child: Column(
              children: [
                documentImage(),
                ListView.builder(
                    itemCount: DocumentBloc.documentList.length,
                    padding: EdgeInsets.symmetric(vertical: getSize(20)),
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
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
                if (!widget.isUpdate)
                  Padding(
                    padding:
                        EdgeInsets.only(top: getSize(10), bottom: getSize(50)),
                    child: CommonButton(
                      isSubmitting: state.isSubmitting,
                      onPressed: () {
                        context
                            .read<DocumentBloc>()
                            .add(const DocumentEvent.submitDocumentsEvent());
                      },
                      buttonText: StringConstant.txtContinue,
                    ),
                  ),
              ],
            ),
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
          color: AppColors.grey04, borderRadius: BorderRadius.circular(10)),
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
                text: StringConstant
                    .pleaseUploadTheDocumentsListedBelowGovtIssuedIdIsCompulsory,
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
