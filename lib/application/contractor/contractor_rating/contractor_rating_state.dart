part of 'contractor_rating_bloc.dart';

@freezed
class ContractorRatingState with _$ContractorRatingState {
  const factory ContractorRatingState({
    @Default(false) bool loading,
    @Default(false) bool error,
    @Default(false) bool noDataFound,
    @Default([]) List<dynamic> ratingList,
}) = _ContractorRatingState;
}
