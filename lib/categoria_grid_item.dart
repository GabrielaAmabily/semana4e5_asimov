import 'package:flutter/material.dart';

import 'categoria.dart';

class CategoriaGridItem extends StatelessWidget {
  const CategoriaGridItem({
    super.key, 
    required this.categoria,
    required this.onSelecionaCategoria,
    });

  final Categoria categoria;
  final void Function() onSelecionaCategoria;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onSelecionaCategoria,
      //
      splashColor: Theme.of(context).primaryColor,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          gradient: LinearGradient(
            colors: [
              categoria.color.withAlpha(180),
              categoria.color.withAlpha(255),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Text(
          categoria.title,
          style: Theme.of(context).textTheme.titleLarge!.copyWith(
            color: Theme.of(context).colorScheme.onSurface,
          ),
        ),
      ),
    );
  }
}
