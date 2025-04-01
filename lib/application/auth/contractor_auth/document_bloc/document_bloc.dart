// ignore_for_file: avoid_print, prefer_const_constructors, unused_local_variable

import 'dart:convert';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:shift/domain/account/account.dart';
import 'package:shift/domain/account/account_failure.dart';
import 'package:shift/domain/account/i_account_repository.dart';
import 'package:shift/domain/auth/auth_value_objects.dart';
import 'package:shift/domain/core/string_constant.dart';
import 'package:shift/infrastructure/core/document_dto/document_dto.dart';
import 'package:shift/infrastructure/core/skill_list_model/skill_dto.dart';
import 'package:shift/presentation/auth/contractor_auth/documents/immunizations.dart';
import 'package:shift/presentation/auth/contractor_auth/documents/professional_liability_protection.dart';
import 'package:shift/presentation/auth/contractor_auth/documents/apparel_equipment.dart';
import 'package:shift/presentation/auth/contractor_auth/documents/covid_vaccination_proof.dart';
import 'package:shift/presentation/auth/contractor_auth/documents/credential_registration.dart';
import 'package:shift/presentation/auth/contractor_auth/documents/document_list.dart';
import 'package:shift/presentation/auth/contractor_auth/documents/government_issue_id.dart';
import 'package:shift/presentation/auth/contractor_auth/documents/professional_licenses.dart';
import 'package:shift/presentation/auth/contractor_auth/documents/resume.dart';
import 'package:shift/presentation/common/utils/flushbar_creator.dart';
import 'package:shift/presentation/core/common_lisitng/common_listing.dart';

part 'document_event.dart';
part 'document_state.dart';
part 'document_bloc.freezed.dart';

@injectable
class DocumentBloc extends Bloc<DocumentEvent, DocumentState> {
  // static final box = Hive.box(BoxNames.cotractorDocumentBox);

  static final pageController = PageController();

  // static List documentPageList = [
  //   DocumentList(),
  //   GovernmentIssueDocument(),
  //   CovidVaccinationDocument(),
  //   CredentialRegistration(
  //     isUpdate: state.isUpdate,
  //   ),
  //   ProfessionalLicenses(),
  //   ImmunizationsVaccinations(),
  //   ProfessionalLiabilityProtection(),
  //   ResumeDocument(),
  //   ApparelEquipment(),
  // ];
  static List documentPageList({bool isUpdate = false}) {
    return [
      DocumentList(
        isUpdate: isUpdate,
      ),
      GovernmentIssueDocument(),
      CovidVaccinationDocument(),
      CredentialRegistration(
        isUpdate: isUpdate,
      ),
      ProfessionalLicenses(
        isUpdate: isUpdate,
      ),
      ImmunizationsVaccinations(
        isUpdate: isUpdate,
      ),
      ProfessionalLiabilityProtection(
        isUpdate: isUpdate,
      ),
      ResumeDocument(),
      ApparelEquipment(
        isUpdate: isUpdate,
      ),
    ];
  }

  static List<String> appbarTitleList = [
    StringConstant.documents,
    StringConstant.governmentIssuedId,
    StringConstant.covid19VaccinationProof,
    StringConstant.credentialsRegistrations,
    StringConstant.professionalLicenses,
    StringConstant.immunizationsVaccinations,
    StringConstant.professionalLiabilityProtection,
    StringConstant.resume,
    StringConstant.apparelEquipment,
  ];

  static List<String> documentList = [
    "Government Issued Id",
    "Covid 19 Vaccination Proof",
    "Credentials/Registrations",
    "Professional License",
    "Immunizations/Vaccinations",
    "Professional Liability Protection",
    "Resume",
    "Apparel/Equipment",
  ];

  static bool isDocSubmit(List<DocumentDTO> list, int index) {
    switch (index) {
      case 0:
        return hasAtLeastOneDocument(list, 1);
      case 1:
        return hasAtLeastOneDocument(list, 2);
      case 2:
        return hasAtLeastOneDocument(list, 3);
      case 3:
        return hasAtLeastOneDocument(list, 4);
      case 4:
        return hasAtLeastOneDocument(list, 5);
      case 5:
        return hasAtLeastOneDocument(list, 6);
      case 6:
        return hasAtLeastOneDocument(list, 7);
      case 7:
        return hasAtLeastOneDocument(list, 8);
      default:
        return false;
    }
  }

  static bool hasAtLeastOneDocument(
      List<DocumentDTO> allDocumentList, int type) {
    return allDocumentList.any((document) => document.document_type == type);
  }

  final IAccountRepository _repository;

