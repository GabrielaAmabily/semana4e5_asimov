import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'classe_item.dart';
import 'item_card.dart';
import 'categorias.dart';
import 'item_detalhes.dart';
import 'filtro.dart';
import 'adicionar_item_modal.dart';
import 'providers.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  // Estado local de UI: qual aba está selecionada.
  int _indexSelecionado = 0;

  // Monta a lista de cards.
  Widget _buildList(List<Item> lista) {
    if (lista.isEmpty) {
      return const Center(child: Text('Nada aqui ainda.'));
    }

    return ListView.builder(
      itemCount: lista.length,
      itemBuilder: (context, index) {
        final item = lista[index];

        // Dismissible permite arrastar para excluir
        return Dismissible(
          key: ValueKey(item.id),
          direction: DismissDirection.endToStart, // direita p/ esquerda
          // fundo vermelho e ícone da lixeira
          background: Container(
            alignment: Alignment.centerRight,
            padding: const EdgeInsets.only(right: 20),
            color: Colors.red,
            child: const Icon(Icons.delete, color: Colors.white),
          ),

          //onfirmação antes de excluir 
          confirmDismiss: (_) async {
            return await showDialog<bool>(
                  context: context,
                  builder: (ctx) => AlertDialog(
                    title: const Text('Excluir item?'),
                    content: Text('Tem certeza que deseja excluir "${item.nome}"?'),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.of(ctx).pop(false),
                        child: const Text('Cancelar'),
                      ),
                      ElevatedButton(
                        onPressed: () => Navigator.of(ctx).pop(true),
                        child: const Text('Excluir'),
                      ),
                    ],
                  ),
                ) ??
                false;
          },

          //remove do estado global 
          onDismissed: (_) {
            ref.read(itensStateProvider.notifier).removerItem(item.id);

            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('"${item.nome}" removido')),
            );
          },

          child: ItemCard(
            item: item,

            // Favorito global: atualiza via notifier
            onFavoriteToggle: () {
              ref.read(itensStateProvider.notifier).alternarFavorito(item.id);
            },

            // Navega para detalhes
            onSelecionaItem: (item) {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (ctx) => ItemDetalhesScreen(item: item),
                ),
              );
            },
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final isCardapioCompleto = _indexSelecionado == 0;

    // Listas calculadas com filtros globais
    final itensFiltrados = ref.watch(itensFiltradosProvider);
    final favoritosFiltrados = ref.watch(itensFavoritosFiltradosProvider);

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
                  Navigator.pop(context);
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
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const FiltrosScreen(),
                    ),
                  );
                },
              ),

              ListTile(
                leading: const Icon(Icons.edit),
                title: const Text('Adicionar Item'),
                onTap: () {
                  Navigator.pop(context); // fecha o drawer

                  showModalBottomSheet(
                    context: context,
                    isScrollControlled: true, // teclado não “espreme” o modal
                    builder: (ctx) => const AdicionarItemModal(),
                  );
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

      // Lista depende da aba.
      body: isCardapioCompleto
          ? _buildList(itensFiltrados)
          : _buildList(favoritosFiltrados),

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
