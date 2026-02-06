//tela de categorias
import 'package:flutter/material.dart';

// não vai mais filtrar por categoria usando backend falso 
import 'categoria.dart';
import 'categoria_grid_item.dart';
import 'meals.dart';

class CategoriasScreen extends StatelessWidget {
  const CategoriasScreen({super.key});

  void _selecionaCategoria(BuildContext context, Categoria categoria) {
    Navigator.of(context).push(//agora só manda o id da categoria, e a MealsScreen busca/filtra via providers
      //pilha de telas
      MaterialPageRoute(
        builder: (ctx) => MealsScreen(
          title: categoria.title,
          categoriaId: categoria.id, 
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
