import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:shift/infrastructure/core/contractor_home/contractor_dashboard_dto.dart';
import 'package:shift/infrastructure/core/location_dto/location_dto.dart';


part 'employer_saved_template_dto.freezed.dart';

part 'employer_saved_template_dto.g.dart';

@freezed
class EmployerSavedTemplateDto with _$EmployerSavedTemplateDto {
  const factory EmployerSavedTemplateDto({
    int? id,
    String? roles,
    Location? location,
    int? shift
  }) = _EmployerSavedTemplateDto;

  factory EmployerSavedTemplateDto.fromJson(Map<String, dynamic> json) => _$EmployerSavedTemplateDtoFromJson(json);
}
