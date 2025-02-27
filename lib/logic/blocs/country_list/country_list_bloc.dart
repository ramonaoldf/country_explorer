import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import '../../../data/models/models.dart';
import '../../../data/repositories/country_repository.dart';
part 'country_list_event.dart';
part 'country_list_state.dart';

part 'country_list_bloc.freezed.dart';

class CountryListBloc extends Bloc<CountryListEvent, CountryListState> {
  final CountryRepository repository;

  CountryListBloc(this.repository) : super(const CountryListState.initial()) {
    on<CountryListEvent>((event, emit) async {
      await event.when(
        fetch: () async {
          emit(const CountryListState.loading());
          try {
            final countries = await repository.fetchAfricanCountries();
            emit(CountryListState.loaded(countries));
          } catch (e) {
            emit(CountryListState.error(e.toString()));
          }
        },
      );
    });
  }
}
