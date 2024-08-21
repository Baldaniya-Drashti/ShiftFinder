part of 'address_proof_bloc.dart';

@freezed
class AddressProofEvent with _$AddressProofEvent {
  const factory AddressProofEvent.selectAddressFrontDoc(String frontDoc) =
      SelectAddressFrontDoc;
  const factory AddressProofEvent.selectAddressBackDoc(String backDoc) =
      SelectAddressBackDoc;
  factory AddressProofEvent.selectAddressProofType(SkillDTO selectedType) =
      SelectAddressProofType;
  const factory AddressProofEvent.getAddressProof() = GetAddressProof;

  const factory AddressProofEvent.deleteAddressFrontDoc(
      String govermentFrontDoc) = DeleteAddressFrontDoc;
  const factory AddressProofEvent.deleteAddressBackDoc(
      String govermentBackDoc) = DeleteAddressBackDoc;
  const factory AddressProofEvent.addressProofSubmit(BuildContext context,
      {required bool isUpdate}) = AddressProofSubmit;
  const factory AddressProofEvent.expiryDateChanged(String expiryDate) =
      ExpiryDateChanged;
}
