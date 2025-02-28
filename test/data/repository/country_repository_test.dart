// Test cases for the CountryRepository
import 'package:country_explorer/data/data.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockDio extends Mock implements Dio {}

void main() {
  late MockDio mockDio;
  late CountryRepository repository;
  final String baseUrl = 'https://restcountries.com/v3.1';

  setUp(() {
    mockDio = MockDio();
    repository = CountryRepository(dio: mockDio); // Inject mock Dio
  });

  // Helper method to register fallback values for mocktail
  setUpAll(() {
    registerFallbackValue(RequestOptions(path: ''));
  });

  group('CountryRepository', () {
    group('fetchAfricanCountries', () {
      final mockResponse = [
        {
          'name': {'common': 'Nigeria'},
          'capital': ['Abuja'],
          'flags': {'png': 'https://flagcdn.com/w320/ng.png'},
          'languages': {'en': 'English'},
        },
        {
          'name': {'common': 'Kenya'},
          'capital': ['Nairobi'],
          'flags': {'png': 'https://flagcdn.com/w320/ke.png'},
          'languages': {'en': 'English', 'sw': 'Swahili'},
        },
      ];

      final expectedCountries = [
        Country(
          name: 'Nigeria',
          capital: 'Abuja',
          flagUrl: 'https://flagcdn.com/w320/ng.png',
          languages: {'en': 'English'},
        ),
        Country(
          name: 'Kenya',
          capital: 'Nairobi',
          flagUrl: 'https://flagcdn.com/w320/ke.png',
          languages: {'en': 'English', 'sw': 'Swahili'},
        ),
      ];

      test('returns list of countries on successful API call', () async {
        // Arrange
        when(() => mockDio.get(
              '$baseUrl/region/africa',
              queryParameters: {'fields': 'name,languages,capital,flags'},
            )).thenAnswer((_) async => Response(
              data: mockResponse,
              statusCode: 200,
              requestOptions: RequestOptions(path: ''),
            ));

        // Act
        final result = await repository.fetchAfricanCountries();

        // Assert
        expect(result, equals(expectedCountries));
        verify(() => mockDio.get(
              '$baseUrl/region/africa',
              queryParameters: {'fields': 'name,languages,capital,flags'},
            )).called(1);
      });

      test('handles missing capital gracefully', () async {
        // Arrange
        final mockResponseNoCapital = [
          {
            'name': {'common': 'TestCountry'},
            'flags': {'png': 'https://flagcdn.com/test.png'},
            'languages': {'en': 'English'},
          },
        ];
        when(() => mockDio.get(any(),
                queryParameters: any(named: 'queryParameters')))
            .thenAnswer((_) async => Response(
                  data: mockResponseNoCapital,
                  statusCode: 200,
                  requestOptions: RequestOptions(path: ''),
                ));

        // Act
        final result = await repository.fetchAfricanCountries();

        // Assert
        expect(result.first.capital, 'N/A');
      });

      test('throws exception on API failure', () async {
        // Arrange
        when(() => mockDio.get(any(),
                queryParameters: any(named: 'queryParameters')))
            .thenThrow(DioException(
          requestOptions: RequestOptions(path: ''),
          response: Response(
              statusCode: 404, requestOptions: RequestOptions(path: '')),
        ));

        // Act & Assert
        expect(
          () => repository.fetchAfricanCountries(),
          throwsA(isA<Exception>().having((e) => e.toString(), 'message',
              contains('Failed to fetch countries'))),
        );
      });
    });

    group('fetchCountryDetails', () {
      final mockDetailResponse = [
        {
          'name': {'common': 'Ghana'},
          'capital': ['Accra'],
          'flags': {'png': 'https://flagcdn.com/gh.png'},
          'languages': {'en': 'English', 'tw': 'Twi'},
        },
      ];

      final expectedCountry = Country(
        name: 'Ghana',
        capital: 'Accra',
        flagUrl: 'https://flagcdn.com/gh.png',
        languages: {'en': 'English', 'tw': 'Twi'},
      );

      test('returns country details on successful API call', () async {
        // Arrange
        when(() => mockDio.get(any())).thenAnswer((_) async => Response(
              data: mockDetailResponse,
              statusCode: 200,
              requestOptions: RequestOptions(path: ''),
            ));

        // Act
        final result = await repository.fetchCountryDetails('Ghana');

        // Assert
        expect(result, equals(expectedCountry));
        verify(() => mockDio.get('$baseUrl/name/Ghana')).called(1);
      });

      test('handles missing capital in details gracefully', () async {
        // Arrange
        final mockResponseNoCapital = [
          {
            'name': {'common': 'Ghana'},
            'flags': {'png': 'https://flagcdn.com/gh.png'},
            'languages': {'en': 'English'},
          },
        ];
        when(() => mockDio.get(any())).thenAnswer((_) async => Response(
              data: mockResponseNoCapital,
              statusCode: 200,
              requestOptions: RequestOptions(path: ''),
            ));

        // Act
        final result = await repository.fetchCountryDetails('Ghana');

        // Assert
        expect(result.capital, 'N/A');
      });

      test('throws exception on API failure', () async {
        // Arrange
        when(() => mockDio.get(any())).thenThrow(DioException(
          requestOptions: RequestOptions(path: ''),
          response: Response(
              statusCode: 500, requestOptions: RequestOptions(path: '')),
        ));

        // Act & Assert
        expect(
          () => repository.fetchCountryDetails('Ghana'),
          throwsA(isA<Exception>().having((e) => e.toString(), 'message',
              contains('Failed to fetch country details'))),
        );
      });
    });
  });
}
