import 'package:country_explorer/data/data.dart';
import 'package:country_explorer/logic/logic.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('CountryDetailState', () {
    final country = Country(
        name: 'Nigeria',
        capital: 'Abuja',
        flagUrl: 'url',
        languages: {'en': 'English'});
    test('supports value comparisons', () {
      expect(const CountryDetailState.initial(),
          const CountryDetailState.initial());
      expect(const CountryDetailState.loading(),
          const CountryDetailState.loading());
      expect(CountryDetailState.loaded(country),
          CountryDetailState.loaded(country));
      expect(
          CountryDetailState.error('error'), CountryDetailState.error('error'));
    });
  });
}