  DocumentBloc(this._repository) : super(DocumentState.initial()) {
    on<DocumentEvent>((event, emit) async {
      await event.map(
        submitDocumentsEvent: (e) async {
          Either<AccountFailure, Account>? failureOrSuccess;

          emit(
            state.copyWith(
              isSubmitting: true,
              continueFailureOrSuccessOption: none(),
            ),
          );

          failureOrSuccess = await _repository.addMultiDocumentApi(
            documentType: 8,
            documentFile: "",
            documentTitle: "",
            lastPage: "AddressProofScreen",
          );

          failureOrSuccess.fold(
            (l) => emit(
              state.copyWith(
                isSubmitting: false,
              ),
            ),
            (r) {
              emit(
                state.copyWith(
                  isSubmitting: false,
                  showErrorMessages: false,
                  continueFailureOrSuccessOption: none(),
                ),
              );
            },
          );

          emit(
            state.copyWith(
              isSubmitting: false,
              continueFailureOrSuccessOption: optionOf(failureOrSuccess),
            ),
          );
        },

        /// GO TO NEXT PAGE
        nextPage: (e) {
          emit(state.copyWith(currentPage: e.page));
        },

        getAllDocumentStatus: (e) async {
          Either<AccountFailure, List<DocumentDTO>>? failureOrSuccess;

          emit(
            state.copyWith(
              allListLoading: true,
              isSubmitting: false,
              isUpdate: e.isUpdate ?? false,
              governmentDocAuthFailureOrSuccessOption: none(),
              authFailureOrSuccessOption: none(),
              continueFailureOrSuccessOption: none(),
            ),
          );

          failureOrSuccess = await _repository.getDocumentApi(
            documentType: null,
          );
          failureOrSuccess.fold(
            (l) => emit(
              state.copyWith(
                allListLoading: false,
              ),
            ),
            (r) {
              if (r.isNotEmpty) {
                return emit(
                  state.copyWith(
                    allListLoading: false,
                    allDocumentList: r,
                  ),
                );
              } else {
                return emit(
                  state.copyWith(
                    allListLoading: false,
                    allDocumentList: [],
                  ),
                );
              }
            },
          );

          emit(
            state.copyWith(
              allListLoading: false,
              authFailureOrSuccessOption: optionOf(failureOrSuccess),
            ),
          );
        },

        /// FOR GOVERNEMT DOCUMENT
        getGovermentDoc: (e) async {
          Either<AccountFailure, List<DocumentDTO>>? failureOrSuccess;
          emit(
            state.copyWith(
              isLoading: true,
              currentGovermentDocType: SkillDTO(),
              showGovernmentIdErrorMessages: false,
              governmentDocAuthFailureOrSuccessOption: none(),
            ),
          );
          failureOrSuccess = await _repository.getDocumentApi(documentType: 1);
          failureOrSuccess.fold(
            (l) => emit(
              state.copyWith(
                isLoading: false,
                currentGovermentDocType: SkillDTO(),
                govermentDoc: InputEmptyOrNot(""),
                govermentFrontDoc: InputEmptyOrNot(""),
                govermentBackDoc: InputEmptyOrNot(""),
                governmentExpiryDate: "",
                govmentDocTitle: InputEmptyOrNot(""),
                isGovernemtExpiryCheck: false,
              ),
            ),
            (r) {
              if (r.isNotEmpty) {
                return emit(
                  state.copyWith(
                    isLoading: false,
                    existingGovermentDoc: r[0],
                    currentGovermentDocType:
                        CommonList.govermentIdList.firstWhere(
                      (skill) => skill.id == r[0].sub_type,
                      orElse: () => SkillDTO(),
                    ),
                    govermentDocId: (r[0].id != null) ? r[0].id! : -1,
                    govermentDoc: InputEmptyOrNot(r[0].file ?? ""),
                    govermentFrontDoc: InputEmptyOrNot(r[0].file ?? ""),
                    govermentBackDoc: InputEmptyOrNot(r[0].back_file ?? ""),
                    govmentDocTitle: InputEmptyOrNot(r[0].document_title ?? ""),
                    governmentExpiryDate: (r[0].expiry_date != null)
                        ? DateTime.fromMillisecondsSinceEpoch(
                            (r[0].expiry_date ?? -1) * 1000,
                          ).toIso8601String()
                        : "",
                    isGovernemtExpiryCheck:
                        (r[0].expiry_date_not_applicable == 0) ? false : true,
                  ),
                );
              } else {
                return emit(
                  state.copyWith(
                    isLoading: false,
                    currentGovermentDocType: SkillDTO(),
                    govermentDocId: -1,
                    govermentDoc: InputEmptyOrNot(""),
                    govermentFrontDoc: InputEmptyOrNot(""),
                    govermentBackDoc: InputEmptyOrNot(""),
                    govmentDocTitle: InputEmptyOrNot(""),
                    governmentExpiryDate: "",
                    isGovernemtExpiryCheck: false,
                  ),
                );
              }
            },
          );
          // emit(
          //   state.copyWith(
          //     isLoading: false,
          //     currentGovermentDocType: SkillDTO(),

          //     // governmentDocAuthFailureOrSuccessOption:
          //     //     optionOf(failureOrSuccess),
          //   ),
          // );
        },
        govtDocumentTitleChanged: (e) {
          emit(
            state.copyWith(
              govmentDocTitle: InputEmptyOrNot(e.documentTitle),
              isGovermentDocSubmitting: false,
              showGovernmentIdErrorMessages: false,
              governmentDocAuthFailureOrSuccessOption: none(),
            ),
          );
        },
        selectGovermentDoc: (e) {
          emit(
            state.copyWith(
              govermentDoc: InputEmptyOrNot(e.govermentDoc),
              governmentExpiryDate: "",
              isGovernemtExpiryCheck: false,
              isGovermentDocSubmitting: false,
              showGovernmentIdErrorMessages: false,
              governmentDocAuthFailureOrSuccessOption: none(),
            ),
          );
        },
        selectGovermentFrontDoc: (e) {
          emit(
            state.copyWith(
              govermentFrontDoc: InputEmptyOrNot(e.govermentDoc),
              governmentExpiryDate: "",
              isGovernemtExpiryCheck: false,
              isGovermentDocSubmitting: false,
              showGovernmentIdErrorMessages: false,
              governmentDocAuthFailureOrSuccessOption: none(),
            ),
          );
        },
        selectGovermentBackDoc: (e) {
          emit(
            state.copyWith(
              govermentBackDoc: InputEmptyOrNot(e.govermentDoc),
              governmentExpiryDate: "",
              isGovernemtExpiryCheck: false,
              isGovermentDocSubmitting: false,
              showGovernmentIdErrorMessages: false,
              governmentDocAuthFailureOrSuccessOption: none(),
            ),
          );
        },
        checkNAGovermentExpiryDate: (e) {
          emit(
            state.copyWith(
              isGovernemtExpiryCheck: e.isCheck,
              governmentDocAuthFailureOrSuccessOption: none(),
            ),
          );
        },
        govermentExpiryDateChanged: (e) {
          emit(
            state.copyWith(
              governmentExpiryDate: e.expiryDate,
              governmentDocAuthFailureOrSuccessOption: none(),
            ),
          );
        },
        deleteGovermentDoc: (e) {
          emit(
            state.copyWith(
              govermentDoc: InputEmptyOrNot(""),
              isGovermentDocSubmitting: false,
              governmentDocAuthFailureOrSuccessOption: none(),
            ),
          );
        },
        deleteGovermentFrontDoc: (e) {
          emit(
            state.copyWith(
              govermentFrontDoc: InputEmptyOrNot(""),
              isGovermentDocSubmitting: false,
              governmentDocAuthFailureOrSuccessOption: none(),
            ),
          );
        },
        deleteGovermentBackDoc: (e) {
          emit(
            state.copyWith(
              govermentBackDoc: InputEmptyOrNot(""),
              isGovermentDocSubmitting: false,
              governmentDocAuthFailureOrSuccessOption: none(),
            ),
          );
        },
        /* govermentDocSubmit: (e) async {
          Either<AccountFailure, String>? failureOrSuccess;

          final isGovernmentFrontDocValid = state.govermentDoc.isValid();
          final isGovernmentBackDocValid = state.govermentDoc.isValid();
          // final isGovernemntDocTitle = state.govmentDocTitle.isValid();

          print("DOC IS VALID--> ${state.govermentDoc}");
          print("DOC IS VALID--> ${state.govermentDocId}");
          print("DOC IS VALID111--> ${state.isGovernemtExpiryCheck}");
          print("DOC IS VALID222--> ${state.governmentExpiryDate}");
          if ((state.governmentExpiryDate.isNotEmpty) &&
              isGovernmentFrontDocValid &&
              isGovernmentBackDocValid) {
            if (state.currentGovermentDocType.id != 3 &&
                state.currentGovermentDocType.id != 4) {
              if (state.governmentExpiryDate.isEmpty) {
                emit(
                  state.copyWith(
                    isGovermentDocSubmitting: false,
                    showGovernmentIdErrorMessages: true,
                    governmentDocAuthFailureOrSuccessOption: none(),
                  ),
                );
              } else {
                emit(
                  state.copyWith(
                    isSubmitting: true,
                    governmentDocAuthFailureOrSuccessOption: none(),
                  ),
                );

                if (state.govermentDocId != -1) {
                  failureOrSuccess = await _repository.updateDocumentApi(
                    id: state.govermentDocId,
                    documentType: 1,
                    documentTitle: state.govmentDocTitle.getValue(),
                    documentFile: state.govermentDoc.getValue() ?? "",
                    expiryDate: state.governmentExpiryDate,
                    expiryDateNotApplicable: state.isGovernemtExpiryCheck,
                  );
                } else {
                  failureOrSuccess = await _repository.addDocumentApi(
                    documentType: 1,
                    documentTitle: state.govmentDocTitle.getValue(),
                    documentFile: state.govermentDoc.getValue() ?? "",
                    expiryDate: state.governmentExpiryDate,
                    expiryDateNotApplicable: state.isGovernemtExpiryCheck,
                  );
                }

                failureOrSuccess.fold(
                  (l) => emit(
                    state.copyWith(
                      isSubmitting: false,
                    ),
                  ),
                  (r) {
                    DocumentBloc.pageController.nextPage(
                        duration: const Duration(milliseconds: 10),
                        curve: Curves.easeInOut);
                    // return emit(
                    //   state.copyWith(
                    //     isLoading: false,
                    //     govermentDoc: InputEmptyOrNot(r[0].file ?? ""),
                    //     governmentExpiryDate: DateFormat('yyyy-MM-dd').format(
                    //       DateTime.fromMillisecondsSinceEpoch(
                    //           r[0].expiry_date ?? 0),
                    //     ),
                    //     isGovernemtExpiryCheck: false,
                    //   ),
                    // );
                  },
                );

                emit(
                  state.copyWith(
                    isLoading: false,
                    governmentDocAuthFailureOrSuccessOption:
                        optionOf(failureOrSuccess),
                  ),
                );
              }
            } else {
              emit(
                state.copyWith(
                  isSubmitting: true,
                  governmentDocAuthFailureOrSuccessOption: none(),
                ),
              );

              if (state.govermentDocId != -1) {
                failureOrSuccess = await _repository.updateDocumentApi(
                  id: state.govermentDocId,
                  documentType: 1,
                  documentTitle: state.govmentDocTitle.getValue(),
                  documentFile: state.govermentDoc.getValue() ?? "",
                  expiryDate: state.governmentExpiryDate,
                  expiryDateNotApplicable: state.isGovernemtExpiryCheck,
                );
              } else {
                failureOrSuccess = await _repository.addDocumentApi(
                  documentType: 1,
                  documentTitle: state.govmentDocTitle.getValue(),
                  documentFile: state.govermentDoc.getValue() ?? "",
                  expiryDate: state.governmentExpiryDate,
                  expiryDateNotApplicable: state.isGovernemtExpiryCheck,
                );
              }

              failureOrSuccess.fold(
                (l) => emit(
                  state.copyWith(
                    isSubmitting: false,
                  ),
                ),
                (r) {
                  DocumentBloc.pageController.nextPage(
                      duration: const Duration(milliseconds: 10),
                      curve: Curves.easeInOut);
                  // return emit(
                  //   state.copyWith(
                  //     isLoading: false,
                  //     govermentDoc: InputEmptyOrNot(r[0].file ?? ""),
                  //     governmentExpiryDate: DateFormat('yyyy-MM-dd').format(
                  //       DateTime.fromMillisecondsSinceEpoch(
                  //           r[0].expiry_date ?? 0),
                  //     ),
                  //     isGovernemtExpiryCheck: false,
                  //   ),
                  // );
                },
              );

              emit(
                state.copyWith(
                  isLoading: false,
                  governmentDocAuthFailureOrSuccessOption:
                      optionOf(failureOrSuccess),
                ),
              );
            }
          } else {
            emit(
              state.copyWith(
                isGovermentDocSubmitting: false,
                showGovernmentIdErrorMessages: true,
                governmentDocAuthFailureOrSuccessOption: none(),
              ),
            );
          }
        },
 */

        govermentDocSubmit: (e) async {
          Either<AccountFailure, String>? failureOrSuccess;

          final isGovernmentFrontDocValid = state.govermentFrontDoc.isValid();
          final isGovernmentBackDocValid = state.govermentBackDoc.isValid();

          print("DOC IS VALID--> ${state.govermentDoc}");
          print("DOC ID--> ${state.govermentDocId}");
          print("EXPIRY CHECK--> ${state.isGovernemtExpiryCheck}");
          print("EXPIRY DATE--> ${state.governmentExpiryDate}");

          if (isGovernmentFrontDocValid && isGovernmentBackDocValid) {
            emit(state.copyWith(isGovermentDocSubmitting: true));

            final isExpiryDateMandatory =
                state.currentGovermentDocType.id != 3 &&
                    state.currentGovermentDocType.id != 4;

            if (isExpiryDateMandatory && state.governmentExpiryDate.isEmpty) {
              showError(
                      message: StringConstant
                          .someDetailsAreMissingOrInvalidPleaseCheck)
                  .show(e.context);
              emit(
                state.copyWith(
                  isGovermentDocSubmitting: false,
                  showGovernmentIdErrorMessages: true,
                  governmentDocAuthFailureOrSuccessOption: none(),
                ),
              );
              return;
            }

            emit(
              state.copyWith(
                isGovermentDocSubmitting: true,
                isSubmitting: true,
                governmentDocAuthFailureOrSuccessOption: none(),
              ),
            );

            if (state.govermentDocId != -1) {
              failureOrSuccess = await _repository.updateDocumentApi(
                id: state.govermentDocId,
                documentType: 1,
                subType: state.currentGovermentDocType.id,
                // documentTitle: state.govmentDocTitle.getValue(),
                // documentFile: state.govermentDoc.getValue() ?? "",
                documentTitle: state.currentGovermentDocType.name ?? "",
                documentFile: state.govermentFrontDoc.getValue() ?? "",
                documentBackFile: state.govermentBackDoc.getValue() ?? "",
                expiryDate: state.governmentExpiryDate,
                expiryDateNotApplicable: state.isGovernemtExpiryCheck,
              );
            } else {
              failureOrSuccess = await _repository.addDocumentApi(
                documentType: 1,
                subType: state.currentGovermentDocType.id,
                // documentTitle: state.govmentDocTitle.getValue(),
                // documentFile: state.govermentDoc.getValue() ?? "",
                documentTitle: state.currentGovermentDocType.name ?? "",
                documentFile: state.govermentFrontDoc.getValue() ?? "",
                documentBackFile: state.govermentBackDoc.getValue() ?? "",
                expiryDate: state.governmentExpiryDate,
                expiryDateNotApplicable: state.isGovernemtExpiryCheck,
              );
            }

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
                  state.copyWith(
                    isGovermentDocSubmitting: false,
                    isSubmitting: false,
                  ),
                );
              },
              (success) {
                DocumentBloc.pageController.nextPage(
                  duration: const Duration(milliseconds: 10),
                  curve: Curves.easeInOut,
                );
              },
            );

            emit(
              state.copyWith(
                isLoading: false,
                isGovermentDocSubmitting: false,
                governmentDocAuthFailureOrSuccessOption:
                    optionOf(failureOrSuccess),
              ),
            );
          } else {
            showError(
                    message: StringConstant
                        .someDetailsAreMissingOrInvalidPleaseCheck)
                .show(e.context);
            emit(
              state.copyWith(
                isGovermentDocSubmitting: false,
                showGovernmentIdErrorMessages: true,
                governmentDocAuthFailureOrSuccessOption: none(),
              ),
            );
          }
        },

        /// >>>>--New changes--<<<<<
        selectGovenmentType: (e) async {
          if (state.currentGovermentDocType != e.selectedType) {
            emit(state.copyWith(
              isLoading: true,
              showGovernmentIdErrorMessages: false,
            ));
            await Future.delayed(Duration(seconds: 1));
            if (e.selectedType.id == state.existingGovermentDoc.sub_type) {
              emit(state.copyWith(
                isLoading: false,
                currentGovermentDocType: e.selectedType,
                govermentDocId: state.existingGovermentDoc.id ?? -1,
                govermentDoc:
                    InputEmptyOrNot(state.existingGovermentDoc.file ?? ""),
                govermentFrontDoc:
                    InputEmptyOrNot(state.existingGovermentDoc.file ?? ""),
                govermentBackDoc:
                    InputEmptyOrNot(state.existingGovermentDoc.back_file ?? ""),
                govmentDocTitle: InputEmptyOrNot(
                    state.existingGovermentDoc.document_title ?? ""),
                governmentExpiryDate: (state.existingGovermentDoc.expiry_date !=
                        null)
                    ? DateTime.fromMillisecondsSinceEpoch(
                        (state.existingGovermentDoc.expiry_date ?? -1) * 1000,
                      ).toIso8601String()
                    : "",
                isGovernemtExpiryCheck:
                    (state.existingGovermentDoc.expiry_date_not_applicable == 0)
                        ? false
                        : true,
                // govermentDoc: InputEmptyOrNot(""),
                // govermentFrontDoc: InputEmptyOrNot(""),
                // govermentBackDoc: InputEmptyOrNot(""),
                // govmentDocTitle: InputEmptyOrNot(""),
                // governmentExpiryDate: "",
                // isGovernemtExpiryCheck: false,
                showGovernmentIdErrorMessages: false,
              ));
            } else {
              emit(state.copyWith(
                isLoading: false,
                currentGovermentDocType: e.selectedType,
                govermentDoc: InputEmptyOrNot(""),
                govermentFrontDoc: InputEmptyOrNot(""),
                govermentBackDoc: InputEmptyOrNot(""),
                govmentDocTitle: InputEmptyOrNot(""),
                governmentExpiryDate: "",
                isGovernemtExpiryCheck: false,
                showGovernmentIdErrorMessages: false,
              ));
            }
          }
        },

        /// FOR COVID DOCUMENT
        getCovidDoc: (e) async {
          Either<AccountFailure, List<DocumentDTO>>? failureOrSuccess;
          emit(
            state.copyWith(
              isLoading: true,
              showCovidErrorMessages: false,
              coviDocAuthFailureOrSuccessOption: none(),
            ),
          );
          failureOrSuccess = await _repository.getDocumentApi(documentType: 2);
          failureOrSuccess.fold(
            (l) => emit(
              state.copyWith(
                isLoading: false,
                covidVaccinationDoc: InputEmptyOrNot(""),
              ),
            ),
            (r) {
              if (r.isNotEmpty) {
                return emit(
                  state.copyWith(
                    isLoading: false,
                    covidDocId: (r[0].id != null) ? r[0].id! : -1,
                    covidVaccinationDoc: InputEmptyOrNot(r[0].file ?? ""),
                  ),
                );
              } else {
                return emit(
                  state.copyWith(
                    isLoading: false,
                    covidVaccinationDoc: InputEmptyOrNot(""),
                  ),
                );
              }
            },
          );

          emit(
            state.copyWith(
              isLoading: false,
              // governmentDocAuthFailureOrSuccessOption:
              //     optionOf(failureOrSuccess),
            ),
          );
        },
        selectCovidVaccinationDoc: (e) {
          emit(
            state.copyWith(
              covidVaccinationDoc: InputEmptyOrNot(e.covidDoc),
              showCovidErrorMessages: false,
              isCovidDocSubmitting: false,
              coviDocAuthFailureOrSuccessOption: none(),
            ),
          );
        },
        deleteCovidDoc: (e) async {
          Either<AccountFailure, Account>? failureOrSuccess;

          emit(
            state.copyWith(
              isLoading: true,
              isCovidDocSubmitting: true,
              coviDocAuthFailureOrSuccessOption: none(),
            ),
          );
          if (state.covidDocId != -1) {
            print("Covid document delete id ---> ${state.covidDocId}");
            failureOrSuccess =
                await _repository.deleteDocumentApi(credId: state.covidDocId);

            failureOrSuccess.fold(
              (l) => emit(
                state.copyWith(
                  isLoading: false,
                  isCovidDocSubmitting: false,
                  coviDocAuthFailureOrSuccessOption: none(),
                ),
              ),
              (r) {
                return emit(
                  state.copyWith(
                    isLoading: false,
                    covidVaccinationDoc: InputEmptyOrNot(""),
                    covidDocId: -1,
                    isCovidDocSubmitting: false,
                    coviDocAuthFailureOrSuccessOption: none(),
                  ),
                );
              },
            );
          } else {
            emit(
              state.copyWith(
                isLoading: false,
                covidVaccinationDoc: InputEmptyOrNot(""),
                isCovidDocSubmitting: false,
                coviDocAuthFailureOrSuccessOption: none(),
              ),
            );
          }

          /*emit(
            state.copyWith(
              covidVaccinationDoc: InputEmptyOrNot(""),
              isCovidDocSubmitting: false,
              coviDocAuthFailureOrSuccessOption: none(),
            ),
          );*/
        },
        covidDocSubmit: (e) async {
          Either<AccountFailure, String>? failureOrSuccess;

          final isCovidDocValid = state.covidVaccinationDoc.isValid();

          if (e.isSkip) {
            DocumentBloc.pageController.nextPage(
                duration: const Duration(milliseconds: 10),
                curve: Curves.easeInOut);
          } else {
            emit(
              state.copyWith(
                isCovidDocSubmitting: true,
                coviDocAuthFailureOrSuccessOption: none(),
              ),
            );
            if (isCovidDocValid) {
              if (state.covidDocId != -1) {
                failureOrSuccess = await _repository.updateDocumentApi(
                  id: state.covidDocId,
                  documentType: 2,
                  documentFile: state.covidVaccinationDoc.getValue() ?? "",
                );
              } else {
                failureOrSuccess = await _repository.addDocumentApi(
                  documentType: 2,
                  documentFile: state.covidVaccinationDoc.getValue() ?? "",
                );
              }

              failureOrSuccess.fold(
                (l) => emit(
                  state.copyWith(
                    isCovidDocSubmitting: false,
                  ),
                ),
                (r) {
                  DocumentBloc.pageController.nextPage(
                      duration: const Duration(milliseconds: 10),
                      curve: Curves.easeInOut);
                },
              );

              emit(
                state.copyWith(
                  isCovidDocSubmitting: false,
                  coviDocAuthFailureOrSuccessOption: optionOf(failureOrSuccess),
                ),
              );
            } else {
              showError(
                      message: StringConstant
                          .someDetailsAreMissingOrInvalidPleaseCheck)
                  .show(e.context);
              emit(
                state.copyWith(
                  isCovidDocSubmitting: false,
                  showCovidErrorMessages: true,
                  coviDocAuthFailureOrSuccessOption: optionOf(failureOrSuccess),
                ),
              );
            }
          }
        },
      );
    });
  }
}

