import 'package:auto_route/auto_route.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:shift/domain/account/i_account_repository.dart';
import 'package:shift/domain/core/png_image_constants.dart';
import 'package:shift/domain/main/i_main_facade.dart';
import 'package:shift/domain/main/main_failure.dart';
import 'package:shift/infrastructure/core/location_dto/location_dto.dart';
import 'package:shift/infrastructure/core/network/common_response.dart';
import 'package:shift/presentation/common/utils/flushbar_creator.dart';
import 'package:shift/presentation/common/utils/get_cookie.dart';
import 'package:shift/presentation/core/logger/logger.dart';
import 'package:shift/presentation/core/widgets/dialogs/app_dialog.dart';
part 'support_ticket_event.dart';
part 'support_ticket_state.dart';
part 'support_ticket_bloc.freezed.dart';

@injectable
class SupportTicketBloc extends Bloc<SupportTicketEvent, SupportTicketState> {
  final IAccountRepository _repository;
  final IMainFacade _mainFacade;

  SupportTicketBloc(this._repository, this._mainFacade)
      : super(const SupportTicketState()) {
    on<SupportTicketEvent>((event, emit) async {
      await event.map(
        onAttachmentSelected: (value) {
          emit(state.copyWith(path: value.path));
        },
        onRemoveAttachment: (_) {
          emit(state.copyWith(path: null));
        },
        onCountrySelected: (value) {
          emit(state.copyWith(
              selectedCountryCode: value.code,
              selectedCountryFlag: value.flag));
        },
        fetchLocationList: (FetchLocationList value) async {
          emit(state.copyWith(loading: true));
          final locationList = await _repository.getLocationListApi();
          emit(state.copyWith(loading: false));
          locationList.fold(
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
              emit(state.copyWith(locationList: r));
            },
          );
        },
        onLocationChanged: (OnLocationChanged value) {
          emit(state.copyWith(selectedLocation: value.selectedLocation));

          ///Log.success("selected location=> ${value.id}");
        },
        onSubmit: (value) async {
          Either<MainFailure, CommonResponse>? failureOrSuccess;
          final Map<String, dynamic> data = {};
          final role = getCurrentRole();
          data['name'] = value.name;
          data['email'] = value.email;
          data['subject'] = value.subject;
          data['description'] = value.description;

          if (value.phoneNumber.isNotEmpty) {
            data['country_code'] = state.selectedCountryCode;
            data['phone'] = value.phoneNumber;
            data['country_name_code'] = state.selectedCountryFlag;
          }

          if (state.path != null) data['attachment'];

          if (role == 2) {
            data['company_name'] = value.companyName;
            data['location_id'] = state.selectedLocation?.id;
            data['facility_type'] =
                state.selectedLocation?.facility_type?.id ?? -1;
          }

          ///ToDo: Temp
          //data['company_name'] = "test";
          Log.success("data => $data");
          emit(state.copyWith(postDataLoading: true));
          failureOrSuccess = await _mainFacade.submitSupportTicket(map: data);
          emit(state.copyWith(postDataLoading: false));

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
              AppDialog.showSuccess(
                value.context,
                image: Image.asset(PngImageConstants.ticketSubmittedSuccess),
                title: "Ticket Submitted!",
                infoMessage: r.dioMessage ?? "",
                onOkClick: () {
                  value.context.router.popUntil((route) => route.isFirst);
                },
              );
            },
          );
        },
      );
    });
  }
}
