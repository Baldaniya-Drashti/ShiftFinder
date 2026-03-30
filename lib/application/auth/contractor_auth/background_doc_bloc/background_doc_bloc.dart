import 'package:auto_route/auto_route.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:shift/domain/account/account_failure.dart';
import 'package:shift/domain/account/i_account_repository.dart';
import 'package:shift/domain/auth/auth_value_objects.dart';
import 'package:shift/domain/core/string_constant.dart';
import 'package:shift/infrastructure/core/document_dto/document_dto.dart';
import 'package:shift/infrastructure/core/skill_list_model/skill_dto.dart';
import 'package:shift/presentation/common/utils/date_time_format.dart';
import 'package:shift/presentation/common/utils/flushbar_creator.dart';
import 'package:shift/presentation/core/app_router.gr.dart';
import 'package:shift/presentation/core/common_lisitng/common_listing.dart';

part 'background_doc_event.dart';
part 'background_doc_state.dart';
part 'background_doc_bloc.freezed.dart';

@injectable
class BackgroundDocBloc extends Bloc<BackgroundDocEvent, BackgroundDocState> {
  final IAccountRepository _repository;
  BackgroundDocBloc(this._repository) : super(BackgroundDocState.initial()) {
    on<BackgroundDocEvent>((event, emit) async {
      await event.map(
        backgroundDocIssueDateChanged: (e) {
          emit(
            state.copyWith(
              bgDocIssueDate: e.expiryDate,
              bgDocFailureOrSuccessOption: none(),
            ),
          );
        },
        getBGProofDoc: (e) async {
          Either<AccountFailure, List<DocumentDTO>>? failureOrSuccess;
          emit(
            state.copyWith(
              isLoading: true,
              currentBgDocType: SkillDTO(),
              showErrorMesages: false,
              bgDocFailureOrSuccessOption: none(),
            ),
          );
          failureOrSuccess =
              await _repository.getStripeDocumentApi(documentType: 3);
          failureOrSuccess.fold(
            (l) => emit(
              state.copyWith(
                isLoading: false,
                currentBgDocType: SkillDTO(),
                bgDocFrontDoc: InputEmptyOrNot(""),
                bgDocBackDoc: InputEmptyOrNot(""),
                bgDocIssueDate: "",
              ),
            ),
            (r) {
              if (r.isNotEmpty) {
                return emit(
                  state.copyWith(
                    isLoading: false,
                    existingBgDoc: r[0],
                    currentBgDocType: CommonList.addressProofList.firstWhere(
                      (skill) => skill.id == r[0].sub_type,
                      orElse: () => SkillDTO(),
                    ),
                    bgDocId: (r[0].id != null) ? r[0].id! : -1,
                    bgDocFrontDoc: InputEmptyOrNot(r[0].file ?? ""),
                    bgDocBackDoc: InputEmptyOrNot(r[0].back_file ?? ""),
                    bgDocIssueDate: (r[0].expiry_date != null)
                        ? CustomDateTimeFormat.timeStampToDateTime(
                                r[0].expiry_date ?? -1)
                            .toIso8601String()
                        : "",
                  ),
                );
              } else {
                return emit(
                  state.copyWith(
                    isLoading: false,
                    currentBgDocType: SkillDTO(),
                    bgDocId: -1,
                    bgDocFrontDoc: InputEmptyOrNot(""),
                    bgDocBackDoc: InputEmptyOrNot(""),
                    bgDocIssueDate: "",
                  ),
                );
              }
            },
          );
        },

        selectBGFrontDoc: (e) {
          emit(
            state.copyWith(
              bgDocFrontDoc: InputEmptyOrNot(e.frontDoc),
              bgDocIssueDate: "",
              isSubmitting: false,
              showErrorMesages: false,
              bgDocFailureOrSuccessOption: none(),
            ),
          );
        },
        selectBGBackDoc: (e) {
          emit(
            state.copyWith(
              bgDocBackDoc: InputEmptyOrNot(e.backDoc),
              bgDocIssueDate: "",
              isSubmitting: false,
              showErrorMesages: false,
              bgDocFailureOrSuccessOption: none(),
            ),
          );
        },

        deleteBGFrontDoc: (e) {
          emit(
            state.copyWith(
              bgDocFrontDoc: InputEmptyOrNot(""),
              isSubmitting: false,
              bgDocFailureOrSuccessOption: none(),
            ),
          );
        },
        deleteBGBackDoc: (e) {
          emit(
            state.copyWith(
              bgDocBackDoc: InputEmptyOrNot(""),
              isSubmitting: false,
              bgDocFailureOrSuccessOption: none(),
            ),
          );
        },
        bgProofSubmit: (e) async {
          Either<AccountFailure, String>? failureOrSuccess;

          final isGovernmentFrontDocValid = state.bgDocFrontDoc.isValid();
          final isGovernmentBackDocValid = state.bgDocBackDoc.isValid();

          if (isGovernmentFrontDocValid &&
              isGovernmentBackDocValid &&
              state.bgDocIssueDate.isNotEmpty) {
            print("All details are valid!!");

            emit(
              state.copyWith(
                isSubmitting: true,
                bgDocFailureOrSuccessOption: none(),
              ),
            );

            failureOrSuccess = await _repository.addAddressProofApi(
              documentType: 3,
              documentFile: state.bgDocFrontDoc.getValue() ?? "",
              documentBackFile: state.bgDocBackDoc.getValue() ?? "",
              expiryDate: state.bgDocIssueDate,
              lastPage: "ProofOfLegalStatus",
            );

            failureOrSuccess.fold(
              (failure) {
                showError(
                  message: failure.maybeMap(
                    showAPIResponseMessage: (value) => value.message,
                    networkError: (value) =>
                        'Please check your internet connectivity',
                    orElse: () => StringConstant.somethingWentWrong,
                  ),
                ).show(e.context);
                emit(
                  state.copyWith(
                    isSubmitting: false,
                  ),
                );
              },
              (success) {
                e.context.router.push(PageRouteInfo(ProofOfLegalStatus.name,
                    args: ProofOfLegalStatusArgs(
                      isUpdate: e.isUpdate,
                    )));
              },
            );

            emit(
              state.copyWith(
                isLoading: false,
                isSubmitting: false,
                bgDocFailureOrSuccessOption: optionOf(failureOrSuccess),
              ),
            );
          } else {
            showError(
                    message: StringConstant
                        .someDetailsAreMissingOrInvalidPleaseCheck)
                .show(e.context);
            emit(
              state.copyWith(
                isSubmitting: false,
                showErrorMesages: true,
                bgDocFailureOrSuccessOption: none(),
              ),
            );
          }
        },

        /// >>>>--New changes--<<<<<
        selectBGProofType: (e) async {
          if (state.currentBgDocType != e.selectedType) {
            emit(state.copyWith(
              isLoading: true,
              showErrorMesages: false,
            ));
            await Future.delayed(Duration(seconds: 1));
            if (e.selectedType.id == state.existingBgDoc.sub_type) {
              emit(state.copyWith(
                isLoading: false,
                currentBgDocType: e.selectedType,
                bgDocId: state.existingBgDoc.id ?? -1,
                bgDocFrontDoc: InputEmptyOrNot(state.existingBgDoc.file ?? ""),
                bgDocBackDoc:
                    InputEmptyOrNot(state.existingBgDoc.back_file ?? ""),
                bgDocIssueDate: (state.existingBgDoc.expiry_date != null)
                    ? CustomDateTimeFormat.timeStampToDateTime(
                        state.existingBgDoc.expiry_date ?? -1,
                      ).toIso8601String()
                    : "",
                showErrorMesages: false,
              ));
            } else {
              emit(state.copyWith(
                isLoading: false,
                currentBgDocType: e.selectedType,
                bgDocFrontDoc: InputEmptyOrNot(""),
                bgDocBackDoc: InputEmptyOrNot(""),
                bgDocIssueDate: "",
                showErrorMesages: false,
              ));
            }
          }
        },
      );
    });
  }
}