@injectable
class CredentialBloc extends Bloc<CredentialEvent, CredentialState> {
  final IAccountRepository _repository;

  CredentialBloc(this._repository) : super(CredentialState.initial()) {
    on<CredentialEvent>((event, emit) async {
      await event.map(
        credDocUpdate: (e) async {
          final isCredentialDocValid =
              state.credentialRegistrationDoc.isValid();
          final isDocumentTitleValid = state.documentTitle.isValid();
          final isProvinceRegistrationValid =
              state.selectedProvinceRegistration.isValid();
          if (e.id != null &&
              isCredentialDocValid &&
              isDocumentTitleValid &&
              isProvinceRegistrationValid &&
              (state.isCredExpiryCheck ||
                  state.credentialExpiryDate.isNotEmpty)) {
            Either<AccountFailure, Account>? failureOrSuccess;

            emit(
              state.copyWith(
                isLoading: true,
                isCredintialDocSubmitting: true,
                credintialDocAuthFailureOrSuccessOption: none(),
              ),
            );

            failureOrSuccess = await _repository.updateMultiDocumentApi(
              id: e.id ?? -1,
              documentType: 3,
              registrationNumber: state.registrationNumber,
              provinceOfRegistration:
                  state.selectedProvinceRegistration.getValue(),
              documentTitle: state.documentTitle.getValue(),
              documentFile: state.credentialRegistrationDoc.getValue() ?? "",
              expiryDate: state.credentialExpiryDate,
              expiryDateNotApplicable: state.isCredExpiryCheck,
            );

            failureOrSuccess.fold(
              (l) => emit(
                state.copyWith(
                  isLoading: false,
                  isCredintialDocSubmitting: false,
                ),
              ),
              (r) {
                emit(
                  state.copyWith(
                    credentialRegistrationList: r.document
                            ?.where((doc) => doc.document_type == 3)
                            .toList() ??
                        [],
                    credentialRegistrationDoc: InputEmptyOrNot(""),
                    documentTitle: InputEmptyOrNot(""),
                    selectedProvinceRegistration: InputEmptyOrNot(""),
                    registrationNumber: "",
                    credentialExpiryDate: "",
                    isLoading: false,
                    isCredExpiryCheck: false,
                    isCredintialDocSubmitting: false,
                    showCredintialErrorMessages: false,
                    credintialDocAuthFailureOrSuccessOption: none(),
                  ),
                );
                Navigator.pop(e.context, true);
              },
            );
            emit(
              state.copyWith(
                isLoading: false,
                credintialDocAuthFailureOrSuccessOption:
                    optionOf(failureOrSuccess),
              ),
            );
          }

          /// True When click on continue - add more btn and some details are empty or not valid

          else {
            showError(
                    message: StringConstant
                        .someDetailsAreMissingOrInvalidPleaseCheck)
                .show(e.context);
            emit(
              state.copyWith(
                isCredintialDocSubmitting: false,
                showCredintialErrorMessages: true,
                credintialDocAuthFailureOrSuccessOption: none(),
              ),
            );
          }
        },
        getCurrentCredDoc: (e) async {
          DocumentDTO? doc = e.currentCred;
          if (doc != null) {
            emit(state.copyWith(isLoading: true));
            await Future.delayed(Duration(seconds: 1));
            print("Delayedd complete--->${state.isLoading}");
            emit(state.copyWith(
              registrationNumber: doc.registration_number ?? "",
              selectedProvinceRegistration:
                  InputEmptyOrNot(doc.province_of_registration ?? ""),
              documentTitle: InputEmptyOrNot(doc.document_title ?? ""),
              credentialRegistrationDoc: InputEmptyOrNot(doc.file ?? ""),
              credentialExpiryDate: (doc.expiry_date != null)
                  ? DateTime.fromMillisecondsSinceEpoch(
                      (doc.expiry_date ?? -1) * 1000,
                    ).toIso8601String()
                  : "",
              isCredExpiryCheck:
                  (doc.expiry_date_not_applicable == 0) ? false : true,
            ));

            emit(state.copyWith(isLoading: false));
          }
        },

        /// FOR CREDENTIALS-REGISTRATION DOCUMENT
        getCredentialDocList: (e) async {
          Either<AccountFailure, List<DocumentDTO>>? failureOrSuccess;
          emit(
            state.copyWith(
              isLoading: true,
              credintialDocAuthFailureOrSuccessOption: none(),
            ),
          );
          failureOrSuccess = await _repository.getDocumentApi(documentType: 3);
          failureOrSuccess.fold(
            (l) => emit(
              state.copyWith(
                isLoading: false,
                credentialRegistrationList: [],
              ),
            ),
            (r) {
              print("r.length---> ${r.length}");
              if (r.isNotEmpty) {
                return emit(
                  state.copyWith(
                    isLoading: false,
                    credentialRegistrationList: r,
                  ),
                );
              } else {
                return emit(
                  state.copyWith(
                    isLoading: false,
                    credentialRegistrationList: [],
                  ),
                );
              }
            },
          );

          emit(
            state.copyWith(
              isLoading: false,
              // credintialDocAuthFailureOrSuccessOption:
              //     optionOf(failureOrSuccess),
            ),
          );
        },
        registrationNumberChanegd: (e) {
          emit(
            state.copyWith(
              registrationNumber: e.registrationNo,
              isCredintialDocSubmitting: false,
              showCredintialErrorMessages: false,
              credintialDocAuthFailureOrSuccessOption: none(),
            ),
          );
        },
        checkNACredExpiryDate: (e) {
          emit(
            state.copyWith(
              isCredExpiryCheck: e.isCheck,
              credintialDocAuthFailureOrSuccessOption: none(),
            ),
          );
        },
        credExpiryDateChanged: (e) {
          emit(
            state.copyWith(
              credentialExpiryDate: e.expiryDate,
              credintialDocAuthFailureOrSuccessOption: none(),
            ),
          );
        },
        documentTitleChanged: (e) {
          emit(
            state.copyWith(
              documentTitle: InputEmptyOrNot(e.documentTitle),
              isCredintialDocSubmitting: false,
              showCredintialErrorMessages: false,
              credintialDocAuthFailureOrSuccessOption: none(),
            ),
          );
        },
        selectProvinceRegistration: (e) {
          emit(
            state.copyWith(
              selectedProvinceRegistration:
                  InputEmptyOrNot(e.provinceRegistration),
              isCredintialDocSubmitting: false,
              showCredintialErrorMessages: false,
              credintialDocAuthFailureOrSuccessOption: none(),
            ),
          );
        },
        selectCredentialDoc: (e) {
          emit(
            state.copyWith(
              credentialRegistrationDoc: InputEmptyOrNot(e.credentialDoc),
              isCredintialDocSubmitting: false,
              showCredintialErrorMessages: false,
              credintialDocAuthFailureOrSuccessOption: none(),
            ),
          );
        },
        deleteCredentialDoc: (e) {
          emit(
            state.copyWith(
              credentialRegistrationDoc: InputEmptyOrNot(""),
              isCredintialDocSubmitting: false,
              showCredintialErrorMessages: false,
              credintialDocAuthFailureOrSuccessOption: none(),
            ),
          );
        },
        addMoreCredentialDoc: (e) async {
          Either<AccountFailure, Account>? failureOrSuccess;

          final isCredentialDocValid =
              state.credentialRegistrationDoc.isValid();
          final isDocumentTitleValid = state.documentTitle.isValid();
          final isProvinceRegistrationValid =
              state.selectedProvinceRegistration.isValid();
          if (isCredentialDocValid &&
              isDocumentTitleValid &&
              isProvinceRegistrationValid &&
              (state.isCredExpiryCheck ||
                  state.credentialExpiryDate.isNotEmpty)) {
            print(
                "province Number---> ${state.selectedProvinceRegistration.getValue()}");

            /// FROMMMMMM
            emit(
              state.copyWith(
                isLoading: true,
                isCredintialDocSubmitting: true,
                credintialDocAuthFailureOrSuccessOption: none(),
              ),
            );

            failureOrSuccess = await _repository.addMultiDocumentApi(
              documentType: 3,
              registrationNumber: state.registrationNumber,
              provinceOfRegistration:
                  state.selectedProvinceRegistration.getValue(),
              documentTitle: state.documentTitle.getValue(),
              documentFile: state.credentialRegistrationDoc.getValue() ?? "",
              expiryDate: state.credentialExpiryDate,
              expiryDateNotApplicable: state.isCredExpiryCheck,
            );

            failureOrSuccess.fold(
              (l) => emit(
                state.copyWith(
                  isLoading: false,
                  isCredintialDocSubmitting: false,
                ),
              ),
              (r) {
                print(
                    "credential List ----> ${jsonEncode(r.document!.length)}");
                emit(
                  state.copyWith(
                    credentialRegistrationList: r.document
                            ?.where((doc) => doc.document_type == 3)
                            .toList() ??
                        [],
                    credentialRegistrationDoc: InputEmptyOrNot(""),
                    documentTitle: InputEmptyOrNot(""),
                    selectedProvinceRegistration: InputEmptyOrNot(""),
                    registrationNumber: "",
                    credentialExpiryDate: "",
                    isLoading: false,
                    isCredExpiryCheck: false,
                    isCredintialDocSubmitting: false,
                    showCredintialErrorMessages: false,
                    credintialDocAuthFailureOrSuccessOption: none(),
                  ),
                );
              },
            );
            emit(
              state.copyWith(
                isLoading: false,
                credintialDocAuthFailureOrSuccessOption:
                    optionOf(failureOrSuccess),
              ),
            );
          } else {
            emit(
              state.copyWith(
                isCredintialDocSubmitting: false,
                showCredintialErrorMessages: true,
                credintialDocAuthFailureOrSuccessOption: none(),
              ),
            );
          }
        },
        deleteCredentialObject: (e) async {
          Either<AccountFailure, Account>? failureOrSuccess;

          emit(
            state.copyWith(
              isLoading: true,
              isCredintialDocSubmitting: true,
              credintialDocAuthFailureOrSuccessOption: none(),
            ),
          );

          print("Delete Id-> ${state.credentialRegistrationList[e.index].id}");
          failureOrSuccess = await _repository.deleteDocumentApi(
              credId: state.credentialRegistrationList[e.index].id ?? -1);

          failureOrSuccess.fold(
            (l) => emit(
              state.copyWith(
                isLoading: false,
                isCredintialDocSubmitting: false,
                credentialRegistrationList:
                    List.from(state.credentialRegistrationList),
              ),
            ),
            (r) {
              return emit(
                state.copyWith(
                  isLoading: false,
                  isCredintialDocSubmitting: false,
                  credentialRegistrationList: List.from(r.document
                          ?.where((doc) => doc.document_type == 3)
                          .toList() ??
                      []),
                ),
              );
            },
          );
        },
        credentialDocSubmit: (e) async {
          final isCredentialDocValid =
              state.credentialRegistrationDoc.isValid();
          final isDocumentTitleValid = state.documentTitle.isValid();
          final isProvinceRegistrationValid =
              state.selectedProvinceRegistration.isValid();

          if (e.isSkip) {
            /// True When click on continue btn and all details are empty
            /*if (!e.isAddMoreBtnClick &&
                !isCredentialDocValid &&
                !isDocumentTitleValid &&
                !isProvinceRegistrationValid &&
                (!state.isCredExpiryCheck &&
                    state.credentialExpiryDate.isEmpty)) {*/
            emit(
              state.copyWith(
                isCredintialDocSubmitting: true,
                showCredintialErrorMessages: false,
                credintialDocAuthFailureOrSuccessOption:
                    optionOf(right(Account())),
              ),
            );
            DocumentBloc.pageController.nextPage(
                duration: const Duration(milliseconds: 10),
                curve: Curves.easeInOut);
            // }
          } else {
            /// True When click on continue - add more btn and all details are valid
            if (isCredentialDocValid &&
                isDocumentTitleValid &&
                isProvinceRegistrationValid &&
                (state.isCredExpiryCheck ||
                    state.credentialExpiryDate.isNotEmpty)) {
              Either<AccountFailure, Account>? failureOrSuccess;

              emit(
                state.copyWith(
                  isLoading: true,
                  isCredintialDocSubmitting: true,
                  credintialDocAuthFailureOrSuccessOption: none(),
                ),
              );

              failureOrSuccess = await _repository.addMultiDocumentApi(
                documentType: 3,
                registrationNumber: state.registrationNumber,
                provinceOfRegistration:
                    state.selectedProvinceRegistration.getValue(),
                documentTitle: state.documentTitle.getValue(),
                documentFile: state.credentialRegistrationDoc.getValue() ?? "",
                expiryDate: state.credentialExpiryDate,
                expiryDateNotApplicable: state.isCredExpiryCheck,
              );

              failureOrSuccess.fold(
                (l) => emit(
                  state.copyWith(
                    isLoading: false,
                    isCredintialDocSubmitting: false,
                  ),
                ),
                (r) {
                  emit(
                    state.copyWith(
                      credentialRegistrationList: r.document
                              ?.where((doc) => doc.document_type == 3)
                              .toList() ??
                          [],
                      credentialRegistrationDoc: InputEmptyOrNot(""),
                      documentTitle: InputEmptyOrNot(""),
                      selectedProvinceRegistration: InputEmptyOrNot(""),
                      registrationNumber: "",
                      credentialExpiryDate: "",
                      isLoading: false,
                      isCredExpiryCheck: false,
                      isCredintialDocSubmitting: false,
                      showCredintialErrorMessages: false,
                      credintialDocAuthFailureOrSuccessOption: none(),
                    ),
                  );
                  DocumentBloc.pageController.nextPage(
                    duration: const Duration(milliseconds: 10),
                    curve: Curves.easeInOut,
                  );
                },
              );
              emit(
                state.copyWith(
                  isLoading: false,
                  credintialDocAuthFailureOrSuccessOption:
                      optionOf(failureOrSuccess),
                ),
              );
            }

            /// True When click on continue - add more btn and some details are empty or not valid

            else {
              showError(
                      message: StringConstant
                          .someDetailsAreMissingOrInvalidPleaseCheck)
                  .show(e.context);
              emit(
                state.copyWith(
                  isCredintialDocSubmitting: false,
                  showCredintialErrorMessages: true,
                  credintialDocAuthFailureOrSuccessOption: none(),
                ),
              );
            }
          }
        },
      );
    });
  }
}

