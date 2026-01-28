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
      //drawer 
      endDrawer: Drawer(
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Padding(
                padding: EdgeInsets.all(16),
                child: Text(
                  'Menu',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
              const Divider(height: 1),

              ListTile(
                leading: const Icon(Icons.filter_list),
                title: const Text('Filtrar por categoria'),
                onTap: () {
                  Navigator.pop(context);
                  //fazer tela de filtro
                },
              ),

              ListTile(
                leading: const Icon(Icons.edit),
                title: const Text('Editar cardapio'),
                onTap: () {
                  Navigator.pop(context);
                  //fazer tela de editar cardapio
                },
              ),
            ],
          ),
        ),
      ),


      appBar: AppBar(
        title: Text(
          'AsiCoffee 2.0',
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
