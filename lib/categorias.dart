//tela de categorias
import 'package:flutter/material.dart';

import 'categoria.dart';
import 'categoria_grid_item.dart';
import 'meals.dart';

class CategoriasScreen extends StatelessWidget {
  const CategoriasScreen({super.key});

  void_selecionaCategoria(BuildContext context) {
    Navigator.of(context).push(
      //pilha de telas
      MaterialPageRoute(
        builder: (ctx) => MealsScreen(title: 'categoria x', itens: []),
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
                void_selecionaCategoria(context);
              },
            ),
        ],
      ),
    );
  }
}
