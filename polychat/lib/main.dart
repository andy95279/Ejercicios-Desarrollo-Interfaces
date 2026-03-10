import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'router/app_router.dart';
import 'providers/auth_provider.dart';
import 'providers/chat_provider.dart';
import 'providers/settings_provider.dart';

// Punto de entrada de la aplicación y configuración de proveedores de estado
void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => ChatProvider()),
        ChangeNotifierProvider(create: (_) => SettingsProvider()),
      ],
      child: const PolyChatApp(),
    ),
  );
}

class PolyChatApp extends StatelessWidget {
  const PolyChatApp({super.key});

  @override
  Widget build(BuildContext context) {
    final settings = context.watch<SettingsProvider>();

    final accentColors = [
      const Color(0xFF3D8BFF), // Blue
      const Color(0xFF9E5EFF), // Purple
      const Color(0xFF2ECC71), // Green
      const Color(0xFFFF8C00), // Orange
      const Color(0xFFFF5E9E), // Pink
      const Color(0xFFFF4D4D), // Red
    ];
    final selectedAccent = accentColors[settings.accentColorIndex];

    return MaterialApp.router(
      // Título de la aplicación que se muestra en el administrador de tareas
      title: 'PolyChat',
      debugShowCheckedModeBanner: false,
      // Configuración del tema (Oscuro/Claro) según los ajustes del usuario
      themeMode: settings.themeMode,
      // Definición del tema claro: Colores de fondo, botones y barra superior
      theme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.light,
        colorScheme: ColorScheme.fromSeed(
          seedColor: selectedAccent,
          brightness: Brightness.light,
        ),
        appBarTheme: const AppBarTheme(centerTitle: true, elevation: 0),
      ),
      // Definición del tema oscuro: Fondo negro profundo y colores de acento
      darkTheme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
        scaffoldBackgroundColor: const Color(0xFF0A0A0A),
        colorScheme: ColorScheme.fromSeed(
          seedColor: selectedAccent,
          brightness: Brightness.dark,
          surface: const Color(0xFF121212),
        ),
        appBarTheme: const AppBarTheme(
          centerTitle: true,
          backgroundColor: Color(0xFF0A0A0A),
          elevation: 0,
        ),
      ),
      // Configuración del enrutador para navegar entre pantallas
      routerConfig: router,
    );
  }
}
