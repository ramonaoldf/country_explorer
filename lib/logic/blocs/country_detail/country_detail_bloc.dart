import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../data/data.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
part 'country_detail_event.dart';
part 'country_detail_state.dart';

part 'country_detail_bloc.freezed.dart';

class CountryDetailBloc extends Bloc<CountryDetailEvent, CountryDetailState> {
  final CountryRepository repository;

  CountryDetailBloc(this.repository)
      : super(const CountryDetailState.initial()) {
    on<CountryDetailEvent>((event, emit) async {
      await event.when(
        fetch: (name) async {
          emit(const CountryDetailState.loading());
          try {
            final country = await repository.fetchCountryDetails(name);
            emit(CountryDetailState.loaded(country));
          } catch (e) {
            emit(CountryDetailState.error(e.toString()));
          }
        },
      );
    });
  }
}
