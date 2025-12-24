import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'backend_falso.dart';
import 'item_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'AsiCoffee ',
          style: GoogleFonts.pacifico(fontSize: 24),
        ),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: itens.length,
        itemBuilder: (context, index) {
          return ItemCard(
            item: itens[index],
            onFavoriteToggle: () {
              setState(() {
                itens[index].favorito =
                    !itens[index].favorito;
              });
            },
          );
        },
      ),
    );
  }
}