@injectable
class ProfessionalLicensesBloc
    extends Bloc<ProfessionalLicensesEvent, ProfessionalLicensesState> {
  final IAccountRepository _repository;
  ProfessionalLicensesBloc(this._repository)
      : super(ProfessionalLicensesState.initial()) {
    on<ProfessionalLicensesEvent>((event, emit) async {
      await event.map(
        /// FOR PROFESSIONAL LICENSES DOCUMENT
        getCurrentLicenseDoc: (e) async {
          DocumentDTO? doc = e.currentCred;
          if (doc != null) {
            emit(state.copyWith(isLicensesDocSubmitting: true));
            await Future.delayed(Duration(seconds: 1));
            emit(state.copyWith(
              registrationNumber: doc.registration_number ?? "",
              selectedProvinceRegistration:
                  InputEmptyOrNot(doc.province_of_registration ?? ""),
              documentTitle: InputEmptyOrNot(doc.document_title ?? ""),
              professionalLicensesDoc: InputEmptyOrNot(doc.file ?? ""),
              licensesExpiryDate: (doc.expiry_date != null)
                  ? DateTime.fromMillisecondsSinceEpoch(
                      (doc.expiry_date ?? -1) * 1000,
                    ).toIso8601String()
                  : "",
              isLicensesExpiryCheck:
                  (doc.expiry_date_not_applicable == 0) ? false : true,
            ));

            emit(state.copyWith(isLicensesDocSubmitting: false));
          }
        },
        licenseDocUpdate: (e) async {
          final isProfessionalLicensesDocValid =
              state.professionalLicensesDoc.isValid();
          final isDocumentTitleValid = state.documentTitle.isValid();
          final isProvinceRegistrationValid =
              state.selectedProvinceRegistration.isValid();

          if (e.id != null &&
              isProfessionalLicensesDocValid &&
              isDocumentTitleValid &&
              isProvinceRegistrationValid &&
              (state.isLicensesExpiryCheck ||
                  state.licensesExpiryDate.isNotEmpty)) {
            Either<AccountFailure, Account>? failureOrSuccess;

            emit(
              state.copyWith(
                isLicensesDocSubmitting: true,
                licensesDocAuthFailureOrSuccessOption: none(),
              ),
            );

            failureOrSuccess = await _repository.updateMultiDocumentApi(
              id: e.id ?? -1,
              documentType: 4,
              registrationNumber: state.registrationNumber,
              provinceOfRegistration:
                  state.selectedProvinceRegistration.getValue(),
              documentTitle: state.documentTitle.getValue(),
              documentFile: state.professionalLicensesDoc.getValue() ?? "",
              expiryDate: state.licensesExpiryDate,
              expiryDateNotApplicable: state.isLicensesExpiryCheck,
            );

            failureOrSuccess.fold(
              (l) => emit(
                state.copyWith(
                  isLicensesDocSubmitting: false,
                ),
              ),
              (r) {
                emit(
                  state.copyWith(
                    professionalLicensesList: r.document
                            ?.where((doc) => doc.document_type == 4)
                            .toList() ??
                        [],
                    professionalLicensesDoc: InputEmptyOrNot(""),
                    documentTitle: InputEmptyOrNot(""),
                    selectedProvinceRegistration: InputEmptyOrNot(""),
                    registrationNumber: "",
                    licensesExpiryDate: "",
                    isLicensesExpiryCheck: false,
                    isLicensesDocSubmitting: false,
                    showLicensesErrorMessages: false,
                    licensesDocAuthFailureOrSuccessOption: none(),
                  ),
                );
                Navigator.pop(e.context, true);
              },
            );
            emit(
              state.copyWith(
                isLicensesDocSubmitting: false,
                licensesDocAuthFailureOrSuccessOption:
                    optionOf(failureOrSuccess),
              ),
            );
          }

          /// True When click on continue - add more btn and some details are empty or not valid
          else {
            showError(
                    message: StringConstant
                        .someDetailsAreMissingOrInvalidPleaseCheck)
                .show(e.context);
            emit(
              state.copyWith(
                isLicensesDocSubmitting: false,
                showLicensesErrorMessages: true,
                licensesDocAuthFailureOrSuccessOption: none(),
              ),
            );
          }
        },
        getProfessinalLicensesList: (e) async {
          Either<AccountFailure, List<DocumentDTO>>? failureOrSuccess;
          emit(
            state.copyWith(
              isLicensesDocSubmitting: true,
              licensesDocAuthFailureOrSuccessOption: none(),
            ),
          );
          failureOrSuccess = await _repository.getDocumentApi(documentType: 4);
          failureOrSuccess.fold(
            (l) => emit(
              state.copyWith(
                isLicensesDocSubmitting: false,
                professionalLicensesList: [],
              ),
            ),
            (r) {
              print("r.length---> ${r.length}");
              if (r.isNotEmpty) {
                return emit(
                  state.copyWith(
                    isLicensesDocSubmitting: false,
                    professionalLicensesList: r,
                  ),
                );
              } else {
                return emit(
                  state.copyWith(
                    isLicensesDocSubmitting: false,
                    professionalLicensesList: [],
                  ),
                );
              }
            },
          );

          emit(
            state.copyWith(
              isLicensesDocSubmitting: false,
              // licensesDocAuthFailureOrSuccessOption: optionOf(failureOrSuccess),
            ),
          );
        },
        checkNALicensesExpiryDate: (e) {
          emit(
            state.copyWith(
              isLicensesExpiryCheck: e.isCheck,
              licensesDocAuthFailureOrSuccessOption: none(),
            ),
          );
        },
        licensesExpiryDateChanged: (e) {
          emit(
            state.copyWith(
              licensesExpiryDate: e.expiryDate,
              licensesDocAuthFailureOrSuccessOption: none(),
            ),
          );
        },
        licensesRegistrationNumberChanegd: (e) {
          emit(
            state.copyWith(
              registrationNumber: e.registrationNo,
              isLicensesDocSubmitting: false,
              showLicensesErrorMessages: false,
              licensesDocAuthFailureOrSuccessOption: none(),
            ),
          );
        },
        licensesDocumentTitleChanged: (e) {
          emit(
            state.copyWith(
              documentTitle: InputEmptyOrNot(e.documentTitle),
              isLicensesDocSubmitting: false,
              showLicensesErrorMessages: false,
              licensesDocAuthFailureOrSuccessOption: none(),
            ),
          );
        },
        selectProvinceLicenses: (e) {
          emit(
            state.copyWith(
              selectedProvinceRegistration:
                  InputEmptyOrNot(e.provinceRegistration),
              isLicensesDocSubmitting: false,
              showLicensesErrorMessages: false,
              licensesDocAuthFailureOrSuccessOption: none(),
            ),
          );
        },
        selectLicensesDoc: (e) {
          emit(
            state.copyWith(
              professionalLicensesDoc: InputEmptyOrNot(e.licensesDoc),
              isLicensesDocSubmitting: false,
              showLicensesErrorMessages: false,
              licensesDocAuthFailureOrSuccessOption: none(),
            ),
          );
        },
        deleteLicensesDoc: (e) {
          emit(
            state.copyWith(
              professionalLicensesDoc: InputEmptyOrNot(""),
              isLicensesDocSubmitting: false,
              showLicensesErrorMessages: false,
              licensesDocAuthFailureOrSuccessOption: none(),
            ),
          );
        },
        addMoreLicensesDoc: (e) async {
          Either<AccountFailure, Account>? failureOrSuccess;
          final isProfessionalLicensesDocValid =
              state.professionalLicensesDoc.isValid();
          final isDocumentTitleValid = state.documentTitle.isValid();
          final isProvinceRegistrationValid =
              state.selectedProvinceRegistration.isValid();
          if (isProfessionalLicensesDocValid &&
              isDocumentTitleValid &&
              isProvinceRegistrationValid &&
              (state.isLicensesExpiryCheck ||
                  state.licensesExpiryDate.isNotEmpty)) {
            /// FROMMMMMM
            emit(
              state.copyWith(
                isLicensesDocSubmitting: true,
                licensesDocAuthFailureOrSuccessOption: none(),
              ),
            );

            failureOrSuccess = await _repository.addMultiDocumentApi(
              documentType: 4,
              registrationNumber: state.registrationNumber,
              provinceOfRegistration:
                  state.selectedProvinceRegistration.getValue(),
              documentTitle: state.documentTitle.getValue(),
              documentFile: state.professionalLicensesDoc.getValue() ?? "",
              expiryDate: state.licensesExpiryDate,
              expiryDateNotApplicable: state.isLicensesExpiryCheck,
            );

            failureOrSuccess.fold(
              (l) => emit(
                state.copyWith(
                  isLicensesDocSubmitting: false,
                ),
              ),
              (r) {
                print("licenses List ----> ${jsonEncode(r.document!.length)}");
                emit(
                  state.copyWith(
                    professionalLicensesList: r.document
                            ?.where((doc) => doc.document_type == 4)
                            .toList() ??
                        [],
                    professionalLicensesDoc: InputEmptyOrNot(""),
                    documentTitle: InputEmptyOrNot(""),
                    selectedProvinceRegistration: InputEmptyOrNot(""),
                    registrationNumber: "",
                    licensesExpiryDate: "",
                    isLicensesExpiryCheck: false,
                    isLicensesDocSubmitting: false,
                    showLicensesErrorMessages: false,
                    licensesDocAuthFailureOrSuccessOption: none(),
                  ),
                );
              },
            );
            emit(
              state.copyWith(
                isLicensesDocSubmitting: false,
                licensesDocAuthFailureOrSuccessOption:
                    optionOf(failureOrSuccess),
              ),
            );
          } else {
            emit(
              state.copyWith(
                isLicensesDocSubmitting: false,
                showLicensesErrorMessages: true,
                licensesDocAuthFailureOrSuccessOption: none(),
              ),
            );
          }
        },
        deleteLicensesObject: (e) async {
          Either<AccountFailure, Account>? failureOrSuccess;

          emit(
            state.copyWith(
              isLicensesDocSubmitting: true,
              licensesDocAuthFailureOrSuccessOption: none(),
            ),
          );

          print("Delete Id-> ${state.professionalLicensesList[e.index].id}");
          failureOrSuccess = await _repository.deleteDocumentApi(
              credId: state.professionalLicensesList[e.index].id ?? -1);

          failureOrSuccess.fold(
            (l) => emit(
              state.copyWith(
                isLicensesDocSubmitting: false,
                professionalLicensesList:
                    List.from(state.professionalLicensesList),
              ),
            ),
            (r) {
              return emit(
                state.copyWith(
                  isLicensesDocSubmitting: false,
                  professionalLicensesList: List.from(r.document
                          ?.where((doc) => doc.document_type == 4)
                          .toList() ??
                      []),
                ),
              );
            },
          );
        },
        licensesDocSubmit: (e) async {
          final isProfessionalLicensesDocValid =
              state.professionalLicensesDoc.isValid();
          final isDocumentTitleValid = state.documentTitle.isValid();
          final isProvinceRegistrationValid =
              state.selectedProvinceRegistration.isValid();

          if (e.isSkip) {
            /// True When click on continue btn and all details are empty

            /* if (!e.isAddMoreBtnClick &&
              !isProfessionalLicensesDocValid &&
              !isDocumentTitleValid &&
              !isProvinceRegistrationValid &&
              (!state.isLicensesExpiryCheck &&
                  state.licensesExpiryDate.isEmpty)) {*/
            emit(
              state.copyWith(
                isLicensesDocSubmitting: true,
                showLicensesErrorMessages: false,
                licensesDocAuthFailureOrSuccessOption:
                    optionOf(right(const Account())),
              ),
            );
            DocumentBloc.pageController.nextPage(
                duration: const Duration(milliseconds: 10),
                curve: Curves.easeInOut);
            // }
          } else {
            /// True When click on continue - add more btn and all details are valid
            if (isProfessionalLicensesDocValid &&
                isDocumentTitleValid &&
                isProvinceRegistrationValid &&
                (state.isLicensesExpiryCheck ||
                    state.licensesExpiryDate.isNotEmpty)) {
              Either<AccountFailure, Account>? failureOrSuccess;

              emit(
                state.copyWith(
                  isLicensesDocSubmitting: true,
                  licensesDocAuthFailureOrSuccessOption: none(),
                ),
              );

              failureOrSuccess = await _repository.addMultiDocumentApi(
                documentType: 4,
                registrationNumber: state.registrationNumber,
                provinceOfRegistration:
                    state.selectedProvinceRegistration.getValue(),
                documentTitle: state.documentTitle.getValue(),
                documentFile: state.professionalLicensesDoc.getValue() ?? "",
                expiryDate: state.licensesExpiryDate,
                expiryDateNotApplicable: state.isLicensesExpiryCheck,
              );

              failureOrSuccess.fold(
                (l) => emit(
                  state.copyWith(
                    isLicensesDocSubmitting: false,
                  ),
                ),
                (r) {
                  emit(
                    state.copyWith(
                      professionalLicensesList: r.document
                              ?.where((doc) => doc.document_type == 4)
                              .toList() ??
                          [],
                      professionalLicensesDoc: InputEmptyOrNot(""),
                      documentTitle: InputEmptyOrNot(""),
                      selectedProvinceRegistration: InputEmptyOrNot(""),
                      registrationNumber: "",
                      licensesExpiryDate: "",
                      isLicensesExpiryCheck: false,
                      isLicensesDocSubmitting: false,
                      showLicensesErrorMessages: false,
                      licensesDocAuthFailureOrSuccessOption: none(),
                    ),
                  );
                  DocumentBloc.pageController.nextPage(
                    duration: const Duration(milliseconds: 10),
                    curve: Curves.easeInOut,
                  );
                },
              );
              emit(
                state.copyWith(
                  isLicensesDocSubmitting: false,
                  licensesDocAuthFailureOrSuccessOption:
                      optionOf(failureOrSuccess),
                ),
              );
            }

            /// True When click on continue - add more btn and some details are empty or not valid
            else {
              showError(
                      message: StringConstant
                          .someDetailsAreMissingOrInvalidPleaseCheck)
                  .show(e.context);
              emit(
                state.copyWith(
                  isLicensesDocSubmitting: false,
                  showLicensesErrorMessages: true,
                  licensesDocAuthFailureOrSuccessOption: none(),
                ),
              );
            }
          }
        },
      );
    });
  }
}

