import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:shift/domain/auth/auth_failure.dart';
import 'package:shift/domain/auth/auth_value_objects.dart';
part 'location_details_event.dart';
part 'location_details_state.dart';
part 'location_details_bloc.freezed.dart';

@injectable
class LocationDetailsBloc
    extends Bloc<LocationDetailsEvent, LocationDetailsState> {
  LocationDetailsBloc() : super(LocationDetailsState.initial()) {
    on<LocationDetailsEvent>((event, emit) {
      event.map(
        addressChanged: (e) {
          emit(
            state.copyWith(
              address: InputEmptyOrNot(e.address),
              authFailureOrSuccessOption: none(),
            ),
          );
        },
        locationIdChanged: (e) {
          emit(
            state.copyWith(
              locationId: e.locationId,
              authFailureOrSuccessOption: none(),
            ),
          );
        },
        accreditationNumberChanged: (e) {
          emit(
            state.copyWith(
              accreditationNumber: e.accreditationNumber,
              authFailureOrSuccessOption: none(),
            ),
          );
        },
        locationNoteChanged: (e) {
          emit(
            state.copyWith(
              locationNote: e.locationNote,
              authFailureOrSuccessOption: none(),
            ),
          );
        },
        unitNumberChanged: (e) {
          emit(
            state.copyWith(
              unitNumber: e.unitNumber,
              authFailureOrSuccessOption: none(),
            ),
          );
        },
        removeUnitNumberChip: (e) {
          emit(
            state.copyWith(
              unitNoNameChipList: List.from(state.unitNoNameChipList)
                ..remove(e.unitNumber),
              unitNumber: "",
              authFailureOrSuccessOption: none(),
            ),
          );
        },
        addUnitNumberChipList: (e) {
          if (state.unitNoNameChipList.isEmpty ||
              !state.unitNoNameChipList.contains(e.unitNumber)) {
            emit(
              state.copyWith(
                unitNoNameChipList: List.from(state.unitNoNameChipList)
                  ..add(e.unitNumber),
                unitNumber: e.unitNumber,
                authFailureOrSuccessOption: none(),
              ),
            );
          } else {
            emit(
              state.copyWith(
                unitNoNameChipList: List.from(state.unitNoNameChipList),
                unitNumber: e.unitNumber,
                authFailureOrSuccessOption: none(),
              ),
            );
          }
        },
        notesChanged: (e) {
          emit(
            state.copyWith(
              unitNumber: e.notes,
              authFailureOrSuccessOption: none(),
            ),
          );
        },
        facilityTypeChanged: (e) {
          emit(
            state.copyWith(
              faciltyTypeDDValue: e.faciltyType,
              faciltyType: InputEmptyOrNot(e.faciltyType),
            ),
          );
        },
        continueBtnPressed: (e) {
          Either<AuthFailure, String>? failureOrSuccess;
          final isAddressValid = state.address.isValid();
          final isFaciltyTypeValid = state.faciltyType.isValid();
          if (isAddressValid && isFaciltyTypeValid) {
            emit(
              state.copyWith(
                isSubmitting: true,
                authFailureOrSuccessOption: none(),
              ),
            );
            // failureOrSuccess = await _authFacade.login(
            //   mobileNumber: EmailAddress(""),
            //   countryCode: '+${state.selectedCountrycode}',
            // );
            failureOrSuccess = right("sucess");
          }
          emit(
            state.copyWith(
              isSubmitting: false,
              showErrorMessages: true,
              authFailureOrSuccessOption: optionOf(failureOrSuccess),
            ),
          );
        },
        addOtherfaciltyType: (e) {
          emit(
            state.copyWith(
              otherFaciltyTypeValue: e.faciltyType,
              otherFaciltyType: InputEmptyOrNot(e.faciltyType),
            ),
          );
        },
      );
    });
  }
}
