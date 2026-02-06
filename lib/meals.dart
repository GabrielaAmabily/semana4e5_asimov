import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'classe_item.dart';
import 'item_card.dart';
import 'item_detalhes.dart';
import 'providers.dart';

// antes era StatefulWidget agora é ConsumerWidget e recebe apenas a categoriaId
class MealsScreen extends ConsumerWidget {
  const MealsScreen({
    super.key,
    required this.title,
    required this.categoriaId,
  });

  final String title;
  final String categoriaId;

  void _selecionaItem(BuildContext context, Item item) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (ctx) => ItemDetalhesScreen(item: item),
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final listaBase = ref.watch(itensFiltradosProvider);// Pega a lista global JÁ filtrada pelos "Outros Filtros"

    // Filtra pela categoria escolhida
    final itensDaCategoria = listaBase
        .where((item) => item.categoria.id == categoriaId)
        .toList();

    Widget content = ListView.builder(
      itemCount: itensDaCategoria.length,
      itemBuilder: (context, index) {
        final item = itensDaCategoria[index];

        return ItemCard(
          item: item,
          onSelecionaItem: (item) => _selecionaItem(context, item), 
          onFavoriteToggle: () {
            // agora avisa o provider global, então ao voltar a Home já vem atualizada
            ref.read(itensStateProvider.notifier).alternarFavorito(item.id);
          },
        );
      },
    );

    if (itensDaCategoria.isEmpty) {
      content = const Center(
        child: Text('Opa! Nada aqui ainda!', style: TextStyle(fontSize: 20)),
      );
    }

    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: content,
    );
  }
}
