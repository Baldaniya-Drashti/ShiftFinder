part of 'save_template_bloc.dart';

@freezed
class SaveTemplateEvent with _$SaveTemplateEvent {
  const factory SaveTemplateEvent.onFilterChanged(CommonDropdownModel value) = onFilterChanged;

  const factory SaveTemplateEvent.getSavedTemplateList({required bool refresh, String? search}) = GetSavedTemplateList;

  const factory SaveTemplateEvent.onSelectMultiShift({
    required int type,
  }) = OnSelectMultiShift;

  const factory SaveTemplateEvent.onSearchJobRole({
    required String query,
  }) = OnSearchJobRole;

  const factory SaveTemplateEvent.onDeleteCodeSavedTemplate({
    required int id,
    required BuildContext context,
  }) = OnDeleteCodeSavedTemplate;
}
