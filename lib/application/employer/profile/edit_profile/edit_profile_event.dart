part of 'edit_profile_bloc.dart';

@freezed
class EditProfileEvent with _$EditProfileEvent {

  const factory EditProfileEvent.firstNameChanged(String firstName) =FirstNameChanged;
  const factory EditProfileEvent.lastNameChanged(String lastname) =LastNameChanged;
  const factory EditProfileEvent.companyNameChanged(String companyName) =CompanyNameChanged;
  const factory EditProfileEvent.companyDescChanged(String companyDesc) =CompanyDescChanged;

  const factory EditProfileEvent.selectCountryCode(String phoneCode, String flag) = SelectCountryCode;
  const factory EditProfileEvent.phoneNumberChanged(String phoneNumber) = PhoneNumberChanged;
  const factory EditProfileEvent.associationTextChanged(String value) = AssociationTextChanged;
  const factory EditProfileEvent.updateProfile() = UpdateProfile;



}
