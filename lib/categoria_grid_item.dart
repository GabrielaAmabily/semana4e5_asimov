//widget para a categoria

import 'package:flutter/material.dart';

import 'categoria.dart';

class CategoriaGridItem extends StatelessWidget {
  const CategoriaGridItem({
    super.key,
    required this.categoria,
    });

  final Categoria categoria;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors:[
            //categoria.color.withOpacity(0.55),//pq withOpacity ricou riscado?
            //categoria.color.withOpacity(0.9),//pq withOpacity ricou riscado?
            categoria.color,
            categoria.color,
          ]  ,
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          )
      ),
      child: Text(
        categoria.title,
        style:  Theme.of(context).textTheme.titleLarge!.copyWith(
          //color: Theme.of(context).colorScheme.onBackground,//pq onBackground ricou riscado?
        ),
      ),
    );
  }
}
