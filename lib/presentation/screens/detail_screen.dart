import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/data.dart';
import '../../logic/logic.dart';
import '../widgets/widgets.dart';

class DetailScreen extends StatelessWidget {
  final String countryName;

  const DetailScreen({super.key, required this.countryName});

  static Route<T> getRoute<T>(String countryName) {
    return MaterialPageRoute(
      builder: (_) {
        return BlocProvider(
          create: (context) => CountryDetailBloc(
            context.read<CountryRepository>(),
          )..add(CountryDetailEvent.fetch(countryName)),
          child: DetailScreen(countryName: countryName),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(countryName)),
      body: BlocBuilder<CountryDetailBloc, CountryDetailState>(
        builder: (context, state) => state.when(
          initial: () => const Center(child: CircularProgressIndicator()),
          loading: () => const Center(child: CircularProgressIndicator()),
          loaded: (country) => Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Image.network(country.flagUrl,
                      key: const Key('flag_image'),
                      height: 100,
                      errorBuilder: (_, __, ___) =>
                          const Icon(Icons.error, key: Key('flag_error_icon'))),
                ),
                const SizedBox(height: 16),
                RichText(
                    key: const Key('capital_name'),
                    text: TextSpan(
                      style: Theme.of(context).textTheme.titleLarge,
                      children: [
                        TextSpan(
                          text: 'Capital: ',
                          style:
                              Theme.of(context).textTheme.titleLarge!.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                        ),
                        TextSpan(
                          text: country.capital,
                        ),
                      ],
                    )),
                const SizedBox(height: 8),
                RichText(
                    key: const Key('languages'),
                    text: TextSpan(
                      style: Theme.of(context).textTheme.titleMedium,
                      children: [
                        TextSpan(
                          text: 'Languages: ',
                          style:
                              Theme.of(context).textTheme.titleLarge!.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                        ),
                        TextSpan(text: country.languages.values.join(', ')),
                      ],
                    )),
              ],
            ),
          ),
          error: (message) => ErrorDisplay(message: message),
        ),
      ),
    );
  }
}
