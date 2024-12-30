import 'package:auto_route/auto_route.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import 'package:shift/domain/account/account_failure.dart';
import 'package:shift/domain/account/i_account_repository.dart';
import 'package:shift/domain/auth/auth_value_objects.dart';
import 'package:shift/infrastructure/core/document_dto/document_dto.dart';
import 'package:shift/infrastructure/core/skill_list_model/skill_dto.dart';
import 'package:shift/presentation/common/utils/flushbar_creator.dart';
import 'package:shift/presentation/core/app_router.gr.dart';
import 'package:shift/presentation/core/common_lisitng/common_listing.dart';

part 'address_proof_event.dart';
part 'address_proof_state.dart';
part 'address_proof_bloc.freezed.dart';

@injectable
class AddressProofBloc extends Bloc<AddressProofEvent, AddressProofState> {
  final IAccountRepository _repository;
  AddressProofBloc(this._repository) : super(AddressProofState.initial()) {
    on<AddressProofEvent>((event, emit) async {
      await event.map(
        expiryDateChanged: (e) {
          final isValid = validateExpiryDate(
            expiryDate: e.expiryDate,
            yearLimit: state.currentAddressProofType.yearLimit ?? "",
          );
          if (isValid) {
            emit(
              state.copyWith(
                docExpiryDate: e.expiryDate,
                isExpiryInValid: false,
                addressProofFailureOrSuccessOption: none(),
              ),
            );
          } else {
            emit(
              state.copyWith(
                docExpiryDate: "",
                isExpiryInValid: true,
                addressProofFailureOrSuccessOption: none(),
              ),
            );
          }
        },
        getAddressProof: (e) async {
          Either<AccountFailure, List<DocumentDTO>>? failureOrSuccess;
          emit(
            state.copyWith(
              isLoading: true,
              currentAddressProofType: SkillDTO(),
              showErrorMesages: false,
              addressProofFailureOrSuccessOption: none(),
            ),
          );
          failureOrSuccess = await _repository.getDocumentApi(documentType: 1);
          failureOrSuccess.fold(
            (l) => emit(
              state.copyWith(
                isLoading: false,
                currentAddressProofType: SkillDTO(),
                addressproofFrontDoc: InputEmptyOrNot(""),
                addressProofBackDoc: InputEmptyOrNot(""),
                // governmentExpiryDate: "",
                // isGovernemtExpiryCheck: false,
              ),
            ),
            (r) {
              if (r.isNotEmpty) {
                print("ExpiryDate--> ${r}");
                return emit(
                  state.copyWith(
                    isLoading: false,
                    existingAddressProof: r[0],
                    currentAddressProofType:
                        CommonList.addressProofList.firstWhere(
                      (skill) => skill.id == r[0].sub_type,
                      orElse: () => SkillDTO(),
                    ),
                    addressProofDocId: (r[0].id != null) ? r[0].id! : -1,
                    addressproofFrontDoc: InputEmptyOrNot(r[0].file ?? ""),
                    addressProofBackDoc: InputEmptyOrNot(r[0].back_file ?? ""),

                    /* governmentExpiryDate: (r[0].expiry_date != null)? DateTime.fromMillisecondsSinceEpoch((r[0].expiry_date ?? -1) * 1000,).toIso8601String(): "",
                    isGovernemtExpiryCheck:(r[0].expiry_date_not_applicable == 0) ? false : true, */
                  ),
                );
              } else {
                return emit(
                  state.copyWith(
                    isLoading: false,
                    currentAddressProofType: SkillDTO(),
                    addressProofDocId: -1,
                    addressproofFrontDoc: InputEmptyOrNot(""),
                    addressProofBackDoc: InputEmptyOrNot(""),
                    /* governmentExpiryDate: "",
                    isGovernemtExpiryCheck: false, */
                  ),
                );
              }
            },
          );
        },

        selectAddressFrontDoc: (e) {
          emit(
            state.copyWith(
              addressproofFrontDoc: InputEmptyOrNot(e.frontDoc),
              /* governmentExpiryDate: "",
              isGovernemtExpiryCheck: false, */
              isSubmitting: false,
              showErrorMesages: false,
              addressProofFailureOrSuccessOption: none(),
            ),
          );
        },
        selectAddressBackDoc: (e) {
          emit(
            state.copyWith(
              addressProofBackDoc: InputEmptyOrNot(e.backDoc),
              /* governmentExpiryDate: "",
              isGovernemtExpiryCheck: false, */
              isSubmitting: false,
              showErrorMesages: false,
              addressProofFailureOrSuccessOption: none(),
            ),
          );
        },
        /*   checkNAGovermentExpiryDate: (e) {
          emit(
            state.copyWith(
              isGovernemtExpiryCheck: e.isCheck,
              addressProofFailureOrSuccessOption: none(),
            ),
          );
        },
        govermentExpiryDateChanged: (e) {
          emit(
            state.copyWith(
              governmentExpiryDate: e.expiryDate,
              addressProofFailureOrSuccessOption: none(),
            ),
          );
        },
       */

        deleteAddressFrontDoc: (e) {
          emit(
            state.copyWith(
              addressproofFrontDoc: InputEmptyOrNot(""),
              isSubmitting: false,
              addressProofFailureOrSuccessOption: none(),
            ),
          );
        },
        deleteAddressBackDoc: (e) {
          emit(
            state.copyWith(
              addressProofBackDoc: InputEmptyOrNot(""),
              isSubmitting: false,
              addressProofFailureOrSuccessOption: none(),
            ),
          );
        },
        addressProofSubmit: (e) async {
          Either<AccountFailure, String>? failureOrSuccess;

          final isFrontDocValid = state.addressproofFrontDoc.isValid();
          final isBackDocValid = state.addressProofBackDoc.isValid();

          print("DOC IS VALID--> ${state.addressProofBackDoc}");
          print("DOC ID--> ${state.addressProofDocId}");

          if (isFrontDocValid && isBackDocValid) {
            final isExpiryDateMandatory =
                (state.currentAddressProofType.yearLimit != null);

            if (isExpiryDateMandatory && state.docExpiryDate.isEmpty) {
              emit(
                state.copyWith(
                  isSubmitting: false,
                  showErrorMesages: true,
                  addressProofFailureOrSuccessOption: none(),
                ),
              );
              return;
            }
            print("All Details are valid!");

            emit(
              state.copyWith(
                isSubmitting: true,
                addressProofFailureOrSuccessOption: none(),
              ),
            );

            if (state.addressProofDocId != -1) {
              /* failureOrSuccess = await _repository.updateDocumentApi(
                id: state.addressProofDocId,
                documentType: 1,
                subType: state.currentAddressProofType.id,
                documentTitle: state.currentAddressProofType.name ?? "",
                documentFile: state.addressproofFrontDoc.getValue() ?? "",
                documentBackFile: state.addressProofBackDoc.getValue() ?? "",
                // expiryDate: state.governmentExpiryDate,
                // expiryDateNotApplicable: state.isGovernemtExpiryCheck,
              ); */
            } else {
              failureOrSuccess = await _repository.addAddressProofApi(
                documentType: 2,
                subType: state.currentAddressProofType.id,
                documentFile: state.addressproofFrontDoc.getValue() ?? "",
                documentBackFile: state.addressProofBackDoc.getValue() ?? "",
                expiryDate: state.docExpiryDate,
                lastPage: "BackgroundCheckDocument",
              );
            }

            failureOrSuccess?.fold(
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
                  state.copyWith(
                    isSubmitting: false,
                  ),
                );
              },
              (success) {
                e.context.router.push(PageRouteInfo(BackgroundDocument.name));
              },
            );

            emit(
              state.copyWith(
                isSubmitting: false,
                isLoading: false,
                addressProofFailureOrSuccessOption: optionOf(failureOrSuccess),
              ),
            );
          } else {
            print("Some Details are invalid!");
            emit(
              state.copyWith(
                isSubmitting: false,
                showErrorMesages: true,
                addressProofFailureOrSuccessOption: none(),
              ),
            );
          }
        },

        /// >>>>--New changes--<<<<<
        selectAddressProofType: (e) async {
          if (state.currentAddressProofType != e.selectedType) {
            emit(state.copyWith(
              isLoading: true,
              showErrorMesages: false,
            ));
            await Future.delayed(Duration(seconds: 1));
            if (e.selectedType.id == state.existingAddressProof.sub_type) {
              emit(state.copyWith(
                isLoading: false,
                currentAddressProofType: e.selectedType,
                addressProofDocId: state.existingAddressProof.id ?? -1,
                addressproofFrontDoc:
                    InputEmptyOrNot(state.existingAddressProof.file ?? ""),
                addressProofBackDoc:
                    InputEmptyOrNot(state.existingAddressProof.back_file ?? ""),
                /* governmentExpiryDate: (state.existingAddressProof.expiry_date !=null)? DateTime.fromMillisecondsSinceEpoch((state.existingAddressProof.expiry_date ?? -1) * 1000,).toIso8601String() : "",
                isGovernemtExpiryCheck:(state.existingAddressProof.expiry_date_not_applicable == 0)? false: true, */
                docExpiryDate: (state.existingAddressProof.expiry_date != null)
                    ? DateTime.fromMillisecondsSinceEpoch(
                        (state.existingAddressProof.expiry_date ?? -1) * 1000,
                      ).toIso8601String()
                    : "",
                /* isGovernemtExpiryCheck:
                    (state.existingGovermentDoc.expiry_date_not_applicable == 0)
                        ? false
                        : true, */
                showErrorMesages: false,
              ));
            } else {
              emit(state.copyWith(
                isLoading: false,
                currentAddressProofType: e.selectedType,
                addressproofFrontDoc: InputEmptyOrNot(""),
                addressProofBackDoc: InputEmptyOrNot(""),
                /* governmentExpiryDate: "",
                isGovernemtExpiryCheck: false, */
                showErrorMesages: false,
              ));
            }
          }
        },
      );
    });
  }

  /* bool validateExpiryDate(
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
  } */
  bool validateExpiryDate(
      {required String yearLimit, required String expiryDate}) {
    if (expiryDate.isNotEmpty) {
      final date = DateTime.parse(expiryDate);
      if (yearLimit.isEmpty) return true;

      List<double> yearLimits =
          yearLimit.split(',').map((e) => double.tryParse(e) ?? 0).toList();

      double minYearLimit = yearLimits.isNotEmpty
          ? yearLimits.reduce((a, b) => a < b ? a : b)
          : 0;

      Duration duration;
      print("minYearLimit----> $minYearLimit");
      if (minYearLimit < 1) {
        // Treat as months if less than 1
        duration = Duration(days: (minYearLimit * 10 * 30).toInt());
      } else {
        // Treat as years if 1 or greater
        duration = Duration(days: (minYearLimit * 365).toInt());
      }
      print("duration----> $duration");

      DateTime maxAllowedDate = DateTime.now().add(duration);

      print("maxAllowedDate----> $maxAllowedDate");

      return date.isBefore(maxAllowedDate) ||
          date.isAtSameMomentAs(maxAllowedDate);
    }

    return false;
  }
}
