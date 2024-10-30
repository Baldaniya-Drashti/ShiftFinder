part of 'employer_location_bloc.dart';

@freezed
class EmployerLocationEvent with _$EmployerLocationEvent {
  const factory EmployerLocationEvent.getLocationList(BuildContext context,{bool? refresh}) =GetLocationList;
  const factory EmployerLocationEvent.deleteLocation({required int id,required BuildContext context }) =DeleteLocation;

  
}
