import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'home_page.dart';

// Variáveis globais para os temas 
final KColorSheme = ColorScheme.fromSeed(seedColor: Colors.brown);
final KDarkColorSheme = ColorScheme.fromSeed(
  seedColor: Colors.brown,
  brightness: Brightness.dark,
);

void main() {
  // ProviderScope "liga" o Riverpod no app inteiro.
  runApp(
    const ProviderScope(
      child: AsiCoffeeApp(),
    ),
  );
}

class AsiCoffeeApp extends StatelessWidget {
  const AsiCoffeeApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Tema claro
    final temaClaro = ThemeData(
      useMaterial3: true,
      colorScheme: KColorSheme,
      textTheme: GoogleFonts.poppinsTextTheme(),
    );

    // Tema escuro
    final temaEscuro = ThemeData(
      useMaterial3: true,
      colorScheme: KDarkColorSheme,
      textTheme: GoogleFonts.poppinsTextTheme(ThemeData.dark().textTheme),
    );

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'AsiCoffee',
      theme: temaClaro,
      darkTheme: temaEscuro,
      themeMode: ThemeMode.system,
      home: const HomePage(),
    );
  }
}