@injectable
class ImmunizationBloc extends Bloc<ImmunizationEvent, ImmunizationState> {
  final IAccountRepository _repository;

  ImmunizationBloc(this._repository) : super(ImmunizationState.initial()) {
    /// FOR Immunizations-Vaccinations DOCUMENT
    on<ImmunizationEvent>((event, emit) async {
      await event.map(
        getCurrentImmunizationDoc: (e) async {
          DocumentDTO? doc = e.currentCred;
          if (doc != null) {
            emit(state.copyWith(isImmunizationDocSubmitting: true));
            await Future.delayed(Duration(seconds: 1));
            emit(state.copyWith(
              immunizationName: InputEmptyOrNot(doc.name_of_vaccinations ?? ""),
              immunizationDoc: InputEmptyOrNot(doc.file ?? ""),
            ));
            emit(state.copyWith(isImmunizationDocSubmitting: false));
          }
        },
        immunizationDocUpdate: (e) async {
          final isImmunizationDocValid = state.immunizationDoc.isValid();
          final isImmunizationNameValid = state.immunizationName.isValid();

          if (e.id != null &&
              isImmunizationDocValid &&
              isImmunizationNameValid) {
            Either<AccountFailure, Account>? failureOrSuccess;

            emit(
              state.copyWith(
                isImmunizationDocSubmitting: true,
                immunizationDocAuthFailureOrSuccessOption: none(),
              ),
            );

            failureOrSuccess = await _repository.updateMultiDocumentApi(
              id: e.id ?? -1,
              documentType: 5,
              nameOfVaccinations: state.immunizationName.getValue(),
              documentFile: state.immunizationDoc.getValue() ?? "",
              // expiryDate: state.immunizationExpiryDate,
              // expiryDateNotApplicable: state.isImmunizationExpiryCheck,
            );

            failureOrSuccess.fold(
              (l) => emit(
                state.copyWith(
                  isImmunizationDocSubmitting: false,
                ),
              ),
              (r) {
                emit(
                  state.copyWith(
                    immunizationList: r.document
                            ?.where((doc) => doc.document_type == 5)
                            .toList() ??
                        [],
                    immunizationName: InputEmptyOrNot(""),
                    immunizationDoc: InputEmptyOrNot(""),
                    immunizationExpiryDate: "",
                    isImmunizationExpiryCheck: false,
                    isImmunizationDocSubmitting: false,
                    showImmunizationErrorMessages: false,
                    immunizationDocAuthFailureOrSuccessOption: none(),
                  ),
                );
                Navigator.pop(e.context, true);
              },
            );
            emit(
              state.copyWith(
                isImmunizationDocSubmitting: false,
                immunizationDocAuthFailureOrSuccessOption:
                    optionOf(failureOrSuccess),
              ),
            );
          } else {
            showError(
                    message: StringConstant
                        .someDetailsAreMissingOrInvalidPleaseCheck)
                .show(e.context);
            emit(
              state.copyWith(
                isImmunizationDocSubmitting: false,
                showImmunizationErrorMessages: true,
                immunizationDocAuthFailureOrSuccessOption: none(),
              ),
            );
          }
        },
        getImmunizationDataOnInit: (e) async {
          Either<AccountFailure, List<DocumentDTO>>? failureOrSuccess;
          emit(
            state.copyWith(
              isImmunizationDocSubmitting: true,
              immunizationDocAuthFailureOrSuccessOption: none(),
            ),
          );
          failureOrSuccess = await _repository.getDocumentApi(documentType: 5);
          failureOrSuccess.fold(
            (l) => emit(
              state.copyWith(
                isImmunizationDocSubmitting: false,
                immunizationList: [],
              ),
            ),
            (r) {
              print("r.length---> ${r.length}");
              if (r.isNotEmpty) {
                return emit(
                  state.copyWith(
                    isImmunizationDocSubmitting: false,
                    immunizationList: r,
                  ),
                );
              } else {
                return emit(
                  state.copyWith(
                    isImmunizationDocSubmitting: false,
                    immunizationList: [],
                  ),
                );
              }
            },
          );

          emit(
            state.copyWith(
              isImmunizationDocSubmitting: false,
              // licensesDocAuthFailureOrSuccessOption: optionOf(failureOrSuccess),
            ),
          );
        },
        checkNAImmunizationExpiryDate: (e) {
          emit(
            state.copyWith(
              isImmunizationExpiryCheck: e.isCheck,
              immunizationDocAuthFailureOrSuccessOption: none(),
            ),
          );
        },
        immunizationExpiryDateChanged: (e) {
          emit(
            state.copyWith(
              immunizationExpiryDate: e.expiryDate,
              immunizationDocAuthFailureOrSuccessOption: none(),
            ),
          );
        },
        immunizationsNameChanegd: (e) {
          emit(
            state.copyWith(
              immunizationName: InputEmptyOrNot(e.immunizationsName),
              isImmunizationDocSubmitting: false,
              showImmunizationErrorMessages: false,
              immunizationDocAuthFailureOrSuccessOption: none(),
            ),
          );
        },
        selectImmunizationDoc: (e) {
          emit(
            state.copyWith(
              immunizationDoc: InputEmptyOrNot(e.immunizationDoc),
              isImmunizationDocSubmitting: false,
              showImmunizationErrorMessages: false,
              immunizationDocAuthFailureOrSuccessOption: none(),
            ),
          );
        },
        deleteImmunizationDoc: (e) {
          emit(
            state.copyWith(
              immunizationDoc: InputEmptyOrNot(""),
              isImmunizationDocSubmitting: false,
              showImmunizationErrorMessages: false,
              immunizationDocAuthFailureOrSuccessOption: none(),
            ),
          );
        },
        addMoreImmunizationDoc: (e) async {
          Either<AccountFailure, Account>? failureOrSuccess;

          final isImmunizationDocValid = state.immunizationDoc.isValid();
          final isImmunizationNameValid = state.immunizationName.isValid();

          if (isImmunizationDocValid && isImmunizationNameValid
              /* &&(state.isImmunizationExpiryCheck ||
                  state.immunizationExpiryDate.isNotEmpty)*/
              ) {
            /// FROMMMMMM
            emit(
              state.copyWith(
                isImmunizationDocSubmitting: true,
                immunizationDocAuthFailureOrSuccessOption: none(),
              ),
            );

            failureOrSuccess = await _repository.addMultiDocumentApi(
              documentType: 5,
              nameOfVaccinations: state.immunizationName.getValue(),
              documentFile: state.immunizationDoc.getValue() ?? "",
              // expiryDate: state.immunizationExpiryDate,
              // expiryDateNotApplicable: state.isImmunizationExpiryCheck,
            );

            failureOrSuccess.fold(
              (l) => emit(
                state.copyWith(
                  isImmunizationDocSubmitting: false,
                ),
              ),
              (r) {
                print(
                    "Immunization List ----> ${jsonEncode(r.document!.length)}");
                emit(
                  state.copyWith(
                    immunizationList: r.document
                            ?.where((doc) => doc.document_type == 5)
                            .toList() ??
                        [],
                    immunizationName: InputEmptyOrNot(""),
                    immunizationDoc: InputEmptyOrNot(""),
                    immunizationExpiryDate: "",
                    isImmunizationExpiryCheck: false,
                    isImmunizationDocSubmitting: false,
                    showImmunizationErrorMessages: false,
                    immunizationDocAuthFailureOrSuccessOption: none(),
                  ),
                );
              },
            );
            emit(
              state.copyWith(
                isImmunizationDocSubmitting: false,
                immunizationDocAuthFailureOrSuccessOption:
                    optionOf(failureOrSuccess),
              ),
            );
          } else {
            emit(
              state.copyWith(
                isImmunizationDocSubmitting: false,
                showImmunizationErrorMessages: true,
                immunizationDocAuthFailureOrSuccessOption: none(),
              ),
            );
          }
        },
        deleteImmunizationObject: (e) async {
          Either<AccountFailure, Account>? failureOrSuccess;

          emit(
            state.copyWith(
              isImmunizationDocSubmitting: true,
              immunizationDocAuthFailureOrSuccessOption: none(),
            ),
          );

          print("Delete Id-> ${state.immunizationList[e.index].id}");
          failureOrSuccess = await _repository.deleteDocumentApi(
              credId: state.immunizationList[e.index].id ?? -1);

          failureOrSuccess.fold(
            (l) => emit(
              state.copyWith(
                isImmunizationDocSubmitting: false,
                immunizationList: List.from(state.immunizationList),
              ),
            ),
            (r) {
              return emit(
                state.copyWith(
                  isImmunizationDocSubmitting: false,
                  immunizationList: List.from(r.document
                          ?.where((doc) => doc.document_type == 5)
                          .toList() ??
                      []),
                ),
              );
            },
          );
        },
        immunizationDocSubmit: (e) async {
          final isImmunizationDocValid = state.immunizationDoc.isValid();
          final isImmunizationNameValid = state.immunizationName.isValid();

          if (e.isSkip) {
            /// True When click on continue btn and all details are empty

            /* if (!e.isAddMoreBtnClick &&
              !isImmunizationDocValid &&
              !isImmunizationNameValid &&
              (!state.isImmunizationExpiryCheck &&
                  state.immunizationExpiryDate.isEmpty)) {*/
            emit(
              state.copyWith(
                isImmunizationDocSubmitting: true,
                showImmunizationErrorMessages: false,
                immunizationDocAuthFailureOrSuccessOption:
                    optionOf(right(Account())),
              ),
            );
            DocumentBloc.pageController.nextPage(
                duration: const Duration(milliseconds: 10),
                curve: Curves.easeInOut);
            // }
          } else {
            /// True When click on continue - add more btn and all details are valid
            if (isImmunizationDocValid && isImmunizationNameValid
                /*(state.isImmunizationExpiryCheck ||
                  state.immunizationExpiryDate.isNotEmpty)*/

                ) {
              /*emit(
              state.copyWith(
                isImmunizationDocSubmitting: true,
                showImmunizationErrorMessages: false,
                immunizationDocAuthFailureOrSuccessOption:
                    optionOf(right(Account())),
              ),
            );
            DocumentBloc.pageController.nextPage(
              duration: const Duration(milliseconds: 10),
              curve: Curves.easeInOut,
            );*/

              Either<AccountFailure, Account>? failureOrSuccess;

              emit(
                state.copyWith(
                  isImmunizationDocSubmitting: true,
                  immunizationDocAuthFailureOrSuccessOption: none(),
                ),
              );

              failureOrSuccess = await _repository.addMultiDocumentApi(
                documentType: 5,
                nameOfVaccinations: state.immunizationName.getValue(),
                documentFile: state.immunizationDoc.getValue() ?? "",
                // expiryDate: state.immunizationExpiryDate,
                // expiryDateNotApplicable: state.isImmunizationExpiryCheck,
              );

              failureOrSuccess.fold(
                (l) => emit(
                  state.copyWith(
                    isImmunizationDocSubmitting: false,
                  ),
                ),
                (r) {
                  emit(
                    state.copyWith(
                      immunizationList: r.document
                              ?.where((doc) => doc.document_type == 5)
                              .toList() ??
                          [],
                      immunizationName: InputEmptyOrNot(""),
                      immunizationDoc: InputEmptyOrNot(""),
                      immunizationExpiryDate: "",
                      isImmunizationExpiryCheck: false,
                      isImmunizationDocSubmitting: false,
                      showImmunizationErrorMessages: false,
                      immunizationDocAuthFailureOrSuccessOption: none(),
                    ),
                  );
                  DocumentBloc.pageController.nextPage(
                    duration: const Duration(milliseconds: 10),
                    curve: Curves.easeInOut,
                  );
                },
              );
              emit(
                state.copyWith(
                  isImmunizationDocSubmitting: false,
                  immunizationDocAuthFailureOrSuccessOption:
                      optionOf(failureOrSuccess),
                ),
              );
            }

            /// True When click on continue - add more btn and some details are empty or not valid

            else {
              showError(
                      message: StringConstant
                          .someDetailsAreMissingOrInvalidPleaseCheck)
                  .show(e.context);
              emit(
                state.copyWith(
                  isImmunizationDocSubmitting: false,
                  showImmunizationErrorMessages: true,
                  immunizationDocAuthFailureOrSuccessOption: none(),
                ),
              );
            }
          }
        },
      );
    });
  }
}

