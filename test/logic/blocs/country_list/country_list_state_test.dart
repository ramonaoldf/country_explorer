// Test cases of the CountryListState
import 'package:country_explorer/logic/logic.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('CountryListState', () {
    test('supports value comparisons', () {
      expect(
          const CountryListState.initial(), const CountryListState.initial());
      expect(
          const CountryListState.loading(), const CountryListState.loading());
      expect(CountryListState.loaded([]), CountryListState.loaded([]));
      expect(CountryListState.error('error'), CountryListState.error('error'));
    });
  });
}
