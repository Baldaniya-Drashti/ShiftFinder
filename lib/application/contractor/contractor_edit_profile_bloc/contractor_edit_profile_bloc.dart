import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:shift/domain/account/account.dart';
import 'package:shift/domain/account/account_failure.dart';
import 'package:shift/domain/account/i_account_repository.dart';
import 'package:shift/domain/auth/auth_value_objects.dart';
import 'package:shift/domain/core/string_constant.dart';
import 'package:shift/infrastructure/core/location_dto/search_location_dto/place_detail_dto.dart';
import 'package:shift/infrastructure/core/location_dto/search_location_dto/search_location_dto.dart';
import 'package:shift/presentation/common/utils/flushbar_creator.dart';
import 'package:shift/presentation/core/helper/location_helper.dart';
part 'contractor_edit_profile_event.dart';
part 'contractor_edit_profile_state.dart';
part 'contractor_edit_profile_bloc.freezed.dart';

@injectable
class ContractorEditProfileBloc
    extends Bloc<ContractorEditProfileEvent, ContractorEditProfileState> {
  final IAccountRepository respository;

  Timer? timer;
  bool isNewPassObscure = false;
  bool isConfirmPassObscure = false;
  List<dynamic> placeList = [];

  static TextEditingController locationCtrl = TextEditingController(text: "");

  get http => null;

  /// TO GET GOOGLE PLACES
  Future<String?> fetchUrl(String query, {Map<String, String>? headers}) async {
    Uri uri = Uri.https(
      "maps.googleapis.com",
      'maps/api/place/autocomplete/json',
      {
        "input": query,
        "key": "AIzaSyCiVTuKvc7IrDDG_onVY-CdAlKz_Mo_XoE",
        "components": "country:ca",
      },
    );
    try {
      final response = await http.get(uri, headers: headers);
      if (response.statusCode == 200) {
        return response.body;
      }
    } catch (e) {
      print("LOCATION CATCH ERROR: $e");
    }
    return null;
  }

  ContractorEditProfileBloc(this.respository)
      : super(ContractorEditProfileState.initial()) {
    on<ContractorEditProfileEvent>((event, emit) async {
      await event.map(
        getCurrentProfileDetail: (e) async {
          emit(state.copyWith(isLoading: true));
          // Either<AccountFailure, Account> failureOrSuccess;
          final failureOrSuccess = await respository.getCurrentUserApi();
          failureOrSuccess.fold(
            (l) {
              emit(state.copyWith(isLoading: false));
            },
            (r) {
              print("Current user complete profile----> $r");
              locationCtrl.text = r.location ?? "";

              return emit(
                state.copyWith(
                  isLoading: false,
                  currentUser: r,
                  selectImage: r.profileImage ?? "",
                  firstName: Username(r.firstName ?? ""),
                  lastName: Lastname(r.lastName ?? ""),
                  email: EmailAddress(r.email ?? ""),
                  locationAddress: InputEmptyOrNot(r.location ?? ""),
                ),
              );
            },
          );
        },
        changeProfilePic: (e) {
          emit(
            state.copyWith(selectImage: e.imagePath),
          );
        },
        firstNameChanged: (e) {
          emit(
            state.copyWith(
              firstName: Username(e.firstName),
              // authFailureOrSuccessOption: none(),
            ),
          );
        },
        lastNameChanged: (e) {
          emit(
            state.copyWith(
              lastName: Lastname(e.lastName),
              // authFailureOrSuccessOption: none(),
            ),
          );
        },
        emailChanged: (e) {
          emit(
            state.copyWith(
              email: EmailAddress(e.email),
              // authFailureOrSuccessOption: none(),
            ),
          );
        },
        locationAddressChanged: (e) async {
          /* /// To get google place with serched result
          if (placeList.isNotEmpty) {
            placeList.clear();
          }
          /*String? response = await fetchUrl(e.location);
          if (response != null) {
            print("API RESPONSE----> $response");
            placeList = json.decode(response)['predictions'];
          }*/

          String? response = await LocationHelper.fetchUrl(e.location);
          if (response != null) {
            print("API RESPONSE----> $response");
            placeList = json.decode(response)['predictions'];
          }
          emit(
            state.copyWith(
              locationAddress: InputEmptyOrNot(e.location),
              // searchLocationList: placeList,
              searchLocationList: placeList
                  .map(
                    (e) => Predictions.fromJson(e),
                  )
                  .toList(),

              authFailureOrSuccessOption: none(),
            ),
          ); */
        },
        locationSelectedFromSearchList: (e) async {
          locationCtrl.text = e.selectedLocation.description ?? "";
          var res = await LocationHelper.getPlaceDetail(
              e.selectedLocation.place_id ?? "");
          emit(
            state.copyWith(
              locationAddress:
                  InputEmptyOrNot(e.selectedLocation.description ?? ""),
              searchLocationList: [],
              selectedAddress: res ?? PlaceDetailDTO(),
              selectedLocationPrediction: e.selectedLocation,
              // authFailureOrSuccessOption: none(),
            ),
          );
        },
        updateProfile: (e) async {
          Either<AccountFailure, Account>? failureOrSuccess;

          final isFirstNameValid = state.firstName.isValid();
          final isLastNameValid = state.lastName.isValid();
          final isEmailValid = state.email.isValid();
          final isLocationAddressValid = state.locationAddress.isValid();
          final isProfilePicValid = (state.selectImage.isNotEmpty);

          if (isFirstNameValid &&
              isLastNameValid &&
              isEmailValid &&
              isLocationAddressValid &&
              isProfilePicValid) {
            print("All details are valid");
            emit(
              state.copyWith(
                isSubmitting: true,
              ),
            );
            failureOrSuccess = await respository.editContractorProfile(
              address: state.locationAddress.getValue() ?? "",
              firstName: state.firstName.getValue(),
              lastName: state.lastName.getValue(),
              profileImage: state.selectImage,
              email: state.email.getValue(),
              latitude: state.selectedAddress.result?.geometry?.location?.lat
                      .toString() ??
                  "${state.currentUser?.latitude ?? 0}",
              longitude: state.selectedAddress.result?.geometry?.location?.lng
                      .toString() ??
                  "${state.currentUser?.longitude ?? 0}",
              lastPage: state.currentUser?.lastPage ?? "",
            );

            failureOrSuccess.fold(
              (l) {
                showError(
                  message: l.maybeMap(
                    showAPIResponseMessage: (value) => value.message,
                    networkError: (value) =>
                        'Please check your internet connectivity',
                    orElse: () => "Server Error. Try again later.",
                  ),
                ).show(e.context);
                emit(state.copyWith(isSubmitting: false));
              },
              (r) {
                emit(state.copyWith(isSubmitting: false));

                showSuccess(
                        message: "Your profile has been successfully updated!")
                    .show(e.context)
                    .then((value) {
                  e.context.router.maybePop(r);
                });
              },
            );
          } else {
            showError(
                    message: StringConstant
                        .someDetailsAreMissingOrInvalidPleaseCheck)
                .show(e.context);
          }

          emit(
            state.copyWith(
              isSubmitting: false,
              showErrorMessages: true,
              // authFailureOrSuccessOption: optionOf(failureOrSuccess),
            ),
          );
        },
      );
    });
  }
}
