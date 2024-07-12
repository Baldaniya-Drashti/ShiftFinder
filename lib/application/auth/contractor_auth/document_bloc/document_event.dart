part of 'document_bloc.dart';

@freezed
class DocumentEvent with _$DocumentEvent {
  const factory DocumentEvent.nextPage(int page) = _NextPage;
  // FOR GOVERNMENT DOCUMENT
  const factory DocumentEvent.selectGovermentDoc(String govermentDoc) =
      _SelectGovermentDoc;
  const factory DocumentEvent.deleteGovermentDoc(String govermentDoc) =
      _DeleteGovermentDoc;
  const factory DocumentEvent.govermentDocSubmit() = _GovermentDocSubmit;

  // FOR COVID DOCUMENT
  const factory DocumentEvent.selectCovidVaccinationDoc(String covidDoc) =
      _SelectCovidVaccinationDoc;
  const factory DocumentEvent.deleteCovidDoc(String covidDoc) = _DeleteCovidDoc;
  const factory DocumentEvent.covidDocSubmit() = _CovidDocSubmit;
}
