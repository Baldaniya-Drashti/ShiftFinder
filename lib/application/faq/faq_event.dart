part of 'faq_bloc.dart';

@freezed
class FaqEvent with _$FaqEvent {
  const factory FaqEvent.getFaqList(BuildContext context,
      {required bool refresh}) = GetFaqList;
  const factory FaqEvent.toggleExpansionEvent(int index) = ToggleExpansionEvent;
}
