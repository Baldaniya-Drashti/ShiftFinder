import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
part 'contractor_update_profile_event.dart';
part 'contractor_update_profile_state.dart';
part 'contractor_update_profile_bloc.freezed.dart';

class ContractorUpdateProfileBloc
    extends Bloc<ContractorUpdateProfileEvent, ContractorUpdateProfileState> {
  ContractorUpdateProfileBloc()
      : super(const ContractorUpdateProfileState.initial()) {
    on<ContractorUpdateProfileEvent>((event, emit) {});
  }
}
