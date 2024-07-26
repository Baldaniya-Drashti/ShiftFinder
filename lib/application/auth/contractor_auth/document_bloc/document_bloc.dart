// ignore_for_file: avoid_print, prefer_const_constructors

import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:intl/intl.dart';
import 'package:shift/domain/account/account.dart';
import 'package:shift/domain/account/account_failure.dart';
import 'package:shift/domain/account/i_account_repository.dart';
import 'package:shift/domain/auth/auth_failure.dart';
import 'package:shift/domain/auth/auth_value_objects.dart';
import 'package:shift/domain/core/string_constant.dart';
import 'package:shift/infrastructure/auth/contractor/document/upload_document_dto.dart';
import 'package:shift/infrastructure/core/document_dto/document_dto.dart';
import 'package:shift/presentation/auth/contractor_auth/documents/immunizations.dart';
import 'package:shift/presentation/auth/contractor_auth/documents/Professional_liability_protection.dart';
import 'package:shift/presentation/auth/contractor_auth/documents/apparel_equipment.dart';
import 'package:shift/presentation/auth/contractor_auth/documents/covid_vaccination_proof.dart';
import 'package:shift/presentation/auth/contractor_auth/documents/credential_registration.dart';
import 'package:shift/presentation/auth/contractor_auth/documents/document_list.dart';
import 'package:shift/presentation/auth/contractor_auth/documents/government_issue_id.dart';
import 'package:shift/presentation/auth/contractor_auth/documents/professional_licenses.dart';
import 'package:shift/presentation/auth/contractor_auth/documents/resume.dart';
import 'package:shift/presentation/common/utils/get_cookie.dart';

part 'document_event.dart';

part 'document_state.dart';

part 'document_bloc.freezed.dart';

@injectable
class DocumentBloc extends Bloc<DocumentEvent, DocumentState> {
  // static final box = Hive.box(BoxNames.cotractorDocumentBox);

  static final pageController = PageController();

  static List documentPageList = const [
    DocumentList(),
    GovernmentIssueDocument(),
    CovidVaccinationDocument(),
    CredentialRegistration(),
    ProfessionalLicenses(),
    ImmunizationsVaccinations(),
    ProfessionalLiabilityProtection(),
    ResumeDocument(),
    ApparelEquipment(),
  ];

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
        /// GO TO NEXT PAGE
        nextPage: (e) {
          emit(state.copyWith(currentPage: e.page));
        },

