import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:polychat/main.dart';
import 'package:polychat/providers/auth_provider.dart';
import 'package:polychat/providers/chat_provider.dart';
import 'package:polychat/providers/settings_provider.dart';

void main() {
  testWidgets('App starts at Login Screen', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => AuthProvider()),
          ChangeNotifierProvider(create: (_) => ChatProvider()),
          ChangeNotifierProvider(create: (_) => SettingsProvider()),
        ],
        child: const PolyChatApp(),
      ),
    );

    // Verify that we are on the Login Screen.
    expect(find.text('PolyChat'), findsOneWidget);
    expect(find.text('Inicio de Sesión'), findsOneWidget);
    expect(find.text('Entrar'), findsOneWidget);
    expect(find.byType(TextFormField), findsNWidgets(2));
  });
}