/// FOR Professional Liability Protection DOCUMENT

@injectable
class ProfessionalLiabilityBloc
    extends Bloc<ProfessionalLiabilityEvent, ProfessionalLiabilityState> {
  final IAccountRepository _repository;

  ProfessionalLiabilityBloc(this._repository)
      : super(ProfessionalLiabilityState.initial()) {
    on<ProfessionalLiabilityEvent>((event, emit) async {
      await event.map(
        getCurrentDoc: (e) async {
          DocumentDTO? doc = e.currentCred;
          if (doc != null) {
            emit(state.copyWith(isLiabilityDocSubmitting: true));
            await Future.delayed(Duration(seconds: 1));
            emit(state.copyWith(
              liabilityDoc: InputEmptyOrNot(doc.file ?? ""),
              liabilityExpiryDate: (doc.expiry_date != null)
                  ? DateTime.fromMillisecondsSinceEpoch(
                      (doc.expiry_date ?? -1) * 1000,
                    ).toIso8601String()
                  : "",
              isLiabilityExpiryCheck:
                  (doc.expiry_date_not_applicable == 0) ? false : true,
            ));

            emit(state.copyWith(isLiabilityDocSubmitting: false));
          }
        },
        liabilityDocUpdate: (e) async {
          final isLiabilityDocValid = state.liabilityDoc.isValid();

          if (e.id != null &&
              isLiabilityDocValid &&
              (state.isLiabilityExpiryCheck ||
                  state.liabilityExpiryDate.isNotEmpty)) {
            Either<AccountFailure, Account>? failureOrSuccess;

            emit(
              state.copyWith(
                isLiabilityDocSubmitting: true,
                liabilityDocAuthFailureOrSuccessOption: none(),
              ),
            );

            failureOrSuccess = await _repository.updateMultiDocumentApi(
              id: e.id ?? -1,
              documentType: 6,
              documentFile: state.liabilityDoc.getValue() ?? "",
              expiryDate: state.liabilityExpiryDate,
              expiryDateNotApplicable: state.isLiabilityExpiryCheck,
            );

            failureOrSuccess.fold(
              (l) => emit(
                state.copyWith(
                  isLiabilityDocSubmitting: false,
                ),
              ),
              (r) {
                emit(
                  state.copyWith(
                    liabilityList: r.document
                            ?.where((doc) => doc.document_type == 6)
                            .toList() ??
                        [],
                    liabilityDoc: InputEmptyOrNot(""),
                    liabilityExpiryDate: "",
                    isLiabilityExpiryCheck: false,
                    isLiabilityDocSubmitting: false,
                    showLiabilityErrorMessages: false,
                    liabilityDocAuthFailureOrSuccessOption: none(),
                  ),
                );
                Navigator.pop(e.context, true);
              },
            );
            emit(
              state.copyWith(
                isLiabilityDocSubmitting: false,
                liabilityDocAuthFailureOrSuccessOption:
                    optionOf(failureOrSuccess),
              ),
            );
          }

          /// True When click on continue - add more btn and some details are empty or not valid
          else {
            showError(
                    message: StringConstant
                        .someDetailsAreMissingOrInvalidPleaseCheck)
                .show(e.context);
            emit(
              state.copyWith(
                isLiabilityDocSubmitting: false,
                showLiabilityErrorMessages: true,
                liabilityDocAuthFailureOrSuccessOption: none(),
              ),
            );
          }
        },
        getLiabilityList: (e) async {
          Either<AccountFailure, List<DocumentDTO>>? failureOrSuccess;
          emit(
            state.copyWith(
              isLiabilityDocSubmitting: true,
              liabilityDocAuthFailureOrSuccessOption: none(),
            ),
          );
          failureOrSuccess = await _repository.getDocumentApi(documentType: 6);
          failureOrSuccess.fold(
            (l) => emit(
              state.copyWith(
                isLiabilityDocSubmitting: false,
                liabilityList: [],
              ),
            ),
            (r) {
              print("r.length---> ${r.length}");
              if (r.isNotEmpty) {
                return emit(
                  state.copyWith(
                    isLiabilityDocSubmitting: false,
                    liabilityList: r,
                  ),
                );
              } else {
                return emit(
                  state.copyWith(
                    isLiabilityDocSubmitting: false,
                    liabilityList: [],
                  ),
                );
              }
            },
          );
          emit(
            state.copyWith(
              isLiabilityDocSubmitting: false,
              // licensesDocAuthFailureOrSuccessOption: optionOf(failureOrSuccess),
            ),
          );
        },
        checkNALiabilityExpiryDate: (e) {
          emit(
            state.copyWith(
              isLiabilityExpiryCheck: e.isCheck,
              liabilityDocAuthFailureOrSuccessOption: none(),
            ),
          );
        },
        liabilityExpiryDateChanged: (e) {
          emit(
            state.copyWith(
              liabilityExpiryDate: e.expiryDate,
              liabilityDocAuthFailureOrSuccessOption: none(),
            ),
          );
        },
        selectLiabilityDoc: (e) {
          emit(
            state.copyWith(
              liabilityDoc: InputEmptyOrNot(e.liabilityDoc),
              isLiabilityDocSubmitting: false,
              showLiabilityErrorMessages: false,
              liabilityDocAuthFailureOrSuccessOption: none(),
            ),
          );
        },
        deleteLiabilityDoc: (e) {
          emit(
            state.copyWith(
              liabilityDoc: InputEmptyOrNot(""),
              isLiabilityDocSubmitting: false,
              showLiabilityErrorMessages: false,
              liabilityDocAuthFailureOrSuccessOption: none(),
            ),
          );
        },
        addMoreLiabilityDoc: (e) async {
          Either<AccountFailure, Account>? failureOrSuccess;

          final isLiabilityDocValid = state.liabilityDoc.isValid();

          if (isLiabilityDocValid &&
              (state.isLiabilityExpiryCheck ||
                  state.liabilityExpiryDate.isNotEmpty)) {
            emit(
              state.copyWith(
                isLiabilityDocSubmitting: true,
                liabilityDocAuthFailureOrSuccessOption: none(),
              ),
            );

            failureOrSuccess = await _repository.addMultiDocumentApi(
              documentType: 6,
              documentFile: state.liabilityDoc.getValue() ?? "",
              expiryDate: state.liabilityExpiryDate,
              expiryDateNotApplicable: state.isLiabilityExpiryCheck,
            );

            failureOrSuccess.fold(
              (l) => emit(
                state.copyWith(
                  isLiabilityDocSubmitting: false,
                ),
              ),
              (r) {
                print("Liability List ----> ${jsonEncode(r.document!.length)}");
                emit(
                  state.copyWith(
                    liabilityList: r.document
                            ?.where((doc) => doc.document_type == 6)
                            .toList() ??
                        [],
                    liabilityDoc: InputEmptyOrNot(""),
                    liabilityExpiryDate: "",
                    isLiabilityExpiryCheck: false,
                    isLiabilityDocSubmitting: false,
                    showLiabilityErrorMessages: false,
                    liabilityDocAuthFailureOrSuccessOption: none(),
                  ),
                );
              },
            );
            emit(
              state.copyWith(
                isLiabilityDocSubmitting: false,
                liabilityDocAuthFailureOrSuccessOption:
                    optionOf(failureOrSuccess),
              ),
            );
          } else {
            emit(
              state.copyWith(
                isLiabilityDocSubmitting: false,
                showLiabilityErrorMessages: true,
                liabilityDocAuthFailureOrSuccessOption: none(),
              ),
            );
          }
        },
        deleteLiabilityObject: (e) async {
          Either<AccountFailure, Account>? failureOrSuccess;
          emit(
            state.copyWith(
              isLiabilityDocSubmitting: true,
              liabilityDocAuthFailureOrSuccessOption: none(),
            ),
          );

          print("Delete Id-> ${state.liabilityList[e.index].id}");
          failureOrSuccess = await _repository.deleteDocumentApi(
              credId: state.liabilityList[e.index].id ?? -1);

          failureOrSuccess.fold(
            (l) => emit(
              state.copyWith(
                isLiabilityDocSubmitting: false,
                liabilityList: List.from(state.liabilityList),
              ),
            ),
            (r) {
              return emit(
                state.copyWith(
                  isLiabilityDocSubmitting: false,
                  liabilityList: List.from(r.document
                          ?.where((doc) => doc.document_type == 6)
                          .toList() ??
                      []),
                ),
              );
            },
          );
        },
        liabilityDocSubmit: (e) async {
          final isLiabilityDocValid = state.liabilityDoc.isValid();

          if (e.isSkip) {
            /// True When click on continue btn and all details are empty
            /* if (!e.isAddMoreBtnClick &&
              !isLiabilityDocValid &&
              (!state.isLiabilityExpiryCheck &&
                  state.liabilityExpiryDate.isEmpty)) {*/
            emit(
              state.copyWith(
                isLiabilityDocSubmitting: true,
                showLiabilityErrorMessages: false,
                liabilityDocAuthFailureOrSuccessOption:
                    optionOf(right(Account())),
              ),
            );
            DocumentBloc.pageController.nextPage(
                duration: const Duration(milliseconds: 10),
                curve: Curves.easeInOut);
            // }
          } else {
            /// True When click on continue - add more btn and all details are valid
            if (isLiabilityDocValid &&
                (state.isLiabilityExpiryCheck ||
                    state.liabilityExpiryDate.isNotEmpty)) {
              Either<AccountFailure, Account>? failureOrSuccess;

              emit(
                state.copyWith(
                  isLiabilityDocSubmitting: true,
                  liabilityDocAuthFailureOrSuccessOption: none(),
                ),
              );

              failureOrSuccess = await _repository.addMultiDocumentApi(
                documentType: 6,
                documentFile: state.liabilityDoc.getValue() ?? "",
                expiryDate: state.liabilityExpiryDate,
                expiryDateNotApplicable: state.isLiabilityExpiryCheck,
              );

              failureOrSuccess.fold(
                (l) => emit(
                  state.copyWith(
                    isLiabilityDocSubmitting: false,
                  ),
                ),
                (r) {
                  emit(
                    state.copyWith(
                      liabilityList: r.document
                              ?.where((doc) => doc.document_type == 6)
                              .toList() ??
                          [],
                      liabilityDoc: InputEmptyOrNot(""),
                      liabilityExpiryDate: "",
                      isLiabilityExpiryCheck: false,
                      isLiabilityDocSubmitting: false,
                      showLiabilityErrorMessages: false,
                      liabilityDocAuthFailureOrSuccessOption: none(),
                    ),
                  );
                  DocumentBloc.pageController.nextPage(
                    duration: const Duration(milliseconds: 10),
                    curve: Curves.easeInOut,
                  );
                },
              );
              emit(
                state.copyWith(
                  isLiabilityDocSubmitting: false,
                  liabilityDocAuthFailureOrSuccessOption:
                      optionOf(failureOrSuccess),
                ),
              );
            }

            /// True When click on continue - add more btn and some details are empty or not valid
            else {
              showError(
                      message: StringConstant
                          .someDetailsAreMissingOrInvalidPleaseCheck)
                  .show(e.context);
              emit(
                state.copyWith(
                  isLiabilityDocSubmitting: false,
                  showLiabilityErrorMessages: true,
                  liabilityDocAuthFailureOrSuccessOption: none(),
                ),
              );
            }
          }
        },
      );
    });
  }
}

