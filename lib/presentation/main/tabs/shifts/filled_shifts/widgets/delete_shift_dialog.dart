import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shift/application/main_tab/shifts/shifts_bloc_bloc.dart';
import 'package:shift/domain/core/math_utils.dart';
import 'package:shift/domain/core/string_constant.dart';
import 'package:shift/injection.dart';
import 'package:shift/presentation/common/widgets/base_text.dart';
import 'package:shift/presentation/core/style/app_colors.dart';
import 'package:shift/presentation/core/widgets/buttons/common_button.dart';
import 'package:shift/presentation/core/widgets/inputs/custom_text_field.dart';

class DeleteShiftDialog extends StatelessWidget {
  final bool showCADDesc;
  final bool showDelete;
  final int postId;
  const DeleteShiftDialog(
      {super.key,
      this.showCADDesc = false,
      this.showDelete = false,
      required this.postId});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }

  deleteShiftDialog(BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) {
        return BlocProvider(
          create: (context) => getIt<ShiftsBloc>(),
          child: BlocBuilder<ShiftsBloc, ShiftsBlocState>(
            builder: (context, state) {
              if (showDelete && showCADDesc) {
                return deleteAlertDialog(context, state);
              } else if (showDelete) {
                return AlertDialog(
                  contentPadding: EdgeInsets.zero,
                  clipBehavior: Clip.none,
                  elevation: 0,
                  backgroundColor: AppColors.white,
                  insetPadding: EdgeInsets.symmetric(horizontal: getSize(17)),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(getSize(15)),
                  ),
                  content: Padding(
                    padding: EdgeInsets.symmetric(horizontal: getSize(25)),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SizedBox(height: getSize(30)),
                        BaseText(
                          text: StringConstant.deleteShift,
                          fontSize: 22,
                          fontFamily: 'Aclonica',
                        ),
                        SizedBox(height: getSize(10)),
                        BaseText(
                          text: StringConstant.notDeleteFilledShiftDesc,
                          fontSize: 14,
                          showFullDescription: true,
                          textAlign: TextAlign.center,
                          fontWeight: FontWeight.w500,
                          textColor: AppColors.black.withValues(alpha: 0.7),
                        ),
                        SizedBox(height: getSize(30)),
                        CommonButton(
                          width: getSize(285),
                          onPressed: () {
                            context.router.maybePop();
                          },
                          buttonText: StringConstant.ok,
                        ),
                        SizedBox(height: getSize(25)),
                      ],
                    ),
                  ),
                );
              } else {
                return deleteAlertDialog(context, state);
              }
            },
          ),
        );
      },
    ).then((value) {
      if (value == true) {
        context
            .read<ShiftsBloc>()
            .add(ShiftsBlocEvent.fetchFilledShiftList(refresh: true));
      }
    });
  }

  Widget deleteAlertDialog(BuildContext context, ShiftsBlocState state) {
    return AlertDialog(
      contentPadding: EdgeInsets.zero,
      clipBehavior: Clip.none,
      elevation: 0,
      backgroundColor: AppColors.white,
      insetPadding: EdgeInsets.symmetric(horizontal: getSize(17)),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(getSize(15)),
      ),
      content: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: getSize(25)),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(height: getSize(30)),
              BaseText(
                text: StringConstant.deleteShift,
                fontSize: 22,
                fontFamily: 'Aclonica',
              ),
              SizedBox(height: getSize(10)),
              BaseText(
                text: (showCADDesc)
                    ? StringConstant.deleteFilledShiftCADDesc
                    : StringConstant.deleteFilledShiftDesc,
                fontSize: 14,
                showFullDescription: true,
                textAlign: TextAlign.center,
                fontWeight: FontWeight.w500,
                textColor: AppColors.black.withValues(alpha: 0.7),
              ),
              SizedBox(height: getSize(25)),
              Form(
                autovalidateMode: state.showErrorMessages
                    ? AutovalidateMode.always
                    : AutovalidateMode.disabled,
                child: CustomTextField(
                  hintText: StringConstant.typeHere,
                  labelText: StringConstant.reason,
                  labelStyle: TextStyle(fontWeight: FontWeight.w600),
                  fillColor: AppColors.scaffoldColor,
                  maxLines: 5,
                  onChanged: (p0) => context
                      .read<ShiftsBloc>()
                      .add(ShiftsBlocEvent.deleteReasonChange(p0)),
                  validator: (p0, p1) => context
                      .read<ShiftsBloc>()
                      .state
                      .deleteReason
                      .value
                      .fold(
                        (l) => l.maybeMap(
                          empty: (_) =>
                              StringConstant.pleaseAddValidReasonToDeletePost,
                          orElse: () => null,
                        ),
                        (r) => null,
                      ),
                ),
              ),
              SizedBox(height: getSize(30)),
              Flexible(
                child: Row(
                  children: [
                    Expanded(
                      child: CommonButton(
                        backgroundColor: AppColors.white,
                        borderColor: AppColors.green,
                        buttonTextColor: AppColors.green,
                        onPressed: () {
                          context.router.maybePop();
                        },
                        buttonText: StringConstant.cancle,
                      ),
                    ),
                    SizedBox(width: getSize(25)),
                    Expanded(
                      child: CommonButton(
                        onPressed: () {
                          context.read<ShiftsBloc>().add(
                              ShiftsBlocEvent.withdrawShift(context,
                                  isCad: (showCADDesc) ? 1 : null,
                                  postId: postId));
                        },
                        buttonText: StringConstant.delete,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: getSize(25),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
