import 'package:auto_route/auto_route.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:shift/domain/core/math_utils.dart';
import 'package:shift/domain/core/png_image_constants.dart';
import 'package:shift/domain/core/string_constant.dart';
import 'package:shift/domain/core/svg_image_constants.dart';
import 'package:shift/domain/main/i_main_facade.dart';
import 'package:shift/domain/main/main_failure.dart';
import 'package:shift/infrastructure/core/employer_proposal_dto/employer_proposal_dto.dart';
import 'package:shift/infrastructure/core/network/common_response.dart';
import 'package:shift/infrastructure/core/skill_list_model/skill_dto.dart';
import 'package:shift/presentation/common/utils/flushbar_creator.dart';
import 'package:shift/presentation/common/widgets/base_text.dart';
import 'package:shift/presentation/core/style/app_colors.dart';
import 'package:shift/presentation/core/widgets/buttons/common_button.dart';

part 'proposal_detail_event.dart';
part 'proposal_detail_state.dart';
part 'proposal_detail_bloc.freezed.dart';

@injectable
class ProposalDetailBloc
    extends Bloc<ProposalDetailEvent, ProposalDetailState> {
  final IMainFacade _mainFacade;

  ProposalDetailBloc(this._mainFacade) : super(ProposalDetailState.initial()) {
    on<ProposalDetailEvent>((event, emit) async {
      await event.map(
        isCheckAvailability: (e) {
          if (state.isConfirmProposalDate == true) {
            emit(state.copyWith(
              isConfirmError: false,
            ));
            Navigator.pop(e.context, state.isConfirmProposalDate);
          } else {
            emit(state.copyWith(
              isConfirmError: true,
            ));
          }
        },
        checkConfirmAvailability: (e) {
          emit(state.copyWith(
            isConfirmProposalDate: e.isCheck,
          ));
        },
        getProposalDetail: (value) async {
          Either<MainFailure, CommonResponse> failureOrSuccess;
          emit(state.copyWith(isLoading: true));
          failureOrSuccess = await _mainFacade.getProposalDetail(
              userId: value.userId, postId: value.postId);
          emit(state.copyWith(isLoading: false));

          failureOrSuccess.fold(
            (l) {
              showError(
                message: l.maybeMap(
                  showAPIResponseMessage: (value) => value.message,
                  networkError: (value) =>
                      'Please check your internet connectivity',
                  orElse: () => "Server Error. Try again later.",
                ),
              ).show(value.context);
              emit(state.copyWith(isErrorInAPI: true, isLoading: false));
            },
            (r) {
              final data = EmployerProposalDto.fromJson(r.data);
              emit(
                state.copyWith(proposalDetailDto: data),
              );
            },
          );
        },
        proposalAcceptReject: (ProposalAcceptReject value) async {
          Either<MainFailure, CommonResponse> failureOrSuccess;
          emit(state.copyWith(postDataLoading: true));
          failureOrSuccess = await _mainFacade.proposalAcceptReject(
              id: value.id, request: value.request);
          emit(state.copyWith(postDataLoading: false));
          failureOrSuccess.fold(
            (l) {
              showError(
                message: l.maybeMap(
                  showAPIResponseMessage: (value) => value.message,
                  networkError: (value) =>
                      'Please check your internet connectivity',
                  orElse: () => "Server Error. Try again later.",
                ),
              ).show(value.context);
              emit(state.copyWith(isErrorInAPI: true, isLoading: false));
            },
            (r) async {
              if (value.request == 2) {
                value.context.maybePop(true);
                return;
              }
              final result = await showDialog<bool?>(
                context: value.context,
                barrierDismissible: false,
                builder: (context) => AlertDialog(
                  clipBehavior: Clip.none,
                  insetPadding: EdgeInsets.symmetric(horizontal: getSize(20)),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(getSize(15)),
                  ),
                  titlePadding: EdgeInsets.zero,
                  title: Column(
                    children: [
                      Stack(
                        clipBehavior: Clip.none,
                        alignment: Alignment.center,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(getSize(15)),
                            child: Image.asset(
                                PngImageConstants.curvedBackgroundImage),
                          ),
                          Positioned(
                            top: getSize(85),
                            child: SvgPicture.asset(
                              SvgImageConstant.awaitingConfirmation,
                              height: getSize(107),
                              width: getSize(107),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: getSize(90)),
                      BaseText(
                        text: StringConstant.awaitingConfirmation,
                        fontSize: 22,
                        fontFamily: 'Aclonica',
                      ),
                    ],
                  ),
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(
                        height: getSize(10),
                      ),
                      BaseText(
                        text:
                            "Proposal accepted, Contractor\nnotified for Confirmation.",
                        fontSize: 14,
                        textAlign: TextAlign.center,
                        fontWeight: FontWeight.w500,
                        textColor: AppColors.black.withValues(alpha: 0.7),
                      ),
                    ],
                  ),
                  actionsAlignment: MainAxisAlignment.center,
                  actions: [
                    CommonButton(
                      height: 46,
                      width: 200,
                      onPressed: () => context.maybePop(true),
                      buttonText: "Ok",
                    ),
                  ],
                ),
              );

              if (result ?? false) {
                value.context.maybePop(true);
              }
            },
          );
        },
        addConfirmDialogFlag: (AddConfirmDialogFlag value) {
          emit(state.copyWith(confirmDialog: value.flag));
        },
        getHoursList: (GetHoursList value) async {
          final hoursList = await _mainFacade.getAccomdationHoursListApi();
          hoursList.fold(
            (l) => emit(
              state.copyWith(
                hoursList: [],
              ),
            ),
            (r) {
              print("Hours List ---> $hoursList");
              return emit(
                state.copyWith(
                  hoursList: r,
                ),
              );
            },
          );
        },
      );
    });
  }
}
