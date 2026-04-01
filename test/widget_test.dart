// test/widget_test.dart

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';

import 'package:dhira_hrms/main.dart';               // adjust if path differs
import 'package:dhira_hrms/services/auth_service.dart';
import 'package:dhira_hrms/providers/auth_provider.dart';

void main() {
  testWidgets('App starts and shows login screen', (WidgetTester tester) async {
    // Arrange: create navigatorKey and AuthService
    final navigatorKey = GlobalKey<NavigatorState>();
    final authService = AuthService(navigatorKey: navigatorKey);

    // Act: pump the MyApp widget
    await tester.pumpWidget(
      ChangeNotifierProvider<AuthProvider>(
        create: (_) => AuthProvider(authService),
        child: MyApp(authService: authService, navigatorKey: navigatorKey),
      ),
    );

    // Wait for the widget tree to settle
    await tester.pumpAndSettle();

    // Assert: expect something on the login screen, e.g., a login button
    expect(find.text('Login with Microsoft'), findsOneWidget);
    expect(find.byType(ElevatedButton), findsOneWidget);
  });

  testWidgets('Press login button triggers login flow', (WidgetTester tester) async {
    final navigatorKey = GlobalKey<NavigatorState>();
    final authService = AuthService(navigatorKey: navigatorKey);

    await tester.pumpWidget(
      ChangeNotifierProvider<AuthProvider>(
        create: (_) => AuthProvider(authService),
        child: MyApp(authService: authService, navigatorKey: navigatorKey),
      ),
    );

    await tester.pumpAndSettle();

    // Tap the login button
    await tester.tap(find.text('Login with Microsoft'));
    await tester.pump();

    // Here you may need to mock the login() method of authService to return a dummy user
    // For simplicity, just check that the UI changes (for example shows HomePage).
    // You might need to wait for setState / provider update:
    await tester.pumpAndSettle();

    // Expect something from HomeScreen (for example: "Your email:" text)
    expect(find.textContaining('Your email:'), findsOneWidget);
  });
}

