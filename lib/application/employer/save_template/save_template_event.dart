part of 'save_template_bloc.dart';

@freezed
class SaveTemplateEvent with _$SaveTemplateEvent {
  const factory SaveTemplateEvent.onFilterChanged(
      BuildContext context, CommonDropdownModel value) = onFilterChanged;

  const factory SaveTemplateEvent.getSavedTemplateList(BuildContext context,
      {required bool refresh, String? search}) = GetSavedTemplateList;

  const factory SaveTemplateEvent.onSelectMultiShift(
    BuildContext context, {
    required int type,
  }) = OnSelectMultiShift;

  const factory SaveTemplateEvent.onSearchJobRole(
    BuildContext context, {
    required String query,
  }) = OnSearchJobRole;

  const factory SaveTemplateEvent.onDeleteCodeSavedTemplate({
    required int id,
    required int shiftType,
    required BuildContext context,
  }) = OnDeleteCodeSavedTemplate;
}
