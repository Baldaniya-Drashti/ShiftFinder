import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

part 'contractor_rating_event.dart';

part 'contractor_rating_state.dart';

part 'contractor_rating_bloc.freezed.dart';
@injectable
class ContractorRatingBloc extends Bloc<ContractorRatingEvent, ContractorRatingState> {
  ContractorRatingBloc() : super(const ContractorRatingState()) {
    on<ContractorRatingEvent>((event, emit) {

    });
  }
}
