import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'home_page.dart';

// variáveis globais para os temas
final kColorScheme = ColorScheme.fromSeed(
  seedColor: Colors.brown,
);

final kDarkColorScheme = ColorScheme.fromSeed(
  seedColor: Colors.brown,
  brightness: Brightness.dark,
);

void main() {
  runApp(const AsiCoffeeApp());
}

class AsiCoffeeApp extends StatelessWidget {
  const AsiCoffeeApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Tema claro
    final lightTheme = ThemeData(
      useMaterial3: true,
      colorScheme: kColorScheme,
      textTheme: GoogleFonts.poppinsTextTheme(),
    ).copyWith(
      appBarTheme: AppBarTheme(
        backgroundColor: kColorScheme.primaryContainer,
        foregroundColor: kColorScheme.onPrimaryContainer,
      ),
    );

    // Tema escuro
    final darkTheme = ThemeData(
      useMaterial3: true,
      colorScheme: kDarkColorScheme,
      textTheme: GoogleFonts.poppinsTextTheme(ThemeData.dark().textTheme),
    ).copyWith(
      appBarTheme: AppBarTheme(
        backgroundColor: kDarkColorScheme.primaryContainer,
        foregroundColor: kDarkColorScheme.onPrimaryContainer,
      ),
    );

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'AsiCoffee',

      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: ThemeMode.system, // segue o sistema

      home: const HomePage(),
    );
  }
}
