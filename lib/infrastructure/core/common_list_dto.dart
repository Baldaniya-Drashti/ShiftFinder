import 'package:freezed_annotation/freezed_annotation.dart';

part 'common_list_dto.freezed.dart';
part 'common_list_dto.g.dart';

@freezed
class ListDTO with _$ListDTO {
  factory ListDTO({String? title, int? id}) = _ListDTO;

  factory ListDTO.fromJson(Map<String, dynamic> json) =>
      _$ListDTOFromJson(json);
}
