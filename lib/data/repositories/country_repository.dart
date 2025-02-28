import 'package:dio/dio.dart';
import '../models/country.dart';

class CountryRepository {
  CountryRepository({Dio? dio}) : dio = dio ?? Dio();
  final Dio dio;
  final String _baseUrl = 'https://restcountries.com/v3.1';

  Future<List<Country>> fetchAfricanCountries() async {
    try {
      final response = await dio.get(
        '$_baseUrl/region/africa',
        queryParameters: {'fields': 'name,languages,capital,flags'},
      );
      final List<dynamic> data = response.data;
      return data
          .map((json) => Country(
                name: json['name']['common'],
                capital: (json['capital'] as List?)?.first ?? 'N/A',
                flagUrl: json['flags']['png'],
                languages: Map<String, String>.from(json['languages']),
              ))
          .toList();
    } catch (e) {
      throw Exception('Failed to fetch countries: $e');
    }
  }

  Future<Country> fetchCountryDetails(String name) async {
    try {
      final response = await dio.get('$_baseUrl/name/$name');
      final json = response.data[0];
      return Country(
        name: json['name']['common'],
        capital: (json['capital'] as List?)?.first ?? 'N/A',
        flagUrl: json['flags']['png'],
        languages: Map<String, String>.from(json['languages']),
      );
    } catch (e) {
      throw Exception('Failed to fetch country details: $e');
    }
  }
}
