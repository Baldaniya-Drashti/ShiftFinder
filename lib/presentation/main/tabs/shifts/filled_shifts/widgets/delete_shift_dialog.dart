import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shift/application/main_tab/shifts/shifts_bloc_bloc.dart';
import 'package:shift/domain/core/math_utils.dart';
import 'package:shift/injection.dart';
import 'package:shift/presentation/common/widgets/base_text.dart';
import 'package:shift/presentation/core/style/app_colors.dart';
import 'package:shift/presentation/core/widgets/buttons/common_button.dart';
import 'package:shift/presentation/core/widgets/inputs/custom_text_field.dart';

class DeleteShiftDialog extends StatelessWidget {
  const DeleteShiftDialog({super.key});

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
                        SizedBox(
                          height: getSize(30),
                        ),
                        BaseText(
                          text: 'Delete Shift',
                          fontSize: 22,
                          fontFamily: 'Aclonica',
                        ),
                        SizedBox(
                          height: getSize(10),
                        ),
                        BaseText(
                          text:
                              'Deleting this shift will incur a compensation of CAD 150 payable to the assigned contractor, plus a CAD 25 cancellation fee charged by ShiftFinder. Deleting a scheduled shift could impact your future hiring opportunities. Are you sure you want to proceed??',
                          fontSize: 14,
                          showFullDescription: true,
                          textAlign: TextAlign.center,
                          fontWeight: FontWeight.w500,
                          textColor: AppColors.black.withOpacity(0.7),
                        ),
                        SizedBox(
                          height: getSize(25),
                        ),
                        Form(
                          autovalidateMode: state.showErrorMessages ? AutovalidateMode.always : AutovalidateMode.disabled,
                          child: CustomTextField(
                            hintText: 'Type here',
                            labelText: 'Reason',
                            fillColor: AppColors.scaffoldColor,
                            maxLines: 5,
                            onChanged: (p0) => context.read<ShiftsBloc>().add(
                                  ShiftsBlocEvent.deleteReasonChange(
                                    p0,
                                  ),
                                ),
                            validator: (p0, p1) => context.read<ShiftsBloc>().state.deleteReason.value.fold(
                                  (l) => l.maybeMap(
                                    empty: (_) => 'Please enter reason',
                                    orElse: () => null,
                                  ),
                                  (r) => null,
                                ),
                          ),
                        ),
                        SizedBox(
                          height: getSize(30),
                        ),
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
                                  buttonText: 'Cancel',
                                ),
                              ),
                              SizedBox(
                                width: getSize(25),
                              ),
                              Expanded(
                                child: CommonButton(
                                  onPressed: () {
                                    context.read<ShiftsBloc>().add(ShiftsBlocEvent.withdrawShift());
                                  },
                                  buttonText: 'Delete',
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
            },
          ),
        );
      },
    );
  }
}
