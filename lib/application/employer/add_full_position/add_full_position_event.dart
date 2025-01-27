part of 'add_full_position_bloc.dart';

@freezed
class AddFullPositionEvent with _$AddFullPositionEvent {
  const factory AddFullPositionEvent.onCreate(BuildContext context,int? postId) = onCreate;

  const factory AddFullPositionEvent.fetchLocationList({required BuildContext context}) = FetchLocationList;

  const factory AddFullPositionEvent.onJobTypeChanged(CommonDropdownModel value) = OnJobTypeChanged;

  const factory AddFullPositionEvent.onShiftScheduleChanged(CommonDropdownModel value) = OnShiftScheduleChanged;

  const factory AddFullPositionEvent.onLocationChanged({required LocationDTO selectedLocation}) = OnLocationChanged;

  const factory AddFullPositionEvent.onCompensationTypeChanged({required int type}) = OnCompensationTypeChanged;

  const factory AddFullPositionEvent.onEstimatedDateChanged({required TimeOfDay value}) = OnEstimatedDateChanged;

  const factory AddFullPositionEvent.removeShiftSchedule(String selectedValue) = RemoveShiftSchedule;

  const factory AddFullPositionEvent.confirmShiftSchedule(List<String> shiftSchedule) = ConfirmSoftwareSkill;
  const factory AddFullPositionEvent.getEmployerFullPostingData(BuildContext context,int id) = GetEmployerFullPostingData;


  const factory AddFullPositionEvent.onContinue({
    required BuildContext context,
    required String unionBargainUnit,
    required String salaryOrRateHour,
    required String benefits,
    required String compensationPackage,
    required String jobSummary,
    required String keyResponsibility,
    required String externalInternalRelationship,
    required String requiredQualification,
    required String requiredExperience,
    required String licenseCertification,
    required String requiredSkill,
    required String others,
    required String position,
  }) = OnContinue;

  const factory AddFullPositionEvent.locationChanged(String selectedValue) = LocationChanged;

  const factory AddFullPositionEvent.locationUnitSelectionChanged(String selectedUnit) = LocationUnitSelectionChanged;
  const factory AddFullPositionEvent.selectEstimatedHour({required TimeOfDay estimatedHour}) = SelectEstimatedHour;

}
