part of 'save_template_bloc.dart';

@freezed
class SaveTemplateState with _$SaveTemplateState {
  const factory SaveTemplateState({
    @Default(CommonDropdownModel(id: 1, label: "Single")) final CommonDropdownModel? selectedFilterType,
    @Default(false) final bool loading,
    @Default(false) final bool error,
    @Default(false) final bool noDataFound,
    @Default([]) final List<EmployerSavedTemplateDto> savedTemplateList,
    @Default([]) final List<EmployerSavedTemplateDto> searchTemplateList,
    @Default(1) final int selectedMultiShift,
    final String? searchQuery,
    @Default(false)bool postDataLoading
  }) = _SaveTemplateState;
}
