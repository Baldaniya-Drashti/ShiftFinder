part of 'employer_long_term_detail_bloc.dart';

@freezed
class EmployerLongTermDetailEvent with _$EmployerLongTermDetailEvent {
  const factory EmployerLongTermDetailEvent.getPositionDetail(BuildContext context ,int id) = _GetPositionDetail;
}
