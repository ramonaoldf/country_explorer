import 'package:country_explorer/presentation/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('ErrorDisplay', () {
    testWidgets('renders ErrorDisplay', (tester) async {
      // Arrange
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ErrorDisplay(message: 'An error occurred'),
          ),
        ),
      );

      // Assert
      expect(find.byType(ErrorDisplay), findsOneWidget);
    });

    testWidgets('displays error message', (tester) async {
      // Arrange
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ErrorDisplay(message: 'An error occurred'),
          ),
        ),
      );

      // Assert
      expect(find.text('Error: An error occurred'), findsOneWidget);
    });
  });
}
