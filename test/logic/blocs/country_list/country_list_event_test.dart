import 'package:country_explorer/logic/logic.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('CountryListEvent', () {
    test('supports value comparisons', () {
      expect(const CountryListEvent.fetch(), const CountryListEvent.fetch());
    });
  });
}
