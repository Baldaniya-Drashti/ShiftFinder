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
import 'package:shift/presentation/common/utils/flushbar_creator.dart';
import 'package:shift/presentation/core/app_router.gr.dart';
import 'package:shift/presentation/core/common_lisitng/common_listing.dart';

part 'proof_of_legal_status_event.dart';
part 'proof_of_legal_status_state.dart';
part 'proof_of_legal_status_bloc.freezed.dart';

@injectable
class ProofOfLegalStatusBloc
    extends Bloc<ProofOfLegalStatusEvent, ProofOfLegalStatusState> {
  final IAccountRepository _repository;
  ProofOfLegalStatusBloc(this._repository)
      : super(ProofOfLegalStatusState.initial()) {
    on<ProofOfLegalStatusEvent>((event, emit) async {
      await event.map(
        expiryDateChanged: (e) {
          final isValid = validateExpiryDate(
            expiryDate: e.expiryDate,
            yearLimit: state.currentProofType.yearLimit ?? "",
          );
          if (isValid) {
            emit(
              state.copyWith(
                docExpiryDate: e.expiryDate,
                isExpiryInValid: false,
                proofFailureOrSuccessOption: none(),
              ),
            );
          } else {
            emit(
              state.copyWith(
                docExpiryDate: "",
                isExpiryInValid: true,
                proofFailureOrSuccessOption: none(),
              ),
            );
          }
        },

        getProofLegalDoc: (e) async {
          Either<AccountFailure, List<DocumentDTO>>? failureOrSuccess;
          emit(
            state.copyWith(
              isLoading: true,
              currentProofType: SkillDTO(),
              showErrorMesages: false,
              proofFailureOrSuccessOption: none(),
            ),
          );
          failureOrSuccess =
              await _repository.getStripeDocumentApi(documentType: 4);
          failureOrSuccess.fold(
            (l) => emit(
              state.copyWith(
                isLoading: false,
                currentProofType: SkillDTO(),
                proofFrontDoc: InputEmptyOrNot(""),
                proofBackDoc: InputEmptyOrNot(""),
                docExpiryDate: "",
              ),
            ),
            (r) {
              if (r.isNotEmpty) {
                return emit(
                  state.copyWith(
                    isLoading: false,
                    existingProofDoc: r[0],
                    currentProofType: CommonList.proofLegalWorkList.firstWhere(
                      (skill) => skill.id == r[0].sub_type,
                      orElse: () => SkillDTO(),
                    ),
                    selectedDocId: (r[0].id != null) ? r[0].id! : -1,
                    proofFrontDoc: InputEmptyOrNot(r[0].file ?? ""),
                    proofBackDoc: InputEmptyOrNot(r[0].back_file ?? ""),
                    docExpiryDate: (r[0].expiry_date != null)
                        ? DateTime.fromMillisecondsSinceEpoch(
                            (r[0].expiry_date ?? -1) * 1000,
                          ).toIso8601String()
                        : "",
                  ),
                );
              } else {
                return emit(
                  state.copyWith(
                    isLoading: false,
                    currentProofType: SkillDTO(),
                    selectedDocId: -1,
                    proofFrontDoc: InputEmptyOrNot(""),
                    proofBackDoc: InputEmptyOrNot(""),
                    docExpiryDate: "",
                  ),
                );
              }
            },
          );
        },

        selectFrontDoc: (e) {
          emit(
            state.copyWith(
              proofFrontDoc: InputEmptyOrNot(e.frontDoc),
              docExpiryDate: "",
              isSubmitting: false,
              showErrorMesages: false,
              proofFailureOrSuccessOption: none(),
            ),
          );
        },
        selectBackDoc: (e) {
          emit(
            state.copyWith(
              proofBackDoc: InputEmptyOrNot(e.backDoc),
              docExpiryDate: "",
              isSubmitting: false,
              showErrorMesages: false,
              proofFailureOrSuccessOption: none(),
            ),
          );
        },

        deleteFrontDoc: (e) {
          emit(
            state.copyWith(
              proofFrontDoc: InputEmptyOrNot(""),
              isSubmitting: false,
              proofFailureOrSuccessOption: none(),
            ),
          );
        },
        deleteBackDoc: (e) {
          emit(
            state.copyWith(
              proofBackDoc: InputEmptyOrNot(""),
              isSubmitting: false,
              proofFailureOrSuccessOption: none(),
            ),
          );
        },
        proofLegalDocSubmit: (e) async {
          Either<AccountFailure, String>? failureOrSuccess;

          final isFronDocValid = state.proofFrontDoc.isValid();
          final isBackDocValid = state.proofBackDoc.isValid();

          print("DOC IS VALID--> ${state.proofBackDoc}");
          print("DOC ID--> ${state.selectedDocId}");

          if (isFronDocValid && isBackDocValid) {
            final isExpiryDateMandatory =
                (state.currentProofType.isMandatory ?? false);

            if (isExpiryDateMandatory && state.docExpiryDate.isEmpty) {
              showError(
                      message: StringConstant
                          .someDetailsAreMissingOrInvalidPleaseCheck)
                  .show(e.context);
              emit(
                state.copyWith(
                  isSubmitting: false,
                  showErrorMesages: true,
                  proofFailureOrSuccessOption: none(),
                ),
              );
              return;
            }
            print("All Details are valid!");

            emit(
              state.copyWith(
                isSubmitting: true,
                proofFailureOrSuccessOption: none(),
              ),
            );

            /* if (state.selectedDocId != -1) {
              /*  failureOrSuccess = await _repository.updateDocumentApi(
                id: state.selectedDocId,
                documentType: 1,
                subType: state.currentProofType.id,
                documentTitle: state.currentProofType.name ?? "",
                documentFile: state.proofFrontDoc.getValue() ?? "",
                documentBackFile: state.proofBackDoc.getValue() ?? "",
                expiryDate: state.docExpiryDate,
              ); */
            } else {
              failureOrSuccess = await _repository.addAddressProofApi(
                documentType: 4,
                subType: state.currentProofType.id,
                documentFile: state.proofFrontDoc.getValue() ?? "",
                documentBackFile: state.proofBackDoc.getValue() ?? "",
                expiryDate: state.docExpiryDate,
                lastPage: "BankDetail",
              );
            } */
            failureOrSuccess = await _repository.addAddressProofApi(
              documentType: 4,
              subType: state.currentProofType.id,
              documentFile: state.proofFrontDoc.getValue() ?? "",
              documentBackFile: state.proofBackDoc.getValue() ?? "",
              expiryDate: state.docExpiryDate,
              lastPage: "BankDetail",
            );

            failureOrSuccess.fold(
              (failure) {
                showError(
                  message: failure.maybeMap(
                    showAPIResponseMessage: (value) => value.message,
                    networkError: (value) =>
                        'Please check your internet connectivity',
                    orElse: () => "Something went wrong!",
                  ),
                ).show(e.context);
                emit(
                  state.copyWith(isSubmitting: false),
                );
              },
              (success) {
                if (e.isUpdate) {
                  e.context.router.popUntil((route) {
                    if (route.settings.name ==
                        ContractorUpdateProfileView.name) {
                      return true;
                    } else {
                      return false;
                    }
                  });
                } else {
                  e.context.router
                      .push(PageRouteInfo(AddBankDetailsScreen.name));
                }
              },
            );

            emit(
              state.copyWith(
                isLoading: false,
                isSubmitting: false,
                proofFailureOrSuccessOption: optionOf(failureOrSuccess),
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
                proofFailureOrSuccessOption: none(),
              ),
            );
          }
        },

        /// >>>>--New changes--<<<<<
        selectAddressProofType: (e) async {
          if (state.currentProofType != e.selectedType) {
            emit(state.copyWith(
              isLoading: true,
              showErrorMesages: false,
            ));
            await Future.delayed(Duration(seconds: 1));
            if (e.selectedType.id == state.existingProofDoc.sub_type) {
              emit(state.copyWith(
                isLoading: false,
                currentProofType: e.selectedType,
                selectedDocId: state.existingProofDoc.id ?? -1,
                proofFrontDoc:
                    InputEmptyOrNot(state.existingProofDoc.file ?? ""),
                proofBackDoc:
                    InputEmptyOrNot(state.existingProofDoc.back_file ?? ""),
                docExpiryDate: (state.existingProofDoc.expiry_date != null)
                    ? DateTime.fromMillisecondsSinceEpoch(
                        (state.existingProofDoc.expiry_date ?? -1) * 1000,
                      ).toIso8601String()
                    : "",
                showErrorMesages: false,
              ));
            } else {
              emit(state.copyWith(
                isLoading: false,
                currentProofType: e.selectedType,
                proofFrontDoc: InputEmptyOrNot(""),
                proofBackDoc: InputEmptyOrNot(""),
                docExpiryDate: "",
                showErrorMesages: false,
              ));
            }
          }
        },
      );
    });
  }
  bool validateExpiryDate(
      {required String yearLimit, required String expiryDate}) {
    final date = DateTime.parse(expiryDate);
    if (yearLimit.isEmpty) return true;

    List<int> yearLimits =
        yearLimit.split(',').map((e) => int.tryParse(e) ?? 0).toList();

    int minYearLimit =
        yearLimits.isNotEmpty ? yearLimits.reduce((a, b) => a < b ? a : b) : 0;

    DateTime maxAllowedDate =
        DateTime.now().add(Duration(days: minYearLimit * 365));

    return date.isBefore(maxAllowedDate) ||
        date.isAtSameMomentAs(maxAllowedDate);
  }
}