@injectable
class ResumeBloc extends Bloc<ResumeEvent, ResumeState> {
  final IAccountRepository _repository;

  ResumeBloc(this._repository) : super(ResumeState.initial()) {
    on<ResumeEvent>((event, emit) async {
      await event.map(
        getResumeDoc: (e) async {
          Either<AccountFailure, List<DocumentDTO>>? failureOrSuccess;
          emit(
            state.copyWith(
              isResumeDocSubmitting: true,
              resumeDocAuthFailureOrSuccessOption: none(),
            ),
          );
          failureOrSuccess = await _repository.getDocumentApi(documentType: 7);
          failureOrSuccess.fold(
            (l) => emit(
              state.copyWith(
                isResumeDocSubmitting: false,
                // resumeDoc: InputEmptyOrNot(""),
                resume: DocumentDTO(),
              ),
            ),
            (r) {
              print("r.length---> ${r.length}");
              if (r.isNotEmpty) {
                return emit(
                  state.copyWith(
                    isResumeDocSubmitting: false,
                    resume: r.firstWhere(
                      (document) => document.document_type == 7,
                      orElse: () => DocumentDTO(),
                    ),
                  ),
                );
              } else {
                return emit(
                  state.copyWith(
                    isResumeDocSubmitting: false,
                    // resumeDoc: InputEmptyOrNot(""),
                    resume: DocumentDTO(),
                  ),
                );
              }
            },
          );
          emit(
            state.copyWith(
              isResumeDocSubmitting: false,
              // licensesDocAuthFailureOrSuccessOption: optionOf(failureOrSuccess),
            ),
          );
        },
        selectResumeDoc: (e) {
          emit(
            state.copyWith(
              // resumeDoc: InputEmptyOrNot(e.resumeDoc),
              resume: DocumentDTO(
                file: e.resumeDoc,
              ),
              isResumeDocSubmitting: false,
              showResumeErrorMessages: false,
              resumeDocAuthFailureOrSuccessOption: none(),
            ),
          );
        },
        deleteResumeDoc: (e) async {
          Either<AccountFailure, Account>? failureOrSuccess;

          if (state.resume.id != null && state.resume.id != -1) {
            emit(
              state.copyWith(
                isResumeDocSubmitting: true,
                resumeDocAuthFailureOrSuccessOption: none(),
              ),
            );

            print("Delete Id-> ${state.resume.id}");
            failureOrSuccess = await _repository.deleteDocumentApi(
                credId: state.resume.id ?? -1);

            failureOrSuccess.fold(
              (l) => emit(
                state.copyWith(
                  isResumeDocSubmitting: false,
                  resume: state.resume,
                ),
              ),
              (r) {
                return emit(
                  state.copyWith(
                    isResumeDocSubmitting: false,
                    resume: r.document!.firstWhere(
                      (document) => document.document_type == 7,
                      orElse: () => DocumentDTO(),
                    ),
                  ),
                );
              },
            );
          } else {
            emit(
              state.copyWith(
                // resumeDoc: InputEmptyOrNot(""),
                resume: DocumentDTO(),
                isResumeDocSubmitting: false,
                resumeDocAuthFailureOrSuccessOption: none(),
              ),
            );
          }
        },
        resumeDocSubmit: (e) async {
          // emit(
          //   state.copyWith(
          //     isResumeDocSubmitting: true,
          //     showResumeErrorMessages: false,
          //     resumeDocAuthFailureOrSuccessOption: optionOf(right("success")),
          //   ),
          // );
          // DocumentBloc.pageController.nextPage(
          //     duration: const Duration(milliseconds: 10),
          //     curve: Curves.easeInOut);
          Either<AccountFailure, Account>? failureOrSuccess;

          if (e.isSkip) {
            emit(
              state.copyWith(
                isResumeDocSubmitting: true,
                resumeDocAuthFailureOrSuccessOption: none(),
              ),
            );
            failureOrSuccess = await _repository.addMultiDocumentApi(
              documentType: 7,
              documentFile: state.resume.file ?? "",
            );

            failureOrSuccess.fold(
              (l) => emit(
                state.copyWith(
                  isResumeDocSubmitting: false,
                ),
              ),
              (r) {
                if (r.document != null) {
                  emit(
                    state.copyWith(
                      resume: r.document!.firstWhere(
                        (document) => document.document_type == 7,
                        orElse: () => DocumentDTO(),
                      ),
                      isResumeDocSubmitting: false,
                      showResumeErrorMessages: false,
                      resumeDocAuthFailureOrSuccessOption: none(),
                    ),
                  );
                  DocumentBloc.pageController.nextPage(
                    duration: const Duration(milliseconds: 10),
                    curve: Curves.easeInOut,
                  );
                }
              },
            );
            emit(
              state.copyWith(
                isResumeDocSubmitting: false,
                resumeDocAuthFailureOrSuccessOption: optionOf(failureOrSuccess),
              ),
            );
          } else {
            emit(
              state.copyWith(
                isResumeDocSubmitting: true,
                resumeDocAuthFailureOrSuccessOption: none(),
              ),
            );

            if (state.resume.file != null && state.resume.file!.isNotEmpty) {
              if (state.resume.id != null) {
                failureOrSuccess = await _repository.updateMultiDocumentApi(
                  id: state.resume.id!,
                  documentType: 7,
                  documentFile: state.resume.file ?? "",
                );
              } else {
                failureOrSuccess = await _repository.addMultiDocumentApi(
                  documentType: 7,
                  documentFile: state.resume.file ?? "",
                );
              }
              failureOrSuccess.fold(
                (l) => emit(
                  state.copyWith(
                    isResumeDocSubmitting: false,
                  ),
                ),
                (r) {
                  if (r.document != null) {
                    emit(
                      state.copyWith(
                        resume: r.document!.firstWhere(
                          (document) => document.document_type == 7,
                          orElse: () => DocumentDTO(),
                        ),
                        isResumeDocSubmitting: false,
                        showResumeErrorMessages: false,
                        resumeDocAuthFailureOrSuccessOption: none(),
                      ),
                    );
                    DocumentBloc.pageController.nextPage(
                      duration: const Duration(milliseconds: 10),
                      curve: Curves.easeInOut,
                    );
                  }
                },
              );
              emit(
                state.copyWith(
                  isResumeDocSubmitting: false,
                  resumeDocAuthFailureOrSuccessOption:
                      optionOf(failureOrSuccess),
                ),
              );
            } else {
              showError(
                      message: StringConstant
                          .someDetailsAreMissingOrInvalidPleaseCheck)
                  .show(e.context);
              emit(
                state.copyWith(
                  isResumeDocSubmitting: false,
                  showResumeErrorMessages: true,
                  resumeDocAuthFailureOrSuccessOption: none(),
                ),
              );
            }
          }
        },
      );
    });
  }
}

