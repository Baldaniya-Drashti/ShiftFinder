part of 'contractor_rating_bloc.dart';

@freezed
class ContractorRatingEvent with _$ContractorRatingEvent {
  const factory ContractorRatingEvent.getRatingList({required BuildContext context,required bool refresh}) = GetRatingList;
}
