import 'package:flutter/material.dart';
import 'classeItem.dart';
import 'backendFalso.dart';
import 'package:google_fonts/google_fonts.dart';

//usar acima 

void main() {
  runApp(const AsiCoffeeApp());
}

class AsiCoffeeApp extends StatelessWidget {
  const AsiCoffeeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'AsiCoffee',
      theme: ThemeData(
        primarySwatch: Colors.brown,
        textTheme: GoogleFonts.poppinsTextTheme(),
      ),
      //home: const HomePage(), //// fazerrr
    );
  }
}