import 'package:country_explorer/data/data.dart';
import 'package:country_explorer/presentation/screens/screens.dart';
import 'package:country_explorer/presentation/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:country_explorer/logic/logic.dart';

class MockCountryListBloc extends MockBloc<CountryListEvent, CountryListState>
    implements CountryListBloc {}

class MockCountryDetailBloc
    extends MockBloc<CountryDetailEvent, CountryDetailState>
    implements CountryDetailBloc {}

void main() {
  late CountryListBloc mockCountryListBloc;
  late CountryDetailBloc mockCountryDetailBloc;
  final countries = [
    Country(
      name: 'Kenya',
      capital: 'Nairobi',
      flagUrl: '🇰🇪',
      languages: {'en': 'English'},
    ),
    Country(
      name: 'Nigeria',
      capital: 'Abuja',
      flagUrl: '🇳🇬',
      languages: {'en': 'English'},
    ),
  ];

  setUp(() {
    mockCountryListBloc = MockCountryListBloc();
    mockCountryDetailBloc = MockCountryDetailBloc();
  });

  tearDown(() {
    mockCountryListBloc.close();
    mockCountryDetailBloc.close();
  });

  // Helper method to create a testable widget with mocked Bloc
  Widget createHomeScreen(CountryListState state) {
    return MaterialApp(
      home: BlocProvider<CountryListBloc>(
        create: (_) => mockCountryListBloc..emit(state),
        child: const HomeScreen(),
      ),
    );
  }

  group('HomeScreen', () {
    testWidgets('renders HomeScreen', (tester) async {
      // Arrange
      when(() => mockCountryListBloc.state)
          .thenReturn(const CountryListState.initial());
      // act
      await tester
          .pumpWidget(createHomeScreen(const CountryListState.initial()));

      // assert
      expect(find.byType(HomeScreen), findsOneWidget);
    });

    testWidgets('renders CircularProgressIndicator when state is initial',
        (tester) async {
      // Arrange
      when(() => mockCountryListBloc.state)
          .thenReturn(const CountryListState.initial());

      // act
      await tester
          .pumpWidget(createHomeScreen(const CountryListState.initial()));

      // Assert
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
      expect(find.text('African Countries'), findsOneWidget);
    });

    testWidgets('renders CircularProgressIndicator when state is loading',
        (tester) async {
      // Arrange
      when(() => mockCountryListBloc.state)
          .thenReturn(const CountryListState.loading());

      // Act
      await tester
          .pumpWidget(createHomeScreen(const CountryListState.loading()));

      // Assert
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });

    testWidgets('renders ListView.builder when state is loaded',
        (tester) async {
      // Arrange
      when(() => mockCountryListBloc.state)
          .thenReturn(CountryListState.loaded(countries));

      // Act
      await tester
          .pumpWidget(createHomeScreen(CountryListState.loaded(countries)));
      await tester.pump(); // Allow image placeholders to settle

      // Assert
      expect(find.byType(ListView), findsOneWidget);
      expect(find.byType(CountryCard), findsNWidgets(countries.length));
      expect(find.text('Nigeria'), findsOneWidget);
      expect(find.text('Capital: Abuja'), findsOneWidget);
      expect(find.text('Kenya'), findsOneWidget);
      expect(find.text('Capital: Nairobi'), findsOneWidget);
    });

    testWidgets('renders ErrorDisplay when state is error', (tester) async {
      // Arrange
      const errorMessage = 'Failed to load countries';
      when(() => mockCountryListBloc.state)
          .thenReturn(const CountryListState.error(errorMessage));

      // Act
      await tester
          .pumpWidget(createHomeScreen(CountryListState.error(errorMessage)));

      // Assert
      expect(find.byType(ErrorDisplay), findsOneWidget);
      expect(find.byType(SelectableText), findsOneWidget);
      expect(find.textContaining('Error: $errorMessage'), findsOneWidget);
    });

    testWidgets('navigates to DetailScreen when CountryCard is tapped',
        (tester) async {
      // Arrange
      when(() => mockCountryListBloc.state)
          .thenReturn(CountryListState.loaded(countries));
      when(() => mockCountryDetailBloc.state)
          .thenReturn(const CountryDetailState.initial());
      await tester.pumpWidget(
        MaterialApp(
          home: MultiBlocProvider(
            providers: [
              BlocProvider.value(value: mockCountryListBloc),
              BlocProvider.value(value: mockCountryDetailBloc),
            ],
            child: HomeScreen(),
          ),
        ),
      );

      // Act
      await tester.pump(); // Allow initial render
      await tester.tap(find.text('Nigeria'));

      // Assert
      verify(
          () => mockCountryDetailBloc.add(CountryDetailEvent.fetch('Nigeria')));
    });
  });
}
