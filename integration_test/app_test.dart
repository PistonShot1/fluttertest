import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fluttertest/main.dart' as app;
import 'package:integration_test/integration_test.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('Product Page and Navigation Test', () {
    testWidgets('should display product page and navigate to product detail', (
      tester,
    ) async {
      // Launch the app
      app.main();
      await tester.pumpAndSettle(const Duration(seconds: 3));

      // Verify the product page is displayed
      // Check for "Products found" text which indicates the product list is loaded
      expect(find.textContaining('Products found'), findsOneWidget);

      // Wait a bit more for products to fully load
      await tester.pumpAndSettle(const Duration(seconds: 2));

      // Find product cards by looking for star icons (rating stars in product cards)
      // Product cards contain star icons for ratings
      final starIcons = find.byIcon(Icons.star);

      // Verify that at least one product card exists (indicated by star icons)
      expect(starIcons, findsWidgets);

      // Find the GestureDetector that wraps the product card
      // We'll find the first star icon and get its ancestor GestureDetector
      final firstStar = starIcons.first;
      final productCard = find.ancestor(
        of: firstStar,
        matching: find.byType(GestureDetector),
      );

      // Verify we found a tappable product card
      expect(productCard, findsOneWidget);

      // Tap on the product card
      await tester.tap(productCard);
      await tester.pumpAndSettle(const Duration(seconds: 2));

      // Verify navigation to product detail page
      // Check for the back button which is present in the product detail screen
      expect(find.byIcon(Icons.arrow_back), findsOneWidget);

      // Verify product detail content is displayed
      // The product detail screen shows the product title in the app bar
      // We can check for any text that would be present in the detail screen
      // Since we don't know the exact product, we'll check for common elements
      expect(find.byType(DraggableScrollableSheet), findsOneWidget);
    });
  });
}
