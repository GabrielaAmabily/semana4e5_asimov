//tela de categorias
import 'package:flutter/material.dart';

import 'backend_falso.dart';
import 'categoria.dart';
import 'categoria_grid_item.dart';
import 'meals.dart';

class CategoriasScreen extends StatelessWidget {
  const CategoriasScreen({super.key});

  void _selecionaCategoria(BuildContext context, Categoria categoria) {
    final itemsFiltrados = itens //filtro por categoria
      .where((item) => item.categoria.id == categoria.id)
      .toList();


    Navigator.of(context).push(
      //pilha de telas
      MaterialPageRoute(
        builder: (ctx) => MealsScreen(
          title: categoria.title, 
          itens: itemsFiltrados,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Categorias:')),
      body: GridView(
        padding: const EdgeInsets.all(12),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, //numero de colunas
          childAspectRatio: 6 / 5, //largura pela altura retangulo nesse caso
          crossAxisSpacing: 12, //espaço entre colunas
          mainAxisSpacing: 15, // espaço entre linhas
        ),
        children: [
          //categoriasDisponiveis.map()
          for (final categoria in categoriasDisponiveis)
            CategoriaGridItem(
              categoria: categoria,
              onSelecionaCategoria: () {
                _selecionaCategoria(context, categoria);
              },
            ),
        ],
      ),
    );
  }
}
