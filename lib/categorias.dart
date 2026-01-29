//tela de categorias 
import 'package:flutter/material.dart';

import 'categoria.dart';
import 'categoria_grid_item.dart';

class CategoriasScreen extends StatelessWidget {
  const CategoriasScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Escolha a categoria desejada:'),
      ),
      body: GridView(
        padding: const EdgeInsets.all(24),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, //numero de colunas 
          childAspectRatio: 3/2, //largura pela altura retangulo nesse caso
          crossAxisSpacing: 20, //espaço entre colunas 
          mainAxisSpacing: 20, // espaço entre colunas
          ),
          children:  [
            //categoriasDisponiveis.map()
            for(final categoria in categoriasDisponiveis)
              CategoriaGridItem(categoria: categoria)
          ],
        ),
    );
  }
}
