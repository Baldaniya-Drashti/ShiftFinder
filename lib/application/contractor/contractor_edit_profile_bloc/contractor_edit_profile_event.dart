part of 'contractor_edit_profile_bloc.dart';

@freezed
class ContractorEditProfileEvent with _$ContractorEditProfileEvent {
  const factory ContractorEditProfileEvent.getCurrentProfileDetail() =
      GetCurrentProfileDetail;

  const factory ContractorEditProfileEvent.firstNameChanged(String firstName) =
      FirstNameChanged;

  const factory ContractorEditProfileEvent.lastNameChanged(String lastName) =
      LastNameChanged;

  const factory ContractorEditProfileEvent.changeProfilePic(String imagePath) =
      ChangeProfilePic;

  const factory ContractorEditProfileEvent.emailChanged(String email) =
      EmailChanged;

  const factory ContractorEditProfileEvent.locationAddressChanged(
      String location) = LocationAddressChanged;

  const factory ContractorEditProfileEvent.locationSelectedFromSearchList(
      Predictions selectedLocation) = _LocationSelectedFromSearchList;

  const factory ContractorEditProfileEvent.updateProfile(BuildContext context) =
      UpdateProfile;
}
