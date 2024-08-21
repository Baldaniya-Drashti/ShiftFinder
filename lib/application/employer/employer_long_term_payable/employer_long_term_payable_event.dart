part of 'employer_long_term_payable_bloc.dart';

@freezed
class EmployerLongTermPayableEvent with _$EmployerLongTermPayableEvent {
  const factory EmployerLongTermPayableEvent.onPostShift({
    required int id,
    required BuildContext context,
    required int totalVacancy,
    int? postId,
    required EmployerLongTermSuccessDto employer,
    required PostShiftDTO postShift,
    required bool fromReview,
    required bool fromTemplate,
    required bool isCreate,
  }) = _OnPostShift;
}
