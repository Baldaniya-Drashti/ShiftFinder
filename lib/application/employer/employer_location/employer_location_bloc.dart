import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

part 'employer_location_event.dart';
part 'employer_location_state.dart';
part 'employer_location_bloc.freezed.dart';

@injectable
class EmployerLocationBloc extends Bloc<EmployerLocationEvent, EmployerLocationState> {

  final RefreshController refreshController = RefreshController();
  int page = 1;
  int lastPage = 1;
  EmployerLocationBloc() : super( EmployerLocationState.initial()) {
    on<EmployerLocationEvent>((event, emit) {
    });
  }
}
