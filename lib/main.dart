import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

//import 'classe_item.dart';
//import 'backendFalso.dart';
// import 'home_page.dart';


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