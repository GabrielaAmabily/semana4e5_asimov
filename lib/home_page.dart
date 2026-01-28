import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'backend_falso.dart';
import 'classe_item.dart';
import 'item_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  //  variavel para aba de favoritos 
  int _indexSelecionado = 0;

  List<Item> get _favoriteItems =>
      itens.where((item) => item.favorito).toList();

  Widget _buildList(List<Item> lista) { 
    if (lista.isEmpty) {
      return const Center(
        child: Text('Nenhum item favoritado ainda.'),
      );
    }

    return ListView.builder(
      itemCount: lista.length,  
      itemBuilder: (context, index) { 
        final item = lista[index];  
        return ItemCard(
          item: item,
          onFavoriteToggle: () {
            setState(() {
              item.favorito = !item.favorito;
            });
          },
        );
      },
    );
  }
  //fim 



  @override
  Widget build(BuildContext context) {
      final isCardapioCompleto = _indexSelecionado == 0;

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
        isCardapioCompleto ? 'AsiCoffee 2.0' : 'Meus Favoritos',
        style: GoogleFonts.pacifico(fontSize: 24),
      ),
      centerTitle: true,
    ),
    body: isCardapioCompleto ? _buildList(itens) : _buildList(_favoriteItems),

      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _indexSelecionado,
        onTap: (index) {
          setState(() {
            _indexSelecionado = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.menu_book),
            label: 'Cardápio',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Favoritos',
          ),
        ],
      ),
    );
  }
}
