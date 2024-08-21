part of 'background_doc_bloc.dart';

@freezed
class BackgroundDocEvent with _$BackgroundDocEvent {
  const factory BackgroundDocEvent.selectBGFrontDoc(String frontDoc) =
      SelectBGFrontDoc;
  const factory BackgroundDocEvent.selectBGBackDoc(String backDoc) =
      SelectBGBackDoc;
  factory BackgroundDocEvent.selectBGProofType(SkillDTO selectedType) =
      SelectBGProofType;
  const factory BackgroundDocEvent.getBGProofDoc() = GetBGProofDoc;

  const factory BackgroundDocEvent.deleteBGFrontDoc(String govermentFrontDoc) =
      DeleteBGFrontDoc;
  const factory BackgroundDocEvent.deleteBGBackDoc(String govermentBackDoc) =
      DeleteBGBackDoc;
  const factory BackgroundDocEvent.bgProofSubmit(BuildContext context,
      {required bool isUpdate}) = BGProofSubmit;
  const factory BackgroundDocEvent.backgroundDocIssueDateChanged(
      String expiryDate) = BackgroundDocIssueDateChanged;
}
