import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:country_explorer/data/models/country.dart';

import 'package:country_explorer/presentation/widgets/widgets.dart';

void main() {
  group('CountryCard', () {
    testWidgets('renders CountryCard', (tester) async {
      // Arrange
      final country = Country(
        name: 'Kenya',
        capital: 'Nairobi',
        flagUrl: '🇰🇪',
        languages: {'en': 'English'},
      );
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CountryCard(
              country: country,
              onTap: () {},
            ),
          ),
        ),
      );

      // Assert
      expect(find.byType(CountryCard), findsOneWidget);
    });

    testWidgets('displays country details', (tester) async {
      // Arrange
      final country = Country(
        name: 'Kenya',
        capital: 'Nairobi',
        flagUrl: '🇰🇪',
        languages: {'en': 'English'},
      );
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CountryCard(
              country: country,
              onTap: () {},
            ),
          ),
        ),
      );

      // Assert
      expect(find.text('Kenya'), findsOneWidget);
      expect(find.text('Capital: Nairobi'), findsOneWidget);
      expect(find.text('Languages: English'), findsOneWidget);
    });

    testWidgets('calls onTap when tapped', (tester) async {
      // Arrange
      final country = Country(
        name: 'Kenya',
        capital: 'Nairobi',
        flagUrl: '🇰🇪',
        languages: {'en': 'English'},
      );
      var tapped = false;
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CountryCard(
              country: country,
              onTap: () {
                tapped = true;
              },
            ),
          ),
        ),
      );

      // Act
      await tester.tap(find.byType(CountryCard));

      // Assert
      expect(tapped, true);
    });

    testWidgets('displays flag image', (tester) async {
      // Arrange
      final country = Country(
        name: 'Kenya',
        capital: 'Nairobi',
        flagUrl: 'https://flagcdn.com/ke.png',
        languages: {'en': 'English'},
      );
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CountryCard(
              country: country,
              onTap: () {},
            ),
          ),
        ),
      );

      // Assert
      expect(find.byType(Image), findsOneWidget);
    });
  });
}
