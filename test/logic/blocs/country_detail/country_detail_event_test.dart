import 'package:country_explorer/logic/logic.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('CountryDetailEvent', () {
    test('supports value comparisons', () {
      expect(const CountryDetailEvent.fetch(''),
          const CountryDetailEvent.fetch(''));
    });
  });
}
