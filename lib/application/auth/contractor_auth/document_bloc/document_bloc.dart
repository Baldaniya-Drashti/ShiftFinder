// ignore_for_file: avoid_print

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

  static bool isDocSubmit(int index) {
    switch (index) {
      case 0:
        return (getGovernmentIssueId().isNotEmpty);
      case 1:
        return (getCovidVaccinationDoc().isNotEmpty);
      default:
        return false;
    }
  }

  final IAccountRepository _repository;

  DocumentBloc(this._repository) : super(DocumentState.initial()) {
    on<DocumentEvent>((event, emit) async {
      await event.map(
        /// GO TO NEXT PAGE
        nextPage: (e) {
          emit(state.copyWith(currentPage: e.page));
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
              print("r.length---> ${r.length}");
              if (r.isNotEmpty) {
                return emit(
                  state.copyWith(
                    isLoading: false,
                    govermentDoc: InputEmptyOrNot(r[0].file ?? ""),
                    governmentExpiryDate: (r[0].expiry_date != null)
                        ? DateFormat('yyyy-MM-dd').format(
                            DateTime.fromMillisecondsSinceEpoch(
                                r[0].expiry_date ?? 0),
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

          print("DOC IS VALID--> $isGovernmentDocValid");
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
            failureOrSuccess = await _repository.addDocumentApi(
              documentType: 1,
              documentFile: state.govermentDoc.getValue() ?? "",
              expiryDate: state.governmentExpiryDate,
              expiryDateNotApplicable: state.isGovernemtExpiryCheck,
            );
            failureOrSuccess.fold(
              (l) => emit(
                state.copyWith(
                  isSubmitting: false,
                  govermentDoc: InputEmptyOrNot(""),
                  governmentExpiryDate: "",
                  isGovernemtExpiryCheck: false,
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

            // emit(
            //   state.copyWith(
            //     isGovermentDocSubmitting: true,
            //     showGovernmentIdErrorMessages: false,
            //     // governmentDocAuthFailureOrSuccessOption:
            //     //     optionOf(right("success")),
            //   ),
            // );
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
        covidDocSubmit: (e) {
          final isCovidDocValid = state.covidVaccinationDoc.isValid();
          // if (isCovidDocValid) {
          emit(
            state.copyWith(
              isCovidDocSubmitting: true,
              showCovidErrorMessages: false,
              coviDocAuthFailureOrSuccessOption: optionOf(right("success")),
            ),
          );
          DocumentBloc.pageController.nextPage(
              duration: const Duration(milliseconds: 10),
              curve: Curves.easeInOut);
          // } else {
          //   emit(
          //     state.copyWith(
          //       isCovidDocSubmitting: false,
          //       showCovidErrorMessages: true,
          //       coviDocAuthFailureOrSuccessOption: none(),
          //     ),
          //   );
          // }
        },

        /// FOR CREDENTIALS-REGISTRATION DOCUMENT
        // registrationNumberChanegd: (e) {
        //   emit(
        //     state.copyWith(
        //       registrationNumber: e.registrationNo,
        //       isCredintialDocSubmitting: false,
        //       showCredintialErrorMessages: false,
        //       credintialDocAuthFailureOrSuccessOption: none(),
        //     ),
        //   );
        // },
        // documentTitleChanged: (e) {
        //   emit(
        //     state.copyWith(
        //       documentTitle: InputEmptyOrNot(e.documentTitle),
        //       isCredintialDocSubmitting: false,
        //       showCredintialErrorMessages: false,
        //       credintialDocAuthFailureOrSuccessOption: none(),
        //     ),
        //   );
        // },
        // selectProvinceRegistration: (e) {
        //   emit(
        //     state.copyWith(
        //       selectedProvinceRegistration:
        //           InputEmptyOrNot(e.provinceRegistration),
        //       isCredintialDocSubmitting: false,
        //       showCredintialErrorMessages: false,
        //       credintialDocAuthFailureOrSuccessOption: none(),
        //     ),
        //   );
        // },
        // selectCredentialDoc: (e) {
        //   emit(
        //     state.copyWith(
        //       credentialRegistrationDoc: InputEmptyOrNot(e.credentialDoc),
        //       isCredintialDocSubmitting: false,
        //       showCredintialErrorMessages: false,
        //       credintialDocAuthFailureOrSuccessOption: none(),
        //     ),
        //   );
        // },
        // deleteCredentialDoc: (e) {
        //   emit(
        //     state.copyWith(
        //       credentialRegistrationDoc: InputEmptyOrNot(""),
        //       isCredintialDocSubmitting: false,
        //       showCredintialErrorMessages: false,
        //       credintialDocAuthFailureOrSuccessOption: none(),
        //     ),
        //   );
        // },
        // addMoreCredentialDoc: (e) {
        //   final isCredentialDocValid =
        //       state.credentialRegistrationDoc.isValid();
        //   final isDocumentTitleValid = state.documentTitle.isValid();
        //   final isProvinceRegistrationValid =
        //       state.selectedProvinceRegistration.isValid();
        //   if (isCredentialDocValid &&
        //       isDocumentTitleValid &&
        //       isProvinceRegistrationValid) {
        //     emit(
        //       state.copyWith(
        //         credentialRegistrationList: [
        //           ...state.credentialRegistrationList,
        //           CredentialRegistrationDTO(
        //             registrationNo: state.registrationNumber,
        //             provinceRegistration:
        //                 state.selectedProvinceRegistration.getValue(),
        //             documentTitle: state.documentTitle.getValue(),
        //             credentialDocument:
        //                 state.credentialRegistrationDoc.getValue(),
        //           )
        //         ],
        //         credentialRegistrationDoc: InputEmptyOrNot(""),
        //         documentTitle: InputEmptyOrNot(""),
        //         selectedProvinceRegistration: InputEmptyOrNot(""),
        //         registrationNumber: "",
        //         isCredintialDocSubmitting: false,
        //         showCredintialErrorMessages: false,
        //         credintialDocAuthFailureOrSuccessOption: none(),
        //       ),
        //     );
        //   } else {
        //     emit(
        //       state.copyWith(
        //         isCredintialDocSubmitting: false,
        //         showCredintialErrorMessages: true,
        //         credintialDocAuthFailureOrSuccessOption: none(),
        //       ),
        //     );
        //   }
        // },
        // deleteCredentialObject: (e) {
        //   emit(
        //     state.copyWith(
        //       credentialRegistrationList:
        //           List.from(state.credentialRegistrationList)
        //             ..removeAt(e.index),
        //       isCredintialDocSubmitting: false,
        //       showCredintialErrorMessages: false,
        //       credintialDocAuthFailureOrSuccessOption: none(),
        //     ),
        //   );
        // },

        // credentialDocSubmit: (e) {
        //   final isCredentialDocValid =
        //       state.credentialRegistrationDoc.isValid();
        //   final isDocumentTitleValid = state.documentTitle.isValid();
        //   final isProvinceRegistrationValid =
        //       state.selectedProvinceRegistration.isValid();

        //   /// True When click on continue - add more btn and all details are valid
        //   if (isCredentialDocValid &&
        //       isDocumentTitleValid &&
        //       isProvinceRegistrationValid) {
        //     emit(
        //       state.copyWith(
        //         isCredintialDocSubmitting: true,
        //         showCredintialErrorMessages: false,
        //         credintialDocAuthFailureOrSuccessOption:
        //             optionOf(right("success")),
        //       ),
        //     );
        //     DocumentBloc.pageController.nextPage(
        //       duration: const Duration(milliseconds: 10),
        //       curve: Curves.easeInOut,
        //     );
        //   }

        //   /// True When click on continue btn and all details are empty

        //   else if (!e.isAddMoreBtnClick &&
        //       !isCredentialDocValid &&
        //       !isDocumentTitleValid &&
        //       !isProvinceRegistrationValid) {
        //     emit(
        //       state.copyWith(
        //         isCredintialDocSubmitting: true,
        //         showCredintialErrorMessages: false,
        //         credintialDocAuthFailureOrSuccessOption:
        //             optionOf(right("success")),
        //       ),
        //     );
        //     DocumentBloc.pageController.nextPage(
        //         duration: const Duration(milliseconds: 10),
        //         curve: Curves.easeInOut);
        //   }

        //   /// True When click on continue - add more btn and some details are empty or not valid

        //   else {
        //     emit(
        //       state.copyWith(
        //         isCredintialDocSubmitting: false,
        //         showCredintialErrorMessages: true,
        //         credintialDocAuthFailureOrSuccessOption: none(),
        //       ),
        //     );
        //   }
        // },
      );
    });
  }
}

class CredentialBloc extends Bloc<CredentialEvent, CredentialState> {
  CredentialBloc() : super(CredentialState.initial()) {
    on<CredentialEvent>((event, emit) {
      event.map(
        /// FOR CREDENTIALS-REGISTRATION DOCUMENT
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
        addMoreCredentialDoc: (e) {
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
            emit(
              state.copyWith(
                credentialRegistrationList: [
                  ...state.credentialRegistrationList,
                  CredentialRegistrationDTO(
                    registrationNo: state.registrationNumber,
                    provinceRegistration:
                        state.selectedProvinceRegistration.getValue(),
                    documentTitle: state.documentTitle.getValue(),
                    credentialDocument:
                        state.credentialRegistrationDoc.getValue(),
                    expiryDate: state.credentialExpiryDate,
                    isExpiryNotApplicable: state.isCredExpiryCheck,
                  )
                ],
                credentialRegistrationDoc: InputEmptyOrNot(""),
                documentTitle: InputEmptyOrNot(""),
                selectedProvinceRegistration: InputEmptyOrNot(""),
                registrationNumber: "",
                isCredintialDocSubmitting: false,
                showCredintialErrorMessages: false,
                credintialDocAuthFailureOrSuccessOption: none(),
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
        deleteCredentialObject: (e) {
          emit(
            state.copyWith(
              credentialRegistrationList:
                  List.from(state.credentialRegistrationList)
                    ..removeAt(e.index),
              isCredintialDocSubmitting: false,
              showCredintialErrorMessages: false,
              credintialDocAuthFailureOrSuccessOption: none(),
            ),
          );
        },

        credentialDocSubmit: (e) {
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
            emit(
              state.copyWith(
                isCredintialDocSubmitting: true,
                showCredintialErrorMessages: false,
                credintialDocAuthFailureOrSuccessOption:
                    optionOf(right("success")),
              ),
            );
            DocumentBloc.pageController.nextPage(
              duration: const Duration(milliseconds: 10),
              curve: Curves.easeInOut,
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
                    optionOf(right("success")),
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

class ProfessionalLicensesBloc
    extends Bloc<ProfessionalLicensesEvent, ProfessionalLicensesState> {
  ProfessionalLicensesBloc() : super(ProfessionalLicensesState.initial()) {
    on<ProfessionalLicensesEvent>((event, emit) {
      event.map(
        /// FOR PROFESSIONAL LICENSES DOCUMENT
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
        addMoreLicensesDoc: (e) {
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
            emit(
              state.copyWith(
                professionalLicensesList: [
                  ...state.professionalLicensesList,
                  CredentialRegistrationDTO(
                    registrationNo: state.registrationNumber,
                    provinceRegistration:
                        state.selectedProvinceRegistration.getValue(),
                    documentTitle: state.documentTitle.getValue(),
                    credentialDocument:
                        state.professionalLicensesDoc.getValue(),
                    expiryDate: state.licensesExpiryDate,
                    isExpiryNotApplicable: state.isLicensesExpiryCheck,
                  )
                ],
                professionalLicensesDoc: InputEmptyOrNot(""),
                documentTitle: InputEmptyOrNot(""),
                isLicensesExpiryCheck: false,
                licensesExpiryDate: "",
                selectedProvinceRegistration: InputEmptyOrNot(""),
                registrationNumber: "",
                isLicensesDocSubmitting: false,
                showLicensesErrorMessages: false,
                licensesDocAuthFailureOrSuccessOption: none(),
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
        deleteLicensesObject: (e) {
          emit(
            state.copyWith(
              professionalLicensesList:
                  List.from(state.professionalLicensesList)..removeAt(e.index),
              isLicensesDocSubmitting: false,
              showLicensesErrorMessages: false,
              licensesDocAuthFailureOrSuccessOption: none(),
            ),
          );
        },

        licensesDocSubmit: (e) {
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
            emit(
              state.copyWith(
                isLicensesDocSubmitting: true,
                showLicensesErrorMessages: false,
                licensesDocAuthFailureOrSuccessOption:
                    optionOf(right("success")),
              ),
            );
            DocumentBloc.pageController.nextPage(
              duration: const Duration(milliseconds: 10),
              curve: Curves.easeInOut,
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
                    optionOf(right("success")),
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

class ImmunizationBloc extends Bloc<ImmunizationEvent, ImmunizationState> {
  ImmunizationBloc() : super(ImmunizationState.initial()) {
    // List<ImmunizationDTO> updateTestImmunizationList = [
    //   ImmunizationDTO(
    //     nameOfImmunization: "Drashti",
    //     immunizationDocument:
    //         "/data/user/0/com.example.shift/cache/scaled_21abbedf-e13c-42e1-8f3f-01507d63ddac7217170039923975474.jpg",
    //   ),
    //   ImmunizationDTO(
    //     nameOfImmunization: "Test",
    //     immunizationDocument:
    //         "/data/user/0/com.example.shift/cache/scaled_21abbedf-e13c-42e1-8f3f-01507d63ddac7217170039923975474.jpg",
    //   ),
    //   ImmunizationDTO(
    //     nameOfImmunization: "Company",
    //     immunizationDocument:
    //         "/data/user/0/com.example.shift/cache/scaled_21abbedf-e13c-42e1-8f3f-01507d63ddac7217170039923975474.jpg",
    //   ),
    //   ImmunizationDTO(
    //     nameOfImmunization: "New Branch",
    //     immunizationDocument:
    //         "/data/user/0/com.example.shift/cache/scaled_21abbedf-e13c-42e1-8f3f-01507d63ddac7217170039923975474.jpg",
    //   ),
    //   ImmunizationDTO(
    //     nameOfImmunization: "COMCNX",
    //     immunizationDocument:
    //         "/data/user/0/com.example.shift/cache/scaled_21abbedf-e13c-42e1-8f3f-01507d63ddac7217170039923975474.jpg",
    //   ),
    // ];

    /// FOR Immunizations-Vaccinations DOCUMENT
    on<ImmunizationEvent>((event, emit) {
      event.map(
        getImmunizationDataOnInit: (e) {
          // emit(
          //   state.copyWith(
          //     immunizationList: updateTestImmunizationList,
          //     showImmunizationErrorMessages: false,
          //     immunizationDocAuthFailureOrSuccessOption: none(),
          //   ),
          // );
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
        addMoreImmunizationDoc: (e) {
          final isImmunizationDocValid = state.immunizationDoc.isValid();
          final isImmunizationNameValid = state.immunizationName.isValid();

          if (isImmunizationDocValid &&
              isImmunizationNameValid &&
              (state.isImmunizationExpiryCheck ||
                  state.immunizationExpiryDate.isNotEmpty)) {
            emit(
              state.copyWith(
                immunizationList: [
                  ...state.immunizationList,
                  ImmunizationDTO(
                    nameOfImmunization: state.immunizationName.getValue(),
                    immunizationDocument: state.immunizationDoc.getValue(),
                    expiryDate: state.immunizationExpiryDate,
                    isExpiryNotApplicable: state.isImmunizationExpiryCheck,
                  )
                ],
                immunizationDoc: InputEmptyOrNot(""),
                immunizationName: InputEmptyOrNot(""),
                isImmunizationDocSubmitting: false,
                immunizationExpiryDate: "",
                isImmunizationExpiryCheck: false,
                showImmunizationErrorMessages: false,
                immunizationDocAuthFailureOrSuccessOption: none(),
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
        deleteImmunizationObject: (e) {
          emit(
            state.copyWith(
              immunizationList: List.from(state.immunizationList)
                ..removeAt(e.index),
              isImmunizationDocSubmitting: false,
              showImmunizationErrorMessages: false,
              immunizationDocAuthFailureOrSuccessOption: none(),
            ),
          );
        },
        immunizationDocSubmit: (e) {
          final isImmunizationDocValid = state.immunizationDoc.isValid();
          final isImmunizationNameValid = state.immunizationName.isValid();

          /// True When click on continue - add more btn and all details are valid
          if (isImmunizationDocValid &&
              isImmunizationNameValid &&
              (state.isImmunizationExpiryCheck ||
                  state.immunizationExpiryDate.isNotEmpty)) {
            emit(
              state.copyWith(
                isImmunizationDocSubmitting: true,
                showImmunizationErrorMessages: false,
                immunizationDocAuthFailureOrSuccessOption:
                    optionOf(right("success")),
              ),
            );
            DocumentBloc.pageController.nextPage(
              duration: const Duration(milliseconds: 10),
              curve: Curves.easeInOut,
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
                    optionOf(right("success")),
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
class ProfessionalLiabilityBloc
    extends Bloc<ProfessionalLiabilityEvent, ProfessionalLiabilityState> {
  ProfessionalLiabilityBloc() : super(ProfessionalLiabilityState.initial()) {
    on<ProfessionalLiabilityEvent>((event, emit) {
      event.map(
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
        addMoreLiabilityDoc: (e) {
          final isLiabilityDocValid = state.liabilityDoc.isValid();

          if (isLiabilityDocValid &&
              (state.isLiabilityExpiryCheck ||
                  state.liabilityExpiryDate.isNotEmpty)) {
            emit(
              state.copyWith(
                liabilityList: [
                  ...state.liabilityList,
                  ImmunizationDTO(
                    immunizationDocument: state.liabilityDoc.getValue(),
                    expiryDate: state.liabilityExpiryDate,
                    isExpiryNotApplicable: state.isLiabilityExpiryCheck,
                  )
                ],
                liabilityDoc: InputEmptyOrNot(""),
                isLiabilityExpiryCheck: false,
                liabilityExpiryDate: "",
                isLiabilityDocSubmitting: false,
                showLiabilityErrorMessages: false,
                liabilityDocAuthFailureOrSuccessOption: none(),
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
        deleteLiabilityObject: (e) {
          emit(
            state.copyWith(
              liabilityList: List.from(state.liabilityList)..removeAt(e.index),
              isLiabilityDocSubmitting: false,
              showLiabilityErrorMessages: false,
              liabilityDocAuthFailureOrSuccessOption: none(),
            ),
          );
        },
        liabilityDocSubmit: (e) {
          final isLiabilityDocValid = state.liabilityDoc.isValid();

          /// True When click on continue - add more btn and all details are valid
          if (isLiabilityDocValid &&
              (state.isLiabilityExpiryCheck ||
                  state.liabilityExpiryDate.isNotEmpty)) {
            emit(
              state.copyWith(
                isLiabilityDocSubmitting: true,
                showLiabilityErrorMessages: false,
                liabilityDocAuthFailureOrSuccessOption:
                    optionOf(right("success")),
              ),
            );
            DocumentBloc.pageController.nextPage(
              duration: const Duration(milliseconds: 10),
              curve: Curves.easeInOut,
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
                    optionOf(right("success")),
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

class ResumeBloc extends Bloc<ResumeEvent, ResumeState> {
  ResumeBloc() : super(ResumeState.initial()) {
    on<ResumeEvent>((event, emit) {
      event.map(
        selectResumeDoc: (e) {
          emit(
            state.copyWith(
              resumeDoc: InputEmptyOrNot(e.resumeDoc),
              isResumeDocSubmitting: false,
              showResumeErrorMessages: false,
              resumeDocAuthFailureOrSuccessOption: none(),
            ),
          );
        },
        deleteResumeDoc: (e) {
          emit(
            state.copyWith(
              resumeDoc: InputEmptyOrNot(""),
              isResumeDocSubmitting: false,
              resumeDocAuthFailureOrSuccessOption: none(),
            ),
          );
        },
        resumeDocSubmit: (e) {
          emit(
            state.copyWith(
              isResumeDocSubmitting: true,
              showResumeErrorMessages: false,
              resumeDocAuthFailureOrSuccessOption: optionOf(right("success")),
            ),
          );
          DocumentBloc.pageController.nextPage(
              duration: const Duration(milliseconds: 10),
              curve: Curves.easeInOut);
        },
      );
    });
  }
}

class EquipmentBloc extends Bloc<EquipmentEvent, EquipmentState> {
  EquipmentBloc() : super(EquipmentState.initial()) {
    on<EquipmentEvent>((event, emit) {
      event.map(
        /// FOR Immunizations-Vaccinations DOCUMENT

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
        addMoreEquipmentDoc: (e) {
          final isEquipmentDocValid = state.equipmentDoc.isValid();
          final isEquipmentNameValid = state.equipmentName.isValid();

          if (isEquipmentDocValid && isEquipmentNameValid) {
            emit(
              state.copyWith(
                equipmentList: [
                  ...state.equipmentList,
                  ImmunizationDTO(
                    nameOfImmunization: state.equipmentName.getValue(),
                    immunizationDocument: state.equipmentDoc.getValue(),
                  )
                ],
                equipmentDoc: InputEmptyOrNot(""),
                equipmentName: InputEmptyOrNot(""),
                isEquipmentDocSubmitting: false,
                showEquipmentErrorMessages: false,
                equipmentDocAuthFailureOrSuccessOption: none(),
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
        deleteEquipmentObject: (e) {
          emit(
            state.copyWith(
              equipmentList: List.from(state.equipmentList)..removeAt(e.index),
              isEquipmentDocSubmitting: false,
              showEquipmentErrorMessages: false,
              equipmentDocAuthFailureOrSuccessOption: none(),
            ),
          );
        },

        equipmentDocSubmit: (e) {
          final isEquipmentDocValid = state.equipmentDoc.isValid();
          final isEquipmentNameValid = state.equipmentName.isValid();

          /// True When click on continue - add more btn and all details are valid
          if (isEquipmentDocValid && isEquipmentNameValid) {
            emit(
              state.copyWith(
                isEquipmentDocSubmitting: true,
                showEquipmentErrorMessages: false,
                equipmentDocAuthFailureOrSuccessOption:
                    optionOf(right("success")),
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
                equipmentDocAuthFailureOrSuccessOption:
                    optionOf(right("success")),
              ),
            );
          }

          /// True When click on continue - add more btn and some details are empty or not valid
          else {
            emit(
              state.copyWith(
                isEquipmentDocSubmitting: false,
                showEquipmentErrorMessages: true,
                equipmentDocAuthFailureOrSuccessOption: none(),
              ),
            );
          }
        },
      );
    });
  }
}