@injectable
class EquipmentBloc extends Bloc<EquipmentEvent, EquipmentState> {
  final IAccountRepository _repository;

  EquipmentBloc(this._repository) : super(EquipmentState.initial()) {
    on<EquipmentEvent>((event, emit) async {
      await event.map(
        /// FOR Immunizations-Vaccinations DOCUMENT

        getCurrentEquipmentDoc: (e) async {
          DocumentDTO? doc = e.currentCred;
          if (doc != null) {
            emit(state.copyWith(isEquipmentDocSubmitting: true));
            await Future.delayed(Duration(seconds: 1));

            emit(state.copyWith(
              equipmentName: InputEmptyOrNot(doc.document_title ?? ""),
              equipmentDoc: InputEmptyOrNot(doc.file ?? ""),
            ));

            emit(state.copyWith(isEquipmentDocSubmitting: false));
          }
        },
        equipmentDocUpdate: (e) async {
          final isEquipmentDocValid = state.equipmentDoc.isValid();
          final isEquipmentNameValid = state.equipmentName.isValid();

          if (e.id != null && isEquipmentDocValid && isEquipmentNameValid) {
            Either<AccountFailure, Account>? failureOrSuccess;

            emit(
              state.copyWith(
                isEquipmentDocSubmitting: true,
                submitDocAuthFailureOrSuccessOption: none(),
              ),
            );

            failureOrSuccess = await _repository.updateMultiDocumentApi(
              id: e.id ?? -1,
              documentType: 8,
              documentFile: state.equipmentDoc.getValue() ?? "",
              documentTitle: state.equipmentName.getValue(),
            );

            failureOrSuccess.fold(
              (l) => emit(
                state.copyWith(
                  isEquipmentDocSubmitting: false,
                ),
              ),
              (r) {
                emit(
                  state.copyWith(
                    equipmentList: r.document
                            ?.where((doc) => doc.document_type == 8)
                            .toList() ??
                        [],
                    equipmentDoc: InputEmptyOrNot(""),
                    equipmentName: InputEmptyOrNot(""),
                    isEquipmentDocSubmitting: false,
                    showEquipmentErrorMessages: false,
                    submitDocAuthFailureOrSuccessOption: none(),
                  ),
                );
                Navigator.pop(e.context, true);
              },
            );
            emit(
              state.copyWith(
                isEquipmentDocSubmitting: false,
                submitDocAuthFailureOrSuccessOption: none(),
                // submitDocAuthFailureOrSuccessOption: optionOf(failureOrSuccess),
              ),
            );
          }

          /// True When click on continue - add more btn and some details are empty or not valid
          else {
            showError(
                    message: StringConstant
                        .someDetailsAreMissingOrInvalidPleaseCheck)
                .show(e.context);
            emit(
              state.copyWith(
                isEquipmentDocSubmitting: false,
                showEquipmentErrorMessages: true,
                submitDocAuthFailureOrSuccessOption: none(),
              ),
            );
          }
        },
        getEquipmentList: (e) async {
          Either<AccountFailure, List<DocumentDTO>>? failureOrSuccess;
          emit(
            state.copyWith(
              isEquipmentDocSubmitting: true,
              equipmentDocAuthFailureOrSuccessOption: none(),
            ),
          );
          failureOrSuccess = await _repository.getDocumentApi(
            documentType: 8,
          );
          failureOrSuccess.fold(
            (l) => emit(
              state.copyWith(
                isEquipmentDocSubmitting: false,
                equipmentList: [],
              ),
            ),
            (r) {
              print("r.length---> ${r.length}");
              if (r.isNotEmpty) {
                return emit(
                  state.copyWith(
                    isEquipmentDocSubmitting: false,
                    equipmentList: r,
                  ),
                );
              } else {
                return emit(
                  state.copyWith(
                    isEquipmentDocSubmitting: false,
                    equipmentList: [],
                  ),
                );
              }
            },
          );
          emit(
            state.copyWith(
              isEquipmentDocSubmitting: false,
              // licensesDocAuthFailureOrSuccessOption: optionOf(failureOrSuccess),
            ),
          );
        },
        equipmentNameChanegd: (e) {
          emit(
            state.copyWith(
              equipmentName: InputEmptyOrNot(e.equipmentName),
              isEquipmentDocSubmitting: false,
              showEquipmentErrorMessages: false,
              equipmentDocAuthFailureOrSuccessOption: none(),
            ),
          );
        },

        selectEquipmentDoc: (e) {
          emit(
            state.copyWith(
              equipmentDoc: InputEmptyOrNot(e.equipmentDoc),
              isEquipmentDocSubmitting: false,
              showEquipmentErrorMessages: false,
              equipmentDocAuthFailureOrSuccessOption: none(),
            ),
          );
        },
        deleteEquipmentDoc: (e) {
          emit(
            state.copyWith(
              equipmentDoc: InputEmptyOrNot(""),
              isEquipmentDocSubmitting: false,
              showEquipmentErrorMessages: false,
              equipmentDocAuthFailureOrSuccessOption: none(),
            ),
          );
        },
        addMoreEquipmentDoc: (e) async {
          Either<AccountFailure, Account>? failureOrSuccess;

          final isEquipmentDocValid = state.equipmentDoc.isValid();
          final isEquipmentNameValid = state.equipmentName.isValid();

          if (isEquipmentDocValid && isEquipmentNameValid) {
            emit(
              state.copyWith(
                isEquipmentDocSubmitting: true,
                equipmentDocAuthFailureOrSuccessOption: none(),
              ),
            );

            failureOrSuccess = await _repository.addMultiDocumentApi(
              documentType: 8,
              documentFile: state.equipmentDoc.getValue() ?? "",
              documentTitle: state.equipmentName.getValue(),
            );

            failureOrSuccess.fold(
              (l) => emit(
                state.copyWith(
                  isEquipmentDocSubmitting: false,
                ),
              ),
              (r) {
                print("Liability List ----> ${jsonEncode(r.document!.length)}");
                emit(
                  state.copyWith(
                    equipmentList: r.document
                            ?.where((doc) => doc.document_type == 8)
                            .toList() ??
                        [],
                    equipmentDoc: InputEmptyOrNot(""),
                    equipmentName: InputEmptyOrNot(""),
                    isEquipmentDocSubmitting: false,
                    showEquipmentErrorMessages: false,
                    equipmentDocAuthFailureOrSuccessOption: none(),
                  ),
                );
              },
            );
            emit(
              state.copyWith(
                isEquipmentDocSubmitting: false,
                equipmentDocAuthFailureOrSuccessOption:
                    optionOf(failureOrSuccess),
              ),
            );
          } else {
            emit(
              state.copyWith(
                isEquipmentDocSubmitting: false,
                showEquipmentErrorMessages: true,
                equipmentDocAuthFailureOrSuccessOption: none(),
              ),
            );
          }
        },
        deleteEquipmentObject: (e) async {
          Either<AccountFailure, Account>? failureOrSuccess;
          emit(
            state.copyWith(
              isEquipmentDocSubmitting: true,
              equipmentDocAuthFailureOrSuccessOption: none(),
            ),
          );

          print("Delete Id-> ${state.equipmentList[e.index].id}");
          failureOrSuccess = await _repository.deleteDocumentApi(
              credId: state.equipmentList[e.index].id ?? -1);

          failureOrSuccess.fold(
            (l) => emit(
              state.copyWith(
                isEquipmentDocSubmitting: false,
                equipmentList: List.from(state.equipmentList),
              ),
            ),
            (r) {
              return emit(
                state.copyWith(
                  isEquipmentDocSubmitting: false,
                  equipmentList: List.from(r.document
                          ?.where((doc) => doc.document_type == 8)
                          .toList() ??
                      []),
                ),
              );
            },
          );
        },

        equipmentDocSubmit: (e) async {
          final isEquipmentDocValid = state.equipmentDoc.isValid();
          final isEquipmentNameValid = state.equipmentName.isValid();

          if (e.isSkip) {
            /// True When click on continue btn and all details are empty
            /* if (!e.isAddMoreBtnClick &&
              !isEquipmentDocValid &&
              !isEquipmentNameValid) {*/
            Either<AccountFailure, Account>? failureOrSuccess;

            emit(
              state.copyWith(
                isEquipmentDocSubmitting: true,
                submitDocAuthFailureOrSuccessOption: none(),
              ),
            );

            failureOrSuccess = await _repository.addMultiDocumentApi(
              documentType: 8,
              documentFile: state.equipmentDoc.getValue() ?? "",
              documentTitle: state.equipmentName.getValue(),
              lastPage: "AddressProofScreen",
            );

            failureOrSuccess.fold(
              (l) => emit(
                state.copyWith(
                  isEquipmentDocSubmitting: false,
                ),
              ),
              (r) {
                emit(
                  state.copyWith(
                    equipmentList: r.document
                            ?.where((doc) => doc.document_type == 8)
                            .toList() ??
                        [],
                    equipmentDoc: InputEmptyOrNot(""),
                    equipmentName: InputEmptyOrNot(""),
                    isEquipmentDocSubmitting: false,
                    showEquipmentErrorMessages: false,
                    submitDocAuthFailureOrSuccessOption: none(),
                  ),
                );
              },
            );
            emit(
              state.copyWith(
                isEquipmentDocSubmitting: false,
                submitDocAuthFailureOrSuccessOption: optionOf(failureOrSuccess),
              ),
            );

            // emit(
            //   state.copyWith(
            //     isEquipmentDocSubmitting: true,
            //     showEquipmentErrorMessages: false,
            //     submitDocAuthFailureOrSuccessOption: optionOf(right(Account())),
            //   ),
            // );
            // }
          } else {
            /// True When click on continue - add more btn and all details are valid
            if (isEquipmentDocValid && isEquipmentNameValid) {
              Either<AccountFailure, Account>? failureOrSuccess;

              emit(
                state.copyWith(
                  isEquipmentDocSubmitting: true,
                  submitDocAuthFailureOrSuccessOption: none(),
                ),
              );

              failureOrSuccess = await _repository.addMultiDocumentApi(
                documentType: 8,
                documentFile: state.equipmentDoc.getValue() ?? "",
                documentTitle: state.equipmentName.getValue(),
                lastPage: "AddressProofScreen",
              );

              failureOrSuccess.fold(
                (l) => emit(
                  state.copyWith(
                    isEquipmentDocSubmitting: false,
                  ),
                ),
                (r) {
                  emit(
                    state.copyWith(
                      equipmentList: r.document
                              ?.where((doc) => doc.document_type == 8)
                              .toList() ??
                          [],
                      equipmentDoc: InputEmptyOrNot(""),
                      equipmentName: InputEmptyOrNot(""),
                      isEquipmentDocSubmitting: false,
                      showEquipmentErrorMessages: false,
                      submitDocAuthFailureOrSuccessOption: none(),
                    ),
                  );
                },
              );
              emit(
                state.copyWith(
                  isEquipmentDocSubmitting: false,
                  submitDocAuthFailureOrSuccessOption:
                      optionOf(failureOrSuccess),
                ),
              );
            }

            /// True When click on continue - add more btn and some details are empty or not valid
            else {
              showError(
                      message: StringConstant
                          .someDetailsAreMissingOrInvalidPleaseCheck)
                  .show(e.context);
              emit(
                state.copyWith(
                  isEquipmentDocSubmitting: false,
                  showEquipmentErrorMessages: true,
                  submitDocAuthFailureOrSuccessOption: none(),
                ),
              );
            }
          }
        },
      );
    });
  }
}
