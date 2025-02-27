// Test cases for the Country model
import 'package:flutter_test/flutter_test.dart';
import 'package:country_explorer/data/data.dart';

void main() {
  group('Country', () {
    final country = Country(
      name: 'Nigeria',
      capital: 'Abuja',
      flagUrl: 'url',
      languages: {'en': 'English'},
    );
    test('supports value comparisons', () {
      expect(
        country,
        Country(
          name: 'Nigeria',
          capital: 'Abuja',
          flagUrl: 'url',
          languages: {'en': 'English'},
        ),
      );
    });

    test('returns correct properties', () {
      expect(country.name, 'Nigeria');
      expect(country.capital, 'Abuja');
      expect(country.flagUrl, 'url');
      expect(country.languages, {'en': 'English'});
    });

    test('returns correct string representation', () {
      expect(
        country.toString(),
        'Country(name: Nigeria, capital: Abuja, flagUrl: url, languages: {en: English})',
      );
    });
    test('returns correct copyWith', () {
      expect(
        country.copyWith(name: 'Kenya'),
        Country(
          name: 'Kenya',
          capital: 'Abuja',
          flagUrl: 'url',
          languages: {'en': 'English'},
        ),
      );
    });

    test('returns correct copyWith when no properties are provided', () {
      expect(
        country.copyWith(),
        Country(
          name: 'Nigeria',
          capital: 'Abuja',
          flagUrl: 'url',
          languages: {'en': 'English'},
        ),
      );
    });

    test('returns correct copyWith when multiple properties are provided', () {
      expect(
        country.copyWith(name: 'Kenya', capital: 'Nairobi'),
        Country(
          name: 'Kenya',
          capital: 'Nairobi',
          flagUrl: 'url',
          languages: {'en': 'English'},
        ),
      );
    });

    test('Test fromJson method', () {
      final json = {
        'name': 'Nigeria',
        'capital': 'Abuja',
        'flagUrl': 'url',
        'languages': {'en': 'English'},
      };
      expect(Country.fromJson(json), country);
    });

    test('Test toJson method', () {
      final json = {
        'name': 'Nigeria',
        'capital': 'Abuja',
        'flagUrl': 'url',
        'languages': {'en': 'English'},
      };
      expect(country.toJson(), json);
    });
  });
}
