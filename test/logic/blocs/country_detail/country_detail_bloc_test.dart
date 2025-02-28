import 'package:bloc_test/bloc_test.dart';
import 'package:country_explorer/data/data.dart';
import 'package:country_explorer/logic/logic.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockCountryRepository extends Mock implements CountryRepository {}

void main() {
  late MockCountryRepository mockRepository;
  late CountryDetailBloc bloc;

  setUp(() {
    mockRepository = MockCountryRepository();
    bloc = CountryDetailBloc(mockRepository);
  });

  tearDown(() => bloc.close());

  final country = Country(
    name: 'Nigeria',
    capital: 'Abuja',
    flagUrl: 'url',
    languages: {'en': 'English'},
  );

  group('CountryDetailBloc', () {
    test('Initial state is CountryDetailState.initial', () {
      expect(bloc.state, const CountryDetailState.initial());
    });

    blocTest<CountryDetailBloc, CountryDetailState>(
      'Emits [loading, loaded] when fetch succeeds',
      build: () {
        when(() => mockRepository.fetchCountryDetails('Nigeria'))
            .thenAnswer((_) async => country);
        return bloc;
      },
      act: (bloc) => bloc.add(const CountryDetailEvent.fetch('Nigeria')),
      expect: () => [
        const CountryDetailState.loading(),
        CountryDetailState.loaded(country),
      ],
      verify: (_) =>
          verify(() => mockRepository.fetchCountryDetails('Nigeria')).called(1),
    );

    blocTest<CountryDetailBloc, CountryDetailState>(
      'Emits [loading, error] when fetch fails',
      build: () {
        when(() => mockRepository.fetchCountryDetails('Nigeria'))
            .thenThrow(Exception('Network error'));
        return bloc;
      },
      act: (bloc) => bloc.add(const CountryDetailEvent.fetch('Nigeria')),
      expect: () => [
        const CountryDetailState.loading(),
        isA<CountryDetailState>().having(
          (s) => s.maybeWhen(error: (m) => m, orElse: () => ''),
          'network message',
          contains('Network error'),
        ),
      ],
      verify: (_) =>
          verify(() => mockRepository.fetchCountryDetails('Nigeria')).called(1),
    );
  });
}
