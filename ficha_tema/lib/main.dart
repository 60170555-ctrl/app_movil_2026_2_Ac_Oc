import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'routes/app_routes.dart';

void main() => runApp(const MiApp());

class MiApp extends StatelessWidget {
  const MiApp({super.key});

  @override
  Widget build(BuildContext context) {
    final baseTheme = ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        seedColor: const Color(0xFF12314D),
      ).copyWith(
        primary: const Color(0xFF12314D),
        onPrimary: Colors.white,
        primaryContainer: const Color(0xFF12314D),
        onPrimaryContainer: Colors.white,
        surface: const Color(0xFFF6F9FB),
        onSurface: const Color(0xFF12314D),
      ),
      inputDecorationTheme: const InputDecorationTheme(
        border: OutlineInputBorder(),
      ),
    );

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Anticipa Azangaro',
      theme: baseTheme.copyWith(
        textTheme: GoogleFonts.interTextTheme(baseTheme.textTheme),
      ),
      darkTheme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF12314D),
          brightness: Brightness.dark,
        ),
        inputDecorationTheme: const InputDecorationTheme(
          border: OutlineInputBorder(),
        ),
        textTheme: GoogleFonts.interTextTheme(ThemeData.dark().textTheme),
      ),
      themeMode: ThemeMode.system,
      initialRoute: AppRoutes.home,
      onGenerateRoute: AppRoutes.onGenerateRoute,
    );
  }
}