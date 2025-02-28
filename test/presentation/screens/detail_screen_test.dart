import 'package:bloc_test/bloc_test.dart';
import 'package:country_explorer/data/data.dart';
import 'package:country_explorer/logic/logic.dart';
import 'package:country_explorer/presentation/screens/screens.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockCountryDetailBloc
    extends MockBloc<CountryDetailEvent, CountryDetailState>
    implements CountryDetailBloc {}

void main() {
  late MockCountryDetailBloc mockCountryDetailBloc;

  setUp(() {
    mockCountryDetailBloc = MockCountryDetailBloc();
  });

  tearDown(() {
    mockCountryDetailBloc.close();
  });

  // Sample data
  final country = Country(
    name: 'Ghana',
    capital: 'Accra',
    flagUrl: 'https://flagcdn.com/gh.png',
    languages: {'en': 'English', 'tw': 'Twi'},
  );

  // Helper method to create a testable widget with mocked Bloc
  Widget createDetailScreen(CountryDetailState state, String countryName) {
    return MaterialApp(
      home: BlocProvider<CountryDetailBloc>(
        create: (_) => mockCountryDetailBloc..emit(state),
        child: DetailScreen(countryName: countryName),
      ),
    );
  }

  group('DetailScreen', () {
    testWidgets('displays loading indicator when state is initial',
        (tester) async {
      // Arrange
      when(() => mockCountryDetailBloc.state)
          .thenReturn(const CountryDetailState.initial());

      // Act
      await tester.pumpWidget(
          createDetailScreen(const CountryDetailState.initial(), 'Ghana'));

      // Assert
      // expect(find.byType(CircularProgressIndicator), findsOneWidget);
      expect(find.text('Ghana'), findsOneWidget); // AppBar title
    });

    testWidgets('displays loading indicator when state is loading',
        (tester) async {
      // Arrange
      when(() => mockCountryDetailBloc.state)
          .thenReturn(const CountryDetailState.loading());

      // Act
      await tester.pumpWidget(
          createDetailScreen(const CountryDetailState.initial(), 'Ghana'));

      // Assert
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });

    testWidgets('displays country details when state is loaded',
        (tester) async {
      // Arrange
      when(() => mockCountryDetailBloc.state)
          .thenReturn(CountryDetailState.loaded(country));

      // Act
      await tester.pumpWidget(
          createDetailScreen(CountryDetailState.loaded(country), 'Ghana'));
      // await tester.pumpAndSettle();

      // Assert
      expect(find.byKey(const Key('languages')), findsOneWidget);
      expect(find.byKey(const Key('capital_name')), findsOneWidget);
      expect(find.byKey(const Key('flag_image')), findsOneWidget);
      expect(find.byType(Image), findsOneWidget); // Flag image
    });

    testWidgets('displays error message when state is error', (tester) async {
      // Arrange
      const errorMessage = 'Failed to load details';
      when(() => mockCountryDetailBloc.state)
          .thenReturn(const CountryDetailState.error(errorMessage));

      // Act
      await tester.pumpWidget(
          createDetailScreen(const CountryDetailState.initial(), 'Ghana'));

      // Assert
      expect(find.textContaining('Error: $errorMessage'), findsOneWidget);
      expect(find.byType(SelectableText), findsOneWidget);
    });

    testWidgets('displays fallback icon when image fails to load',
        (tester) async {
      // Arrange
      when(() => mockCountryDetailBloc.state)
          .thenReturn(CountryDetailState.loaded(country));
      await tester.pumpWidget(
          createDetailScreen(CountryDetailState.loaded(country), 'Ghana'));

      // Simulate image load failure by pumping an error
      await tester.pumpWidget(
          createDetailScreen(CountryDetailState.loaded(country), 'Ghana'));
      await tester.pumpAndSettle();

      // Assert
      expect(find.byKey(const Key('flag_error_icon')),
          findsOneWidget); // Error icon from errorBuilder
    });
  });
}
