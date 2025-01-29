part of 'employer_long_term_position_add_detail_bloc.dart';

@freezed
class EmployerLongTermPositionAddDetailState with _$EmployerLongTermPositionAddDetailState {
  const factory EmployerLongTermPositionAddDetailState({
    @Default(false) bool isLoading,
    @Default(false) bool isNoDataFound,
    @Default(false) bool isErrorInAPI,
    @Default(false) bool postDataLoading,
    String? documentPath,
    final CommonDropdownModel? selectedShiftSchedule,
     int? postId,
    @Default(false) final bool hasMoreVacancy,
    @Default(EmployerLongTermSuccessDto()) EmployerLongTermSuccessDto employerLongTermAddDetailDto,
    @Default(PostShiftDTO()) PostShiftDTO postShiftDto,
    required ListInputEmptyOrNot requiredShiftScheduleChipList,
  }) = _EmployerLongTermPositionAddDetailState;

  factory EmployerLongTermPositionAddDetailState.initial() => EmployerLongTermPositionAddDetailState(
        requiredShiftScheduleChipList: ListInputEmptyOrNot(["Morning"]),
      );
}
