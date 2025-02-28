part of 'country_detail_bloc.dart';

@freezed
class CountryDetailState with _$CountryDetailState {
  const factory CountryDetailState.initial() = _Initial;
  const factory CountryDetailState.loading() = _Loading;
  const factory CountryDetailState.loaded(Country country) = _Loaded;
  const factory CountryDetailState.error(String message) = _Error;
}
