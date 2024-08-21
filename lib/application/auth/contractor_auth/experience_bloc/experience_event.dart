part of 'experience_bloc.dart';

@freezed
class ExperienceEvent with _$ExperienceEvent {
  const factory ExperienceEvent.getExperinceDataEvent() =
      _GetExperinceDataEvent;
  // const factory ExperienceEvent.getExperienceListEvent() =
  //     _GetExperienceListEvent;
  const factory ExperienceEvent.updateRecordEvent({
    required int index,
    required String year,
    required String month,
    required String name,
  }) = _UpdateRecordEvent;

  const factory ExperienceEvent.continueBtnPressedEvent(bool isUpdate) =
      _ContinueBtnPressedEvent;
}
