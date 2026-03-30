import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:shift/infrastructure/core/contractor_home/contractor_dashboard_dto.dart';
part 'employer_saved_template_dto.freezed.dart';
part 'employer_saved_template_dto.g.dart';

@freezed
class EmployerSavedTemplateDto with _$EmployerSavedTemplateDto {
  const factory EmployerSavedTemplateDto({
    int? id,
    String? roles,
    String? roles_list_name,
    Location? location,
    int? job_type,
    int? post_type,
    int? shift,
  }) = _EmployerSavedTemplateDto;

  factory EmployerSavedTemplateDto.fromJson(Map<String, dynamic> json) =>
      _$EmployerSavedTemplateDtoFromJson(json);
}