        getAllDocumentStatus: (e) async {
          Either<AccountFailure, List<DocumentDTO>>? failureOrSuccess;
          emit(
            state.copyWith(
              allListLoading: true,
              authFailureOrSuccessOption: none(),
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
              governmentDocAuthFailureOrSuccessOption: none(),
            ),
          );
          failureOrSuccess = await _repository.getDocumentApi(documentType: 1);
          failureOrSuccess.fold(
            (l) => emit(
              state.copyWith(
                isLoading: false,
                govermentDoc: InputEmptyOrNot(""),
                governmentExpiryDate: "",
                isGovernemtExpiryCheck: false,
              ),
            ),
            (r) {
              if (r.isNotEmpty) {
                return emit(
                  state.copyWith(
                    isLoading: false,
                    govermentDocId: (r[0].id != null) ? r[0].id! : -1,
                    govermentDoc: InputEmptyOrNot(r[0].file ?? ""),
                    governmentExpiryDate: (r[0].expiry_date != null)
                        ? DateFormat('yyyy-MM-dd').format(
                            DateTime.fromMillisecondsSinceEpoch(
                                (r[0].expiry_date ?? -1) * 1000,
                                isUtc: true),
                          )
                        : "",
                    isGovernemtExpiryCheck:
                        (r[0].expiry_date_not_applicable == 0) ? false : true,
                  ),
                );
              } else {
                return emit(
                  state.copyWith(
                    isLoading: false,
                    govermentDoc: InputEmptyOrNot(""),
                    governmentExpiryDate: "",
                    isGovernemtExpiryCheck: false,
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
        govermentDocSubmit: (e) async {
          Either<AccountFailure, String>? failureOrSuccess;

          final isGovernmentDocValid = state.govermentDoc.isValid();

          print("DOC IS VALID--> ${state.govermentDoc}");
          print("DOC IS VALID--> ${state.govermentDocId}");
          print("DOC IS VALID111--> ${state.isGovernemtExpiryCheck}");
          print("DOC IS VALID222--> ${state.governmentExpiryDate}");
          if ((state.isGovernemtExpiryCheck ||
                  state.governmentExpiryDate.isNotEmpty) &&
              isGovernmentDocValid) {
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
                documentFile: state.govermentDoc.getValue() ?? "",
                expiryDate: state.governmentExpiryDate,
                expiryDateNotApplicable: state.isGovernemtExpiryCheck,
              );
            } else {
              failureOrSuccess = await _repository.addDocumentApi(
                documentType: 1,
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

        /// FOR COVID DOCUMENT
        getCovidDoc: (e) async {
          Either<AccountFailure, List<DocumentDTO>>? failureOrSuccess;
          emit(
            state.copyWith(
              isLoading: true,
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
        deleteCovidDoc: (e) {
          emit(
            state.copyWith(
              covidVaccinationDoc: InputEmptyOrNot(""),
              isCovidDocSubmitting: false,
              coviDocAuthFailureOrSuccessOption: none(),
            ),
          );
        },
        covidDocSubmit: (e) async {
          Either<AccountFailure, String>? failureOrSuccess;

          final isCovidDocValid = state.covidVaccinationDoc.isValid();
          // if (isCovidDocValid) {
          // emit(
          //   state.copyWith(
          //     isCovidDocSubmitting: true,
          //     showCovidErrorMessages: false,
          //     coviDocAuthFailureOrSuccessOption: optionOf(right("success")),
          //   ),
          // );

          emit(
            state.copyWith(
              isCovidDocSubmitting: true,
              coviDocAuthFailureOrSuccessOption: none(),
            ),
          );

          if (state.covidDocId != -1) {
            failureOrSuccess = await _repository.updateDocumentApi(
              id: state.covidDocId,
              documentType: 2,
              documentFile: state.covidVaccinationDoc.getValue() ?? "",
            );
          } else if (state.covidVaccinationDoc.isValid()) {
            failureOrSuccess = await _repository.addDocumentApi(
              documentType: 2,
              documentFile: state.covidVaccinationDoc.getValue() ?? "",
            );
          } else {
            failureOrSuccess = right("success");
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
        },
      );
    });
  }
}

class CredentialBloc extends Bloc<CredentialEvent, CredentialState> {
  final IAccountRepository _repository;

  CredentialBloc(this._repository) : super(CredentialState.initial()) {
    on<CredentialEvent>((event, emit) async {
      await event.map(
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

          /// True When click on continue btn and all details are empty
          else if (!e.isAddMoreBtnClick &&
              !isCredentialDocValid &&
              !isDocumentTitleValid &&
              !isProvinceRegistrationValid &&
              (!state.isCredExpiryCheck &&
                  state.credentialExpiryDate.isEmpty)) {
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
          }

          /// True When click on continue - add more btn and some details are empty or not valid

          else {
            emit(
              state.copyWith(
                isCredintialDocSubmitting: false,
                showCredintialErrorMessages: true,
                credintialDocAuthFailureOrSuccessOption: none(),
              ),
            );
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

          /// True When click on continue btn and all details are empty

          else if (!e.isAddMoreBtnClick &&
              !isProfessionalLicensesDocValid &&
              !isDocumentTitleValid &&
              !isProvinceRegistrationValid &&
              (!state.isLicensesExpiryCheck &&
                  state.licensesExpiryDate.isEmpty)) {
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
          }

          /// True When click on continue - add more btn and some details are empty or not valid

          else {
            emit(
              state.copyWith(
                isLicensesDocSubmitting: false,
                showLicensesErrorMessages: true,
                licensesDocAuthFailureOrSuccessOption: none(),
              ),
            );
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

          if (isImmunizationDocValid &&
              isImmunizationNameValid &&
              (state.isImmunizationExpiryCheck ||
                  state.immunizationExpiryDate.isNotEmpty)) {
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
              expiryDate: state.immunizationExpiryDate,
              expiryDateNotApplicable: state.isImmunizationExpiryCheck,
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

          /// True When click on continue - add more btn and all details are valid
          if (isImmunizationDocValid &&
              isImmunizationNameValid &&
              (state.isImmunizationExpiryCheck ||
                  state.immunizationExpiryDate.isNotEmpty)) {
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
              expiryDate: state.immunizationExpiryDate,
              expiryDateNotApplicable: state.isImmunizationExpiryCheck,
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

          /// True When click on continue btn and all details are empty

          else if (!e.isAddMoreBtnClick &&
              !isImmunizationDocValid &&
              !isImmunizationNameValid &&
              (!state.isImmunizationExpiryCheck &&
                  state.immunizationExpiryDate.isEmpty)) {
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
          }

          /// True When click on continue - add more btn and some details are empty or not valid

          else {
            emit(
              state.copyWith(
                isImmunizationDocSubmitting: false,
                showImmunizationErrorMessages: true,
                immunizationDocAuthFailureOrSuccessOption: none(),
              ),
            );
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

          /// True When click on continue btn and all details are empty
          else if (!e.isAddMoreBtnClick &&
              !isLiabilityDocValid &&
              (!state.isLiabilityExpiryCheck &&
                  state.liabilityExpiryDate.isEmpty)) {
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
          }

          /// True When click on continue - add more btn and some details are empty or not valid
          else {
            emit(
              state.copyWith(
                isLiabilityDocSubmitting: false,
                showLiabilityErrorMessages: true,
                liabilityDocAuthFailureOrSuccessOption: none(),
              ),
            );
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
                    resume:
                        r.firstWhere((document) => document.document_type == 7),
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
                    resume: r.document!
                        .firstWhere((document) => document.document_type == 7),
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

        getEquipmentList: (e) async {
          Either<AccountFailure, List<DocumentDTO>>? failureOrSuccess;
          emit(
            state.copyWith(
              isEquipmentDocSubmitting: true,
              equipmentDocAuthFailureOrSuccessOption: none(),
            ),
          );
          failureOrSuccess = await _repository.getDocumentApi(documentType: 8);
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
          }

          /// True When click on continue btn and all details are empty
          else if (!e.isAddMoreBtnClick &&
              !isEquipmentDocValid &&
              !isEquipmentNameValid) {
            emit(
              state.copyWith(
                isEquipmentDocSubmitting: true,
                showEquipmentErrorMessages: false,
                submitDocAuthFailureOrSuccessOption: optionOf(right(Account())),
              ),
            );
          }

          /// True When click on continue - add more btn and some details are empty or not valid
          else {
            emit(
              state.copyWith(
                isEquipmentDocSubmitting: false,
                showEquipmentErrorMessages: true,
                submitDocAuthFailureOrSuccessOption: none(),
              ),
            );
          }
        },
      );
    });
  }
}
