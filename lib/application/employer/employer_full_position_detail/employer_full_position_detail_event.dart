part of 'employer_full_position_detail_bloc.dart';

@freezed
class EmployerFullPositionDetailEvent with _$EmployerFullPositionDetailEvent {
  const factory EmployerFullPositionDetailEvent.getPositionDetail(BuildContext context ,int id) = _GetPositionDetail;
}
