import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../logic/blocs/blocs.dart';
import '../widgets/widgets.dart';
import 'screens.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('African Countries')),
      body: RefreshIndicator(
        onRefresh: () async =>
            context.read<CountryListBloc>().add(const CountryListEvent.fetch()),
        child: BlocBuilder<CountryListBloc, CountryListState>(
          builder: (context, state) => state.when(
            initial: () => const Center(child: CircularProgressIndicator()),
            loading: () => const Center(child: CircularProgressIndicator()),
            loaded: (countries) => ListView.builder(
              itemCount: countries.length,
              itemBuilder: (context, index) => CountryCard(
                country: countries[index],
                onTap: () => Navigator.push(
                    context, DetailScreen.getRoute(countries[index].name)),
              ),
            ),
            error: (message) => ErrorDisplay(message: message),
          ),
        ),
      ),
    );
  }
}
