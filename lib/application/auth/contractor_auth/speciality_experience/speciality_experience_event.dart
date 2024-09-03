part of 'speciality_experience_bloc.dart';

@freezed
class SpecialityExperienceEvent with _$SpecialityExperienceEvent {
  const factory SpecialityExperienceEvent.getSpecialityExperinceDataEvent() =
      _GetSpecialityExperinceDataEvent;
  // const factory SpecialityExperienceEvent.getExperienceListEvent() =
  //     _GetExperienceListEvent;
  const factory SpecialityExperienceEvent.updateRecordEvent({
    required int index,
    required String year,
    required String month,
    required String name,
  }) = _UpdateRecordEvent;

  const factory SpecialityExperienceEvent.continueBtnPressedEvent() =
      _ContinueBtnPressedEvent;
}
