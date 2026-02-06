import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'backend_falso.dart';
import 'classe_item.dart';
import 'item_card.dart';
import 'categorias.dart';
import 'item_detalhes.dart';
import 'filtro.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // variavel para aba de favoritos
  int _indexSelecionado = 0;

  // filtros (estado local)
  bool _semGlutenFiltroSet = false;
  bool _semLactoseFiltroSet = false;
  bool _semAcucarFiltroSet = false;

  List<Item> get _itensFiltrados {
    return itens.where((item) {
      if (_semGlutenFiltroSet && !item.isGlutenFree) return false;
      if (_semLactoseFiltroSet && !item.isLactoseFree) return false;
      if (_semAcucarFiltroSet && !item.isSemAcucar) return false;
      return true;
    }).toList();
  }

  List<Item> get _favoriteItemsFiltrados =>
      _itensFiltrados.where((item) => item.favorito).toList();

  Widget _buildList(List<Item> lista) {
    if (lista.isEmpty) {
      return const Center(child: Text('Nada aqui ainda.'));
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
          onSelecionaItem: (item) {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (ctx) => ItemDetalhesScreen(item: item),
              ),
            );
          },
        );
      },
    );
  }

  Future<void> _abrirFiltros() async {
    final result = await Navigator.of(context).push<Map<String, bool>>(
      MaterialPageRoute(
        builder: (ctx) => FiltrosScreen(
          filtrosAtuais: {
            'semGluten': _semGlutenFiltroSet,
            'semLactose': _semLactoseFiltroSet,
            'semAcucar': _semAcucarFiltroSet,
          },
        ),
      ),
    );

    if (result == null) return;

    setState(() {
      _semGlutenFiltroSet = result['semGluten'] ?? false;
      _semLactoseFiltroSet = result['semLactose'] ?? false;
      _semAcucarFiltroSet = result['semAcucar'] ?? false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final isCardapioCompleto = _indexSelecionado == 0;

    return Scaffold(
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
                title: const Text('Filtrar por Categoria'),
                onTap: () {
                  Navigator.pop(context); // fecha o drawer
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const CategoriasScreen(),
                    ),
                  );
                },
              ),

              ListTile(
                leading: const Icon(Icons.eco),
                title: const Text('Outros Filtros'),
                onTap: () {
                  Navigator.pop(context); // fecha o drawer
                  _abrirFiltros();
                },
              ),

              ListTile(
                leading: const Icon(Icons.edit),
                title: const Text('Adicionar Item'),
                onTap: () {
                  Navigator.pop(context);
                  // fazer modal
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

      body: isCardapioCompleto
          ? _buildList(_itensFiltrados)
          : _buildList(_favoriteItemsFiltrados),

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
