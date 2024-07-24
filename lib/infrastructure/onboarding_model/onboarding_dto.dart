import 'package:freezed_annotation/freezed_annotation.dart';

part 'onboarding_dto.freezed.dart';
part 'onboarding_dto.g.dart';

@freezed
class OnBoardingDTO with _$OnBoardingDTO {
  factory OnBoardingDTO({
    int? id,
    String? title,
    String? image,
    String? backgroundImage,
    String? description,
  }) = _OnBoardingDTO;

  factory OnBoardingDTO.fromJson(Map<String, dynamic> json) =>
      _$OnBoardingDTOFromJson(json);
}
