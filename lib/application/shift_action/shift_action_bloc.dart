import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:shift/domain/main/i_main_facade.dart';
import 'package:shift/domain/main/main_failure.dart';
import 'package:shift/infrastructure/core/network/common_response.dart';
import 'package:shift/presentation/common/utils/flushbar_creator.dart';
import '../../infrastructure/core/employer_previous_shift/employer_previous_shift_dto.dart';
part 'shift_action_event.dart';
part 'shift_action_state.dart';
part 'shift_action_bloc.freezed.dart';

@injectable
class ShiftActionBloc extends Bloc<ShiftActionEvent, ShiftActionState> {
  final IMainFacade _mainFacade;

  ShiftActionBloc(this._mainFacade) : super(const ShiftActionState()) {
    on<ShiftActionEvent>(
      (event, emit) async {
        await event.map(
          getEmployerData: (value) async {
            Either<MainFailure, CommonResponse>? failureOrSuccess;
            emit(state.copyWith(
                loading: true, postId: value.postId, userId: value.userId));
            failureOrSuccess = await _mainFacade.getEmployerApprovedShiftUser(
                postId: value.postId, userId: value.userId);
            emit(state.copyWith(loading: false));
            failureOrSuccess.fold(
              (l) {
                showError(
                  message: l.maybeMap(
                    showAPIResponseMessage: (value) => value.message,
                    networkError: (value) =>
                        'Please check your internet connectivity',
                    orElse: () => "Server Error. Try again later.",
                  ),
                ).show(value.context);
              },
              (r) {
                final data = EmployerPreviousShiftDto.fromJson(
                    r.data as Map<String, dynamic>);
                emit(state.copyWith(employerPreviousShift: data));
              },
            );
          },
          addRemark: (value) async {
            Either<MainFailure, CommonResponse>? failureOrSuccess;
            emit(state.copyWith(postLoading: true));
            failureOrSuccess = await _mainFacade.employerAddRemark(
              postId: value.postId,
              userId: value.userId,
              remark: value.remark,
            );
            emit(state.copyWith(postLoading: false));
            failureOrSuccess.fold(
              (l) {
                showError(
                  message: l.maybeMap(
                    showAPIResponseMessage: (value) => value.message,
                    networkError: (value) =>
                        'Please check your internet connectivity',
                    orElse: () => "Server Error. Try again later.",
                  ),
                ).show(value.context);
              },
              (r) {
                if (state.postId == null || state.userId == null) return;
                add(ShiftActionEvent.getEmployerData(
                    context: value.context,
                    postId: state.postId!,
                    userId: state.userId!));
                showSuccess(message: r.dioMessage ?? "").show(value.context);
              },
            );
          },
          addFavorite: (value) async {
            Either<MainFailure, CommonResponse>? failureOrSuccess;
            emit(state.copyWith(postLoading: true));
            failureOrSuccess = await _mainFacade.addFavorite(
                postId: value.postId, userId: value.userId);
            emit(state.copyWith(postLoading: false));

            failureOrSuccess.fold(
              (l) {
                showError(
                  message: l.maybeMap(
                    showAPIResponseMessage: (value) => value.message,
                    networkError: (value) =>
                        'Please check your internet connectivity',
                    orElse: () => "Server Error. Try again later.",
                  ),
                ).show(value.context);
              },
              (r) {
                if (state.postId == null || state.userId == null) return;
                add(ShiftActionEvent.getEmployerData(
                    context: value.context,
                    postId: state.postId!,
                    userId: state.userId!));
                showSuccess(message: r.dioMessage ?? "").show(value.context);
              },
            );
          },
          addUnFavorite: (value) async {
            Either<MainFailure, CommonResponse>? failureOrSuccess;
            emit(state.copyWith(postLoading: true));
            failureOrSuccess = await _mainFacade.addUnFavorite(
                postId: value.postId, userId: value.userId);
            emit(state.copyWith(postLoading: false));
            failureOrSuccess.fold(
              (l) {
                showError(
                  message: l.maybeMap(
                    showAPIResponseMessage: (value) => value.message,
                    networkError: (value) =>
                        'Please check your internet connectivity',
                    orElse: () => "Server Error. Try again later.",
                  ),
                ).show(value.context);
              },
              (r) {
                if (state.postId == null || state.userId == null) return;
                add(ShiftActionEvent.getEmployerData(
                    context: value.context,
                    postId: state.postId!,
                    userId: state.userId!));
                showSuccess(message: r.dioMessage ?? "").show(value.context);
              },
            );
          },
          leaveRating: (value) async {
            print("testttt");
            Either<MainFailure, CommonResponse>? failureOrSuccess;
            emit(state.copyWith(postLoading: true));
            failureOrSuccess = await _mainFacade.addEmployerRating(
              postId: value.postId,
              userId: value.userId,
              rating: value.rating,
            );
            emit(state.copyWith(postLoading: false));
            failureOrSuccess.fold(
              (l) {
                showError(
                  message: l.maybeMap(
                    showAPIResponseMessage: (value) => value.message,
                    networkError: (value) =>
                        'Please check your internet connectivity',
                    orElse: () => "Server Error. Try again later.",
                  ),
                ).show(value.context);
              },
              (r) {
                if (state.postId == null || state.userId == null) return;
                add(ShiftActionEvent.getEmployerData(
                    context: value.context,
                    postId: state.postId!,
                    userId: state.userId!));
                showSuccess(message: r.dioMessage ?? "").show(value.context);
              },
            );
          },
          blockUnblockPost: (value) async {
            Either<MainFailure, CommonResponse>? failureOrSuccess;
            emit(state.copyWith(postLoading: true));
            failureOrSuccess = await _mainFacade.employerBlockUnblock(
              postId: value.postId,
              userId: value.userId,
            );
            emit(state.copyWith(postLoading: false));

            failureOrSuccess.fold(
              (l) {
                showError(
                  message: l.maybeMap(
                    showAPIResponseMessage: (value) => value.message,
                    networkError: (value) =>
                        'Please check your internet connectivity',
                    orElse: () => "Server Error. Try again later.",
                  ),
                ).show(value.context);
              },
              (r) {
                if (state.postId == null || state.userId == null) return;
                add(ShiftActionEvent.getEmployerData(
                    context: value.context,
                    postId: state.postId!,
                    userId: state.userId!));
                showSuccess(message: r.dioMessage ?? "").show(value.context);
              },
            );
          },
        );
      },
    );
  }
}
