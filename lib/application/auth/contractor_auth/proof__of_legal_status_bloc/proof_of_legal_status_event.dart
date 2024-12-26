part of 'proof_of_legal_status_bloc.dart';

@freezed
class ProofOfLegalStatusEvent with _$ProofOfLegalStatusEvent {
  const factory ProofOfLegalStatusEvent.selectFrontDoc(String frontDoc) =
      SelectFrontDoc;
  const factory ProofOfLegalStatusEvent.selectBackDoc(String backDoc) =
      SelectBackDoc;
  factory ProofOfLegalStatusEvent.selectAddressProofType(
      SkillDTO selectedType) = SelectAddressProofType;
  const factory ProofOfLegalStatusEvent.getProofLegalDoc() = GetProofLegalDoc;
  const factory ProofOfLegalStatusEvent.deleteFrontDoc(String frontDoc) =
      DeleteFrontDoc;
  const factory ProofOfLegalStatusEvent.deleteBackDoc(String backDoc) =
      DeleteBackDoc;
  const factory ProofOfLegalStatusEvent.proofLegalDocSubmit(
      BuildContext context) = ProofLegalDocSubmit;
  const factory ProofOfLegalStatusEvent.expiryDateChanged(String expiryDate) =
      ExpiryDateChanged;
}
