// ignore_for_file: prefer_const_constructors

import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:shift/domain/auth/auth_failure.dart';
import 'package:shift/infrastructure/core/skill_list_model/skill_dto.dart';

part 'post_shift_event.dart';
part 'post_shift_state.dart';
part 'post_shift_bloc.freezed.dart';

class PostShiftBloc extends Bloc<PostShiftEvent, PostShiftState> {
  static List<SkillDTO> shiftTypeList = [
    SkillDTO(id: 1, name: "Single"),
    SkillDTO(id: 2, name: "Multi"),
    SkillDTO(id: 3, name: "Long-Term"),
  ];

  PostShiftBloc() : super(PostShiftState.initial()) {
    on<PostShiftEvent>((event, emit) {
      event.map(
        changeShiftType: (e) {
          SkillDTO? selectedSkillDTO = shiftTypeList.firstWhere(
            (skill) => skill.name == e.shiftType,
            orElse: () => SkillDTO(),
          );
          emit(state.copyWith(
            shiftType: selectedSkillDTO.id ?? -1,
          ));
        },
      );
    });
  }
}
