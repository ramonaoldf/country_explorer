import 'package:freezed_annotation/freezed_annotation.dart';
part 'country.g.dart';
part 'country.freezed.dart';

@freezed
class Country with _$Country {
  const factory Country({
    required String name,
    required String capital,
    required String flagUrl,
    required Map<String, String> languages,
  }) = _Country;

  factory Country.fromJson(Map<String, dynamic> json) =>
      _$CountryFromJson(json);
}
