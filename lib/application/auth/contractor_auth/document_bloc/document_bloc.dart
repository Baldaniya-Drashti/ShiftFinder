import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive/hive.dart';
import 'package:shift/domain/auth/auth_failure.dart';
import 'package:shift/domain/auth/auth_value_objects.dart';
import 'package:shift/domain/core/string_constant.dart';
import 'package:shift/infrastructure/core/network/hive_box_names.dart';
import 'package:shift/presentation/auth/contractor_auth/documents/covid_vaccination_proof.dart';
import 'package:shift/presentation/auth/contractor_auth/documents/credential_registration.dart';
import 'package:shift/presentation/auth/contractor_auth/documents/document_list.dart';
import 'package:shift/presentation/auth/contractor_auth/documents/government_issue_id.dart';
import 'package:shift/presentation/common/utils/get_cookie.dart';

part 'document_event.dart';
part 'document_state.dart';
part 'document_bloc.freezed.dart';

class DocumentBloc extends Bloc<DocumentEvent, DocumentState> {
  static final box = Hive.box(BoxNames.cotractorDocumentBox);

  static final pageController = PageController();

  static List documentPageList = const [
    DocumentList(),
    GovernmentIssueDocument(),
    CovidVaccinationDocument(),
    CredentialRegistration(),
  ];

  static List<String> appbarTitleList = [
    StringConstant.documents,
    StringConstant.governmentIssuedId,
    StringConstant.covid19VaccinationProof,
    StringConstant.credentialsRegistrations,
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

  DocumentBloc() : super(DocumentState.initial()) {
    on<DocumentEvent>((event, emit) {
      event.map(
        // GO TO NEXT PAGE
        nextPage: (e) {
          emit(state.copyWith(currentPage: e.page));
        },

        /// FOR GOVERNEMT DOCUMENT
        selectGovermentDoc: (e) {
          emit(
            state.copyWith(
              govermentDoc: InputEmptyOrNot(e.govermentDoc),
              showGovernmentIdErrorMessages: false,
              governmentDocAuthFailureOrSuccessOption: none(),
            ),
          );
        },
        deleteGovermentDoc: (e) {
          box.delete(BoxKeys.governmentIssueId);
          emit(
            state.copyWith(
              govermentDoc: InputEmptyOrNot(""),
              governmentDocAuthFailureOrSuccessOption: none(),
            ),
          );
        },
        govermentDocSubmit: (e) {
          final isGovernmentDocValid = state.govermentDoc.isValid();
          print("DOC IS VALIED--> ${isGovernmentDocValid}");
          if (isGovernmentDocValid) {
            box.put(BoxKeys.governmentIssueId, state.govermentDoc.getValue());
            emit(
              state.copyWith(
                isGovermentDocSubmitting: true,
                showGovernmentIdErrorMessages: false,
                governmentDocAuthFailureOrSuccessOption:
                    optionOf(right("success")),
              ),
            );
            DocumentBloc.pageController.nextPage(
                duration: const Duration(milliseconds: 10),
                curve: Curves.easeInOut);
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
              coviDocAuthFailureOrSuccessOption: none(),
            ),
          );
        },
        deleteCovidDoc: (e) {
          box.delete(BoxKeys.covidVaccinationDoc);
          emit(
            state.copyWith(
              covidVaccinationDoc: InputEmptyOrNot(""),
              coviDocAuthFailureOrSuccessOption: none(),
            ),
          );
        },
        covidDocSubmit: (e) {
          final isCovidDocValid = state.covidVaccinationDoc.isValid();
          if (isCovidDocValid) {
            box.put(BoxKeys.covidVaccinationDoc,
                state.covidVaccinationDoc.getValue());
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
          } else {
            emit(
              state.copyWith(
                isCovidDocSubmitting: false,
                showCovidErrorMessages: true,
                coviDocAuthFailureOrSuccessOption: none(),
              ),
            );
          }
        },
      );
    });
  }
}
