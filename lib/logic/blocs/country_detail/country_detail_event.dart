import 'package:freezed_annotation/freezed_annotation.dart';

part 'country_detail_event.freezed.dart';

@freezed
class CountryDetailEvent with _$CountryDetailEvent {
  const factory CountryDetailEvent.fetch(String name) = _Fetch;
}
