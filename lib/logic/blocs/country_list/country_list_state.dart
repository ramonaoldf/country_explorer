part of 'country_list_bloc.dart';

@freezed
class CountryListState with _$CountryListState {
  const factory CountryListState.initial() = _Initial;
  const factory CountryListState.loading() = _Loading;
  const factory CountryListState.loaded(List<Country> countries) = _Loaded;
  const factory CountryListState.error(String message) = _Error;
}
