import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'data/repositories/country_repository.dart';
import 'logic/logic.dart';
import 'presentation/screens/home_screens.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    final repository = CountryRepository();
    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (_) => CountryListBloc(repository)
              ..add(const CountryListEvent.fetch())),
        BlocProvider(create: (_) => CountryDetailBloc(repository)),
      ],
      child: RepositoryProvider(
        create: (context) => repository,
        child: MaterialApp(
          theme: ThemeData.light(useMaterial3: true).copyWith(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          ),
          home: const HomeScreen(),
          debugShowCheckedModeBanner: false,
        ),
      ),
    );
  }
}
