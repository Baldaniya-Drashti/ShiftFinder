part of 'reference_bloc.dart';

@freezed
class ReferenceEvent with _$ReferenceEvent {
  const factory ReferenceEvent.getReferenceList() = GetReferenceList;

  const factory ReferenceEvent.deleteReference(int referenceId) =
      DeleteReference;

  const factory ReferenceEvent.tabChangeEvent(int tabIndex) = _TabChangeEvent;
  // FOR PROFESSIONAL
  const factory ReferenceEvent.jobPositionChanged(String jobPosition) =
      _JobPositionChanged;
  const factory ReferenceEvent.organizationChanged(String organization) =
      _OrganizationChanged;
  const factory ReferenceEvent.referrerChanged(String referrer) =
      _referrerChanged;
  const factory ReferenceEvent.referrerEmailChanged(String referrerEmail) =
      _ReferrerEmailChanged;
  const factory ReferenceEvent.referrerPhoneNoChanged(String referrerPhoneNo) =
      _ReferrerPhoneNoChanged;
  const factory ReferenceEvent.jobLocationChanged(String jobLocation) =
      _JobLocationChanged;
  const factory ReferenceEvent.unitDepartmentChanged(String unitDepartment) =
      _UnitDepartmentChanged;
  const factory ReferenceEvent.startDateChanged(String startDate) =
      _StartDateChanged;
  const factory ReferenceEvent.endDateChanged(String endDate) = _EndDateChanged;
  const factory ReferenceEvent.selectCountryCode(
      String phoneCode, String flag) = SelectCountryCode;
  const factory ReferenceEvent.professinalBtnPressed() = _ProfessinalBtnPressed;

  // FOR PERSONAL
  const factory ReferenceEvent.personalEmailChanged(String personalEmail) =
      _PersonalEmailChanged;
  const factory ReferenceEvent.personalPhoneNoChanged(String personalPhoneNo) =
      _PersonalPhoneNoChanged;
  const factory ReferenceEvent.contactPersonChanged(String contactPerson) =
      _ContactPersonChanged;
  const factory ReferenceEvent.professionChanged(String profession) =
      _ProfessionChanged;
  const factory ReferenceEvent.personalCountryCode(
      String phoneCode, String flag) = _PersonalCountryCode;
  const factory ReferenceEvent.personalBtnPressed() = _PersonalBtnPressed;
}
