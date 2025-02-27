import 'package:bloc_test/bloc_test.dart';
import 'package:country_explorer/data/data.dart';
import 'package:country_explorer/logic/logic.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockCountryRepository extends Mock implements CountryRepository {}

void main() {
  late MockCountryRepository mockRepository;
  late CountryListBloc bloc;

  setUp(() {
    mockRepository = MockCountryRepository();
    bloc = CountryListBloc(mockRepository);
  });

  tearDown(() => bloc.close());

  final countries = [
    Country(
        name: 'Nigeria',
        capital: 'Abuja',
        flagUrl: 'url',
        languages: {'en': 'English'})
  ];

  group('CountryListBloc', () {
    test('initial state is CountryListState.initial', () {
      expect(bloc.state, const CountryListState.initial());
    });

    blocTest<CountryListBloc, CountryListState>(
      'emits [loading, loaded] when fetch succeeds',
      build: () {
        when(() => mockRepository.fetchAfricanCountries())
            .thenAnswer((_) async => countries);
        return bloc;
      },
      act: (bloc) => bloc.add(const CountryListEvent.fetch()),
      expect: () => [
        const CountryListState.loading(),
        CountryListState.loaded(countries)
      ],
      verify: (_) =>
          verify(() => mockRepository.fetchAfricanCountries()).called(1),
    );

    blocTest<CountryListBloc, CountryListState>(
      'emits [loading, error] when fetch fails',
      build: () {
        when(() => mockRepository.fetchAfricanCountries())
            .thenThrow(Exception('Network error'));
        return bloc;
      },
      act: (bloc) => bloc.add(const CountryListEvent.fetch()),
      expect: () => [
        const CountryListState.loading(),
        isA<CountryListState>().having(
            (s) => s.maybeWhen(error: (m) => m, orElse: () => ''),
            'message',
            contains('Network error'))
      ],
    );
  });
}
